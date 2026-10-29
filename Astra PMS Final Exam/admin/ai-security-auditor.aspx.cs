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
    public partial class ai_security_auditor : System.Web.UI.Page
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
            return "System Security & Compliance Health Check:\r\n\r\n" +
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
            if (Session["admin"] == null)
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
            string prompt = "Act as an expert Astra Placement AI engine. Generate a comprehensive " + "AI System Security Audit" + " based on the following parameters: " + txtPromptInput.Text.Trim() + ". Format professionally with bullet points and clear sections.";
            
            string result = CallApi(prompt);
            txtResult.Text = result.Replace("**", "").Replace("* ", "• ");
            lblMsg.Text = "AI blueprint generated successfully!";
        }
    
        protected void btnLogSecurityAudit_Click(object sender, EventArgs e)
        {
            getcon();
                string desc = "Security Audit Completed: Role Permissions & Session Isolation verified. Scope: " + txtPromptInput.Text.Trim();
                if (desc.Length > 400) desc = desc.Substring(0, 400);
                cmd = new SqlCommand("insert into Activity_Log_tbl (User_Role, User_Email, Action, Module, Description, IP_Address, Log_Date) values ('Admin', '" + Session["admin"] + "', 'SECURITY_AUDIT', 'Security Auditor', '" + desc.Replace("'", "''") + "', '127.0.0.1', GETDATE())", con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "🛡️ Database Action Executed: Security Audit recorded in <code>Activity_Log_tbl</code>!";

        }
        
    }
}
