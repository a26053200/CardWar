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
        private string xlsxPath;
        private XSSFWorkbook xssfWorkbook;
        private string className;

        public void LoadExcelFile(string path)
        {
            xlsxPath = path;
            className = Path.GetFileNameWithoutExtension(xlsxPath);
            try
            {
                using (FileStream file = new FileStream(xlsxPath, FileMode.Open, FileAccess.ReadWrite))
                    xssfWorkbook = new XSSFWorkbook(file);
            }
            catch (System.Exception e)
            {
                Debug.LogError("Excel Error: " + xlsxPath + " : " + e.Message);
            }
        }
        public List<FieldColVo> GetExcelFieldList()
        {
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
                FieldColVo fieldVo = new FieldColVo(fieldRow.GetCell(i) ,fileTypeRow.GetCell(i), commentRow.GetCell(i));
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
                    fieldVo.cellList.Add(cell);
                    //Debug.Log(cellValueString);
                }
            }
            return fieldList;
        }
        
        private void ParserValue(FieldColVo fieldVo, string stringValue = null)
        {//获取当前格子的值
            if (stringValue == null)
            {
                if (fieldVo.fieldType == FieldType.String)
                    fieldVo.valueList.Add("");
                else if (fieldVo.fieldType == FieldType.Number)
                    fieldVo.valueList.Add("0");
                else if (fieldVo.fieldType == FieldType.Bool)
                    fieldVo.valueList.Add("false");
                else
                    fieldVo.valueList.Add("");
            }
            else
            {
                if (fieldVo.fieldType == FieldType.Bool)
                    fieldVo.valueList.Add(stringValue.ToLowerInvariant());
                else
                    fieldVo.valueList.Add(stringValue);
            }
        }

        public void Save()
        {
            try
            {
                FileStream fs = File.OpenWrite(xlsxPath);
                xssfWorkbook.Write(fs);//向打开的这个Excel文件中写入表单并保存。  
                fs.Close();
            }
            catch (Exception e)
            {
                Debug.LogError(e.Message);
            }
        }

        //根据数据类型设置不同类型的cell
        public static void SetCellValue(ICell cell, object obj)
        {
            if (obj is int)
            {
                cell.SetCellValue((int)obj);
            }
            else if (obj is double)
            {
                cell.SetCellValue((double)obj);
            }
            else if (obj.GetType() == typeof(IRichTextString))
            {
                cell.SetCellValue((IRichTextString)obj);
            }
            else if (obj is string)
            {
                cell.SetCellValue(obj.ToString());
            }
            else if (obj is DateTime)
            {
                cell.SetCellValue((DateTime)obj);
            }
            else if (obj is bool)
            {
                cell.SetCellValue((bool)obj);
            }
            else
            {
                cell.SetCellValue(obj.ToString());
            }
        }
    }
}