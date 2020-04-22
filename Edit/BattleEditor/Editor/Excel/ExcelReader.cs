using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using UnityEngine;

namespace BattleEditor
{
    public class ExcelReader
    {
        public class FieldType
        {
            public const string String = "string";
            public const string Number = "number";
            public const string Bool = "bool";
        }
        public class FieldColVo
        {
            public string fieldName { get; private set; }//字段名
            public string fieldComment { get; private set; }//字段注释
            public readonly string FieldType;//字段类型
            public List<string> ValueList;
            public FieldColVo(string fieldName, string fieldType, string fieldComment)
            {
                this.fieldComment   = fieldComment;
                this.fieldName      = fieldName;
                if (string.IsNullOrEmpty(fieldType))
                    this.FieldType = ExcelReader.FieldType.String;
                else
                    this.FieldType = fieldType.ToLowerInvariant();
            }
        }
        public List<FieldColVo> GetExcelFieldList(string xlsxPath)
        {
            string className = Path.GetFileNameWithoutExtension(xlsxPath);
            //读取excel文件
            XSSFWorkbook xssfWorkbook = null;
            try
            {
                using (FileStream file = new FileStream(xlsxPath, FileMode.Open, FileAccess.ReadWrite))
                    xssfWorkbook = new XSSFWorkbook(file);
            }
            catch (System.Exception e)
            {
                Debug.LogError("Excel Error: " + xlsxPath + " : " + e.Message);
                return null;
            }

            ISheet sheet = xssfWorkbook.GetSheetAt(0);// 第一张表
            IEnumerator rows = sheet.GetRowEnumerator();
            if (!rows.MoveNext())
            {
                Debug.LogError("字段行不存在! 表： " + className);
                return null;
            }
            IRow fieldRow = (XSSFRow)rows.Current;// 字段行
            rows.MoveNext();
            IRow fileTypeRow = (XSSFRow)rows.Current;// 字段类型行
            rows.MoveNext();
            IRow commentRow = (XSSFRow)rows.Current;// 字段描述行

            List<FieldColVo> fieldList = new List<FieldColVo>();//字段列表

            for (int i = 0; i < fieldRow.LastCellNum; i++)
            {
                ICell fieldCell = fieldRow.GetCell(i);
                ICell fileTypeCell = fileTypeRow.GetCell(i);
                ICell commentCell = commentRow.GetCell(i);
                FieldColVo fieldVo = new FieldColVo(fieldCell.ToString() ,fileTypeCell.ToString(), commentCell.ToString());
                fieldList.Add(fieldVo);
            }
            //分析数据
            ICell cell;//格子
            IRow row;
            int srcRowNum = 0;
            int tempCount = 0;
            
            while (rows.MoveNext())
            {
                tempCount++;
                row = (XSSFRow)rows.Current;
                if (row.ZeroHeight)
                {
                    Debug.Log($"FileName:{Path.GetFileName(xlsxPath)} row:{tempCount}已隐藏");
                    continue;
                }
                  
                if (row.LastCellNum == 0)
                    continue;
                //这一行的每一列
                //dataRowNum++;
                srcRowNum++;
                for (int i = 0; i < fieldList.Count; i++)
                {
                    FieldColVo fieldVo = fieldList[i];
                    cell = row.GetCell(i);
                    var cellValueString = string.Empty;
                    try
                    {
                        if (cell.CellType == CellType.Formula)//格子含有计算公式
                        {
                            switch (cell.CachedFormulaResultType)
                            {
                                case CellType.Boolean:
                                    cellValueString = cell.BooleanCellValue.ToString();
                                    break;
                                case CellType.Error:
                                    cellValueString = cell.ErrorCellValue.ToString();
                                    break;
                                case CellType.Numeric:
                                    cellValueString = cell.NumericCellValue.ToString(CultureInfo.InvariantCulture);
                                    break;
                                case CellType.String:
                                    cellValueString = cell.StringCellValue;
                                    break;
                                default:
                                    cellValueString = cell.ToString();
                                    break;
                            }
                        }
                        else
                            cellValueString = cell.ToString();//直接取值
                    }
                    catch (Exception e)
                    {
                        Debug.LogError(e.Message + "\n Row:" + cell.RowIndex + " Col:" + cell.ColumnIndex);
                        return null;
                    }
                    ParserValue(fieldVo, cellValueString);
                    Debug.Log(cellValueString);
                }
            }
            return fieldList;
        }
        
        private void ParserValue(FieldColVo fieldVo, string stringValue = null)
        {//获取当前格子的值
            if (fieldVo.ValueList == null)
                fieldVo.ValueList = new List<string>();
            if (stringValue == null)
            {
                if (fieldVo.FieldType == FieldType.String)
                    fieldVo.ValueList.Add("");
                else if (fieldVo.FieldType == FieldType.Number)
                    fieldVo.ValueList.Add("0");
                else if (fieldVo.FieldType == FieldType.Bool)
                    fieldVo.ValueList.Add("false");
                else
                    fieldVo.ValueList.Add("");
            }
            else
            {
                if (fieldVo.FieldType == FieldType.Bool)
                    fieldVo.ValueList.Add(stringValue.ToLowerInvariant());
                else
                    fieldVo.ValueList.Add(stringValue);
            }
        }
    }
}