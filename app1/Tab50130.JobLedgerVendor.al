table 50130 "Job Ledger Vendor Temp"
{
    Caption = 'Job Ledger Vendor Temp';
    TableType = Temporary;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer) { }
        field(2; "Posting Date"; Date) { }
        field(3; "Document No."; Code[20]) { }
        field(4; "Job No."; Code[20]) { }
        field(5; "Job Task No."; Code[20]) { }
        field(6; "Type"; Enum "Job Journal Line Type") { }
        field(7; "No."; Code[20]) { }
        field(8; "Quantity"; Decimal) { }
        field(9; "Unit Cost"; Decimal) { }
        field(10; "Total Cost"; Decimal) { }
        field(11; "Description"; Text[100]) { }
        field(12; "Unit Cost (LCY)"; Decimal) { }
        field(13; "Total Cost (LCY)"; Decimal) { }
        field(14; "Global Dimension 1 Code"; Code[20]) { }
        field(15; "Vendor Invoice No."; Code[35]) { }
        field(16; "Vendor No."; Code[20]) { }
        field(17; "Vendor Name"; Text[100]) { }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}

