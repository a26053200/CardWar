
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using ExcelExporter;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    public class ExcelToLua : ExcelExporter
    {
        [MenuItem("Tools/Excel/Excel2Lua %#l")]
        public static void DoExcelToLua()
        {
            DoExcelExport(false, "lua", new ExcelToLua());
        }
        
        [MenuItem("Tools/Excel/Excel2Lua Force")]
        public static void DoExcelToLuaForce()
        {
            DoExcelExport(true, "lua", new ExcelToLua());
        }
        
        public override void GenerateLua(ExcelReader reader, string outputPath)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append($"-- {Path.GetFileNameWithoutExtension(reader.xlsxPath)} Last Edit By:{Environment.UserName}");
            sb.AppendLine();
            sb.Append("local Data = {}");
            sb.AppendLine();
            sb.Append("Data.table = {");
            for (int i = 0; i < reader.dataTable.Rows.Count; i++)
            {
                ExecuteFile(i, reader.dataTable.Columns, reader.dataTable.Rows[i], sb);
            }
            sb.Append("}");
            sb.AppendLine();
            
            sb.AppendLine(@"
function Data.Get(id)
    if Data.table[id] == nil then
        logError(string.format('There is no id = %s data is table <"+ Path.GetFileName(reader.xlsxPath) + @">', id))
        return nil
    else
        return Data.table[id]
    end
end

return Data
                ");
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
                if ((string) headTypes[0] == Type_Number)
                    sb.Append($"    [{row[0]}]");
                else
                    sb.Append($"    [\"{row[0]}\"]");
                sb.Append(" = {");
                for (int i = 0; i < columns.Count; i++)
                {
                    if ((string) headTypes[i] == Type_Number)
                    {
                       if (string.IsNullOrEmpty(row[i].ToString()))
                            sb.Append($"{columns[i].ColumnName} = 0");
                       else
                            sb.Append($"{columns[i].ColumnName} = {row[i]}");
                    }
                    else
                        sb.Append($"{columns[i].ColumnName} = \"{row[i]}\"");
                    if(i < columns.Count - 1)
                        sb.Append(", ");
                }
                sb.Append("},");
                sb.AppendLine();
            }
        }
    }
}