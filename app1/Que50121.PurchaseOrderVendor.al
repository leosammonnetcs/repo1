namespace ALProject.ALProject;

using Microsoft.Purchases.Document;

query 50121 PurchaseOrderVendor
{
    Caption = 'PurchaseOrderVendor';
    QueryType = Normal;

    elements
    {
        dataitem(Purchase_Line; "Purchase Line")
        {
            column(SystemRowVersion; SystemRowVersion)
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
            column(Type; Type)
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
            column(Line_Amount; "Line Amount")
            {

            }
            column(Description; Description)
            {
            }
            column(UnitCostLCY; "Unit Cost (LCY)")
            {
            }
            column(Job_Total_Price__LCY_; "Job Total Price (LCY)")
            {

            }
            column(Outstanding_Amt__Ex__VAT__LCY_; "Outstanding Amt. Ex. VAT (LCY)")
            {

            }
            dataitem(Purchase_Header; "Purchase Header")
            {
                DataItemLink = "No." = Purchase_Line."Document No.";
                column(Posting_Date; "Posting Date") { }
                column(Buy_from_Vendor_No; "Buy-from Vendor No.") { }
                column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            }
        }
    }
}
