using UnityEngine;
using UnityEngine.Serialization;

namespace BattleEditor
{
    public class BattleEditorSetting : ScriptableObject
    {
        public string excelFolder = "";
        public string outputPath = "";
        public string battleUnitExcelPath;
        public string skillExcelPath;
    }
}