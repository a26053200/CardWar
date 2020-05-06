
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
    public static class ExcelToLua
    {
        private static DataRow headFields;
        //private static DataRow headNames;
        private static DataRow headTypes;
        private const string Type_String = "string";
        private const string Type_Number = "number";

        private const string SettingPath = "Assets/Edit/BattleEditorSetting.asset";
        private static BattleEditorSetting setting;
        private static Dictionary<string, string> md5Dict;

        [MenuItem("Tools/Excel2Lua %#e")]
        static void DoExcelToLua()
        {
            DoExcelToLua(false);
        }
        
        [MenuItem("Tools/Excel2Lua Force")]
        static void DoExcelToLuaForce()
        {
            DoExcelToLua(true);
        }
        
        static void DoExcelToLua(bool isForce)
        {
            setting = BattleEditorUtility.LoadSetting(SettingPath);
            string md5Path = Application.dataPath + setting.excelFolder + "md5.txt";
            List<string> excelFileList = BattleEditorUtility.GetExcelFileList(setting.excelFolder);
            md5Dict = BattleEditorUtility.GetDictionaryFromFile(md5Path);
            if(md5Dict == null)
                md5Dict = new Dictionary<string, string>();
            Debug.Log("<color=#3A9BF8FF>Begin Export</color><color=#FFFFFFFF>:</color>");
            for (int i = 0; i < excelFileList.Count; i++)
            {
                var excelFilePath = excelFileList[i];
                var excelFileName = Path.GetFileName(excelFilePath);
                var md5 = BattleEditorUtility.GetFileMD5(excelFilePath.Replace("/../", ""));
                md5Dict.TryGetValue(excelFileName, out string oldMd5);
                bool modify = true;
                if(string.IsNullOrEmpty(oldMd5))
                    md5Dict.Add(excelFileName, md5);
                else if (oldMd5 != md5)
                    md5Dict[excelFileName] = md5;
                else
                    modify = false;
                if (isForce || modify)
                {
                    Debug.Log($"<color=#3A9BF8FF>Export Lua Table - </color><color=#FFFFFFFF>{excelFileName}</color>");
                    ExcelEditor excelEditor = new ExcelEditor(excelFilePath);
                    excelEditor.Reload();
                    var outputPath = $"{setting.outputPath}/{Path.GetFileNameWithoutExtension(excelFilePath)}.lua";
                    GenerateLua(excelEditor.excelReader, outputPath);
                    BattleEditorUtility.DisplayProgress(i,excelFileList.Count, excelFilePath);
                }
            }
            Debug.Log("<color=#3A9BF8FF>End Export</color><color=#FFFFFFFF>:</color>");
            BattleEditorUtility.SaveDictionary(md5Path, md5Dict);
            EditorUtility.ClearProgressBar();
        }
        
        public static void GenerateLua(ExcelReader reader, string outputPath)
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
        private static void ExecuteFile(int rowIndex, DataColumnCollection columns, DataRow row,StringBuilder sb)
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
        private static void Output(StringBuilder sb, string outputPath)
        {
//           Debug.Log(sb.ToString());
           if (!File.Exists(outputPath))
               Directory.Delete(outputPath);
           EditUtils.SaveUTF8TextFile(outputPath,sb.ToString());
        }
    }
}