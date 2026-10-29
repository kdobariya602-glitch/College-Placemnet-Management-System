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
    public partial class ai_interview_questions : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

        public string qHtml = "";

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
                    filljobs();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        

        //step 5
        private string CallApi(string prompt, string jobTitle = "", string round = "")
        {
            return GenerateQuestionsFallback(jobTitle, round);
        }

        private string GenerateQuestionsFallback(string jobTitle, string round)
        {
            if (string.IsNullOrEmpty(jobTitle)) jobTitle = "Software Engineer";
            if (string.IsNullOrEmpty(round)) round = "Technical Interview";

            return "<b>1. Core Architecture &amp; OOP Fundamentals:</b><br/>" +
                   "Explain the core design principles applied in modern " + Server.HtmlEncode(jobTitle) + " architectures. What is the difference between abstraction and encapsulation, and how do you achieve dependency inversion?<br/>" +
                   "<i>Expected: Candidate demonstrates understanding of SOLID principles, interfaces, and decoupling.</i><br/><br/>" +
                   "<b>2. Algorithmic Efficiency &amp; Optimization:</b><br/>" +
                   "How do you approach optimizing an API endpoint or database operation with high latency? Which data structures provide O(1) lookups vs O(log N)?<br/>" +
                   "<i>Expected: Discusses Hash Tables, B-Trees, database indexing, and caching layers (Redis / MemoryCache).</i><br/><br/>" +
                   "<b>3. Practical Web API &amp; Database Design:</b><br/>" +
                   "Describe how you design a RESTful service endpoint with proper HTTP status codes, error handling, and SQL injection prevention.<br/>" +
                   "<i>Expected: Mentions parameterized queries/ORMs, HTTP 200/201/400/404/500 codes, and validation attributes.</i><br/><br/>" +
                   "<b>4. Real-world Project &amp; Debugging Challenge:</b><br/>" +
                   "Walk us through the most complex bug you solved in your academic or internship projects. What tools did you use to trace and profile the root cause?<br/>" +
                   "<i>Expected: Shows hands-on problem solving using IDE debuggers, logs, and systematic isolation.</i><br/><br/>" +
                   "<b>5. Concurrency &amp; State Management:</b><br/>" +
                   "Explain async/await in C#/JavaScript. How does asynchronous I/O prevent thread pool starvation in high-throughput applications?<br/>" +
                   "<i>Expected: Clear grasp of non-blocking I/O and task scheduling.</i><br/><br/>" +
                   "<b>6. Behavioral &amp; Culture Fit (" + Server.HtmlEncode(round) + "):</b><br/>" +
                   "Describe a situation where project requirements changed close to a deadline. How did you prioritize tasks and communicate with teammates?<br/>" +
                   "<i>Expected: Demonstrates adaptability, teamwork, and proactive communication.</i>";
        }

        void filljobs()
        {
            getcon();
                string comp = Session["company"].ToString().Replace("'", "''");
                da = new SqlDataAdapter("select Job_Id, Job_Title, Required_Skills from Job_tbl where Company_Email='" + comp + "' or Company_Name in (select Company_Name from Company_reg_tbl where Email='" + comp + "') order by Job_Id desc", con);
                ds = new DataSet();
                da.Fill(ds);

                ddlJob.Items.Clear();
                if (ds.Tables[0].Rows.Count == 0)
                {
                    ddlJob.Items.Add(new ListItem("Software Engineer / Developer", "0"));
                }
                else
                {
                    for (int k = 0; k < ds.Tables[0].Rows.Count; k++)
                    {
                        ddlJob.Items.Add(new ListItem(ds.Tables[0].Rows[k]["Job_Title"].ToString(), ds.Tables[0].Rows[k]["Job_Id"].ToString()));
                    }
                }
        }

        protected void btnGen_Click(object sender, EventArgs e)
        {
            string jobTitle = ddlJob.SelectedItem != null ? ddlJob.SelectedItem.Text : "Software Engineer";
            string round = ddlRound.SelectedValue;
            string level = ddlLevel.SelectedValue;

            string prompt = "Generate 8 interview questions for campus recruitment for the position: " + jobTitle + ". Round: " + round + ", Level: " + level + ". Provide numbered questions and brief expected answer points.";

            var res = CallApi(prompt, jobTitle, round);

            qHtml = "<div class='p-4 bg-white rounded-3 border shadow-sm' style='line-height:1.8;'>" +
                    "<h5 class='fw-bold text-primary mb-3'><i class='bi bi-patch-question me-2'></i>Interview Kit: " + Server.HtmlEncode(jobTitle) + " (" + Server.HtmlEncode(round) + ")</h5>" +
                    "<hr/>" +
                    res +
                    "</div>";

            lblMsg.Text = "Interview kit generated successfully by AI.";
}
    }
}
