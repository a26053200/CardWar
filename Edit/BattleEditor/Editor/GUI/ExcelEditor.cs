using System;
using System.Collections.Generic;
using System.Data;
using LitJson;
using NPOI.SS.UserModel;
using UnityEditor;
using UnityEngine;
using UnityEngine.Windows;

namespace BattleEditor
{
    /// <summary>
    /// <para></para>
    /// <para>Author: zhengnan </para>
    /// <para>Create: DATE TIME</para>
    /// </summary> 
    public class ExcelEditor
    {
        public delegate void OnLinkEditor(ExcelColHeader header, string vid);
        
        private string _excelPath;
        
        private ExcelReader _excelReader;
        
        private Dictionary<string, ExcelColHeader>  _excelColHeaderDict;
        public ExcelReader excelReader { get { return _excelReader; } }
        
        private DataTable _dataTable;
        public DataTable dataTable { get { return _dataTable; } }
        
        public OnLinkEditor LinkEditor;
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
        
        public int[] GetRowIndexes(string fieldName, string value)
        {
            List<int> indexes = new List<int>();
            for (int i = 0; i < _dataTable.Columns.Count; i++)
            {
                if (_dataTable.Columns[i].ColumnName == fieldName)
                {
                    for (int j = 0; j < _dataTable.Rows.Count; j++)
                    {
                        if ((string) _dataTable.Rows[j][i] == value)
                        {
                            indexes.Add(j);
                        }
                    }
                    break;
                }
            }
            return indexes.ToArray();
        }
        
        public void Reload()
        {
            _excelReader?.Dispose();
            _excelReader = new ExcelReader();
            _excelReader.LoadExcelFile(Application.dataPath + _excelPath);
            _excelColHeaderDict = BattleEditorUtility.GetExcelHeaderList(_excelPath);
            _dataTable = _excelReader.dataTable;
        }
        
        public void Save()
        {
            _excelReader?.Save();
//            _excelReader?.SaveDataTableToExcel();
        }
        
        public void DisplayRow(int rowIndex)
        {
            for (int i = 0; i < _dataTable.Columns.Count; i++)
            {
                var fieldName = _dataTable.Columns[i].ToString();
                var fieldType = _dataTable.Rows[0][i].ToString();
                var fieldComment = _dataTable.Rows[1][i].ToString();
                var header = _excelColHeaderDict[fieldName];
                if (header.IsString())
                {
                    DisplayString(fieldName, fieldComment, rowIndex,i, header);
                }else if (fieldType == FieldType.Number)
                {
                    if(header.IsSliderFloat())
                        DisplaySliderFloat(fieldName, fieldComment, rowIndex, i, header);
                    else if(header.IsSliderInt())
                        DisplaySliderInt(fieldName, fieldComment, rowIndex, i, header);
                    else
                        DisplayNumber(fieldName, fieldComment, rowIndex, i, header);
                }else if (header.IsBool())
                {
                    DisplayBool(fieldName, fieldComment, rowIndex, i);
                }else if (header.IsEnum())
                {
                    DisplayEnum(fieldName, fieldComment, rowIndex, i, header);
                }
            }
        }

        public string GetRowJson(int rowIndex)
        {
            var json = BattleEditorUtility.DataRowToJson(_excelReader.dataTable.Columns,_excelReader.dataTable.Rows[rowIndex]);
            return json; 
        }
        
        private void DisplayString(string title,string comment,int rowIndex,int colIndex, ExcelColHeader header)
        {
            EditorGUILayout.BeginHorizontal();
            var value = _dataTable.Rows[rowIndex][colIndex].ToString();
            var newValue = EditorGUILayout.TextField(new GUIContent(title,comment), value);
            if(value != newValue)
                _excelReader.SetCellValue(newValue, rowIndex, colIndex);
            if (!string.IsNullOrEmpty(header.linkEditorUrl) && GUILayout.Button("..."))
                LinkEditor(header, newValue);
            EditorGUILayout.EndHorizontal();
        }
        private void DisplayNumber(string title,string comment, int rowIndex,int colIndex, ExcelColHeader header)
        {
            EditorGUILayout.BeginHorizontal();
            string valueStr = _dataTable.Rows[rowIndex][colIndex].ToString();
            var value = string.IsNullOrEmpty(valueStr) ? 0 : double.Parse(valueStr);
            var newValue = EditorGUILayout.DoubleField(new GUIContent(title,comment), value);
            if (Math.Abs(value - newValue) > 0)
                _excelReader.SetCellValue(newValue, rowIndex, colIndex);
            EditorGUILayout.EndHorizontal();
        }
        
        private void DisplaySliderInt(string title,string comment, int rowIndex,int colIndex, ExcelColHeader header)
        {
            var value = int.Parse(_dataTable.Rows[rowIndex][colIndex].ToString());
            var newValue = EditorGUILayout.IntSlider(new GUIContent(title,comment), value, header.minIntValue, header.maxIntValue);
            if (Math.Abs(value - newValue) > 0)
                _excelReader.SetCellValue(newValue, rowIndex, colIndex);
        }
        
        private void DisplaySliderFloat(string title,string comment, int rowIndex,int colIndex, ExcelColHeader header)
        {
            var value = float.Parse(_dataTable.Rows[rowIndex][colIndex].ToString());
            var newValue = EditorGUILayout.Slider(new GUIContent(title,comment), value, header.minFloatValue, header.maxFloatValue);
            if (Math.Abs(value - newValue) > 0)
                _excelReader.SetCellValue(newValue, rowIndex, colIndex);
        }
        
        private void DisplayBool(string title,string comment, int rowIndex,int colIndex)
        {
            var value = bool.Parse(_dataTable.Rows[rowIndex][colIndex].ToString());
            var newValue = EditorGUILayout.Toggle(new GUIContent(title, comment), value);
            if (value != newValue)
                _excelReader.SetCellValue(newValue, rowIndex, colIndex);
        }

        
        private void DisplayEnum(string title,string comment, int rowIndex,int colIndex, ExcelColHeader header)
        {
            var value = _dataTable.Rows[rowIndex][colIndex].ToString();
            var options = header.fieldEnum;
            int selectIndex = Array.IndexOf(options, value);
            var newIndex = EditorGUILayout.Popup(new GUIContent(title, comment), selectIndex, options);
            if (newIndex != selectIndex)
                _excelReader.SetCellValue(options[newIndex], rowIndex, colIndex);
        }

        public void GenerateHeaderJson(bool forceGenerate)
        {
            var jsonPath = Application.dataPath + _excelPath.Replace(".xlsx", ".json");
            if (forceGenerate && File.Exists(jsonPath))
                File.Delete(jsonPath);
            if (!File.Exists(jsonPath))
            {
                JsonData json = new JsonData();
                for (int i = 0; i < _dataTable.Columns.Count; i++)
                {
                    var fieldName = _dataTable.Columns[i].ToString();
                    var fieldType = _dataTable.Rows[0][i].ToString();
                    JsonData headerNode = new JsonData();
                    json[fieldName] = headerNode;
                    headerNode["fieldType"] = fieldType;
                }
                string jsonStr = JsonMapper.ToJson(json);
                BattleEditorUtility.SaveUTF8TextFile(jsonPath, JCode.ToFormart(jsonStr));
            }
        }
    }
}