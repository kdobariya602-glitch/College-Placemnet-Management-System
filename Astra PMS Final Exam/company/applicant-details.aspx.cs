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
    public partial class applicant_details : System.Web.UI.Page
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

        void notify(string email, string title, string msg, string typ)
        {
            getcon();
            cmd = new SqlCommand("insert into Notification_tbl (Recipient_Role, Recipient_Email, Title, Message, Notification_Type, Is_Read, Created_Date) values ('Student', '" + email + "', '" + title + "', '" + msg + "', '" + typ + "', 0, GETDATE())", con);
            cmd.ExecuteNonQuery();
        }

        string getctc(string jobId)
        {
            getcon();
            da = new SqlDataAdapter("select Salary_CTC from Job_tbl where Job_Id='" + jobId + "'", con);
            DataSet dsCtc = new DataSet();
            da.Fill(dsCtc);
            if (dsCtc.Tables[0].Rows.Count > 0 && dsCtc.Tables[0].Rows[0][0] != DBNull.Value && dsCtc.Tables[0].Rows[0][0].ToString().Trim() != "")
            {
                return dsCtc.Tables[0].Rows[0][0].ToString().Trim();
            }
            return "Not Disclosed";
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

                if (Session["aid"] != null) { ViewState["aid"] = Session["aid"]; }

                if (!IsPostBack)
                {
                    filldata();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void filldata()
        {
            getcon();
            ds = new DataSet();
            if (ViewState["aid"] != null && ViewState["aid"].ToString() != "")
            {
                da = new SqlDataAdapter("select * from Application_tbl where Application_Id='" + ViewState["aid"] + "' and Company_Email='" + Session["company"] + "'", con);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count == 0)
                {
                    da = new SqlDataAdapter("select * from Application_tbl where Application_Id='" + ViewState["aid"] + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                }
            }

            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                da = new SqlDataAdapter("select top 1 * from Application_tbl where Company_Email='" + Session["company"] + "' order by Application_Id desc", con);
                ds = new DataSet();
                da.Fill(ds);
            }

            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                da = new SqlDataAdapter("select top 1 * from Application_tbl order by Application_Id desc", con);
                ds = new DataSet();
                da.Fill(ds);
            }

            if (ds.Tables[0].Rows.Count == 0)
            {
                Response.Redirect("applicants.aspx");
                return;
            }

            ViewState["aid"] = ds.Tables[0].Rows[0]["Application_Id"].ToString();
            Session["aid"] = ViewState["aid"];

            if (ds.Tables[0].Rows.Count > 0)
            {
                string sEmail = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                string jobTitle = ds.Tables[0].Rows[0]["Job_Title"].ToString();
                lblName.Text = ds.Tables[0].Rows[0]["Student_Name"].ToString();
                lblEmail.Text = sEmail;
                lblAppStatusBadge.Text = ds.Tables[0].Rows[0]["Status"].ToString();

                da = new SqlDataAdapter("select * from Student_Reg_tbl where Email='" + sEmail + "' or Enrollment_No='" + sEmail + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string sPhoto = ds.Tables[0].Rows[0]["Photo_File"] != DBNull.Value ? ds.Tables[0].Rows[0]["Photo_File"].ToString().Trim() : "";
                    string sFullName = ds.Tables[0].Rows[0]["Full_Name"].ToString();
                    string sInitials = "AP";
                    if (!string.IsNullOrWhiteSpace(sFullName))
                    {
                        string[] parts = sFullName.Trim().Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                        if (parts.Length >= 2)
                            sInitials = (parts[0][0].ToString() + parts[parts.Length - 1][0].ToString()).ToUpper();
                        else if (parts.Length == 1 && parts[0].Length > 0)
                            sInitials = parts[0].Substring(0, Math.Min(2, parts[0].Length)).ToUpper();
                    }

                    if (!string.IsNullOrEmpty(sPhoto))
                    {
                        string photoUrl = sPhoto;
                        if (!photoUrl.StartsWith("http") && !photoUrl.StartsWith("/") && !photoUrl.StartsWith("~"))
                            photoUrl = ResolveUrl("~/uploads/profiles/" + sPhoto);
                        else
                            photoUrl = ResolveUrl(photoUrl);
                        litApplicantAvatar.Text = string.Format("<img src='{0}' alt='{1}' style='width:100%; height:100%; object-fit:cover; display:block;' onerror=\"this.onerror=null; this.parentElement.innerHTML='<span style=\\'font-size:2rem; font-weight:bold;\\'>{2}</span>';\" />", photoUrl, Server.HtmlEncode(sFullName), sInitials);
                    }
                    else
                    {
                        litApplicantAvatar.Text = string.Format("<span style='font-size:2rem; font-weight:bold;'>{0}</span>", sInitials);
                    }

                    lblEnrollment.Text = ds.Tables[0].Rows[0]["Enrollment_No"].ToString();
                    lblPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
                    string dept = ds.Tables[0].Rows[0]["Course"].ToString() + " (" + ds.Tables[0].Rows[0]["Branch"].ToString() + ")";
                    lblDeptCourse.Text = dept;
                    lblBatchSem.Text = ds.Tables[0].Rows[0]["Batch"].ToString() + " - Semester " + ds.Tables[0].Rows[0]["Semester"].ToString();

                    lbl10th.Text = ds.Tables[0].Rows[0]["Tenth_Pct"].ToString();
                    lbl12th.Text = ds.Tables[0].Rows[0]["Twelfth_Pct"].ToString();
                    string cgpaStr = ds.Tables[0].Rows[0]["Cgpa"].ToString();
                    lblCGPA.Text = cgpaStr;
                    string backlogsStr = ds.Tables[0].Rows[0]["Active_Backlogs"].ToString();
                    lblBacklogs.Text = backlogsStr;

                    string skillsStr = ds.Tables[0].Rows[0]["Skills"].ToString();
                    lblSkills.Text = skillsStr;

                    string resumePath = ds.Tables[0].Rows[0]["Resume_File"].ToString();
                    if (resumePath == "")
                    {
                        lblResumeFileName.Text = "sample_resume.pdf";
                    }
                    else if (resumePath.Contains("/"))
                    {
                        lblResumeFileName.Text = resumePath.Substring(resumePath.LastIndexOf('/') + 1);
                    }
                    else
                    {
                        lblResumeFileName.Text = resumePath;
                    }
                    lnkResumeDownload.NavigateUrl = GetSafeResumeUrl(resumePath);

                    PopulateAiScreening(lblName.Text, dept, cgpaStr, backlogsStr, skillsStr, jobTitle);
                }
            }
        }

        

        

        protected void btnRunAiScreening_Click(object sender, EventArgs e)
        {
            filldata();
            Response.Write("<script>alert('AI Candidate Screening completed successfully! View match index and custom interview questions below.');</script>");
        }

        private void PopulateAiScreening(string sName, string dept, string cgpaStr, string backlogsStr, string skills, string jobTitle)
        {
            double cgpa = 7.0;
            if (!string.IsNullOrEmpty(cgpaStr)) { cgpa = Convert.ToDouble(cgpaStr); }
            int backlogs = 0;
            if (!string.IsNullOrEmpty(backlogsStr)) { backlogs = Convert.ToInt32(backlogsStr); }
                int scoreVal = 70;
                if (cgpa >= 8.5) scoreVal += 15;
                else if (cgpa >= 7.5) scoreVal += 10;
                else if (cgpa >= 6.5) scoreVal += 5;

                if (backlogs == 0) scoreVal += 10;
                if (skills.ToLower().Contains("sql") || skills.ToLower().Contains("python") || skills.ToLower().Contains("c#") || skills.ToLower().Contains("react")) scoreVal += 5;
                if (scoreVal > 98) scoreVal = 98;

                lblAiScore.Text = scoreVal + "% Match Index";
                if (scoreVal >= 85)
                {
                    lblAiVerdict.Text = "Top Tier Candidate (Highly Recommended)";
}
                else if (scoreVal >= 75)
                {
                    lblAiVerdict.Text = "Eligible Candidate (Meets Benchmarks)";
}
                else
                {
                    lblAiVerdict.Text = "Requires Technical Assessment Review";
}

                lblAiSummary.Text = "Candidate " + sName + " holds a consistent academic record (" + cgpa + " CGPA, " + backlogs + " backlogs) and practical proficiency in: " + (!string.IsNullOrEmpty(skills) ? skills : "Core Computer Science Fundamentals") + ". Profile aligns well with " + (!string.IsNullOrEmpty(jobTitle) ? jobTitle : "campus recruitment opening") + ".";

                litAiQuestions.Text = "<b>1. Technical Core:</b> Can you walk us through an end-to-end project where you implemented " + (!string.IsNullOrEmpty(skills) ? skills.Split(',')[0].Trim() : "your key technology") + "?<br/>" +
                                      "<b>2. Problem Solving:</b> How do you approach debugging and optimizing performance in database queries or API endpoints?<br/>" +
                                      "<b>3. Culture & Teamwork:</b> Describe a challenging team scenario during college hackathons or group assignments and how you resolved disagreements.";
        }

        public string GetSafeResumeUrl(string rawPath)
        {
            if (rawPath == null || rawPath.Trim() == "")
            {
                return ResolveUrl("~/uploads/resumes/sample_resume.pdf");
            }
            string cleaned = rawPath.TrimStart('~', '/');
            if (cleaned.ToLower().StartsWith("uploads/"))
            {
                return ResolveUrl("~/" + cleaned);
            }
            return ResolveUrl("~/uploads/resumes/" + cleaned);
        }

        protected void btnShortlist_Click(object sender, EventArgs e)
        {
            if (ViewState["aid"] != null && ViewState["aid"].ToString() != "")
            {
                getcon();
                cmd = new SqlCommand("update Application_tbl set Status='Shortlisted' where Application_Id='" + ViewState["aid"] + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                da = new SqlDataAdapter("select * from Application_tbl where Application_Id='" + ViewState["aid"] + "' and Company_Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string sEmail = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                    string sName = ds.Tables[0].Rows[0]["Student_Name"].ToString();
                    string cEmail = ds.Tables[0].Rows[0]["Company_Email"].ToString();
                    string cName = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                    string jTitle = ds.Tables[0].Rows[0]["Job_Title"].ToString();
                    string jId = ds.Tables[0].Rows[0]["Job_Id"].ToString();
                    string dId = ds.Tables[0].Rows[0]["Drive_Id"].ToString();

                    da = new SqlDataAdapter("select * from Shortlist_tbl where Application_Id='" + ViewState["aid"] + "' and Company_Email='" + Session["company"] + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count == 0)
                    {
                        cmd = new SqlCommand("insert into Shortlist_tbl (Application_Id, Job_Id, Drive_Id, Company_Email, Company_Name, Student_Email, Student_Name, Job_Title, Shortlisted_Date) values ('" + ViewState["aid"] + "', '" + jId + "', '" + dId + "', '" + cEmail + "', '" + cName + "', '" + sEmail + "', '" + sName + "', '" + jTitle + "', GETDATE())", con);
                        cmd.ExecuteNonQuery();
                    }

                    notify(sEmail, "You have been Shortlisted", "Congratulations! " + cName + " has shortlisted you for " + jTitle + ".", "Application");
                }

                Response.Write("<script>alert('Candidate Shortlisted!');</script>");
                filldata();
            }
        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {
            if (ViewState["aid"] != null && ViewState["aid"].ToString() != "")
            {
                getcon();
                cmd = new SqlCommand("update Application_tbl set Status='Selected' where Application_Id='" + ViewState["aid"] + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                da = new SqlDataAdapter("select * from Application_tbl where Application_Id='" + ViewState["aid"] + "' and Company_Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string studentEmail = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                    string studentName = ds.Tables[0].Rows[0]["Student_Name"].ToString();
                    string enrollNo = ds.Tables[0].Rows[0]["Enrollment_No"].ToString();
                    string dept = ds.Tables[0].Rows[0]["Department"].ToString();
                    string compEmail = ds.Tables[0].Rows[0]["Company_Email"].ToString();
                    string compName = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                    string jobTitle = ds.Tables[0].Rows[0]["Job_Title"].ToString();
                    string dId = ds.Tables[0].Rows[0]["Drive_Id"].ToString();
                    string jobId = ds.Tables[0].Rows[0]["Job_Id"].ToString();

                    cmd = new SqlCommand("update Student_Reg_tbl set Placement_Status='Placed' where Email='" + studentEmail + "'", con);
                    cmd.ExecuteNonQuery();

                    da = new SqlDataAdapter("select * from Selection_tbl where Application_Id='" + ViewState["aid"] + "'", con);
                    DataSet dsDup = new DataSet();
                    da.Fill(dsDup);
                    if (dsDup.Tables[0].Rows.Count == 0)
                    {
                        string ctc = getctc(jobId);
                        cmd = new SqlCommand("insert into Selection_tbl(Application_Id, Job_Id, Drive_Id, Company_Email, Company_Name, Job_Title, Student_Email, Student_Name, Enrollment_No, Department, Package_CTC, Offer_Date, Offer_Status, Created_Date) values('" + ViewState["aid"] + "', '" + jobId + "', '" + dId + "', '" + compEmail + "', '" + compName + "', '" + jobTitle + "', '" + studentEmail + "', '" + studentName + "', '" + enrollNo + "', '" + dept + "', '" + ctc + "', GETDATE(), 'Offered', GETDATE())", con);
                        cmd.ExecuteNonQuery();

                        notify(studentEmail, "Offer Received", "Congratulations! " + compName + " has selected you for " + jobTitle + " (CTC: " + ctc + ").", "Selection");
                    }
                }

                Response.Write("<script>alert('Candidate Selected!');</script>");
                filldata();
            }
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            if (ViewState["aid"] != null && ViewState["aid"].ToString() != "")
            {
                getcon();
                cmd = new SqlCommand("update Application_tbl set Status='Rejected' where Application_Id='" + ViewState["aid"] + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                da = new SqlDataAdapter("select * from Application_tbl where Application_Id='" + ViewState["aid"] + "' and Company_Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    notify(ds.Tables[0].Rows[0]["Student_Email"].ToString(), "Application Update", "Your application for " + ds.Tables[0].Rows[0]["Job_Title"].ToString() + " at " + ds.Tables[0].Rows[0]["Company_Name"].ToString() + " was not taken forward.", "Application");
                }

                Response.Write("<script>alert('Candidate Rejected!');</script>");
                filldata();
            }
        }
    }
}
