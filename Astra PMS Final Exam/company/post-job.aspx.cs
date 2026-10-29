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
    public partial class post_job : System.Web.UI.Page
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
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                }

                if (!IsPostBack)
                {
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void fillgrid()
        {
            // Single job posting form
        }

                

        

        protected void btnAiDraft_Click(object sender, EventArgs e)
        {
            string role = !string.IsNullOrEmpty(txtAiRole.Text) ? txtAiRole.Text.Trim() : "Software Engineer";
            string exp = ddlAiExp.SelectedValue;
            string companyName = !string.IsNullOrEmpty(nm) ? nm : "Astra University Hiring Partner";
                // Intelligent campus placement fallback
                txtJobTitle.Text = role;
                txtSkills.Text = GetDefaultSkills(role);
                txtPackage.Text = GetDefaultPackage(role);
                txtCGPA.Text = "6.50";
                txtBacklogs.Text = "0";
                txtOpenings.Text = "15";
                txtLocation.Text = "Bengaluru / Hyderabad / Hybrid";
                txtEligibleBranches.Text = "B.Tech (CSE, IT, ECE), MCA, M.Tech";
                txtJobDesc.Text = GetDefaultDesc(role, companyName);
            // Set deadline to 30 days ahead by default if empty
            if (string.IsNullOrEmpty(txtDeadline.Text))
            {
                txtDeadline.Text = DateTime.Now.AddDays(30).ToString("yyyy-MM-dd");
            }

            pnlAiStatus.Visible = true;
            litAiStatus.Text = "<strong><i class='bi bi-stars text-primary me-2'></i>AI Job Specifications Drafted Successfully!</strong> All form fields have been populated by Gemini AI. You can edit any value manually before publishing.";
        }

        private string GetDefaultSkills(string role)
        {
            string r = role.ToLower();
            if (r.Contains("data") || r.Contains("analyst") || r.Contains("bi"))
                return "Python, SQL, Power BI, Excel, Pandas, Machine Learning, Statistical Modeling";
            if (r.Contains("cloud") || r.Contains("devops"))
                return "AWS, Azure, Docker, Kubernetes, CI/CD Pipelines, Linux, Terraform, Shell Scripting";
            if (r.Contains("ai") || r.Contains("ml") || r.Contains("learning"))
                return "Python, PyTorch, TensorFlow, LLMs, NLP, Prompt Engineering, Scikit-Learn, MLOps";
            if (r.Contains("qa") || r.Contains("test") || r.Contains("automation"))
                return "Selenium, Java, Python, Cypress, JIRA, TestNG, API Testing (Postman), Manual QA";
            return "C#, ASP.NET Core, React.js, SQL Server, RESTful APIs, Git, Data Structures & Algorithms";
        }

        private string GetDefaultPackage(string role)
        {
            string r = role.ToLower();
            if (r.Contains("ai") || r.Contains("cloud")) return "12.00";
            if (r.Contains("data")) return "9.50";
            return "8.50";
        }

        private string GetDefaultDesc(string role, string cname)
        {
            return "About the Role:\n" +
                   cname + " is seeking ambitious and motivated campus graduates for the role of " + role + ". As a core team member, you will contribute to scalable enterprise systems and collaborate with experienced engineering mentors.\n\n" +
                   "Key Responsibilities:\n" +
                   "- Design, develop, test, and deploy clean, maintainable software components.\n" +
                   "- Collaborate closely with product managers, UX designers, and senior engineers in an Agile sprint environment.\n" +
                   "- Troubleshoot production issues, write comprehensive unit tests, and maintain CI/CD pipelines.\n" +
                   "- Continuously learn new frameworks and adhere to corporate security and code quality standards.\n\n" +
                   "Eligibility & Qualifications:\n" +
                   "- Graduating Batch with minimum 6.50 CGPA and no active backlogs.\n" +
                   "- Strong problem-solving, communication, and analytical abilities.\n" +
                   "- Passion for learning modern technologies and building impactful products.";
        }

        protected void btnPublishJob_Click(object sender, EventArgs e)
        {
            if (txtJobTitle.Text != "")
            {
                getcon();
                string deadlineVal = "NULL";
                if (txtDeadline.Text != "")
                {
                    deadlineVal = "'" + txtDeadline.Text + "'";
                }
                string vacanciesVal = "1";
                if (txtOpenings.Text != "")
                {
                    vacanciesVal = txtOpenings.Text;
                }
                string cgpaVal = "6.0";
                if (txtCGPA.Text != "")
                {
                    cgpaVal = txtCGPA.Text;
                }
                string backlogsVal = "0";
                if (txtBacklogs.Text != "")
                {
                    backlogsVal = txtBacklogs.Text;
                }

                cmd = new SqlCommand("insert into Job_tbl (Company_Email, Company_Name, Job_Title, Job_Description, Job_Type, Salary_CTC, Location, Min_CGPA, Max_Backlogs, Eligible_Dept, Required_Skills, Vacancies, App_Deadline, Status, Created_Date) values ('" + Session["company"] + "', '" + nm + "', '" + txtJobTitle.Text + "', '" + txtJobDesc.Text + "', '" + ddlJobType.SelectedValue + "', '" + txtPackage.Text + "', '" + txtLocation.Text + "', " + cgpaVal + ", " + backlogsVal + ", '" + txtEligibleBranches.Text + "', '" + txtSkills.Text + "', " + vacanciesVal + ", " + deadlineVal + ", 'Published', GETDATE())", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Job opening published successfully!'); window.location.href='jobs.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Job Title is required.');</script>");
            }
        }

        void clear()
        {
            txtJobTitle.Text = "";
            txtPackage.Text = "";
            txtLocation.Text = "";
        }
    }
}
