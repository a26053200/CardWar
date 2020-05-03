using System;
using System.Collections.Generic;
using Framework;
using NPOI.SS.UserModel;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    public class ListEditorWnd: EditorBaseWnd
    {
        public delegate void OnRowSelect(string firstColValue, int rowIndex);

        public OnRowSelect onRowSelect;
        public static ListEditorWnd Create(EditorWindow parent,  LuaReflect luaReflect, string excelPath)
        {
            Rect rect = new Rect(parent.position.x + parent.position.width + 20,parent.position.y,440,1136 * 0.5f);
            ListEditorWnd wnd = EditorWindow.GetWindow<ListEditorWnd>(true, "BattleUnitEditor");
            wnd.position = rect;
            wnd.ShowWnd(parent, luaReflect, excelPath);
            return wnd;
        }
        
        private bool[] foldOpen;
        private ExcelEditor excelEditor;
        public void ShowWnd(EditorWindow parent, LuaReflect luaReflect, string excelPath)
        {
            base.ShowWnd(parent, luaReflect);
            excelEditor = new ExcelEditor(excelPath);
            foldOpen = new bool[excelEditor.dataTable.Rows.Count - 2];
            base.SetPageCount(excelEditor.dataTable.Rows.Count - 2);
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
            var id = excelEditor.dataTable.Rows[index + 2][0].ToString();
            foldOpen[index] = EditorGUILayout.Foldout(foldOpen[index] , id);
            if (GUILayout.Button("Select"))
            {
                onRowSelect?.Invoke(id, index);
                Close();
            }
            EditorGUILayout.EndHorizontal();
        }
        
        protected virtual void DrawFoldoutContent(int index)
        {
            EditorGUI.indentLevel++;
            excelEditor.DisplayRow(index + 2);
            EditorGUI.indentLevel--;
            DrawBottom();
        }
    }
}