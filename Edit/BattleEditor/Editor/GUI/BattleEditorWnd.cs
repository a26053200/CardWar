using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    public class BattleEditorWnd : EditorWindow
    {
        [MenuItem("BattleEditor/Open")]
        static void ShowWnd()
        {
            Rect rect = new Rect(100,100,1024,768);
            BattleEditorWnd wnd = EditorWindow.GetWindow<BattleEditorWnd>(true, "战斗编辑器");
            wnd.position = rect;
            wnd.Init();
        }

        private const string SettingPath = "Assets/Edit/BattleEditorSetting.asset";
        private BattleEditorSetting _setting;

        private static readonly string[] PanelLabels = new[] {"Avatar Editor", "Avatar Editor", "Avatar Editor", "Avatar Editor"};

        private void Init()
        {
            if (!File.Exists(SettingPath))
                EditUtility.CreateAsset<BattleEditorSetting>(SettingPath);
            _setting = AssetDatabase.LoadAssetAtPath<BattleEditorSetting>(SettingPath);
        }

        private List<ExcelReader.FieldColVo> battleUnitList;
        private void OnGUI()
        {
            if (battleUnitList == null)
            {
                if(GUILayout.Button("Test"))
                {
                    var reader = new ExcelReader();
                    battleUnitList = reader.GetExcelFieldList(Application.dataPath + _setting.BattleUnitExcelPath);
                }
            }
            else
            {
                for (int i = 0; i < battleUnitList[0].ValueList.Count; i++)
                {
                    if (GUILayout.Button(battleUnitList[0].ValueList[i]))
                    {
                        
                    }
                }
            }
        }
    }
}