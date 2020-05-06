using System;
using LitJson;

namespace BattleEditor
{
    /// <summary>
    /// <para></para>
    /// <para>Author: zhengnan </para>
    /// <para>Create: DATE TIME</para>
    /// </summary> 
    public class ExcelColHeader
    {
        public string fieldName;
        public string fieldType;
        public string editorType;
        public string[] fieldEnum;
        public float minFloatValue = 0;
        public float maxFloatValue = 0;
        public int minIntValue = 0;
        public int maxIntValue = 0;
        public string linkEditorUrl;
        public string linkEditorField;
        public string linkEditorLuaKey;
        
        public ExcelColHeader(string fieldName, JsonData json)
        {
            this.fieldName = fieldName;
            if(json.Keys.Contains("fieldType"))
                fieldType = json["fieldType"].ToString();
            if(json.Keys.Contains("editorType"))
                editorType = json["editorType"].ToString();
            if(json.Keys.Contains("minFloatValue"))
                minFloatValue = float.Parse(json["minFloatValue"].ToString());
            if(json.Keys.Contains("maxFloatValue"))
                maxFloatValue = float.Parse(json["maxFloatValue"].ToString());
            if(json.Keys.Contains("minIntValue"))
                minIntValue = int.Parse(json["minIntValue"].ToString());
            if(json.Keys.Contains("maxIntValue"))
                maxIntValue = int.Parse(json["maxIntValue"].ToString());
            if (json.Keys.Contains("fieldEnum"))
                fieldEnum = BattleEditorUtility.JsonToArray(json, "fieldEnum");
            if (json.Keys.Contains("linkEditorUrl"))
                linkEditorUrl = json["linkEditorUrl"].ToString();
            if (json.Keys.Contains("linkEditorField"))
                linkEditorField = json["linkEditorField"].ToString();
            if (json.Keys.Contains("linkEditorLuaKey"))
                linkEditorLuaKey = json["linkEditorLuaKey"].ToString();
        }

        public bool IsNumber()
        {
            return editorType == UnityEditorType.Number;
        }
        public bool IsString()
        {
            return string.IsNullOrEmpty(fieldType) || fieldType == FieldType.String;
        }
        public bool IsBool()
        {
            return editorType == UnityEditorType.Bool;
        }
        public bool IsEnum()
        {
            return editorType == UnityEditorType.PopupEnum;
        }
        public bool IsSliderFloat()
        {
            return editorType == UnityEditorType.SliderFloat;
        }
        public bool IsSliderInt()
        {
            return editorType == UnityEditorType.SliderInt;
        }
    }
}