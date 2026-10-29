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
    public partial class ai_assistant : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

        public string chatHtml = "";

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

                void loadChatFromDb()
        {
            getcon();
                string user = Session["company"].ToString();
                da = new SqlDataAdapter("select top 20 * from AI_History_tbl where Module='CompanyAI' and User_Email='" + user + "' order by Created_Date asc", con);
                ds = new DataSet();
                da.Fill(ds);
                string chat = "<div class='p-3 bg-light rounded-3 mb-2'><b>AI Assistant:</b> Hello Recruiter! I am your AI Campus Recruitment Assistant. Ask me anything about job descriptions, candidates, skills, or campus interviews.</div>";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int k = 0; k < ds.Tables[0].Rows.Count; k++)
                    {
                        string q = ds.Tables[0].Rows[k]["Prompt"].ToString();
                        string a = ds.Tables[0].Rows[k]["Response"].ToString();
                        chat += "<div class='d-flex justify-content-end mb-2'><div class='bg-primary text-white p-2 px-3 rounded-3' style='max-width:80%'><b>You:</b> " + Server.HtmlEncode(q) + "</div></div>";
                        chat += "<div class='d-flex mb-2'><div class='bg-light border p-3 rounded-3' style='max-width:85%'><b>AI Assistant:</b><br/>" + a + "</div></div>";
                    }
                }
                Session["comp_ai_chat"] = chat;
                chatHtml = chat;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] != null)
            {
                loadChatFromDb();
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        

        private string CallApi(string prompt, string question = "")
        {
            string q = !string.IsNullOrEmpty(question) ? question : prompt;
            return GenerateRecruiterAnswer(q);
        }

        private string GenerateRecruiterAnswer(string q)
        {
            string qLower = q.ToLower();
            string cEmail = Session["company"] != null ? Session["company"].ToString() : "";

            getcon();
                // 1. Hiring Summary / Summary / Overview / Status
                if (qLower.Contains("summary") || qLower.Contains("overview") || qLower.Contains("hiring"))
                {
                    string compName = "Your Company";
                    da = new SqlDataAdapter("select Company_Name from Company_reg_tbl where Email='" + cEmail + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0) compName = ds.Tables[0].Rows[0]["Company_Name"].ToString();

                    da = new SqlDataAdapter("select * from Job_tbl where Company_Email='" + cEmail + "' and Status in ('Active','Published','Open')", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int activeJobs = ds.Tables[0].Rows.Count;

                    da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + cEmail + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int totalApps = ds.Tables[0].Rows.Count;

                    da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + cEmail + "' and Status='Shortlisted'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int shortlisted = ds.Tables[0].Rows.Count;

                    da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + cEmail + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int selected = ds.Tables[0].Rows.Count;

                    return "<b>Hiring Summary for " + compName + "</b><br/><br/>" +
                           "&bull; <b>Active Job Postings:</b> " + activeJobs + " open roles<br/>" +
                           "&bull; <b>Total Candidate Applications:</b> " + totalApps + " received<br/>" +
                           "&bull; <b>Shortlisted for Next Rounds:</b> " + shortlisted + " candidates<br/>" +
                           "&bull; <b>Final Offers / Selections:</b> " + selected + " candidates<br/><br/>" +
                           "<b>Recruitment Status:</b> Campus drive is currently in progress. You can review profiles in <b>Applicants</b> or schedule interviews in <b>Interviews</b>.";
                }

                // 2. Best Candidates / Candidates / Top Candidates
                if (qLower.Contains("candidate") || qLower.Contains("best") || qLower.Contains("top student") || qLower.Contains("who applied"))
                {
                    da = new SqlDataAdapter("select top 5 * from Application_tbl where Company_Email='" + cEmail + "' order by CGPA desc", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string res = "<b>Top Candidates Ranked by Academic Merit &amp; CGPA:</b><br/><br/>";
                        for (int r = 0; r < ds.Tables[0].Rows.Count; r++)
                        {
                                                        res += "&bull; <b>" + ds.Tables[0].Rows[r]["Student_Name"] + "</b> (" + ds.Tables[0].Rows[r]["Department"] + ") &mdash; CGPA: <b>" + ds.Tables[0].Rows[r]["CGPA"] + "</b> | Role: <i>" + ds.Tables[0].Rows[r]["Job_Title"] + "</i> | Status: <span class='badge bg-light text-primary border'>" + ds.Tables[0].Rows[r]["Status"] + "</span><br/>";
                        }
                        res += "<br/><i>Tip: Go to <b>Smart Ranking</b> to filter candidates by skill match and ATS score.</i>";
                        return res;
                    }
                    else
                    {
                        return "<b>Candidate Status:</b> You have not received applications yet, or new submissions are pending review. Check the <b>Applicants</b> tab to review incoming student profiles.";
                    }
                }

                // 3. Applicants per job
                if (qLower.Contains("per job") || qLower.Contains("applicants per") || qLower.Contains("applications count") || (qLower.Contains("applicant") && !qLower.Contains("shortlist")))
                {
                    da = new SqlDataAdapter("select Job_Id, Job_Title, Job_Type, Vacancies from Job_tbl where Company_Email='" + cEmail + "' order by Job_Id desc", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string res = "<b>Applications Breakdown by Job Posting:</b><br/><br/>";
                        for (int r = 0; r < ds.Tables[0].Rows.Count; r++)
                        {
                            string jId = ds.Tables[0].Rows[r]["Job_Id"].ToString();
                            string jTitle = ds.Tables[0].Rows[r]["Job_Title"].ToString();
                            string jType = ds.Tables[0].Rows[r]["Job_Type"].ToString();
                            string vac = ds.Tables[0].Rows[r]["Vacancies"].ToString();

                            SqlDataAdapter daApp = new SqlDataAdapter("select * from Application_tbl where Job_Id='" + jId + "'", con);
                            DataSet dsApp = new DataSet();
                            daApp.Fill(dsApp);
                            int appCount = dsApp.Tables[0].Rows.Count;

                            res += "&bull; <b>" + jTitle + "</b> (" + jType + ") &mdash; <b>" + appCount + "</b> applicants (Openings: " + vac + ")<br/>";
                        }
                        return res;
                    }
                    else
                    {
                        return "<b>No Active Jobs:</b> You currently have no jobs posted. Navigate to <b>Post Job</b> to publish new campus hiring openings.";
                    }
                }

                // 4. Shortlisted / Who is shortlisted
                if (qLower.Contains("shortlist"))
                {
                    da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + cEmail + "' and Status='Shortlisted'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string res = "<b>Currently Shortlisted Candidates (" + ds.Tables[0].Rows.Count + "):</b><br/><br/>";
                        for (int r = 0; r < ds.Tables[0].Rows.Count; r++)
                        {
                                                        res += "&bull; <b>" + ds.Tables[0].Rows[r]["Student_Name"] + "</b> &mdash; " + ds.Tables[0].Rows[r]["Job_Title"] + " (" + ds.Tables[0].Rows[r]["Department"] + ", CGPA: " + ds.Tables[0].Rows[r]["CGPA"] + ")<br/>";
                        }
                        res += "<br/><i>You can advance these candidates to Technical Interview in the <b>Interviews</b> module.</i>";
                        return res;
                    }
                    else
                    {
                        return "<b>No Shortlisted Candidates Yet:</b> None of your applicants are currently in 'Shortlisted' status. Visit the <b>Applicants</b> tab and click <i>Shortlist</i> on deserving candidates.";
                    }
                }

                // 5. Interviews / Upcoming interviews
                if (qLower.Contains("interview"))
                {
                    da = new SqlDataAdapter("select * from Interview_Schedule_tbl where Company_Email='" + cEmail + "' order by Interview_Id desc", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string res = "<b>Scheduled Interview Rounds (" + ds.Tables[0].Rows.Count + "):</b><br/><br/>";
                        for (int r = 0; r < ds.Tables[0].Rows.Count; r++)
                        {
                                                        string sName = ds.Tables[0].Rows[r]["Student_Name"] != null ? ds.Tables[0].Rows[r]["Student_Name"].ToString() : "Candidate";
                            string jTitle = ds.Tables[0].Rows[r]["Job_Title"] != null ? ds.Tables[0].Rows[r]["Job_Title"].ToString() : "Campus Role";
                            string iDate = ds.Tables[0].Rows[r]["Interview_Date"] != null ? Convert.ToDateTime(ds.Tables[0].Rows[r]["Interview_Date"]).ToString("dd MMM yyyy") : "";
                            string rType = ds.Tables[0].Rows[r]["Round_Type"] != null ? ds.Tables[0].Rows[r]["Round_Type"].ToString() : "Interview";
                            res += "&bull; <b>" + sName + "</b> &mdash; " + jTitle + " (" + rType + ") on <b>" + iDate + "</b><br/>";
                        }
                        return res;
                    }
                    else
                    {
                        return "<b>Interview Schedule:</b> No interviews are currently scheduled on the portal. You can schedule interview slots directly from the <b>Applicants</b> page or the <b>Interviews</b> schedule module.";
                    }
                }

                // 6. Deadlines / Closing
                if (qLower.Contains("closing") || qLower.Contains("deadline"))
                {
                    da = new SqlDataAdapter("select Job_Title, Job_Type, App_Deadline, Status from Job_tbl where Company_Email='" + cEmail + "' and Status in ('Active','Published','Open')", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string res = "<b>Application Deadlines for Your Active Jobs:</b><br/><br/>";
                        for (int r = 0; r < ds.Tables[0].Rows.Count; r++)
                        {
                                                        string dDate = ds.Tables[0].Rows[r]["App_Deadline"] != DBNull.Value ? Convert.ToDateTime(ds.Tables[0].Rows[r]["App_Deadline"]).ToString("dd MMM yyyy") : "Open";
                            res += "&bull; <b>" + ds.Tables[0].Rows[r]["Job_Title"] + "</b> (" + ds.Tables[0].Rows[r]["Job_Type"] + ") &mdash; Deadline: <b>" + dDate + "</b><br/>";
                        }
                        return res;
                    }
                    else
                    {
                        return "<b>No Active Deadlines:</b> You do not have active job postings closing soon.";
                    }
                }

                // 7. Offers / Selections
                if (qLower.Contains("offer") || qLower.Contains("select"))
                {
                    da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + cEmail + "' order by Selection_Id desc", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string res = "<b>Offers Released to Candidates (" + ds.Tables[0].Rows.Count + "):</b><br/><br/>";
                        for (int r = 0; r < ds.Tables[0].Rows.Count; r++)
                        {
                                                        string sName = ds.Tables[0].Rows[r]["Student_Name"].ToString();
                            string pkg = ds.Tables[0].Rows[r]["Package_LPA"] != DBNull.Value ? ds.Tables[0].Rows[r]["Package_LPA"].ToString() : "-";
                            string oStatus = ds.Tables[0].Rows[r]["Status"] != DBNull.Value ? ds.Tables[0].Rows[r]["Status"].ToString() : "Offered";
                            res += "&bull; <b>" + sName + "</b> &mdash; Package: <b>Rs. " + pkg + " LPA</b> | Offer Status: <b>" + oStatus + "</b><br/>";
                        }
                        return res;
                    }
                    else
                    {
                        return "<b>Offer Status:</b> No offers have been officially released yet. Once candidates pass all interview rounds, submit selections in the <b>Selections &amp; Offers</b> module.";
                    }
                }

            // General smart recruiter advice
            return "<b>Recruitment Assistant Response:</b><br/><br/>" +
                   "Thank you for your query regarding: <i>" + Server.HtmlEncode(q) + "</i>.<br/><br/>" +
                   "&bull; <b>Candidate Sourcing:</b> Post jobs with clear skill expectations to attract top-percentile engineering graduates.<br/>" +
                   "&bull; <b>Screening Criteria:</b> Filter applications with CGPA &ge; 7.0 and relevant domain competencies (Data Structures, Full Stack, Cloud).<br/>" +
                   "&bull; <b>Campus Placement Workflow:</b> Review applicants &rarr; Shortlist top profiles &rarr; Conduct technical rounds &rarr; Release formal offer letters.<br/><br/>" +
                   "<i>Click any of the quick query chips above for real-time live data from your Astra recruitment drive.</i>";
        }

        private string TryExecuteRecruiterAction(string q)
        {
            string qLower = q.ToLower().Trim();
            string cEmail = Session["company"] != null ? Session["company"].ToString() : "";

            getcon();

                // 1. Voice / Natural Language Job Posting: "Post job: ...", "Create job: ...", "Publish job: ..."
                if (qLower.StartsWith("post job") || qLower.StartsWith("create job") || qLower.StartsWith("publish job") || qLower.StartsWith("add job") || qLower.StartsWith("post a job"))
                {
                    string jobParams = q.Substring(q.IndexOf("job", StringComparison.OrdinalIgnoreCase) + 3).TrimStart(':', ' ');
                    
                    string title = "Campus Software Trainee";
                    string skills = "C#, React, SQL, Problem Solving";
                    string salary = "6.50 LPA";
                    int vacancies = 2;

                    if (jobParams.Contains(","))
                    {
                        string[] parts = jobParams.Split(',');
                        if (parts.Length > 0 && !string.IsNullOrEmpty(parts[0].Trim()))
                        {
                            title = parts[0].Trim();
                        }
                        for (int p = 1; p < parts.Length; p++)
                        {
                            string item = parts[p].Trim();
                            string itemLower = item.ToLower();
                            if (itemLower.StartsWith("skill") || itemLower.StartsWith("skills"))
                            {
                                skills = item.Substring(item.IndexOf(":") != -1 ? item.IndexOf(":") + 1 : 6).Trim();
                            }
                            else if (itemLower.StartsWith("salary") || itemLower.Contains("lpa") || itemLower.Contains("ctc"))
                            {
                                salary = item.Substring(item.IndexOf(":") != -1 ? item.IndexOf(":") + 1 : 0).Trim();
                                if (!salary.ToLower().Contains("lpa")) salary += " LPA";
                            }
                            else if (itemLower.StartsWith("vacanc") || itemLower.StartsWith("opening") || itemLower.StartsWith("positions"))
                            {
                                string vNum = System.Text.RegularExpressions.Regex.Match(item, @"\d+").Value;
                                if (!string.IsNullOrEmpty(vNum)) { vacancies = Convert.ToInt32(vNum);  }
                            }
                        }
                    }
                    else if (!string.IsNullOrEmpty(jobParams))
                    {
                        title = jobParams;
                    }

                    da = new SqlDataAdapter("select Company_Name from Company_reg_tbl where Email = '" + cEmail + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    string cName = ds.Tables[0].Rows.Count > 0 ? ds.Tables[0].Rows[0]["Company_Name"].ToString() : "Recruiter";

                    string jobDesc = "Autonomous AI Job Posting for role " + title + ". Requiring foundational competencies in " + skills + ". Package offering: " + salary + " with direct campus placement eligibility.";

                    cmd = new SqlCommand("insert into Job_tbl (Company_Email, Company_Name, Job_Title, Job_Description, Job_Type, Salary_CTC, Location, Min_CGPA, Max_Backlogs, Eligible_Dept, Required_Skills, Vacancies, App_Deadline, Status, Created_Date) values ('" + cEmail + "', '" + cName.Replace("'", "''") + "', '" + title.Replace("'", "''") + "', '" + jobDesc.Replace("'", "''") + "', 'Full-Time', '" + salary.Replace("'", "''") + "', 'Campus / Hybrid', 6.0, 0, 'All Engineering & MCA', '" + skills.Replace("'", "''") + "', " + vacancies + ", DATEADD(month, 1, GETDATE()), 'Published', GETDATE())", con);
                    cmd.ExecuteNonQuery();

                    return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-check-circle-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Job Published to Campus Portal!</h6>" +
                           "<div class='small'><b>Designation:</b> " + Server.HtmlEncode(title) + "<br/>" +
                           "<b>Skills Required:</b> " + Server.HtmlEncode(skills) + "<br/>" +
                           "<b>Salary:</b> " + Server.HtmlEncode(salary) + " | <b>Vacancies:</b> " + vacancies + "<br/>" +
                           "<b>Status:</b> <span class='badge bg-success'>Published in Live Database</span><br/>" +
                           "<a href='jobs.aspx' class='btn btn-sm btn-primary fw-bold mt-2 shadow-sm rounded-pill'><i class='bi bi-briefcase me-1'></i>View in My Job Listings</a></div>" +
                           "</div>";
                }

                // 2. Shortlist All Applicants
                if (qLower.Contains("shortlist all") || (qLower.Contains("shortlist") && qLower.Contains("pending")))
                {
                    cmd = new SqlCommand("update Application_tbl set Status = 'Shortlisted', Remarks = 'Shortlisted via AI Recruiter Copilot' where Company_Email = '" + cEmail + "' and (Status = 'Applied' or Status = 'Pending' or Status is null)", con);
                    int affected = cmd.ExecuteNonQuery();
                    return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-person-check-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Applicants Shortlisted</h6>" +
                           "<div class='small'>Successfully updated <b>" + affected + " candidate application(s)</b> to <b>Shortlisted</b> status in <code>Application_tbl</code>.<br/>" +
                           "<a href='applicants.aspx' class='btn btn-sm btn-outline-success mt-2 rounded-pill'><i class='bi bi-people me-1'></i>View Shortlisted Candidates</a></div>" +
                           "</div>";
                }

                // 3. Shortlist specific candidate: "shortlist student [name/email]"
                if (qLower.StartsWith("shortlist"))
                {
                    string target = q.Substring(9).Trim();
                    cmd = new SqlCommand("update Application_tbl set Status = 'Shortlisted', Remarks = 'Shortlisted via AI Recruiter Copilot' where Company_Email = '" + cEmail + "' and (Student_Name like '%" + target.Replace("'", "''") + "%' or Student_Email like '%" + target.Replace("'", "''") + "%')", con);
                    int affected = cmd.ExecuteNonQuery();
                    return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-person-check-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Candidate Shortlisted</h6>" +
                           "<div class='small'>Candidate matching <b>'" + Server.HtmlEncode(target) + "'</b> (" + affected + " record(s)) updated to <b>Shortlisted</b> in <code>Application_tbl</code>.</div>" +
                           "</div>";
                }

                // 4. Reject candidate: "reject [name/email]"
                if (qLower.StartsWith("reject"))
                {
                    string target = q.Substring(6).Trim();
                    cmd = new SqlCommand("update Application_tbl set Status = 'Rejected', Remarks = 'Not progressed via AI Recruiter Copilot' where Company_Email = '" + cEmail + "' and (Student_Name like '%" + target.Replace("'", "''") + "%' or Student_Email like '%" + target.Replace("'", "''") + "%')", con);
                    int affected = cmd.ExecuteNonQuery();
                    return "<div class='alert alert-warning py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-person-x-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Candidate Application Rejected</h6>" +
                           "<div class='small'>Application matching <b>'" + Server.HtmlEncode(target) + "'</b> marked as <b>Rejected</b> in <code>Application_tbl</code>.</div>" +
                           "</div>";
                }

                // 5. Delete Job: "delete job [id/title]"
                if (qLower.StartsWith("delete job") || qLower.StartsWith("delete expired"))
                {
                    string target = qLower.Contains("job") ? q.Substring(q.IndexOf("job", StringComparison.OrdinalIgnoreCase) + 3).Trim() : "";
                    int affected = 0;
                    if (string.IsNullOrEmpty(target) || qLower.Contains("expired") || qLower.Contains("inactive"))
                    {
                        cmd = new SqlCommand("delete from Job_tbl where Company_Email = '" + cEmail + "' and (Status in ('Closed', 'Draft', 'Expired') or App_Deadline < GETDATE())", con);
                        affected = cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        int jId;
                        jId = 0; jId = Convert.ToInt32(target);  if (jId > 0)
                        {
                            cmd = new SqlCommand("delete from Job_tbl where Company_Email = '" + cEmail + "' and Job_Id = " + jId, con);
                        }
                        else
                        {
                            cmd = new SqlCommand("delete from Job_tbl where Company_Email = '" + cEmail + "' and Job_Title like '%" + target.Replace("'", "''") + "%'", con);
                        }
                        affected = cmd.ExecuteNonQuery();
                    }
                    return "<div class='alert alert-danger py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-trash3-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Job Listing Deleted</h6>" +
                           "<div class='small'>Deleted <b>" + affected + " job record(s)</b> from your recruitment listings in <code>Job_tbl</code>.</div>" +
                           "</div>";
                }

            return null;
        }

        protected void btnAsk_Click(object sender, EventArgs e)
        {
            string q = txtAsk.Text.Trim();
            if (q == "") return;

            // Check for autonomous DB action execution
            string actionOutput = TryExecuteRecruiterAction(q);
            string aiReply = "";

            if (!string.IsNullOrEmpty(actionOutput))
            {
                aiReply = actionOutput;
            }
            else
            {
                string prompt = "You are an AI assistant for a corporate recruiter at a college campus placement drive. Answer this question: " + q;
                aiReply = CallApi(prompt, q);
            }

            string chat = Session["comp_ai_chat"] != null ? Session["comp_ai_chat"].ToString() : "";
            chat += "<div class='d-flex justify-content-end mb-2'><div class='bg-primary text-white p-2 px-3 rounded-3' style='max-width:80%'><b>You:</b> " + Server.HtmlEncode(q) + "</div></div>";
            chat += "<div class='d-flex mb-2'><div class='bg-light border p-3 rounded-3' style='max-width:85%'><b>AI Assistant:</b><br/>" + aiReply + "</div></div>";

            Session["comp_ai_chat"] = chat;
            chatHtml = chat;
            txtAsk.Text = "";

            getcon();
                string safeQ = q.Replace("'", "''");
                string safeA = aiReply.Replace("'", "''");
                cmd = new SqlCommand("insert into AI_History_tbl(Module, User_Email, Prompt, Response, Created_Date) values('CompanyAI', '" + Session["company"] + "', '" + safeQ + "', '" + safeA + "', GETDATE())", con);
                cmd.ExecuteNonQuery();
            
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            getcon();
                cmd = new SqlCommand("delete from AI_History_tbl where Module='CompanyAI' and User_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();
            
            Session["comp_ai_chat"] = "<div class='p-3 bg-light rounded-3 mb-2'><b>AI Assistant:</b> Hello Recruiter! I am your AI Campus Recruitment Assistant. Ask me anything about job descriptions, candidates, skills, or campus interviews.</div>";
            chatHtml = Session["comp_ai_chat"].ToString();
            txtAsk.Text = "";
        }
    }
}
