using UnityEngine;
using UnityEngine.Serialization;

namespace BattleEditor
{
    public class BattleEditorSetting : ScriptableObject
    {
        public string excelFolder = "";
        public string[] luaExportList;
        public string luaOutputPath = "";
        public string[] jsonExportList;
        public string jsonOutputPath = "";
        public string battleUnitExcelPath;
        public string skillExcelPath;
    }
}