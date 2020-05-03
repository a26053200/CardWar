using System;
using UnityEngine;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using UnityEditor;
using Object = UnityEngine.Object;

namespace BattleEditor
{
    /// <summary>
    /// <para>Class Introduce</para>
    /// <para>Author: zhengnan</para>
    /// <para>Create: 2019/6/12 22:48:38</para>
    /// </summary> 
    public static class BattleEditorUtility
    {
        public static List<string> GetExcelFileList(string excelFolder)
        {
            List<string> excelFileList = new List<string>();
            DirectoryInfo dirs = new DirectoryInfo(Application.dataPath + excelFolder);
            FileInfo[] files = dirs.GetFiles("*.xlsx", SearchOption.AllDirectories);
        
            for (int i = 0; i < files.Length; i++)
                excelFileList.Add(Path.Combine(excelFolder, files[i].Name));
            if(excelFileList.Count == 0)
                Debug.LogErrorFormat("There is not any excel file in folder");
            return excelFileList;
        }
        
        public static void DisplayProgress(int progress, int total, string file)
        {
            string title = $"Progress..[{progress}/{total}]";
            EditorUtility.DisplayCancelableProgressBar(title, file, (float) progress / (float) total);
        }
        
        public static BattleEditorSetting LoadSetting(string settingPath)
        {
            if (!File.Exists(settingPath))
                CreateAsset<BattleEditorSetting>(settingPath);
            return AssetDatabase.LoadAssetAtPath<BattleEditorSetting>(settingPath);
        }
        
        /// <summary>
        /// 绝对路径->相对路径
        /// </summary>
        public static string Absolute2Relativity(string path)
        {
            string temp = path.Substring(path.IndexOf("Assets"));
            temp = temp.Replace('\\', '/');
            return temp;
        }
        
        /// <summary>
        /// 创建asset配置文件
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="path"></param>
        public static void CreateAsset<T>(string path) where T : ScriptableObject
        {
            T asset = ScriptableObject.CreateInstance<T>();
            if (string.IsNullOrEmpty(path))
            {
                Debug.LogError("Not select files, select files first! ");
                return;
            }
            string assetPathAndName = AssetDatabase.GenerateUniqueAssetPath(path);
            AssetDatabase.CreateAsset(asset, assetPathAndName);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            EditorUtility.FocusProjectWindow();
            Selection.activeObject = asset;
        }

        public static void SaveUTF8TextFile(string fn, string txt)
        {
            byte[] data = System.Text.UTF8Encoding.UTF8.GetBytes(txt);
            byte[] bom = new byte[] { 0xef, 0xbb, 0xbf };
            byte[] saveData = new byte[data.Length + bom.Length];
            Array.Copy(bom, 0, saveData, 0, bom.Length);
            Array.Copy(data, 0, saveData, bom.Length, data.Length);
            SaveFileData(fn, saveData);
        }

        public static byte[] GetFileData(string fn)
        {
            if (!File.Exists(fn))
                return null;
            FileStream fs = new FileStream(fn, FileMode.Open);
            try
            {
                if (fs.Length > 0)
                {
                    byte[] data = new byte[(int)fs.Length];
                    fs.Read(data, 0, (int)fs.Length);
                    return data;
                }
                else
                {
                    return null;
                }
            }
            finally
            {
                fs.Close();
            }
        }

        public static void SaveFileData(string fn, byte[] data)
        {
            string dir = Path.GetDirectoryName(fn);
            System.IO.DirectoryInfo dirinfo = new System.IO.DirectoryInfo(dir);
            if (!dirinfo.Exists)
                dirinfo.Create();
            FileStream fs = new FileStream(fn, FileMode.Create);
            try
            {
                fs.Write(data, 0, data.Length);
            }
            finally
            {
                fs.Close();
            }
        }

        public static Dictionary<string, string> GetDictionaryFromFile(string fn)
        {
            byte[] data = GetFileData(fn);
            if (data != null)
            {
                ByteReader br = new ByteReader(data);
                return br.ReadDictionary();
            }
            return null;
        }

        public static void SaveDictionary(string fn, Dictionary<string, string> dic)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            foreach (string k in dic.Keys)
            {
                string v = dic[k];
                sb.Append(string.Format("{0}={1}\r\n", k, v));
            }
            byte[] data = System.Text.ASCIIEncoding.ASCII.GetBytes(sb.ToString());
            SaveFileData(fn, data);

        }

        /// <summary>
        /// 获取文件的MD5值
        /// </summary>
        /// <param name="_PathValue"></param>
        /// <returns></returns>
        public static string GetFileMD5(string _PathValue)
        {
            string fileMd5 = "";
            string tempPath = Application.dataPath.Replace("Assets", "");
            //外部文件的MD5值
            try
            {
                FileStream fs = new FileStream(tempPath + _PathValue, FileMode.Open);

                System.Security.Cryptography.MD5 md5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
                byte[] retVal = md5.ComputeHash(fs);
                fs.Close();
                for (int i = 0; i < retVal.Length; i++)
                {
                    fileMd5 += retVal[i].ToString("x2");
                }
            }
            catch (System.Exception ex)
            {
                Debug.Log(ex);
            }
            return fileMd5;
        }
        
        public static string DataRowToJson(DataColumnCollection columns, DataRow valueRow)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            for (int i = 0; i < columns.Count; i++)
            {
                if (IsNumberic(valueRow[i]))
                    sb.Append($"\"{columns[i].ColumnName}\": {valueRow[i]}");
                else
                    sb.Append($"\"{columns[i].ColumnName}\": \"{valueRow[i]}\"");
                if(i < columns.Count - 1)
                    sb.Append(", ");
            }
            sb.Append("}");
            return sb.ToString();
        }
        //判断字符串是否是数字
        static bool IsNumberic(object message)
        {
            System.Text.RegularExpressions.Regex rex=
                new System.Text.RegularExpressions.Regex(@"^\d+$");
            return rex.IsMatch(message.ToString());
        }
    }
}
    

