using System;
using System.Collections.Generic;
using System.Data;
using NPOI.SS.UserModel;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    /// <summary>
    /// <para></para>
    /// <para>Author: zhengnan </para>
    /// <para>Create: DATE TIME</para>
    /// </summary> 
    public class ExcelEditor
    {
        private string _excelPath;
        
        private ExcelReader _excelReader;
        public ExcelReader excelReader { get { return _excelReader; } }
        
        private DataTable _dataTable;
        public DataTable dataTable { get { return _dataTable; } }
        public ExcelEditor(string excelPath)
        {
            _excelPath = excelPath;
            Reload();
        }
        public int GetRowIndex(string fieldName, string value)
        {
            for (int i = 0; i < _dataTable.Columns.Count; i++)
            {
                if (_dataTable.Columns[i].ColumnName == fieldName)
                {
                    for (int j = 0; j < _dataTable.Rows.Count; j++)
                    {
                        if ((string) _dataTable.Rows[j][i] == value)
                        {
                            return j;
                        }
                    }
                    break;
                }
            }
            return -1;
        }
        
        public void Reload()
        {
            _excelReader?.Dispose();
            _excelReader = new ExcelReader();
            _excelReader.LoadExcelFile(Application.dataPath + _excelPath);
            _dataTable = _excelReader.dataTable;
        }
        
        public void Save()
        {
//            _excelReader?.Save();
            _excelReader?.SaveDataTableToExcel();
        }
        
        public void DisplayRow(int rowIndex)
        {
            for (int i = 0; i < _dataTable.Columns.Count; i++)
            {
                var fieldName = _dataTable.Columns[i].ToString();
                var fieldType = _dataTable.Rows[0][i].ToString();
                var fieldComment = _dataTable.Rows[1][i].ToString();
                if (fieldType == FieldType.String)
                {
                    DisplayString(fieldName, fieldComment, rowIndex,i);
                }else if (fieldType == FieldType.Number)
                {
                    DisplayNumber(fieldName, fieldComment, rowIndex, i);
                }else if (fieldType == FieldType.Bool)
                {
                    DisplayBool(fieldName, fieldComment, rowIndex, i);
                }
            }
        }

        public string GetRowJson(int rowIndex)
        {
            var json = BattleEditorUtility.DataRowToJson(_excelReader.dataTable.Columns,_excelReader.dataTable.Rows[rowIndex]);
            return json; 
        }
        
        public void DisplayString(string title,string comment,int rowIndex,int colIndex)
        {
            var value = _dataTable.Rows[rowIndex][colIndex].ToString();
            var newValue = EditorGUILayout.TextField(new GUIContent(title,comment), value);
            if(value != newValue)
                _excelReader.SetCellValue(newValue, rowIndex, colIndex);
        }
        public void DisplayNumber(string title,string comment, int rowIndex,int colIndex)
        {
            var value = double.Parse(_dataTable.Rows[rowIndex][colIndex].ToString());
            var newValue = EditorGUILayout.DoubleField(new GUIContent(title,comment), value);
            if (Math.Abs(value - newValue) > 0)
                _excelReader.SetCellValue(newValue, rowIndex, colIndex);
        }
        public void DisplayBool(string title,string comment, int rowIndex,int colIndex)
        {
            var value = bool.Parse(_dataTable.Rows[rowIndex][colIndex].ToString());
            var newValue = EditorGUILayout.Toggle(new GUIContent(title, comment), value);
            if (value != newValue)
                _excelReader.SetCellValue(newValue, rowIndex, colIndex);
        }
    }
}