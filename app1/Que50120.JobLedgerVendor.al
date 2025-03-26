namespace ALProject.ALProject;

using Microsoft.Projects.Project.Ledger;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Vendor;

query 50120 JobLedgerVendor
{
    Caption = 'JobLedgerVendor';
    QueryType = Normal;

    elements
    {
        dataitem(JobLedgerEntry; "Job Ledger Entry")
        {
            column(PostingDate; "Posting Date")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(JobNo; "Job No.")
            {
            }
            column(JobTaskNo; "Job Task No.")
            {
            }
            column("Type"; "Type")
            {
            }
            column(No; "No.")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(UnitCost; "Unit Cost")
            {
            }
            column(TotalCost; "Total Cost")
            {
            }
            column(Description; Description)
            {
            }
            column(UnitCostLCY; "Unit Cost (LCY)")
            {
            }
            column(TotalCostLCY; "Total Cost (LCY)")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }

            dataitem(Purch__Inv__Header; "Purch. Inv. Header")
            {
                DataItemLink = "No." = JobLedgerEntry."Document No.";
                column(Buy_from_Vendor_No; "Buy-from Vendor No.") { }
                column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
                dataitem(Vendor; Vendor)
                {
                    DataItemLink = "No." = Purch__Inv__Header."Buy-from Vendor No.";
                    column(VendorName; Name) { }
                }

            }
        }
    }
}
