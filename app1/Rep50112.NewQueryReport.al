report 50112 "New Query Report"
{
    Caption = 'Job Costs Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = 'JobCostsReport.xlsx';

    dataset
    {
        dataitem(TempJobLedgerEntry; "Job Ledger Vendor Temp")
        {
            DataItemTableView = SORTING("Entry No.");

            column(PostingDate; "Posting Date") { }
            column(DocumentNo; "Document No.") { }
            column(JobNo; "Job No.") { }
            column(JobTaskNo; "Job Task No.") { }
            column(Type; "Type") { }
            column(No; "No.") { }
            column(Quantity; "Quantity") { }
            column(UnitCost; "Unit Cost") { }
            column(TotalCost; "Total Cost") { }
            column(Description; "Description") { }
            column(UnitCostLCY; "Unit Cost (LCY)") { }
            column(TotalCostLCY; "Total Cost (LCY)") { }
            column(GlobalDimension1Code; "Global Dimension 1 Code") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(VendorNo; "Vendor No.") { }
            column(VendorName; "Vendor Name") { }
        }
    }

    /*requestpage
    {
        layout
        {
            area(content)
            {
                group(Project)
                {
                    field(JobNoFilter; JobNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Job No.';
                        TableRelation = "Job"."No.";
                    }
                }
            }
        }
    }*/

    var
        JobLedgerEntry: Record "Job Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        Vendor: Record Vendor;
        JobNoFilter: Code[20];

    trigger OnPreReport()
    begin
        // Apply filter if provided
        if JobNoFilter <> '' then
            JobLedgerEntry.SetFilter("Job No.", JobNoFilter);

        // Populate temporary table
        if JobLedgerEntry.FindSet() then begin
            repeat
                TempJobLedgerEntry.Init();
                TempJobLedgerEntry."Entry No." := JobLedgerEntry."Entry No.";
                TempJobLedgerEntry."Posting Date" := JobLedgerEntry."Posting Date";
                TempJobLedgerEntry."Document No." := JobLedgerEntry."Document No.";
                TempJobLedgerEntry."Job No." := JobLedgerEntry."Job No.";
                TempJobLedgerEntry."Job Task No." := JobLedgerEntry."Job Task No.";
                TempJobLedgerEntry."Type" := JobLedgerEntry."Type";
                TempJobLedgerEntry."No." := JobLedgerEntry."No.";
                TempJobLedgerEntry."Quantity" := JobLedgerEntry.Quantity;
                TempJobLedgerEntry."Unit Cost" := JobLedgerEntry."Unit Cost";
                TempJobLedgerEntry."Total Cost" := JobLedgerEntry."Total Cost";
                TempJobLedgerEntry."Description" := JobLedgerEntry.Description;
                TempJobLedgerEntry."Unit Cost (LCY)" := JobLedgerEntry."Unit Cost (LCY)";
                TempJobLedgerEntry."Total Cost (LCY)" := JobLedgerEntry."Total Cost (LCY)";
                TempJobLedgerEntry."Global Dimension 1 Code" := JobLedgerEntry."Global Dimension 1 Code";

                // Retrieve vendor information
                if PurchInvHeader.Get(JobLedgerEntry."Document No.") then begin
                    TempJobLedgerEntry."Vendor Invoice No." := PurchInvHeader."Vendor Invoice No.";
                    TempJobLedgerEntry."Vendor No." := PurchInvHeader."Buy-from Vendor No.";
                    if Vendor.Get(PurchInvHeader."Buy-from Vendor No.") then
                        TempJobLedgerEntry."Vendor Name" := Vendor.Name;
                end;

                TempJobLedgerEntry.Insert();
            until JobLedgerEntry.Next() = 0;
        end;
    end;

    procedure PopulateTempJobLedgerVendor()
    var
        TempJobLedgerVendor: Record "Job Ledger Vendor Temp";
        JobLedgerVendorQuery: Query "JobLedgerVendor";
    begin
        JobLedgerVendorQuery.Open();
        while JobLedgerVendorQuery.Read() do begin
            TempJobLedgerVendor.Init();
            TempJobLedgerVendor."Posting Date" := JobLedgerVendorQuery.PostingDate;
            TempJobLedgerVendor."Document No." := JobLedgerVendorQuery.DocumentNo;
            TempJobLedgerVendor."Job No." := JobLedgerVendorQuery.JobNo;
            TempJobLedgerVendor."Job Task No." := JobLedgerVendorQuery.JobTaskNo;
            TempJobLedgerVendor.Type := JobLedgerVendorQuery.Type;
            TempJobLedgerVendor."No." := JobLedgerVendorQuery.No;
            TempJobLedgerVendor.Quantity := JobLedgerVendorQuery.Quantity;
            TempJobLedgerVendor."Unit Cost" := JobLedgerVendorQuery.UnitCost;
            TempJobLedgerVendor."Total Cost" := JobLedgerVendorQuery.TotalCost;
            TempJobLedgerVendor.Description := JobLedgerVendorQuery.Description;
            TempJobLedgerVendor."Unit Cost (LCY)" := JobLedgerVendorQuery.UnitCostLCY;
            TempJobLedgerVendor."Total Cost (LCY)" := JobLedgerVendorQuery.TotalCostLCY;
            TempJobLedgerVendor."Global Dimension 1 Code" := JobLedgerVendorQuery.GlobalDimension1Code;
            TempJobLedgerVendor."Vendor Invoice No." := JobLedgerVendorQuery.Vendor_Invoice_No_;
            TempJobLedgerVendor."Vendor No." := JobLedgerVendorQuery.Buy_from_Vendor_No;
            TempJobLedgerVendor."Vendor Name" := JobLedgerVendorQuery.VendorName;
            TempJobLedgerVendor.Insert();
        end;
        JobLedgerVendorQuery.Close();
    end;
}
