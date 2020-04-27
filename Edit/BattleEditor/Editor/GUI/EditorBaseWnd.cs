using System;
using System.Collections.Generic;
using Framework;
using NPOI.SS.UserModel;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    public class EditorBaseWnd: PageWnd
    {
        protected EditorWindow _parent;
        protected ExcelReader _excelReader;
        protected List<FieldColVo> _fields;
        protected FieldColVo _firstCol;
        protected LuaReflect _luaReflect;

        protected bool[] foldOpen;
        public void ShowWnd(EditorWindow parent, LuaReflect luaReflect, string excelPath)
        {
            _parent = parent;
            _luaReflect = luaReflect;
            _excelReader = new ExcelReader();
            _excelReader.LoadExcelFile(Application.dataPath + excelPath);
            _fields = _excelReader.GetExcelFieldList();
            _firstCol = _fields[0];
            base.Show(_firstCol.valueList.Count);
            foldOpen = new bool[_fields[0].valueList.Count];
        }

        protected override void OnGUI()
        {
           base.OnGUI();
           DrawCommonButton();
        }
        protected override void DrawFields()
        {
            
        }
        protected override void DrawContent(int index)
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
            foldOpen[index] = EditorGUILayout.Foldout(foldOpen[index] , _firstCol.valueList[index]);
        }
        
        protected virtual void DrawFoldoutContent(int index)
        {
            EditorGUI.indentLevel++;
            DisplayRow(index);
            EditorGUI.indentLevel--;
        }
        protected void DrawCommonButton()
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField("",GUILayout.ExpandWidth(true));
            if (GUILayout.Button("Reload"))
            {
                
            }
            if (GUILayout.Button("Save"))
            {
                
            }
            if (GUILayout.Button("Close"))
            {
                this.Close();
            }
            EditorGUILayout.EndHorizontal();
        }
        
        protected void Reload()
        {
            
        }
        
        protected void Save()
        {
            _excelReader.Save();
        }
        
        protected void DisplayRow(int rowIndex)
        {
            for (int i = 0; i < _fields.Count; i++)
            {
                var field = _fields[i];
                if (field.fieldType == FieldType.String)
                {
                    DisplayString(field.fieldName, field.fieldComment, field.valueList[rowIndex], field.cellList[rowIndex]);
                }else if (field.fieldType == FieldType.Number)
                {
                    DisplayNumber(field.fieldName, field.fieldComment, field.valueList[rowIndex], field.cellList[rowIndex]);
                }else if (field.fieldType == FieldType.Bool)
                {
                    DisplayBool(field.fieldName, field.fieldComment, field.valueList[rowIndex], field.cellList[rowIndex]);
                }
            }
        }

        protected void DisplayString(string title,string comment,string value,ICell cell)
        {
            var newValue = EditorGUILayout.TextField(new GUIContent(title,comment), value);
            if (newValue != value)
                ExcelReader.SetCellValue(cell, newValue);
        }
        protected void DisplayNumber(string title,string comment,string value,ICell cell)
        {
            var newValue = EditorGUILayout.DoubleField(new GUIContent(title,comment), double.Parse(value));
            if (Math.Abs(newValue - double.Parse(value)) > 0)
                ExcelReader.SetCellValue(cell, newValue);
        }
        protected void DisplayBool(string title,string comment,string value,ICell cell)
        {
            var newValue = EditorGUILayout.Toggle(new GUIContent(title, comment), bool.Parse(value));
            if (newValue != bool.Parse(value))
                ExcelReader.SetCellValue(cell, newValue);
        }
    }
}