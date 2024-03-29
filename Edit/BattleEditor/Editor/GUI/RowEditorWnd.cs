﻿using System.IO;
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
    public class RowEditorWnd : EditorBaseWnd
    {
        private ExcelEditor excelEditor;
        public int rowIndex = -1;
        public string luaKey ;
        
        public static RowEditorWnd Create(string title, EditorWindow parent, LuaReflect luaReflect, string excelPath)
        {
            Rect rect = new Rect(parent.position.x + parent.position.width + 20,parent.position.y, parent.position.width, parent.position.height);
            EditorWindow.FocusWindowIfItsOpen(typeof(RowEditorWnd));
            RowEditorWnd wnd = EditorWindow.CreateWindow<RowEditorWnd>(title);
            wnd.position = rect;
            wnd.ShowWnd(parent, luaReflect, excelPath);
            return wnd;
        }
        
        public void ShowWnd(EditorWindow parent, LuaReflect luaReflect, string excelPath)
        {
            this.luaReflect = luaReflect;
            excelEditor = new ExcelEditor(excelPath);
            excelEditor.LinkEditor = LinkEditor;
        }

        protected override void OnGUI()
        {
            if(excelEditor == null) return;
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
        
        public override void Apply(int index)
        {
            SaveBackToLua(luaKey, excelEditor.GetRowJson(rowIndex));
            //重新导出lua
            var outputPath = $"{BattleEditorWnd.Setting.luaOutputPath}/{Path.GetFileNameWithoutExtension(excelEditor.excelReader.xlsxPath)}.lua";
            new ExcelToLua().GenerateLua(excelEditor.excelReader, outputPath);
            //同时写回到Excel文件
            excelEditor?.Save();
        }
        protected override void OnSelect(string id, int rowIndex, int colIndex)
        {
            excelEditor.excelReader.SetCellValue(id, rowIndex, colIndex);
        }
        protected override void DrawPageButtons() { }
     
    }
}