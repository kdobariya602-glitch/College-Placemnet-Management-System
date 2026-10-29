using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace Astra_PMS_Final_Exam.admin
{
    public partial class student_verification : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                if (!IsPostBack)
                {
                    fillstats();
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void fillstats()
        {
            getcon();
            da = new SqlDataAdapter("select count(*) from Student_Document_tbl where Verification_Status='Pending' or Verification_Status is null", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPendingCount.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(*) from Student_Document_tbl where Verification_Status='Verified'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblVerifiedCount.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(*) from Student_Document_tbl where Verification_Status='Rejected'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblRejectedCount.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(*) from Student_Document_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalCount.Text = ds.Tables[0].Rows[0][0].ToString();
        }

        void fillgrid()
        {
            getcon();
            if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select d.*, s.Full_Name as Student_Name, s.Enrollment_No, s.Branch from Student_Document_tbl d left join Student_Reg_tbl s on (d.Student_Email = s.Email or d.Student_Email = s.Enrollment_No) where (s.Full_Name='" + txtSearch.Text + "' or s.Enrollment_No='" + txtSearch.Text + "' or d.Student_Email='" + txtSearch.Text + "' or d.Document_Name='" + txtSearch.Text + "') order by d.Document_Id desc", con);
            }
            else if (ddlStatusFilter.SelectedValue != "All")
            {
                if (ddlStatusFilter.SelectedValue == "Pending")
                {
                    da = new SqlDataAdapter("select d.*, s.Full_Name as Student_Name, s.Enrollment_No, s.Branch from Student_Document_tbl d left join Student_Reg_tbl s on (d.Student_Email = s.Email or d.Student_Email = s.Enrollment_No) where (d.Verification_Status='Pending' or d.Verification_Status is null) order by d.Document_Id desc", con);
                }
                else
                {
                    da = new SqlDataAdapter("select d.*, s.Full_Name as Student_Name, s.Enrollment_No, s.Branch from Student_Document_tbl d left join Student_Reg_tbl s on (d.Student_Email = s.Email or d.Student_Email = s.Enrollment_No) where d.Verification_Status='" + ddlStatusFilter.SelectedValue + "' order by d.Document_Id desc", con);
                }
            }
            else if (ddlDocTypeFilter.SelectedValue != "All")
            {
                da = new SqlDataAdapter("select d.*, s.Full_Name as Student_Name, s.Enrollment_No, s.Branch from Student_Document_tbl d left join Student_Reg_tbl s on (d.Student_Email = s.Email or d.Student_Email = s.Enrollment_No) where d.Document_Type='" + ddlDocTypeFilter.SelectedValue + "' order by d.Document_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select d.*, s.Full_Name as Student_Name, s.Enrollment_No, s.Branch from Student_Document_tbl d left join Student_Reg_tbl s on (d.Student_Email = s.Email or d.Student_Email = s.Enrollment_No) order by d.Document_Id desc", con);
            }

            ds = new DataSet();
            da.Fill(ds);
            gvDocVerification.DataSource = ds;
            gvDocVerification.DataBind();
        }

        public string GetDocumentUrl(object filePathObj)
        {
            if (filePathObj == null || filePathObj == DBNull.Value)
            {
                return ResolveUrl("~/uploads/documents/sample_document.pdf");
            }

            string raw = filePathObj.ToString().Trim().TrimStart('~', '/');
            if (raw.ToLower().StartsWith("uploads/"))
            {
                return ResolveUrl("~/" + raw);
            }
            return ResolveUrl("~/uploads/documents/" + raw);
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            gvDocVerification.PageIndex = 0;
            fillgrid();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlDocTypeFilter.SelectedIndex = 0;
            ddlStatusFilter.SelectedIndex = 0;
            gvDocVerification.PageIndex = 0;
            fillgrid();
        }

        protected void gvDocVerification_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDocVerification.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        protected void gvDocVerification_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "approve_doc")
            {
                int docid = Convert.ToInt32(e.CommandArgument); ViewState["docid"] = docid;
                getcon();

                // Get document info
                da = new SqlDataAdapter("select * from Student_Document_tbl where Document_Id='" + docid + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string sEmail = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                    string dType = ds.Tables[0].Rows[0]["Document_Type"].ToString();
                    string fPath = ds.Tables[0].Rows[0]["File_Path"].ToString();

                    cmd = new SqlCommand("update Student_Document_tbl set Verification_Status='Verified', Verified_By='Central Administrator', Remarks='Verified and endorsed by Institutional Admin Office.' where Document_Id='" + docid + "'", con);
                    cmd.ExecuteNonQuery();

                    // If document is Resume, sync with Student_Reg_tbl
                    if (dType == "Resume" && fPath != "")
                    {
                        cmd = new SqlCommand("update Student_Reg_tbl set Resume_File='" + fPath.TrimStart('~', '/') + "' where Email='" + sEmail + "' or Enrollment_No='" + sEmail + "'", con);
                        cmd.ExecuteNonQuery();
                    }

                    // Send alert notification to student
                    cmd = new SqlCommand("insert into Notification_tbl (Recipient_Role, Recipient_Email, Title, Message, Notification_Type, Is_Read, Created_Date) values ('Student', '" + sEmail + "', 'Document Verified', 'Your " + dType + " has been verified and approved by Central Administration.', 'Success', 0, GETDATE())", con);
                    cmd.ExecuteNonQuery();

                    pnlAlert.Visible = true;
litAlertMsg.Text = "<i class='bi bi-check-circle-fill me-1'></i> Document #" + docid + " (" + dType + ") marked as <strong>Verified</strong> by Central Administration.";
                    fillstats();
                    fillgrid();
                }
            }
        }

        protected void btnConfirmReject_Click(object sender, EventArgs e)
        {
            if (hfRejectDocId.Value != "")
            {
                int docid = Convert.ToInt32(hfRejectDocId.Value);
                string remark = "Document unverified; re-upload required.";
                if (txtRejectRemark.Text.Trim() != "")
                {
                    remark = txtRejectRemark.Text.Trim();
                }

                getcon();
                da = new SqlDataAdapter("select * from Student_Document_tbl where Document_Id='" + docid + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string sEmail = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                    string dType = ds.Tables[0].Rows[0]["Document_Type"].ToString();

                    cmd = new SqlCommand("update Student_Document_tbl set Verification_Status='Rejected', Verified_By='Central Administrator', Remarks='" + remark + "' where Document_Id='" + docid + "'", con);
                    cmd.ExecuteNonQuery();

                    // Send alert notification to student
                    cmd = new SqlCommand("insert into Notification_tbl (Recipient_Role, Recipient_Email, Title, Message, Notification_Type, Is_Read, Created_Date) values ('Student', '" + sEmail + "', 'Document Action Required', 'Your " + dType + " requires re-submission: " + remark + "', 'Warning', 0, GETDATE())", con);
                    cmd.ExecuteNonQuery();

                    pnlAlert.Visible = true;
litAlertMsg.Text = "<i class='bi bi-exclamation-triangle-fill me-1'></i> Document #" + docid + " marked as <strong>Rejected</strong> with instructions sent to student.";
                    fillstats();
                    fillgrid();
                }
            }
        }

        protected void btnBulkVerify_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Student_Document_tbl set Verification_Status='Verified', Verified_By='Central Administrator', Remarks='Verified via administrative batch review.' where Verification_Status='Pending' or Verification_Status is null", con);
            int count = cmd.ExecuteNonQuery();

            pnlAlert.Visible = true;
litAlertMsg.Text = "<i class='bi bi-check-all me-1'></i> Batch verification complete. <strong>" + count + "</strong> pending documents verified by Central Administration.";
            fillstats();
            fillgrid();
        }
    }
}

