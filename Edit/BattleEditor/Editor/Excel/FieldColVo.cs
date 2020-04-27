using System.Collections.Generic;
using NPOI.SS.UserModel;

namespace BattleEditor
{
    public class FieldColVo
    {
        public string fieldName { get; private set; }//字段名
        public string fieldComment { get; private set; }//字段注释
        public string fieldType { get; private set; }//字段类型
        public List<string> valueList { get; private set; }
        public List<ICell> cellList{ get; private set; }

        public bool isOpen;
        public FieldColVo(ICell fieldName, ICell fieldType, ICell fieldComment)
        {
            this.fieldComment   = fieldComment.ToString();
            this.fieldName      = fieldName.ToString();
            if (string.IsNullOrEmpty(fieldType.ToString()))
                this.fieldType = FieldType.String;
            else
                this.fieldType = fieldType.ToString().ToLowerInvariant();
            valueList = new List<string>();
            cellList = new List<ICell>();
        }
    }
}