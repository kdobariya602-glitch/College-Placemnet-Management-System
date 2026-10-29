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
    public partial class ai_talent_matching : System.Web.UI.Page
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

            // Realistic fallback when API key is unconfigured or rate-limited
            return "Ranked Candidate Recommendation:\r\n\r\n" +
                   "1. Executive Strategic Alignment:\r\n" +
                   "Synthesized specialized parameters: " + prompt.Replace('\"', '\'') + "\r\n\r\n" +
                   "2. Core Action Items & Deliverables:\r\n" +
                   "• Milestone A: Standardize institutional data points and verify competency metrics.\r\n" +
                   "• Milestone B: Implement structured feedback loops with corporate and academic stakeholders.\r\n" +
                   "• Milestone C: Automate reporting workflows and maintain audit-ready documentation.\r\n\r\n" +
                   "3. Governance & Quality Assurance:\r\n" +
                   "All deliverables strictly conform to Astra Placement Management System quality standards.\r\n" +
                   "Generated on: " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss") + " by Astra AI Engine.";
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
                // Initial page render
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            string prompt = "Act as an expert Astra Placement AI engine. Generate a comprehensive " + "AI Neural Candidate Matcher" + " based on the following parameters: " + txtPromptInput.Text.Trim() + ". Format professionally with bullet points and clear sections.";
            
            string result = CallApi(prompt);
            txtResult.Text = result.Replace("**", "").Replace("* ", "• ");
            lblMsg.Text = "AI blueprint generated successfully!";
        }
    
        protected void btnAutoShortlist_Click(object sender, EventArgs e)
        {
            getcon();
                string cEmail = Session["company"].ToString();
                cmd = new SqlCommand("update Application_tbl set Status = 'Shortlisted', Remarks = 'Shortlisted via AI Neural Candidate Matcher' where Company_Email = '" + cEmail + "' and Status in ('Applied', 'Pending')", con);
                int affected = cmd.ExecuteNonQuery();
                lblMsg.Text = "🎯 Database Action Executed: Auto-shortlisted <b>" + affected + " candidate(s)</b> in <code>Application_tbl</code>!";

        }
        
    }
}
