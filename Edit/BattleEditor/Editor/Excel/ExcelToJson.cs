
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    public class ExcelToJson : ExcelExporter
    {
        static readonly string Setting_Path = "Assets/Res/ExcelExporterSetting.asset";

        private static BattleEditorSetting setting;
        private static Dictionary<string, string> md5Dict;
        
        [MenuItem("Tools/Excel/Excel2Json %#j")]
        public static void DoExcel2Json()
        {
            DoExcelExport(false, "json", new ExcelToJson());
        }
        
        [MenuItem("Tools/Excel/Excel2Json Force")]
        public static void DoExcel2JsonForce()
        {
            DoExcelExport(true, "json", new ExcelToJson());
        }
        
        public override void GenerateLua(ExcelReader reader, string outputPath)
        {
            var sb = new StringBuilder();
            sb.Append("{");
            sb.Append("\r\t\"list\":[");
            sb.AppendLine();
            for (int i = 0; i < reader.dataTable.Rows.Count; i++)
            {
                ExecuteFile(i, reader.dataTable.Columns, reader.dataTable.Rows[i], sb);
                if (i > 1 && i < reader.dataTable.Rows.Count - 1)
                {
                    sb.Append(",");
                    sb.AppendLine();
                }
            }
            
            sb.Append("\r\t]");
            sb.AppendLine();
            sb.Append("}");
            Output(sb, outputPath);
        }
        private void ExecuteFile(int rowIndex, DataColumnCollection columns, DataRow row,StringBuilder sb)
        {
            if (rowIndex == 0)
            {
                headTypes = row;
            }
            else if (rowIndex == 1)
            {
                //headNames = row;
            }
            else
            {
                //sb.Append($"    [{row[0]}]");
                sb.Append("\t\t{");
                for (int i = 0; i < columns.Count; i++)
                {
                    if ((string) headTypes[i] == Type_Number)
                    {
                        if (string.IsNullOrEmpty(row[i].ToString()))
                            sb.Append($"\"{columns[i].ColumnName}\": 0");
                        else
                            sb.Append($"\"{columns[i].ColumnName}\": {row[i]}");
                    }
                    else
                        sb.Append($"\"{columns[i].ColumnName}\": \"{row[i]}\"");
                    if(i < columns.Count - 1)
                        sb.Append(",");
                }
                sb.Append("}");
            }
        }
    }
}