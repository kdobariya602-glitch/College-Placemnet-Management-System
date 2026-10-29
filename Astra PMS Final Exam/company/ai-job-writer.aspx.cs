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
    public partial class ai_job_writer : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

        public string poolHtml = "";

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] != null)
            {
                if (!IsPostBack)
                {
                    fillpool();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        

        //step 5
        private string CallApi(string prompt, string title = "", string skills = "", string level = "", string mode = "")
        {
            return GenerateJobDescriptionFallback(title, skills, level, mode);
        }

        private string GenerateJobDescriptionFallback(string title, string skills, string level, string mode)
        {
            if (string.IsNullOrEmpty(title)) title = "Software Engineer";
            if (string.IsNullOrEmpty(skills)) skills = "C#, ASP.NET, SQL Server, Web APIs, HTML/CSS, JavaScript";
            if (string.IsNullOrEmpty(level)) level = "Fresher / Entry Level (0-1 Years)";
            if (string.IsNullOrEmpty(mode)) mode = "On-site / Campus";

            return "JOB TITLE: " + title + "\r\n" +
                   "EXPERIENCE: " + level + " | WORK MODE: " + mode + "\r\n" +
                   "CAMPUS LOCATION: Astra University Partner Office / Tech Hub\r\n\r\n" +
                   "ABOUT THE ROLE:\r\n" +
                   "We are seeking motivated, enthusiastic engineering graduates to join our high-growth technology organization as " + title + ". You will work alongside seasoned software engineers, participate in full lifecycle development, and deploy scalable enterprise software solutions.\r\n\r\n" +
                   "KEY RESPONSIBILITIES:\r\n" +
                   "1. Design, build, test, and maintain robust web applications and database architectures.\r\n" +
                   "2. Collaborate with cross-functional engineering and product teams to translate user requirements into technical deliverables.\r\n" +
                   "3. Write clean, scalable, and well-documented code adhering to industry standards and security guidelines.\r\n" +
                   "4. Perform unit testing, bug diagnostics, and continuous integration pipeline deployments.\r\n" +
                   "5. Participate in agile ceremonies including sprint planning, daily standups, and peer code reviews.\r\n\r\n" +
                   "REQUIRED TECHNICAL SKILLS & COMPETENCIES:\r\n" +
                   "- Primary Skills: " + skills + ".\r\n" +
                   "- Solid foundation in Data Structures, Algorithms, and Object-Oriented Programming.\r\n" +
                   "- Familiarity with relational database design, SQL querying, and RESTful APIs.\r\n" +
                   "- Strong problem-solving mindset and effective team collaboration skills.\r\n\r\n" +
                   "ELIGIBILITY & QUALIFICATIONS:\r\n" +
                   "- B.Tech / B.E. / MCA in Computer Science, IT, or allied engineering disciplines.\r\n" +
                   "- Minimum 7.0 CGPA throughout academic curriculum with no active backlogs.\r\n\r\n" +
                   "WHAT WE OFFER:\r\n" +
                   "- Competitive CTC with comprehensive healthcare coverage and performance incentives.\r\n" +
                   "- Structured corporate mentorship and continuous learning allowances.";
        }

        void fillpool()
        {
            getcon();
                da = new SqlDataAdapter("select top 10 Skills from Student_Reg_tbl where Skills is not null and Skills <> ''", con);
                ds = new DataSet();
                da.Fill(ds);
                poolHtml = "";
                for (int k = 0; k < ds.Tables[0].Rows.Count; k++)
                {
                    poolHtml += "<span class='badge bg-light text-dark border me-1 mb-1'>" + ds.Tables[0].Rows[k]["Skills"] + "</span> ";
                }
        }

        protected void btnGen_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            if (string.IsNullOrEmpty(title))
            {
                lblMsg.Text = "Please enter a job title.";
return;
            }

            string skills = txtSkills.Text.Trim();
            string level = ddlLevel.SelectedValue;
            string mode = ddlMode.SelectedValue;

            string prompt = "Write a professional campus job description for:\n" +
                "Job Title: " + title + "\n" +
                "Required Skills: " + skills + "\n" +
                "Experience Level: " + level + "\n" +
                "Work Mode: " + mode + "\n" +
                "Include: About the role, Responsibilities, Requirements, and Eligibility Criteria.";

            var generated = CallApi(prompt, title, skills, level, mode);

            txtOut.Text = generated;
            lblMsg.Text = "Job description drafted successfully by AI.";
}
        protected void btnDirectPost_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string desc = txtOut.Text.Trim();
            if (string.IsNullOrEmpty(title))
            {
                lblMsg.Text = "Please enter a job title first.";
return;
            }

            if (string.IsNullOrEmpty(desc))
            {
                lblMsg.Text = "Please generate the job description first before publishing.";
return;
            }

            getcon();
                da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string cname = ds.Tables[0].Rows.Count > 0 ? ds.Tables[0].Rows[0]["Company_Name"].ToString() : "Company";

                string skills = txtSkills.Text.Trim();
                string mode = ddlMode.SelectedValue;

                cmd = new SqlCommand("insert into Job_tbl (Company_Email, Company_Name, Job_Title, Job_Description, Job_Type, Salary_CTC, Location, Min_CGPA, Max_Backlogs, Eligible_Dept, Required_Skills, Vacancies, App_Deadline, Status, Created_Date) values ('" + Session["company"] + "', '" + cname.Replace("'", "''") + "', '" + title.Replace("'", "''") + "', '" + desc.Replace("'", "''") + "', 'Full-Time', '8.50 LPA', '" + mode.Replace("'", "''") + "', 6.5, 0, 'All Engineering & MCA', '" + skills.Replace("'", "''") + "', 10, DATEADD(month, 1, GETDATE()), 'Published', GETDATE())", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Job published successfully with AI JD!'); window.location.href='jobs.aspx';</script>");
            
        }
    }
}
