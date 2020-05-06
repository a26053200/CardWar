using System;
using System.Collections.Generic;
using Framework;
using NPOI.SS.UserModel;
using UnityEditor;
using UnityEngine;
using UnityEngine.Serialization;

namespace BattleEditor
{
    public class TableEditorWnd: ListEditorWnd
    {
        public delegate void OnRowSelect(string firstColValue, int rowIndex);

        public OnRowSelect rowSelect;
        public new static TableEditorWnd Create(string title, EditorWindow parent,  LuaReflect luaReflect, string excelPath)
        {
            Rect rect = new Rect(parent.position.x + parent.position.width + 20,parent.position.y,440,1136 * 0.5f);
            TableEditorWnd wnd = EditorWindow.CreateWindow<TableEditorWnd>(title);
            wnd.position = rect;
            wnd.ShowWnd(parent, luaReflect, excelPath);
            return wnd;
        }
      
        private void ShowWnd(EditorWindow parent, LuaReflect luaReflect, string excelPath)
        {
            excelEditor = new ExcelEditor(excelPath);
            int[] showRows = new int[excelEditor.dataTable.Rows.Count - 2];
            for (int i = 0; i < showRows.Length; i++)
                showRows[i] = i + 2;
            base.ShowWnd(excelEditor, showRows);
        }
        
        protected override void DrawFoldout(int index)
        {
            EditorGUILayout.BeginHorizontal();
            var id = excelEditor.dataTable.Rows[showRows[index]][0].ToString();
            foldOpen[index] = EditorGUILayout.Foldout(foldOpen[index] , id);
            if (GUILayout.Button("Select"))
            {
                rowSelect?.Invoke(id, index);
                Close();
            }
            EditorGUILayout.EndHorizontal();
        }
    }
}