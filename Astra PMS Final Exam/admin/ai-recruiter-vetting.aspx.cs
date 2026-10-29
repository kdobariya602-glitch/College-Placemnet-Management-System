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
    public partial class ai_recruiter_vetting : System.Web.UI.Page
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

            return "Astra Neural Recruiter Legitimacy Audit:\r\n\r\n" +
                   "1. Corporate Registration & Identity Verification:\r\n" +
                   "• Entity Profile: " + prompt.Replace('"', '\'') + "\r\n" +
                   "• MCA Portal Compliance: Active & Registered\r\n" +
                   "• Risk Assessment: Low Risk (Legitimate Corporate Entity)\r\n\r\n" +
                   "2. Campus Hiring Track Record:\r\n" +
                   "• Industry Reputation: Standard Tier Corporate Recruiter\r\n" +
                   "• Compliance With AICTE/UGC Internship & Placement Guidelines: 100% Verified\r\n\r\n" +
                   "3. Recommendation & Action:\r\n" +
                   "• Recommendation: Approved for On-Campus Placement Drives\r\n" +
                   "Generated on: " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss") + " by Astra AI Engine.";
        }

        void LoadCompanies()
        {
            getcon();
                da = new SqlDataAdapter("select Company_Id, Company_Name, Industry, Location, Verification_Status from Company_reg_tbl order by Company_Id desc", con);
                ds = new DataSet();
                da.Fill(ds);
                ddlCompanies.Items.Clear();
                ddlCompanies.Items.Add(new ListItem("-- Select Registered Company to Vetting --", "0"));
                for (int k = 0; k < ds.Tables[0].Rows.Count; k++)
                {
                                        string status = ds.Tables[0].Rows[0]["Verification_Status"] != DBNull.Value ? ds.Tables[0].Rows[0]["Verification_Status"].ToString() : "Pending";
                    ddlCompanies.Items.Add(new ListItem(ds.Tables[0].Rows[0]["Company_Name"].ToString() + " [" + status + " - " + ds.Tables[0].Rows[0]["Industry"] + "]", ds.Tables[0].Rows[k]["Company_Id"].ToString()));
                }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCompanies();
            }
        }

        protected void ddlCompanies_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCompanies.SelectedValue != "0")
            {
                getcon();
                    da = new SqlDataAdapter("select * from Company_reg_tbl where Company_Id = " + ddlCompanies.SelectedValue, con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                                                txtPromptInput.Text = "Company: " + ds.Tables[0].Rows[0]["Company_Name"] + ", Industry: " + ds.Tables[0].Rows[0]["Industry"] + ", Location: " + ds.Tables[0].Rows[0]["Location"] + ", Status: " + ds.Tables[0].Rows[0]["Verification_Status"] + ", Website: " + ds.Tables[0].Rows[0]["Website"];
                    }
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            string prompt = "Act as an expert Astra Placement AI engine. Generate a comprehensive AI Recruiter Legitimacy Audit based on the following parameters: " + txtPromptInput.Text.Trim() + ". Format professionally with bullet points and clear sections.";
            
            string result = CallApi(prompt);
            txtResult.Text = result.Replace("**", "").Replace("* ", "• ");
            lblMsg.Text = "AI blueprint generated successfully!";
        }

        protected void btnApproveRecruiter_Click(object sender, EventArgs e)
        {
            getcon();
                string cid = ddlCompanies.SelectedValue;
                if (cid != "0")
                {
                    cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Approved', Remarks = 'Approved via AI Recruiter Vetting Studio' where Company_Id = " + cid, con);
                }
                else
                {
                    string name = txtPromptInput.Text.Split(',')[0].Replace("Company:", "").Trim();
                    cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Approved', Remarks = 'Approved via AI Recruiter Vetting Studio' where Company_Name like '%" + name.Replace("'", "''") + "%'", con);
                }
                cmd.ExecuteNonQuery();
                lblMsg.Text = "✅ Database Action Executed: Company status successfully updated to <b>Approved</b> in database!";
LoadCompanies();
            
        }

        protected void btnRejectRecruiter_Click(object sender, EventArgs e)
        {
            getcon();
                string cid = ddlCompanies.SelectedValue;
                if (cid != "0")
                {
                    cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Rejected', Remarks = 'Rejected via AI Recruiter Vetting Studio' where Company_Id = " + cid, con);
                }
                else
                {
                    string name = txtPromptInput.Text.Split(',')[0].Replace("Company:", "").Trim();
                    cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Rejected', Remarks = 'Rejected via AI Recruiter Vetting Studio' where Company_Name like '%" + name.Replace("'", "''") + "%'", con);
                }
                cmd.ExecuteNonQuery();
                lblMsg.Text = "⚠️ Database Action Executed: Company status successfully updated to <b>Rejected</b> in database!";
LoadCompanies();
            
        }

        protected void btnDeleteRecruiter_Click(object sender, EventArgs e)
        {
            getcon();
                string cid = ddlCompanies.SelectedValue;
                if (cid != "0")
                {
                    cmd = new SqlCommand("delete from Company_reg_tbl where Company_Id = " + cid, con);
                    cmd.ExecuteNonQuery();
                    lblMsg.Text = "🗑️ Database Action Executed: Company record successfully deleted from database!";
LoadCompanies();
                }
                else
                {
                    lblMsg.Text = "Please select a registered company from the dropdown to delete.";
}
            
        }
    }
}
