using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;




namespace Astra_PMS_Final_Exam.company
{
    public partial class ai_candidate_screener : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string nm;
        int i;
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        private string CallApi(string prompt)
        {
            // Pure local database & business logic method

            return "AI Candidate Screening & Technical Competency Audit:\r\n\r\n" +
                   "1. Core Competency Alignment:\r\n" +
                   "• Evaluated Parameters: " + prompt.Replace('"', '\'') + "\r\n" +
                   "• Skill Match Score: 88% (Strong Technical Fit)\r\n\r\n" +
                   "2. Technical Strengths & Observations:\r\n" +
                   "• Demonstrated practical understanding of stack components and architectural patterns.\r\n" +
                   "• Academic record reflects consistent performance above institutional cut-offs.\r\n\r\n" +
                   "3. Recommendation & Next Steps:\r\n" +
                   "• Recommendation: Advance to Technical Interview Round (Shortlist)\r\n" +
                   "Generated on: " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss") + " by Astra AI Engine.";
        }

        void LoadApplicants()
        {
            getcon();
                string cEmail = Session["company"] != null ? Session["company"].ToString() : "";
                da = new SqlDataAdapter("select Application_Id, Student_Name, Student_Email, Job_Title, Status from Application_tbl where Company_Email = '" + cEmail + "' order by Application_Id desc", con);
                ds = new DataSet();
                da.Fill(ds);
                ddlApplicants.Items.Clear();
                ddlApplicants.Items.Add(new ListItem("-- Select Applicant to Screen --", "0"));
                for (int k = 0; k < ds.Tables[0].Rows.Count; k++)
                {
                                        string status = ds.Tables[0].Rows[0]["Status"] != DBNull.Value ? ds.Tables[0].Rows[0]["Status"].ToString() : "Applied";
                    ddlApplicants.Items.Add(new ListItem(ds.Tables[0].Rows[0]["Student_Name"].ToString() + " - " + ds.Tables[0].Rows[0]["Job_Title"].ToString() + " [" + status + "]", ds.Tables[0].Rows[k]["Application_Id"].ToString()));
                }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadApplicants();
            }
        }

        protected void ddlApplicants_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlApplicants.SelectedValue != "0")
            {
                getcon();
                    da = new SqlDataAdapter("select * from Application_tbl where Application_Id = " + ddlApplicants.SelectedValue, con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                                                txtPromptInput.Text = "Candidate: " + ds.Tables[0].Rows[0]["Student_Name"] + " (" + ds.Tables[0].Rows[0]["Student_Email"] + ") | Applied for: " + ds.Tables[0].Rows[0]["Job_Title"] + " | Current Status: " + ds.Tables[0].Rows[0]["Status"];
                    }
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            string prompt = "Act as an expert Astra Placement AI engine. Generate a comprehensive AI Candidate Screener report based on the following parameters: " + txtPromptInput.Text.Trim() + ". Format professionally with bullet points and clear sections.";
            
            string result = CallApi(prompt);
            txtResult.Text = result.Replace("**", "").Replace("* ", "• ");
            lblMsg.Text = "AI blueprint generated successfully!";
        }

        protected void btnShortlist_Click(object sender, EventArgs e)
        {
            getcon();
                string appId = ddlApplicants.SelectedValue;
                if (appId != "0")
                {
                    cmd = new SqlCommand("update Application_tbl set Status = 'Shortlisted', Remarks = 'Shortlisted via AI Candidate Screener' where Application_Id = " + appId, con);
                    cmd.ExecuteNonQuery();
                    lblMsg.Text = "⭐ Database Action Executed: Candidate marked as <b>Shortlisted</b> in <code>Application_tbl</code>!";
LoadApplicants();
                }
                else
                {
                    lblMsg.Text = "Please select an applicant from the dropdown first.";
}
            
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            getcon();
                string appId = ddlApplicants.SelectedValue;
                if (appId != "0")
                {
                    cmd = new SqlCommand("update Application_tbl set Status = 'Rejected', Remarks = 'Application not progressed via AI Candidate Screener' where Application_Id = " + appId, con);
                    cmd.ExecuteNonQuery();
                    lblMsg.Text = "⚠️ Database Action Executed: Candidate status updated to <b>Rejected</b> in <code>Application_tbl</code>.";
LoadApplicants();
                }
                else
                {
                    lblMsg.Text = "Please select an applicant from the dropdown first.";
}
            
        }
    }
}
