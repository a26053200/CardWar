using System.IO;
using UnityEditor;
using UnityEngine;

namespace BattleEditor
{
    public class BattleEditorWnd : EditorWindow
    {
        [MenuItem("BattleEditor/Open")]
        static void ShowWnd()
        {
            Rect rect = new Rect(100,100,1024,768);
            BattleEditorWnd wnd = EditorWindow.GetWindow<BattleEditorWnd>(true, "战斗编辑器");
            wnd.position = rect;
            wnd.Init();
        }

        private const string SettingPath = "Assets/Edit/BattleEditorSetting.asset";
        private BattleEditorSetting _setting;
        private void Init()
        {
            if (!File.Exists(SettingPath))
                EditUtility.CreateAsset<BattleEditorSetting>(SettingPath);
            _setting = AssetDatabase.LoadAssetAtPath<BattleEditorSetting>(SettingPath);
        }
    }
}