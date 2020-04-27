using System;
using System.Collections.Generic;
using System.IO;
using Framework;
using UnityEditor;
using UnityEngine;
using SceneManager = UnityEngine.SceneManagement.SceneManager;

namespace BattleEditor
{
    
    public class BattleEditorWnd : EditorWindow
    {
        [MenuItem("BattleEditor/Open")]
        public static void ShowWnd()
        {
            Rect rect = new Rect(100,100,510,320);
            BattleEditorWnd wnd = EditorWindow.GetWindow<BattleEditorWnd>(true, "战斗编辑器");
            wnd.position = rect;
        }

        private string[] Camp = new[] {"Atk", "Def"};
        private const string SettingPath = "Assets/Edit/BattleEditorSetting.asset";
        private BattleEditorSetting _setting;

        private List<string> excelFileList;
        private LuaReflect _luaReflect;
        private Dictionary<string, List<LuaReflect>> _luaReflectDict;
        private GameObject[] rootGameObjects;
        private void Init()
        {
            if (_setting == null)
            {
                if (!File.Exists(SettingPath))
                    EditUtility.CreateAsset<BattleEditorSetting>(SettingPath);
                _setting = AssetDatabase.LoadAssetAtPath<BattleEditorSetting>(SettingPath);
                
            }
        }

        private void OnFocus()
        {
            Debug.Log("OnEnable");
            Init();
            WaitBattleStart();
        }

        private void LoadAllExcel()
        {
            if (Directory.Exists(Application.dataPath + _setting.ExcelFileFolder))
            {
                excelFileList = new List<string>(Directory.GetFiles(Application.dataPath + _setting.ExcelFileFolder, "*.xlsx", SearchOption.AllDirectories));
            }
        }
        private void WaitBattleStart()
        {
            if (!_luaReflect)
            {
                rootGameObjects = SceneManager.GetActiveScene().GetRootGameObjects();
                foreach (var obj in rootGameObjects)
                {
                    if (obj.name.ToLowerInvariant().IndexOf("avatarroot", StringComparison.Ordinal) != -1)
                    {
                        _luaReflect = obj.GetComponent<LuaReflect>();
                        break;
                    }
                }
            }
            if (_luaReflect)
            {
                LoadLuaReflects();
            }
        }
        private void OnGUI()
        {
            EditorGUILayout.Space();
            if (_luaReflect == null)
            {
                EditorGUILayout.HelpBox("请先启动游戏,并进入测试关卡", MessageType.Warning);
            }
            else
            {
                if (_luaReflectDict != null)
                {
                    EditorGUILayout.BeginHorizontal();
//                    foreach (var camp in Camp)
                    {
                        var camp = Camp[0];
                        EditorGUILayout.BeginVertical();
                        EditorGUILayout.LabelField(camp);
                        if(_luaReflectDict.TryGetValue(camp, out List<LuaReflect> list))
                            for (int i = 0; i < list.Count; i++)
                            {
                                LuaReflect luaReflect = list[i];
                                if (luaReflect)
                                {
                                    DrawLuaReflect(list, camp, luaReflect);
                                }
                            }
                        EditorGUILayout.EndVertical();
                    }
                    EditorGUILayout.EndHorizontal();
                }

                if (GUILayout.Button("Add Atk" + Camp[0]))
                {
                    BattleUnitEditorWnd wnd = BattleUnitEditorWnd.Create(this, _luaReflect, _setting.BattleUnitExcelPath);
                    wnd.camp = Camp[0];
                }
            }
        }

        void DrawLuaReflect(List<LuaReflect> list, string camp, LuaReflect luaReflect)
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField(luaReflect.name,GUILayout.Width(160));
            if (GUILayout.Button("Del"))
            {
                RemoveUnit(camp, luaReflect.keyValueMap["layoutIndex"]);
                list.Remove(luaReflect);
                LoadLuaReflects();
            }
            EditorGUILayout.EndHorizontal();
            
            EditorGUI.indentLevel++;
            DrawLuaReflectSkill(camp, luaReflect);
            EditorGUI.indentLevel--;
        }

        void DrawLuaReflectSkill(string camp, LuaReflect luaReflect)
        {
            var skillJsonArray = luaReflect.jsonArrayMap["Skill"];
            for (int i = 0; i < skillJsonArray.Count; i++)
            {
                var skill = skillJsonArray[i];
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.LabelField(skill["id"].ToString());
                if (GUILayout.Button("Edit"))
                {
                    
                }
                if (GUILayout.Button("Test"))
                {
                    ManualAttack(camp, luaReflect.keyValueMap["layoutIndex"], skill["id"].ToString());
                }
                EditorGUILayout.EndHorizontal();
            }
        }

        /// 手动攻击
        private void ManualAttack(string camp, string layoutIndex, string skillId)
         {
             var luaFunc = _luaReflect.luaFuncDict["ManualAttack"];
             luaFunc.BeginPCall();
             luaFunc.Push(camp);
             luaFunc.Push(int.Parse(layoutIndex));
             luaFunc.Push(skillId);
             luaFunc.PCall();
             luaFunc.EndPCall();
         }
        private void RemoveUnit(string camp,string layoutIndex)
        {
            var luaFunc = _luaReflect.luaFuncDict["RemoveBattleUnit"];
            luaFunc.BeginPCall();
            luaFunc.Push(camp);
            luaFunc.Push(int.Parse(layoutIndex));
            luaFunc.PCall();
            luaFunc.EndPCall();
        }
        private void LoadLuaReflects()
        {
            if (_luaReflect)
            {
                _luaReflectDict = new Dictionary<string, List<LuaReflect>>();
                for (int i = 0; i < _luaReflect.transform.childCount; i++)
                {
                    var luaReflect = _luaReflect.transform.GetChild(i).GetComponent<LuaReflect>();
                    if (luaReflect)
                    {
                        if (!_luaReflectDict.TryGetValue(luaReflect.keyValueMap["Camp"], out List<LuaReflect> list))
                        {
                            list = new List<LuaReflect>();
                            _luaReflectDict.Add(luaReflect.keyValueMap["Camp"], list);
                        }
                        list.Add(luaReflect);
                    }
                }
            }
        }
    }
}