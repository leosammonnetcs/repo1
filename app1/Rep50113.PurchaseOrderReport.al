report 50113 "Purchase Order Report"
{
    Caption = 'Purchase Order Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = 'PurchaseOrderReport.xlsx';

    dataset
    {
        dataitem(TempPurchaseOrder; "Purchase Order Vendor Temp")
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
            column(Line_Amount; "Line Amount") { }
            column(Description; "Description") { }
            column(UnitCostLCY; "Unit Cost (LCY)") { }
            column(Job_Total_Price__LCY_; "Job Total Price (LCY)") { }
            column(Outstanding_Amount_Excl__VAT; "Outstanding Amount Excl. VAT") { }
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
        PurchaseLine: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        JobNoFilter: Code[20];

    trigger OnPreReport()
    begin
        // Apply filter if provided
        if JobNoFilter <> '' then
            PurchaseLine.SetFilter("Job No.", JobNoFilter);

        // Populate temporary table
        if PurchaseLine.FindSet() then begin
            repeat
                TempPurchaseOrder.Init();
                TempPurchaseOrder."Entry No." := PurchaseLine.SystemRowVersion;
                TempPurchaseOrder."Document No." := PurchaseLine."Document No.";
                TempPurchaseOrder."Job No." := PurchaseLine."Job No.";
                TempPurchaseOrder."Job Task No." := PurchaseLine."Job Task No.";
                TempPurchaseOrder."Type" := PurchaseLine."Type";
                TempPurchaseOrder."No." := PurchaseLine."No.";
                TempPurchaseOrder."Quantity" := PurchaseLine.Quantity;
                TempPurchaseOrder."Unit Cost" := PurchaseLine."Unit Cost";
                TempPurchaseOrder."Line Amount" := PurchaseLine."Line Amount";
                TempPurchaseOrder."Description" := PurchaseLine.Description;
                TempPurchaseOrder."Unit Cost (LCY)" := PurchaseLine."Unit Cost (LCY)";
                TempPurchaseOrder."Job Total Price (LCY)" := PurchaseLine."Job Total Price (LCY)";
                TempPurchaseOrder."Outstanding Amount Excl. VAT" := PurchaseLine."Outstanding Amt. Ex. VAT (LCY)";

                // Retrieve vendor information
                if PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
                    TempPurchaseOrder."Posting Date" := PurchaseHeader."Posting Date";
                    TempPurchaseOrder."Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                    TempPurchaseOrder."Vendor Name" := PurchaseHeader."Buy-from Vendor Name"
                end;

                TempPurchaseOrder.Insert();
            until PurchaseLine.Next() = 0;
        end;
    end;

    procedure PopulateTempJobLedgerVendor()
    var
        TempPurchaseOrderVendor: Record "Purchase Order Vendor Temp";
        PurchaseOrderVendorQuery: Query PurchaseOrderVendor;
    begin
        PurchaseOrderVendorQuery.Open();
        while PurchaseOrderVendorQuery.Read() do begin
            TempPurchaseOrderVendor.Init();
            TempPurchaseOrderVendor."Posting Date" := PurchaseOrderVendorQuery.Posting_Date;
            TempPurchaseOrderVendor."Document No." := PurchaseOrderVendorQuery.DocumentNo;
            TempPurchaseOrderVendor."Job No." := PurchaseOrderVendorQuery.JobNo;
            TempPurchaseOrderVendor."Job Task No." := PurchaseOrderVendorQuery.JobTaskNo;
            TempPurchaseOrderVendor.Type := PurchaseOrderVendorQuery.Type;
            TempPurchaseOrderVendor."No." := PurchaseOrderVendorQuery.No;
            TempPurchaseOrderVendor.Quantity := PurchaseOrderVendorQuery.Quantity;
            TempPurchaseOrderVendor."Unit Cost" := PurchaseOrderVendorQuery.UnitCost;
            TempPurchaseOrderVendor."Line Amount" := PurchaseOrderVendorQuery.Line_Amount;
            TempPurchaseOrderVendor.Description := PurchaseOrderVendorQuery.Description;
            TempPurchaseOrderVendor."Unit Cost (LCY)" := PurchaseOrderVendorQuery.UnitCostLCY;
            TempPurchaseOrderVendor."Job Total Price (LCY)" := PurchaseOrderVendorQuery.Job_Total_Price__LCY_;
            TempPurchaseOrderVendor."Outstanding Amount Excl. VAT" := PurchaseOrderVendorQuery.Outstanding_Amt__Ex__VAT__LCY_;
            TempPurchaseOrderVendor."Vendor No." := PurchaseOrderVendorQuery.Buy_from_Vendor_No;
            TempPurchaseOrderVendor."Vendor Name" := PurchaseOrderVendorQuery.Buy_from_Vendor_Name;
            TempPurchaseOrderVendor.Insert();
        end;
        PurchaseOrderVendorQuery.Close();
    end;
}
