using Framework;
using UnityEditor;
using UnityEngine;
using UnityEngine.Serialization;

namespace BattleEditor
{
    /// <summary>
    /// <para></para>
    /// <para>Author: zhengnan </para>
    /// <para>Create: DATE TIME</para>
    /// </summary> 
    public class RowEditorWnd : EditorBaseWnd
    {
        private ExcelEditor excelEditor;
        public int rowIndex = -1;
        public string outputPath;
        
        public static RowEditorWnd Create(EditorWindow parent,  LuaReflect luaReflect, string excelPath)
        {
            Rect rect = new Rect(parent.position.x + parent.position.width + 20,100,440,1136 * 0.5f);
            EditorWindow.FocusWindowIfItsOpen(typeof(RowEditorWnd));
            RowEditorWnd wnd = EditorWindow.GetWindow<RowEditorWnd>(true, "RowEditorWnd");
            wnd.position = rect;
            wnd.ShowWnd(parent, luaReflect, excelPath);
            return wnd;
        }
        
        public void ShowWnd(EditorWindow parent, LuaReflect luaReflect, string excelPath)
        {
            base.ShowWnd(parent, luaReflect);
            excelEditor = new ExcelEditor(excelPath);
        }

        protected override void OnGUI()
        {
            base.OnGUI();
            DrawBottom(true);
        }
        public int GetRowIndex(string fieldName, string value)
        {
            return excelEditor.GetRowIndex(fieldName, value);
        }
        protected override void DrawScrollView()
        {
            if (rowIndex >= 0)
                excelEditor.DisplayRow(rowIndex);
        }
        public override void Reload()
        {
            excelEditor?.Reload();
        }
        
        public override void Save()
        {
            SaveBackToLua("Skill", excelEditor.GetRowJson(rowIndex));
            //重新导出lua
            ExcelToLua.GenerateLua(excelEditor.excelReader, outputPath);
            //同时写回到Excel文件
            excelEditor?.Save();
        }
        
        //保存回lua
        private void SaveBackToLua(string key, string json)
        {
            Debug.Log(json);
            var luaFunc = _luaReflect.luaFuncDict["JsonToLua"];
            luaFunc.BeginPCall();
            luaFunc.Push(key);
            luaFunc.Push(json);
            luaFunc.PCall();
            luaFunc.EndPCall();
        }
        
        protected override void DrawPageButtons() { }
        
    }
}