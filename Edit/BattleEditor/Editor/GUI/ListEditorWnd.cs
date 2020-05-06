using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using Framework;
using NPOI.SS.UserModel;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    public class ListEditorWnd: EditorBaseWnd
    {
        protected bool[] foldOpen;
        protected int[] showRows;
        protected ExcelEditor excelEditor;
        private ExcelColHeader header;
        public static ListEditorWnd Create(string title, EditorWindow parent, ExcelColHeader header, string value)
        {
            Rect rect = new Rect(parent.position.x + parent.position.width + 20, parent.position.y, 440, 1136 * 0.5f);
            ListEditorWnd wnd = EditorWindow.CreateWindow<ListEditorWnd>( title);
            wnd.position = rect;
            ExcelEditor excelEditor = new ExcelEditor(header.linkEditorUrl);
            wnd.ShowWnd(excelEditor,excelEditor.GetRowIndexes(header.linkEditorField, value));
            wnd.header = header;
            return wnd;
        }
        
        protected void ShowWnd(ExcelEditor excelEditor, int[] showRows)
        {
            this.excelEditor = excelEditor;
            excelEditor.LinkEditor = LinkEditor;
            this.showRows = showRows;
            foldOpen = new bool[showRows.Length];
            base.SetPageCount(showRows.Length);
        }
        protected override void DrawPageContent(int index)
        {
            if (foldOpen[index])
            {
                DrawFoldout(index);
                DrawFoldoutContent(index);
            }
            else
            {
                DrawFoldout(index);
            }
        }
        
        protected virtual void DrawFoldout(int index)
        {
            EditorGUILayout.BeginHorizontal();
            var id = excelEditor.dataTable.Rows[showRows[index]][0].ToString();
            foldOpen[index] = EditorGUILayout.Foldout(foldOpen[index] , id);
            EditorGUILayout.EndHorizontal();
        }
        
        protected virtual void DrawFoldoutContent(int index)
        {
            EditorGUI.indentLevel++;
            excelEditor.DisplayRow(showRows[index]);
            EditorGUI.indentLevel--;
            DrawBottom(false, index);
        }

        public override void Apply(int rowIndex)
        {
            SaveBackToLua(header.linkEditorLuaKey, excelEditor.GetRowJson(rowIndex));
            //重新导出lua
            var outputPath = $"{BattleEditorWnd.Setting.outputPath}/{Path.GetFileNameWithoutExtension(excelEditor.excelReader.xlsxPath)}.lua";
            ExcelToLua.GenerateLua(excelEditor.excelReader, outputPath);
            //同时写回到Excel文件
            excelEditor?.Save();
        }
        
        private void LinkEditor(ExcelColHeader excelColHeader, string vid)
        {
            Create(excelColHeader.linkEditorLuaKey,this, excelColHeader, vid);
        }
    }
}