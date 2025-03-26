// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.ALProject1;

using Microsoft.Sales.Customer;
using Microsoft.Projects.Project.Job;
using Microsoft.Projects.Project.Ledger;

pageextension 50144 JobCard extends "Job Card"
{
    actions
    {
        addlast("&Job")
        {
            action("Job Costs Report")
            {
                ApplicationArea = All;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;
                ToolTip = 'Open the list of suppliers';

                trigger OnAction();
                var
                    JobRec: Record "Job Ledger Vendor Temp";
                    JobReport: Report "New Query Report";
                begin
                    JobRec.SetRange("Job No.", Rec."No.");
                    JobRec.SetRange("Job Task No.", '200', '900');
                    JobReport.SetTableView(JobRec);
                    JobReport.Run();
                end;
            }

            action("Purchase Orders Report")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                //PromotedIsBig = true;
                ToolTip = 'Open the list of purchase orders';

                trigger OnAction();
                var
                    JobRec: Record "Purchase Order Vendor Temp";
                    JobReport: Report "Purchase Order Report";
                begin
                    JobRec.SetRange("Job No.", Rec."No.");
                    JobRec.SetRange("Job Task No.", '200', '900');
                    JobReport.SetTableView(JobRec);
                    JobReport.Run();
                end;
            }
        }
    }
}

tableextension 50100 Customer extends Customer
{
    fields
    {
        field(50145; RewardPoints; Integer)
        {
            Caption = 'Reward Points';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }
}