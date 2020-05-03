using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using UnityEngine;

namespace BattleEditor
{
    public class ExcelReader
    {
        public string xlsxPath;
        private XSSFWorkbook xssfWorkbook;
        private string className;
        private DataTable _dataTable;
        public DataTable dataTable { get{return _dataTable;}}

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
            GetExcelFieldList();
        }
        private void GetExcelFieldList()
        {
            ISheet sheet = xssfWorkbook.GetSheetAt(0);// 第一张表
            IEnumerator rows = sheet.GetRowEnumerator();
            if (!rows.MoveNext())
            {
                Debug.LogError("字段行不存在! 表： " + className);
                return;
            }
            _dataTable = new DataTable();
            
            IRow fieldRow = (XSSFRow)rows.Current;// 字段行
            rows.MoveNext();
            IRow fileTypeRow = (XSSFRow)rows.Current;// 字段类型行
            rows.MoveNext();
            IRow commentRow = (XSSFRow)rows.Current;// 字段描述行
            DataRow fieldDataRow =_dataTable.NewRow();
            DataRow fieldTypeDataRow =_dataTable.NewRow();
            DataRow commentDataRow =_dataTable.NewRow();
            
            for (int i = 0; i < fieldRow.LastCellNum; i++)
            {
                _dataTable.Columns.Add(fieldRow.GetCell(i).StringCellValue);  
                //fieldDataRow[i] = fieldRow.GetCell(i).StringCellValue;
                fieldTypeDataRow[i] = fileTypeRow.GetCell(i).StringCellValue;
                commentDataRow[i] = commentRow.GetCell(i).StringCellValue;
            }
            _dataTable.Rows.Add(fieldTypeDataRow);
            _dataTable.Rows.Add(commentDataRow);
            //分析数据
            ICell cell;//格子
            IRow row;
            int srcRowNum = 0;
            int tempCount = 0;
            DataRow dataRow;
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
                dataRow = _dataTable.NewRow();
                for (int i = 0; i < _dataTable.Columns.Count; i++)
                {
                    cell = row.GetCell(i);
                    try
                    {
                        if (cell.CellType == CellType.Formula)//格子含有计算公式
                        {
                            switch (cell.CachedFormulaResultType)
                            {
                                case CellType.Boolean:
                                    dataRow[i] = cell.BooleanCellValue.ToString();
                                    break;
                                case CellType.Error:
                                    dataRow[i] = cell.ErrorCellValue.ToString();
                                    break;
                                case CellType.Numeric:
                                    dataRow[i] = cell.NumericCellValue.ToString(CultureInfo.InvariantCulture);
                                    break;
                                case CellType.String:
                                    dataRow[i] = cell.StringCellValue;
                                    break;
                                default:
                                    dataRow[i] = cell.ToString();
                                    break;
                            }
                        }
                        else
                        {
                            dataRow[i] = cell.ToString();
                        }
                    }
                    catch (Exception e)
                    {
                        Debug.LogError(e.Message + "\n Row:" + cell.RowIndex + " Col:" + cell.ColumnIndex);
                        return;
                    }
                    //Debug.Log(cellValueString);
                }
                _dataTable.Rows.Add(dataRow);
            }
        }

        private ICell GetCell(int rowIndex, int colIndex)
        {
            ISheet sheet = xssfWorkbook.GetSheetAt(0);// 第一张表
            IEnumerator rows = sheet.GetRowEnumerator();
            int rowCount = 0;
            while (rowCount < rowIndex)
            {
                rows.MoveNext();
                rowCount++;
            }
            var row = (XSSFRow)rows.Current;
            return row.GetCell(colIndex);
        }
        public void Save()
        {
            try
            {
                if(File.Exists(xlsxPath))
                    File.Delete(xlsxPath);
                FileStream fs = File.OpenWrite(xlsxPath);
                xssfWorkbook.Write(fs);//向打开的这个Excel文件中写入表单并保存。  
                fs.Close();
            }
            catch (Exception e)
            {
                Debug.LogError(e.Message);
            }
        }

        public void Dispose()
        {
            xssfWorkbook?.Clear();
        }
        public bool SaveDataTableToExcel()  
        {  
            bool result = false;  
            IWorkbook workbook = null;  
            FileStream fs = null;  
            IRow row = null;  
            ISheet sheet = null;  
            ICell cell = null;  
            try  
            {  
                if (_dataTable != null && _dataTable.Rows.Count > 0)  
                {  
                    sheet = xssfWorkbook.GetSheet("Sheet0");//创建一个名称为Sheet0的表  
                    IEnumerator rows = sheet.GetRowEnumerator();
                    int rowCount = _dataTable.Rows.Count;//行数  
                    int columnCount = _dataTable.Columns.Count;//列数  
  
                    //设置列头  
                    row = sheet.CreateRow(0);//excel第一行设为列头  
                    for (int c = 0; c < columnCount; c++)  
                    {  
                        cell = row.CreateCell(c);  
                        cell.SetCellValue(_dataTable.Columns[c].ColumnName);  
                    }                      
  
                    //设置每行每列的单元格,  
                    for (int i = 0; i <rowCount; i++)  
                    {  
                        row = sheet.CreateRow(i+1);  
                        for (int j = 0; j < columnCount; j++)  
                        {                              
                            cell = row.CreateCell(j);//excel第二行开始写入数据  
                            SetCellValue(cell, _dataTable.Rows[i][j]);
                        }  
                    }

                    string savePath = Application.dataPath + "/../Excel/test.xlsx";
                    if(File.Exists(savePath))
                        File.Delete(savePath);
                    using (fs = File.OpenWrite(savePath))   
                    {  
                        workbook.Write(fs);//向打开的这个xls文件中写入数据  
                        result = true;  
                    }  
                }  
                return result;  
            }  
            catch (Exception ex)  
            {  
                if (fs != null)  
                {  
                    fs.Close();  
                }  
                return false;  
            }  
        }  
        //根据数据类型设置不同类型的cell
        public void SetCellValue(object obj,int rowIndex,int colIndex)
        {
//            Debug.Log("SetCellValue:" + obj.ToString());
            if (obj is int)
            {
                _dataTable.Rows[rowIndex][colIndex] = (int) obj;
            }
            else if (obj is double)
            {
                _dataTable.Rows[rowIndex][colIndex] = (double) obj;
            }
            else if (obj.GetType() == typeof(IRichTextString))
            {
                _dataTable.Rows[rowIndex][colIndex] = (IRichTextString) obj;
            }
            else if (obj is string)
            {
                _dataTable.Rows[rowIndex][colIndex] = obj.ToString();
            }
            else if (obj is DateTime)
            {
                _dataTable.Rows[rowIndex][colIndex] = (DateTime) obj;
            }
            else if (obj is bool)
            {
                _dataTable.Rows[rowIndex][colIndex] = (bool) obj;
            }
            else
            {
                _dataTable.Rows[rowIndex][colIndex] = obj.ToString();
            }
            ICell cell = GetCell(rowIndex + 2, colIndex);
            SetCellValue(cell, obj);
        }
        public void SetCellValue(ICell cell, object obj)
        {
//            Debug.Log("SetCellValue:" + obj.ToString());
            if (obj is int i)
            {
                cell.SetCellValue(i);
            }
            else if (obj is double d)
            {
                cell.SetCellValue(d);
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