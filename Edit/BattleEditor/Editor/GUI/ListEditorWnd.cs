using System.IO;
using Framework;
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
        public static ListEditorWnd Create(string title, EditorWindow parent, LuaReflect luaReflect, ExcelColHeader header, string vid)
        {
            Rect rect = new Rect(parent.position.x + parent.position.width + 20, parent.position.y, parent.position.width, parent.position.height);
            ListEditorWnd wnd = EditorWindow.CreateWindow<ListEditorWnd>( title);
            wnd.position = rect;
            ExcelEditor excelEditor = new ExcelEditor(header.linkEditorUrl);
            wnd.ShowWnd(excelEditor);
            wnd.SetShowRows(excelEditor.GetRowIndexes(header.linkEditorField, vid), true);
            wnd.header = header;
            wnd.luaReflect = luaReflect;
            return wnd;
        }
        protected override void OnGUI()
        {
            base.OnGUI();
            if(!EditorApplication.isPlaying)
                Close();
        }
        protected virtual void ShowWnd(ExcelEditor excelEditor)
        {
            this.excelEditor = excelEditor;
            excelEditor.LinkEditor = LinkEditor;
        }
        protected void SetShowRows(int[] showRows, bool openFold)
        {
            this.showRows = showRows;
            foldOpen = new bool[showRows.Length];
            for (int i = 0; i < showRows.Length; i++)
                foldOpen[i] = openFold;
            base.SetPageCount(showRows.Length);
        }
        protected override void DrawPageContent(int index)
        {
            if(excelEditor == null) return;
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
            var outputPath = $"{BattleEditorWnd.Setting.luaOutputPath}/{Path.GetFileNameWithoutExtension(excelEditor.excelReader.xlsxPath)}.lua";
            new ExcelToLua().GenerateLua(excelEditor.excelReader, outputPath);
            //同时写回到Excel文件
            excelEditor?.Save();
        }
        
        protected override void OnSelect(string id, int rowIndex, int colIndex)
        {
            excelEditor.excelReader.SetCellValue(id, rowIndex, colIndex);
        }
    }
}