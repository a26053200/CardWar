using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    /// <summary>
    /// <para></para>
    /// <para>Author: zhengnan </para>
    /// <para>Create: 分页窗口</para>
    /// </summary> 
    public class PageWnd : EditorWindow
    {
        private int _totalCount;
        private Vector2 scrollerPos = Vector2.zero;
        private int pageSize = 20;
        private int totalPage = 0;
        private int currPage = 0;
        private int sortBy = 0;

        const string ButtonPre = "Up";
        const string ButtonNext = "Down";
        const string ButtonTop = "Top";
        const string ButtonBottom = "Bottom";
        private const float ButtonWidth = 80;

        public virtual void Show(int totalCount)
        {
            _totalCount = totalCount;
            totalPage = (int)Mathf.Ceil((float)_totalCount / (float)pageSize);
        }
        protected virtual void OnGUI()
        {
            DrawHeader();
            DrawFields();
            scrollerPos = EditorGUILayout.BeginScrollView(scrollerPos, GUILayout.ExpandHeight(true));
            {
                for (int i = currPage * pageSize; i < (currPage + 1) * pageSize && i < _totalCount; i++)
                {
                    DrawContent(i);
                }
            }
            EditorGUILayout.EndScrollView();
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
            
        }
        protected virtual void DrawFields()
        {
            
        }

        protected virtual void DrawContent(int index)
        {
            
        }
    }
}