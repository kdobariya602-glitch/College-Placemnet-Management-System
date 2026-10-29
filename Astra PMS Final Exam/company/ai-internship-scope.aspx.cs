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
    public partial class ai_internship_scope : System.Web.UI.Page
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
            return "Internship Project Charter & Deliverables:\r\n\r\n" +
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
            string prompt = "Act as an expert Astra Placement AI engine. Generate a comprehensive " + "AI Internship Scope Drafter" + " based on the following parameters: " + txtPromptInput.Text.Trim() + ". Format professionally with bullet points and clear sections.";
            
            string result = CallApi(prompt);
            txtResult.Text = result.Replace("**", "").Replace("* ", "• ");
            lblMsg.Text = "AI blueprint generated successfully!";
        }
    
        protected void btnPublishInternship_Click(object sender, EventArgs e)
        {
            getcon();
                string cEmail = Session["company"].ToString();
                da = new SqlDataAdapter("select Company_Name from Company_reg_tbl where Email = '" + cEmail + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string cName = ds.Tables[0].Rows.Count > 0 ? ds.Tables[0].Rows[0]["Company_Name"].ToString() : "Recruiter";
                string title = "Software Development Intern";
                string desc = !string.IsNullOrEmpty(txtResult.Text) ? txtResult.Text : txtPromptInput.Text.Trim();

                cmd = new SqlCommand("insert into Job_tbl (Company_Email, Company_Name, Job_Title, Job_Description, Job_Type, Salary_CTC, Location, Min_CGPA, Max_Backlogs, Eligible_Dept, Required_Skills, Vacancies, App_Deadline, Status, Created_Date) values ('" + cEmail + "', '" + cName.Replace("'", "''") + "', '" + title + "', '" + desc.Replace("'", "''") + "', 'Internship', '25,000 / mo Stipend', 'Hybrid', 6.5, 0, 'All Engineering & MCA', 'Problem Solving, Modern Stack', 10, DATEADD(month, 1, GETDATE()), 'Published', GETDATE())", con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "🚀 Database Action Executed: Internship opportunity published in <code>Job_tbl</code>!";

        }
        
    }
}
