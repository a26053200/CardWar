using Framework;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    /// <summary>
    /// <para></para>
    /// <para>Author: zhengnan </para>
    /// <para>Create: DATE TIME</para>
    /// </summary> 
    public class BattleUnitEditorWnd : EditorBaseWnd
    {
        public string camp;
        
        public static BattleUnitEditorWnd Create(EditorWindow parent,  LuaReflect luaReflect, string excelPath)
        {
            Rect rect = new Rect(parent.position.x + parent.position.width + 20,100,440,1136 * 0.5f);
            BattleUnitEditorWnd wnd = EditorWindow.GetWindow<BattleUnitEditorWnd>(true, "BattleUnitEditor");
            wnd.position = rect;
            wnd.ShowWnd(parent, luaReflect, excelPath);
            return wnd;
        }
        
        protected override void DrawFields()
        {
            EditorGUILayout.Space();
//            EditorGUILayout.BeginHorizontal();
//            for (int i = 0; i < _fields.Count; i++)
//            {
//                EditorGUILayout.BeginVertical();
//                EditorGUILayout.LabelField(_fields[i].fieldType);
//                EditorGUILayout.LabelField(_fields[i].fieldComment);
//                EditorGUILayout.EndVertical();
//            }
//            EditorGUILayout.EndHorizontal();
        }
        
        protected override void DrawFoldout(int index)
        {
            EditorGUILayout.BeginHorizontal();
            foldOpen[index] = EditorGUILayout.Foldout(foldOpen[index] , _firstCol.valueList[index]);
            if (GUILayout.Button("Add"))
            {
                AddBattle(_firstCol.valueList[index]);
                Close();
            }
            EditorGUILayout.EndHorizontal();
        }
        
        private void AddBattle(string battleUnit)
        {
            var luaFunc = _luaReflect.luaFuncDict["AddBattleUnit"];
            luaFunc.BeginPCall();
            luaFunc.Push("Atk");
            luaFunc.Push(battleUnit);
            luaFunc.PCall();
            luaFunc.EndPCall();
        }
    }
}