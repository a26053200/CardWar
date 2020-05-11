using System;
using System.Data;
using Framework;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    public class SelectWnd: ListEditorWnd
    {
        public delegate void OnRowSelect(string firstColValue, int rowIndex);
        public OnRowSelect rowSelect;

        private ExcelEditor parentExcelEditor;
        private int parentRowIndex;
        private int parentColIndex;
        private Action<string> _selectDelegate;
        public new static SelectWnd Create(string title, EditorWindow parent,  LuaReflect luaReflect, string excelPath)
        {
            Rect rect = new Rect(parent.position.x + parent.position.width + 20,parent.position.y, parent.position.width, parent.position.height);
            SelectWnd wnd = EditorWindow.CreateWindow<SelectWnd>(title);
            wnd.position = rect;
            ExcelEditor excelEditor = new ExcelEditor(excelPath);
            wnd.ShowWnd(excelEditor);
            int[] showRows = new int[excelEditor.dataTable.Rows.Count - 2];
            for (int i = 0; i < showRows.Length; i++)
                showRows[i] = i + 2;
            wnd.SetShowRows(showRows, false);
            wnd.luaReflect = luaReflect;
            return wnd;
        }

        public void SetSelectDelegate(Action<string> action)
        {
            _selectDelegate = action;
        }

        protected override void DrawFoldout(int index)
        {
            EditorGUILayout.BeginHorizontal();
            var id = excelEditor.dataTable.Rows[showRows[index]][0].ToString();
            foldOpen[index] = EditorGUILayout.Foldout(foldOpen[index] , id);
            if (GUILayout.Button("Select"))
            {
                rowSelect?.Invoke(id, index);
                OnSelect(id, index);
                Close();
            }
            EditorGUILayout.EndHorizontal();
        }
        
        protected void OnSelect(string id, int rowIndex)
        {
            _selectDelegate?.Invoke(id);
        }
    }
}