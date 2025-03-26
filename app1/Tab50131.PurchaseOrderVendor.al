table 50131 "Purchase Order Vendor Temp"
{
    Caption = 'Purchase Order Vendor Temp';
    TableType = Temporary;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; BigInteger) { }
        field(2; "Posting Date"; Date) { }
        field(3; "Document No."; Code[20]) { }
        field(4; "Job No."; Code[20]) { }
        field(5; "Job Task No."; Code[20]) { }
        field(6; "Type"; Enum "Purchase Line Type") { }
        field(7; "No."; Code[20]) { }
        field(8; "Quantity"; Decimal) { }
        field(9; "Unit Cost"; Decimal) { }
        field(10; "Line Amount"; Decimal) { }
        field(11; "Description"; Text[100]) { }
        field(12; "Unit Cost (LCY)"; Decimal) { }
        field(13; "Job Total Price (LCY)"; Decimal) { }
        field(14; "Outstanding Amount"; Decimal) { }
        field(15; "Vendor No."; Code[20]) { }
        field(16; "Vendor Name"; Text[100]) { }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}

