using System;
using UnityEngine;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using Object = UnityEngine.Object;

namespace BattleEditor
{
    /// <summary>
    /// <para>Class Introduce</para>
    /// <para>Author: zhengnan</para>
    /// <para>Create: 2019/6/12 22:48:38</para>
    /// </summary> 
    public static class EditUtility
    {
        
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
        
        /// <summary>
        /// 获取该目录下面所有的文件,包含子目录
        /// </summary>
        /// <param name="path"></param>
        /// <param name="searchPattern">文件后缀名  例如: "(*.jpg|*.bmp)"</param>
        /// <returns></returns>
        public static FileInfo[] GetAllFiles(string path, string searchPattern)
        {
            DirectoryInfo root = new DirectoryInfo(path);
            FileInfo[] files = root.GetFiles(searchPattern, SearchOption.AllDirectories);
            return files;
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
        /// 相对路径->绝对路径
        /// </summary>
        public static string Relativity2Absolute(string path)
        {
            DirectoryInfo direction = new DirectoryInfo(path);
            FileInfo[] files = direction.GetFiles("*", SearchOption.TopDirectoryOnly);
            if (files.Length > 0)
            {
                path = files[0].DirectoryName;
                return path;
            }
            else
            {
                return null;
            }
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

        public static void DelFolder(string path)
        {
            if(Directory.Exists(path))
            {
                FileAttributes atr = File.GetAttributes(path);
                if (atr == FileAttributes.Directory)
                    Directory.Delete(path, true);
                else
                    File.Delete(path);
            }
        }

        public static void CopyDir(string srcPath, string dstPath)
        {
            try
            {
                // 检查目标目录是否以目录分割字符结束如果不是则添加之
                if (dstPath[dstPath.Length - 1] != Path.DirectorySeparatorChar)
                    dstPath += Path.DirectorySeparatorChar;
                // 判断目标目录是否存在如果不存在则新建之
                if (!Directory.Exists(dstPath))
                    Directory.CreateDirectory(dstPath);
                // 得到源目录的文件列表，该里面是包含文件以及目录路径的一个数组
                // 如果你指向copy目标文件下面的文件而不包含目录请使用下面的方法
                // string[] fileList = Directory.GetFiles(srcPath);
                string[] fileList = Directory.GetFileSystemEntries(srcPath);
                // 遍历所有的文件和目录
                for (int i = 0; i < fileList.Length; i++)
                {
                    var file = fileList[i];
                    // 先当作目录处理如果存在这个目录就递归Copy该目录下面的文件
                    if (Directory.Exists(file))
                        CopyDir(file, dstPath + Path.GetFileName(file));
                    // 否则直接Copy文件
                    else
                        File.Copy(file, dstPath + Path.GetFileName(file), true);
                    EditorUtility.DisplayProgressBar("Move Bundle File...", file, (float)(i + 1.0f) / (float)fileList.Length);
                }
                EditorUtility.ClearProgressBar();
            }
            catch
            {
                Debug.LogErrorFormat("Can not copy! srcPath:{0} dstPath:{1}", srcPath, dstPath);
            }
        }

        /// <summary>
        /// 获取文件的MD5值
        /// </summary>
        /// <param name="_PathValue"></param>
        /// <returns></returns>
        public static string GetFileMD5(string _PathValue)
        {
            //判断是否为本地资源   因为本地文件里有文件名称 但是在资源名称又不能重复  于是需要去掉名称 来检测md5值
            Object _ObejctValue = AssetDatabase.LoadAssetAtPath<Object>(_PathValue);
            bool _isNative = AssetDatabase.IsNativeAsset(_ObejctValue);
            string _FileMD5 = "";
            string _TemPath = Application.dataPath.Replace("Assets", "");

            if (_isNative)
            {
                string _TempFileText = File.ReadAllText(_TemPath + _PathValue).Replace("m_Name: " + _ObejctValue.name, "");

                System.Security.Cryptography.MD5 md5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
                //将字符串转换为字节数组  
                byte[] fromData = System.Text.Encoding.Unicode.GetBytes(_TempFileText);
                //计算字节数组的哈希值  
                byte[] toData = md5.ComputeHash(fromData);
                _FileMD5 = "";
                for (int i = 0; i < toData.Length; i++)
                {
                    _FileMD5 += toData[i].ToString("x2");
                }
            }
            else
            {
                _FileMD5 = "";
                //外部文件的MD5值
                try
                {

                    FileStream fs = new FileStream(_TemPath + _PathValue, FileMode.Open);

                    System.Security.Cryptography.MD5 md5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
                    byte[] retVal = md5.ComputeHash(fs);
                    fs.Close();
                    for (int i = 0; i < retVal.Length; i++)
                    {
                        _FileMD5 += retVal[i].ToString("x2");
                    }
                }
                catch (System.Exception ex)
                {
                    Debug.Log(ex);
                }
                //因为外部文件还存在不同的设置问题，还需要检测一下外部资源的.meta文件
                if (_FileMD5 != "")
                {
                    string _MetaPath = AssetDatabase.GetTextMetaFilePathFromAssetPath(_PathValue);
                    string _ObjectGUID = AssetDatabase.AssetPathToGUID(_PathValue);
                    //去掉guid来检测
                    string _TempFileText = File.ReadAllText(_TemPath + _MetaPath).Replace("guid: " + _ObjectGUID, "");

                    System.Security.Cryptography.MD5 _MetaMd5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
                    //将字符串转换为字节数组  
                    byte[] fromData = System.Text.Encoding.Unicode.GetBytes(_TempFileText);
                    //计算字节数组的哈希值  
                    byte[] toData = _MetaMd5.ComputeHash(fromData);
                    for (int i = 0; i < toData.Length; i++)
                    {
                        _FileMD5 += toData[i].ToString("x2");
                    }
                }
            }
            return _FileMD5;
        }

        //横向分割线
        public static void DrawHorizontalSplitter(float height = 5)
        {
            GUILayout.Box("",
            GUILayout.Height(height),
            GUILayout.MaxHeight(height),
            GUILayout.MinHeight(height),
            GUILayout.ExpandWidth(true));
        }
    }
}
    

