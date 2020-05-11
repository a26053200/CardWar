using System.Data;
using Framework;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    /// <summary>
    /// <para></para>
    /// <para>Author: zhengnan </para>
    /// <para>Create: 分页窗口</para>
    /// </summary> 
    public class EditorBaseWnd : EditorWindow
    {
        const string ButtonPre = "Up";
        const string ButtonNext = "Down";
        const string ButtonTop = "Top";
        const string ButtonBottom = "Bottom";
        private const float ButtonWidth = 80;
        
        private int _totalCount;
        private Vector2 scrollerPos = Vector2.zero;
        private int pageSize = 20;
        private int totalPage = 0;
        private int currPage = 0;
        private int sortBy = 0;

        public LuaReflect luaReflect;
        public EditorBaseWnd childWnd;
        
        public virtual void SetPageCount(int count)
        {
            _totalCount = count;
            totalPage = (int)Mathf.Ceil((float)_totalCount / (float)pageSize);
        }
        protected virtual void OnGUI()
        {
            DrawHeader();
            DrawFields();
            scrollerPos = EditorGUILayout.BeginScrollView(scrollerPos, GUILayout.ExpandHeight(true));
            {
                DrawScrollView();
            }
            EditorGUILayout.EndScrollView();
            DrawPageButtons();
            //DrawBottom();
        }
        protected virtual void DrawScrollView()
        {
            for (int i = currPage * pageSize; i < (currPage + 1) * pageSize && i < _totalCount; i++)
            {
                DrawPageContent(i);
            }
        }
        protected virtual void DrawPageButtons()
        {
            EditorGUILayout.BeginHorizontal();
            //EditorGUILayout.LabelField("");
            EditorGUILayout.BeginHorizontal();
            {
                EditorGUILayout.BeginHorizontal();
                {
                    if (GUILayout.Button(ButtonTop,EditorStyles.miniButtonMid, GUILayout.Width(ButtonWidth)))
                        currPage = 0;
                    if (GUILayout.Button(ButtonPre,EditorStyles.miniButtonMid, GUILayout.Width(ButtonWidth)))
                        currPage = Mathf.Max(0, currPage - 1);
                    EditorGUILayout.LabelField((currPage + 1) + "/" + totalPage, EditorStyles.centeredGreyMiniLabel,GUILayout.Width(ButtonWidth));
                    if (GUILayout.Button(ButtonNext,EditorStyles.miniButtonMid, GUILayout.Width(ButtonWidth)))
                        currPage = Mathf.Min(totalPage - 1, currPage + 1);
                    if (GUILayout.Button(ButtonBottom,EditorStyles.miniButtonMid, GUILayout.Width(ButtonWidth)))
                        currPage = totalPage - 1;
                }
                EditorGUILayout.EndHorizontal();
            }
            EditorGUILayout.EndHorizontal();
            // EditorGUILayout.LabelField("");
            EditorGUILayout.EndHorizontal();
        }
        protected virtual void DrawHeader()
        {
            EditorGUILayout.Space();
        }
        protected virtual void DrawFields()
        {
            
        }

        protected virtual void DrawPageContent(int index)
        {
            
        }
        protected virtual void DrawBottom(bool showClose = false, int index = -1)
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField("",GUILayout.ExpandWidth(true));
            if (GUILayout.Button("Reload"))
            {
                Reload();
            }
            if (GUILayout.Button("Apply"))
            {
                Apply(index);
            }
            if (showClose && GUILayout.Button("Close"))
            {
                CloseWnd();
            }
            EditorGUILayout.EndHorizontal();
        }
        
        public virtual void Reload()
        {
        }
        
        public virtual void Apply(int rowIndex)
        {
        }
        protected virtual void CloseWnd()
        {
            Close();
            DestroyImmediate(this);
        }
        
        //保存回lua
        protected void SaveBackToLua(string key, string json)
        {
            Debug.Log(json);
            var luaFunc = luaReflect.luaFuncDict["JsonToLua"];
            luaFunc.BeginPCall();
            luaFunc.Push(key);
            luaFunc.Push(json);
            luaFunc.PCall();
            luaFunc.EndPCall();
        }
        
        protected void LinkEditor(ExcelColHeader excelColHeader, DataRowCollection rows, int rowIndex,int colIndex, bool showAll)
        {
            if(childWnd)
                childWnd.Close();
            string vid = rows?[rowIndex][colIndex].ToString();
            if (showAll)
            {
                childWnd = SelectWnd.Create("Select " + excelColHeader.linkEditorLuaKey,this,  luaReflect, excelColHeader.linkEditorUrl);
                ((SelectWnd) childWnd).SetSelectDelegate(delegate(string id) 
                {  
                    OnSelect(id, rowIndex, colIndex); 
                });
            }
            else
            {
                childWnd = ListEditorWnd.Create(excelColHeader.linkEditorLuaKey,this, luaReflect, excelColHeader, vid);
            }
        }
        
        protected virtual void OnSelect(string id, int rowIndex, int colIndex)
        {
            
        }
    }
}