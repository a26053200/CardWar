using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using ExcelExporter;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    /// <summary>
    /// <para></para>
    /// <para>Author: zhengnan </para>
    /// <para>Create: DATE TIME</para>
    /// </summary> 
    public class ExcelExporter
    {
        protected const string Type_String = "string";
        protected const string Type_Number = "number";
        protected const string SettingPath = "Assets/Edit/BattleEditorSetting.asset";
        
        protected static DataRow headFields;
        //protected static DataRow headNames;
        protected static DataRow headTypes;
        
        protected static BattleEditorSetting setting;
        protected static Dictionary<string, string> md5Dict;
        
        protected static void DoExcelExport(bool isForce, string type, ExcelExporter exporter)
        {
            setting = BattleEditorUtility.LoadSetting(SettingPath);
            string outputPath = type == "json" ? setting.jsonOutputPath : setting.luaOutputPath;
            string[] fileList = type == "json" ? setting.jsonExportList : setting.luaExportList;
            string md5Path = Application.dataPath + setting.excelFolder + "md5.txt";
            List<string> excelFileList = BattleEditorUtility.GetExcelFileList(setting.excelFolder, fileList);
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
                    Debug.Log($"<color=#3A9BF8FF>Export {type} Table - </color><color=#FFFFFFFF>{excelFileName}</color>");
                    ExcelEditor excelEditor = new ExcelEditor(excelFilePath);
                    excelEditor.Reload();
                    var output = $"{outputPath}/{Path.GetFileNameWithoutExtension(excelFilePath)}.{type}";
                    exporter.GenerateLua(excelEditor.excelReader, output);
                    BattleEditorUtility.DisplayProgress(i,excelFileList.Count, excelFilePath);
                }
            }
            Debug.Log("<color=#3A9BF8FF>End Export</color><color=#FFFFFFFF>:</color>");
            BattleEditorUtility.SaveDictionary(md5Path, md5Dict);
            EditorUtility.ClearProgressBar();
        }

        public virtual void GenerateLua(ExcelReader reader, string outputPath)
        {
            
        }
        
        protected void Output(StringBuilder sb, string outputPath)
        {
            Debug.Log(sb.ToString());
            if (File.Exists(outputPath))
                File.Delete(outputPath);
            EditUtils.SaveUTF8TextFile(outputPath,sb.ToString());
        }
    }
}