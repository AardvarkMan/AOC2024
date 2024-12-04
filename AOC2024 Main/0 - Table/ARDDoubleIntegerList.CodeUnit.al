table 82025 ARD_DoubleIntegerList
{
    Caption = '_DoubleIntegerList';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "ARD_No."; Integer)
        {
            Caption = 'ARD_No.';
            AutoIncrement = true;
        }
        field(2; ARD_Value1; Integer)
        {
            Caption = 'Value 1';
            ToolTip = 'Value 1';
        }
        field(3; ARD_Value2; Integer)
        {
            Caption = 'Value 2';
            ToolTip = 'Value 2';
        }
    }
    keys
    {
        key(PK; "ARD_No.")
        {
            Clustered = true;
        }
    }
}
