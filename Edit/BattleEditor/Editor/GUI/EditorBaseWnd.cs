using System;
using System.Collections.Generic;
using Framework;
using NPOI.SS.UserModel;
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
        
        protected EditorWindow _parent;
        protected LuaReflect _luaReflect;

        public virtual void ShowWnd(EditorWindow parent, LuaReflect luaReflect)
        {
            _parent = parent;
            _luaReflect = luaReflect;
        }
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
                    if (GUILayout.Button(ButtonTop,EditorStyles.toolbarButton, GUILayout.Width(ButtonWidth)))
                        currPage = 0;
                    if (GUILayout.Button(ButtonPre,EditorStyles.toolbarButton, GUILayout.Width(ButtonWidth)))
                        currPage = Mathf.Max(0, currPage - 1);
                    EditorGUILayout.LabelField((currPage + 1) + "/" + totalPage, EditorStyles.centeredGreyMiniLabel,GUILayout.Width(ButtonWidth));
                    if (GUILayout.Button(ButtonNext,EditorStyles.toolbarButton, GUILayout.Width(ButtonWidth)))
                        currPage = Mathf.Min(totalPage - 1, currPage + 1);
                    if (GUILayout.Button(ButtonBottom,EditorStyles.toolbarButton, GUILayout.Width(ButtonWidth)))
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
        protected virtual void DrawBottom(bool showClose = false)
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField("",GUILayout.ExpandWidth(true));
            if (GUILayout.Button("Reload"))
            {
                Reload();
            }
            if (GUILayout.Button("Save"))
            {
                Save();
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
        
        public virtual void Save()
        {
        }
        protected virtual void CloseWnd()
        {
            Close();
            DestroyImmediate(this);
        }
    }
}