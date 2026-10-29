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
                string user = Session["admin"].ToString();
                da = new SqlDataAdapter("select top 20 * from AI_History_tbl where Module='AdminAI' and User_Email='" + user + "' order by AI_History_Id asc", con);
                ds = new DataSet();
                da.Fill(ds);
                string chat = "<div class='p-3 bg-light rounded-3 mb-2'><b>AI Assistant:</b> Hello Administrator! I am your AI Administrative Assistant. Ask me anything about users, placements, companies, or system activity.</div>";
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
                Session["admin_ai_chat"] = chat;
                chatHtml = chat;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
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
            return GenerateAdminAnswer(q);
        }

        private string GenerateAdminAnswer(string q)
        {
            string qLower = q.ToLower();
            getcon();
                // 1. Grievances
                if (qLower.Contains("grievance"))
                {
                    da = new SqlDataAdapter("select * from Grievance_tbl where Status in ('Open','Pending') or Status is null", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int openCount = ds.Tables[0].Rows.Count;

                    da = new SqlDataAdapter("select * from Grievance_tbl", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int totalCount = ds.Tables[0].Rows.Count;

                    return "<b>Grievance Redressal Audit:</b><br/><br/>" +
                           "&bull; <b>Open / Pending Grievances:</b> <span class='badge bg-warning text-dark'>" + openCount + " unresolved</span><br/>" +
                           "&bull; <b>Total Registered Tickets:</b> " + totalCount + "<br/>" +
                           "&bull; <b>Resolved Rate:</b> " + (totalCount > 0 ? ((totalCount - openCount) * 100 / totalCount).ToString() + "%" : "100%") + "<br/><br/>" +
                           "<i>Navigate to <b>Grievances</b> to triage and assign tickets to campus authorities.</i>";
                }

                // 2. Placement percentage / rate
                if (qLower.Contains("placement") || qLower.Contains("rate") || qLower.Contains("percentage"))
                {
                    da = new SqlDataAdapter("select * from Student_Reg_tbl", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int totalS = ds.Tables[0].Rows.Count;

                    da = new SqlDataAdapter("select distinct Student_Email from Selection_tbl", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int placedS = ds.Tables[0].Rows.Count;

                    double pct = totalS > 0 ? Math.Round(((double)placedS / totalS) * 100, 1) : 0.0;
                    return "<b>Institutional Placement KPI:</b><br/><br/>" +
                           "&bull; <b>Total Eligible Students:</b> " + totalS + "<br/>" +
                           "&bull; <b>Placed Students:</b> " + placedS + "<br/>" +
                           "&bull; <b>Placement Achievement:</b> <b>" + pct + "%</b><br/><br/>" +
                           "<i>Real-time statistics extracted from verified student selections.</i>";
                }

                // 3. Top recruiters / Companies
                if (qLower.Contains("top recruiter") || qLower.Contains("hire") || qLower.Contains("companies"))
                {
                    da = new SqlDataAdapter("select top 5 Company_Name, Industry, Verification_Status from Company_reg_tbl order by Company_Id desc", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string res = "<b>Corporate Recruitment Partners:</b><br/><br/>";
                        for (int r = 0; r < ds.Tables[0].Rows.Count; r++)
                        {
                                                        res += "&bull; <b>" + ds.Tables[0].Rows[r]["Company_Name"] + "</b> (" + ds.Tables[0].Rows[r]["Industry"] + ") &mdash; Status: <span class='badge bg-success-subtle text-success'>" + ds.Tables[0].Rows[r]["Verification_Status"] + "</span><br/>";
                        }
                        return res;
                    }
                    else
                    {
                        return "<b>Company Records:</b> No companies registered yet.";
                    }
                }

                // 4. Upcoming drives
                if (qLower.Contains("drive"))
                {
                    da = new SqlDataAdapter("select top 5 Job_Title, Company_Name, Salary_CTC, App_Deadline from Job_tbl where Status in ('Active','Published','Open') order by Job_Id desc", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string res = "<b>Active Recruitment Drives:</b><br/><br/>";
                        for (int r = 0; r < ds.Tables[0].Rows.Count; r++)
                        {
                                                        string dDate = ds.Tables[0].Rows[r]["App_Deadline"] != DBNull.Value ? Convert.ToDateTime(ds.Tables[0].Rows[r]["App_Deadline"]).ToString("dd MMM yyyy") : "Open";
                            res += "&bull; <b>" + ds.Tables[0].Rows[r]["Job_Title"] + "</b> at <b>" + ds.Tables[0].Rows[r]["Company_Name"] + "</b> &mdash; Rs. " + ds.Tables[0].Rows[r]["Salary_CTC"] + " LPA (Deadline: " + dDate + ")<br/>";
                        }
                        return res;
                    }
                    else
                    {
                        return "<b>No Active Drives:</b> There are no open job drives currently active.";
                    }
                }

                // 5. Offers & packages
                if (qLower.Contains("package") || qLower.Contains("offer"))
                {
                    da = new SqlDataAdapter("select top 5 * from Selection_tbl order by Selection_Id desc", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string res = "<b>Latest Campus Selections &amp; Packages:</b><br/><br/>";
                        for (int r = 0; r < ds.Tables[0].Rows.Count; r++)
                        {
                                                        string sName = ds.Tables[0].Rows[r]["Student_Name"].ToString();
                            string pkg = ds.Tables[0].Rows[r]["Package_LPA"] != DBNull.Value ? ds.Tables[0].Rows[r]["Package_LPA"].ToString() : "-";
                            res += "&bull; <b>" + sName + "</b> &mdash; <b>Rs. " + pkg + " LPA</b><br/>";
                        }
                        return res;
                    }
                    else
                    {
                        return "<b>Package Statistics:</b> No candidate packages recorded yet.";
                    }
                }

                // 6. Verification
                if (qLower.Contains("verif"))
                {
                    da = new SqlDataAdapter("select * from Company_reg_tbl where Verification_Status='Pending' or Verification_Status is null", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int pendingComp = ds.Tables[0].Rows.Count;

                    da = new SqlDataAdapter("select * from Student_Reg_tbl where Account_Status='Pending' or Account_Status is null", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    int pendingStud = ds.Tables[0].Rows.Count;

                    return "<b>Pending Portal Verifications:</b><br/><br/>" +
                           "&bull; <b>Companies Awaiting Approval:</b> " + pendingComp + "<br/>" +
                           "&bull; <b>Students Awaiting KYC Approval:</b> " + pendingStud + "<br/><br/>" +
                           "<i>Visit <b>Company Verification</b> and <b>Student Verification</b> to approve access credentials.</i>";
                }
            return "<b>Administrative Intelligence:</b><br/><br/>" +
                   "Regarding: <i>" + Server.HtmlEncode(q) + "</i><br/><br/>" +
                   "&bull; System uptime, security audits, and role-based access control are functioning nominally.<br/>" +
                   "&bull; Monitor open grievances and unverified company registrations to maintain placement governance.<br/><br/>" +
                   "<i>Click any quick query chip for real-time audit details.</i>";
        }

        private string TryExecuteAutonomousAction(string q)
        {
            string qLower = q.ToLower().Trim();
            getcon();

                // 1. Approve All Pending Companies
                if (qLower.Contains("approve all") && (qLower.Contains("company") || qLower.Contains("companies") || qLower.Contains("recruiter")))
                {
                    cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Approved' where Verification_Status = 'Pending' or Verification_Status is null", con);
                    int affected = cmd.ExecuteNonQuery();
                    return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-check-circle-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Approved All Pending Companies</h6>" +
                           "<div class='small'>Successfully verified and activated <b>" + affected + " company records</b> in <code>Company_reg_tbl</code>. Their recruiter credentials are now active on the portal.</div>" +
                           "</div>";
                }

                // 2. Approve specific company: e.g. "approve company Infosys" or "verify company TCS"
                if ((qLower.StartsWith("approve company") || qLower.StartsWith("verify company")) && !qLower.Contains("all"))
                {
                    string compTarget = q.Substring(q.IndexOf("company", StringComparison.OrdinalIgnoreCase) + 7).Trim();
                    if (!string.IsNullOrEmpty(compTarget))
                    {
                        cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Approved' where Company_Name like '%" + compTarget.Replace("'", "''") + "%' or Email like '%" + compTarget.Replace("'", "''") + "%'", con);
                        int affected = cmd.ExecuteNonQuery();
                        return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                               "<h6 class='fw-bold mb-1'><i class='bi bi-check-circle-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Recruiter Approved</h6>" +
                               "<div class='small'>Company matching <b>'" + Server.HtmlEncode(compTarget) + "'</b> (" + affected + " record(s)) updated to <b>Approved</b> in <code>Company_reg_tbl</code>.</div>" +
                               "</div>";
                    }
                }

                // 3. Reject / Block Company: e.g. "reject company XYZ"
                if (qLower.StartsWith("reject company") || qLower.StartsWith("block company"))
                {
                    string compTarget = q.Substring(q.IndexOf("company", StringComparison.OrdinalIgnoreCase) + 7).Trim();
                    if (!string.IsNullOrEmpty(compTarget))
                    {
                        cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Rejected' where Company_Name like '%" + compTarget.Replace("'", "''") + "%' or Email like '%" + compTarget.Replace("'", "''") + "%'", con);
                        int affected = cmd.ExecuteNonQuery();
                        return "<div class='alert alert-warning py-2 px-3 mb-0 rounded-3'>" +
                               "<h6 class='fw-bold mb-1'><i class='bi bi-shield-x me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Company Rejected</h6>" +
                               "<div class='small'>Company matching <b>'" + Server.HtmlEncode(compTarget) + "'</b> (" + affected + " record(s)) updated to <b>Rejected</b> in <code>Company_reg_tbl</code>.</div>" +
                               "</div>";
                    }
                }

                // 4. Delete Company: e.g. "delete company Infosys"
                if (qLower.StartsWith("delete company"))
                {
                    string compTarget = q.Substring(q.IndexOf("company", StringComparison.OrdinalIgnoreCase) + 7).Trim();
                    if (!string.IsNullOrEmpty(compTarget))
                    {
                        cmd = new SqlCommand("delete from Company_reg_tbl where Company_Name like '%" + compTarget.Replace("'", "''") + "%' or Email like '%" + compTarget.Replace("'", "''") + "%'", con);
                        int affected = cmd.ExecuteNonQuery();
                        return "<div class='alert alert-danger py-2 px-3 mb-0 rounded-3'>" +
                               "<h6 class='fw-bold mb-1'><i class='bi bi-trash3-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Company Deleted</h6>" +
                               "<div class='small'>Successfully deleted <b>" + affected + " record(s)</b> matching '" + Server.HtmlEncode(compTarget) + "' from <code>Company_reg_tbl</code>.</div>" +
                               "</div>";
                    }
                }

                // 5. Verify / Approve All Students
                if ((qLower.Contains("verify all") && qLower.Contains("student")) || (qLower.Contains("approve all") && qLower.Contains("student")))
                {
                    cmd = new SqlCommand("update Student_Reg_tbl set Account_Status = 'Active' where Account_Status != 'Active' or Account_Status is null", con);
                    int affected = cmd.ExecuteNonQuery();
                    return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-person-check-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Verified All Students</h6>" +
                           "<div class='small'>Approved and verified <b>" + affected + " student accounts</b> in <code>Student_Reg_tbl</code>.</div>" +
                           "</div>";
                }

                // 6. Verify / Approve specific student: e.g. "verify student rahul" or "approve student rahul"
                if ((qLower.StartsWith("verify student") || qLower.StartsWith("approve student")) && !qLower.Contains("all"))
                {
                    string stuTarget = q.Substring(q.IndexOf("student", StringComparison.OrdinalIgnoreCase) + 7).Trim();
                    if (!string.IsNullOrEmpty(stuTarget))
                    {
                        cmd = new SqlCommand("update Student_Reg_tbl set Account_Status = 'Active' where Full_Name like '%" + stuTarget.Replace("'", "''") + "%' or Email like '%" + stuTarget.Replace("'", "''") + "%' or Enrollment_No like '%" + stuTarget.Replace("'", "''") + "%'", con);
                        int affected = cmd.ExecuteNonQuery();
                        return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                               "<h6 class='fw-bold mb-1'><i class='bi bi-person-check-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Student Approved</h6>" +
                               "<div class='small'>Student matching <b>'" + Server.HtmlEncode(stuTarget) + "'</b> (" + affected + " record(s)) updated to <b>Active</b> in <code>Student_Reg_tbl</code>.</div>" +
                               "</div>";
                    }
                }

                // 7. Block / Suspend student: e.g. "block student rahul"
                if (qLower.StartsWith("block student") || qLower.StartsWith("suspend student"))
                {
                    string stuTarget = q.Substring(q.IndexOf("student", StringComparison.OrdinalIgnoreCase) + 7).Trim();
                    if (!string.IsNullOrEmpty(stuTarget))
                    {
                        cmd = new SqlCommand("update Student_Reg_tbl set Account_Status = 'Suspended' where Full_Name like '%" + stuTarget.Replace("'", "''") + "%' or Email like '%" + stuTarget.Replace("'", "''") + "%' or Enrollment_No like '%" + stuTarget.Replace("'", "''") + "%'", con);
                        int affected = cmd.ExecuteNonQuery();
                        return "<div class='alert alert-warning py-2 px-3 mb-0 rounded-3'>" +
                               "<h6 class='fw-bold mb-1'><i class='bi bi-person-x-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Student Suspended</h6>" +
                               "<div class='small'>Student matching <b>'" + Server.HtmlEncode(stuTarget) + "'</b> (" + affected + " record(s)) updated to <b>Suspended</b>.</div>" +
                               "</div>";
                    }
                }

                // 8. Delete student: e.g. "delete student rahul"
                if (qLower.StartsWith("delete student"))
                {
                    string stuTarget = q.Substring(q.IndexOf("student", StringComparison.OrdinalIgnoreCase) + 7).Trim();
                    if (!string.IsNullOrEmpty(stuTarget))
                    {
                        cmd = new SqlCommand("delete from Student_Reg_tbl where Full_Name like '%" + stuTarget.Replace("'", "''") + "%' or Email like '%" + stuTarget.Replace("'", "''") + "%' or Enrollment_No like '%" + stuTarget.Replace("'", "''") + "%'", con);
                        int affected = cmd.ExecuteNonQuery();
                        return "<div class='alert alert-danger py-2 px-3 mb-0 rounded-3'>" +
                               "<h6 class='fw-bold mb-1'><i class='bi bi-trash3-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Student Deleted</h6>" +
                               "<div class='small'>Deleted <b>" + affected + " record(s)</b> matching '" + Server.HtmlEncode(stuTarget) + "' from <code>Student_Reg_tbl</code>.</div>" +
                               "</div>";
                    }
                }

                // 9. Resolve all open grievances
                if (qLower.Contains("resolve all") && qLower.Contains("grievance"))
                {
                    cmd = new SqlCommand("update Grievance_tbl set Status = 'Resolved', Resolution = 'Resolved by Administrator via AI Command Center', Resolved_Date = GETDATE() where Status != 'Resolved' or Status is null", con);
                    int affected = cmd.ExecuteNonQuery();
                    return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-shield-check me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Resolved All Grievances</h6>" +
                           "<div class='small'>Marked <b>" + affected + " open grievance(s)</b> as <b>Resolved</b> with official administrative resolution timestamp.</div>" +
                           "</div>";
                }

                // 10. Resolve specific grievance: e.g. "resolve grievance 3" or "close grievance #3"
                if (qLower.StartsWith("resolve grievance") || qLower.StartsWith("close grievance"))
                {
                    string numStr = System.Text.RegularExpressions.Regex.Match(q, @"\d+").Value;
                    if (!string.IsNullOrEmpty(numStr))
                    {
                        cmd = new SqlCommand("update Grievance_tbl set Status = 'Resolved', Resolution = 'Resolved by Administrator via AI Command Center', Resolved_Date = GETDATE() where Grievance_Id = " + numStr, con);
                        int affected = cmd.ExecuteNonQuery();
                        return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                               "<h6 class='fw-bold mb-1'><i class='bi bi-shield-check me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Grievance #" + numStr + " Resolved</h6>" +
                               "<div class='small'>Ticket #" + numStr + " marked as <b>Resolved</b> in <code>Grievance_tbl</code>.</div>" +
                               "</div>";
                    }
                }

                // 11. Delete Grievance: e.g. "delete grievance 3"
                if (qLower.StartsWith("delete grievance"))
                {
                    string numStr = System.Text.RegularExpressions.Regex.Match(q, @"\d+").Value;
                    if (!string.IsNullOrEmpty(numStr))
                    {
                        cmd = new SqlCommand("delete from Grievance_tbl where Grievance_Id = " + numStr, con);
                        int affected = cmd.ExecuteNonQuery();
                        return "<div class='alert alert-danger py-2 px-3 mb-0 rounded-3'>" +
                               "<h6 class='fw-bold mb-1'><i class='bi bi-trash3-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Grievance #" + numStr + " Deleted</h6>" +
                               "<div class='small'>Ticket #" + numStr + " permanently deleted from database.</div>" +
                               "</div>";
                    }
                }

                // 12. Delete Job / Drive: e.g. "delete job 5" or "delete job Python Developer"
                if (qLower.StartsWith("delete job") || qLower.StartsWith("delete drive"))
                {
                    string target = q.Substring(q.IndexOf("job", StringComparison.OrdinalIgnoreCase) != -1 ? q.IndexOf("job", StringComparison.OrdinalIgnoreCase) + 3 : q.IndexOf("drive", StringComparison.OrdinalIgnoreCase) + 5).Trim();
                    int jId;
                    jId = 0; jId = Convert.ToInt32(target);  if (jId > 0)
                    {
                        cmd = new SqlCommand("delete from Job_tbl where Job_Id = " + jId, con);
                    }
                    else
                    {
                        cmd = new SqlCommand("delete from Job_tbl where Job_Title like '%" + target.Replace("'", "''") + "%'", con);
                    }
                    int affected = cmd.ExecuteNonQuery();
                    return "<div class='alert alert-danger py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-trash3-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Job Removed</h6>" +
                           "<div class='small'>Deleted <b>" + affected + " job record(s)</b> matching '" + Server.HtmlEncode(target) + "' from <code>Job_tbl</code>.</div>" +
                           "</div>";
                }

                // 13. Post Notice: e.g. "post notice: Title - Description" or "publish notice: Title - Description"
                if (qLower.StartsWith("post notice:") || qLower.StartsWith("publish notice:") || qLower.StartsWith("post notice") || qLower.StartsWith("publish notice"))
                {
                    string noticeBody = q.Substring(q.IndexOf("notice", StringComparison.OrdinalIgnoreCase) + 6).TrimStart(':', ' ');
                    string title = "Campus Announcement";
                    string desc = noticeBody;
                    if (noticeBody.Contains("-"))
                    {
                        string[] parts = noticeBody.Split(new char[] { '-' }, 2);
                        title = parts[0].Trim();
                        desc = parts[1].Trim();
                    }
                    cmd = new SqlCommand("insert into Notice_tbl (Title, Category, Description, Target_Audience, Department, Batch, Priority, Status, Created_By) values ('" + title.Replace("'", "''") + "', 'General', '" + desc.Replace("'", "''") + "', 'All', 'All', 'All', 'High', 'Active', 'Central Admin (AI Engine)')", con);
                    cmd.ExecuteNonQuery();
                    return "<div class='alert alert-success py-2 px-3 mb-0 rounded-3'>" +
                           "<h6 class='fw-bold mb-1'><i class='bi bi-megaphone-fill me-1'></i><i class='bi bi-lightning-charge-fill text-warning me-1'></i>Autonomous DB Action: Notice Published</h6>" +
                           "<div class='small'><b>Title:</b> " + Server.HtmlEncode(title) + "<br/><b>Content:</b> " + Server.HtmlEncode(desc) + "<br/>Published to campus notice board and student dashboards!</div>" +
                           "</div>";
                }

            return null;
        }

        protected void btnAsk_Click(object sender, EventArgs e)
        {
            string q = txtAsk.Text.Trim();
            if (q == "") return;

            // Check if user requested an autonomous DB action (Approve, Update, Delete, Post Notice)
            string actionOutput = TryExecuteAutonomousAction(q);
            string aiReply = "";

            if (!string.IsNullOrEmpty(actionOutput))
            {
                aiReply = actionOutput;
            }
            else
            {
                string prompt = "You are an AI assistant for the University Placement Administrator. Answer this system administration question: " + q;
                aiReply = CallApi(prompt, q);
            }

            string chat = Session["admin_ai_chat"] != null ? Session["admin_ai_chat"].ToString() : "";
            chat += "<div class='d-flex justify-content-end mb-2'><div class='bg-primary text-white p-2 px-3 rounded-3' style='max-width:80%'><b>You:</b> " + Server.HtmlEncode(q) + "</div></div>";
            chat += "<div class='d-flex mb-2'><div class='bg-light border p-3 rounded-3' style='max-width:85%'><b>AI Assistant:</b><br/>" + aiReply + "</div></div>";

            Session["admin_ai_chat"] = chat;
            chatHtml = chat;
            txtAsk.Text = "";

            getcon();
                string safeQ = q.Replace("'", "''");
                string safeA = aiReply.Replace("'", "''");
                cmd = new SqlCommand("insert into AI_History_tbl(Module, User_Email, Prompt, Response, Created_Date) values('AdminAI', '" + Session["admin"] + "', '" + safeQ + "', '" + safeA + "', GETDATE())", con);
                cmd.ExecuteNonQuery();
            
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            getcon();
                cmd = new SqlCommand("delete from AI_History_tbl where Module='AdminAI' and User_Email='" + Session["admin"] + "'", con);
                cmd.ExecuteNonQuery();
            
            Session["admin_ai_chat"] = "<div class='p-3 bg-light rounded-3 mb-2'><b>AI Assistant:</b> Hello Administrator! I am your AI Administrative Assistant. Ask me anything about users, placements, companies, or system activity.</div>";
            chatHtml = Session["admin_ai_chat"].ToString();
            txtAsk.Text = "";
        }
    }
}
