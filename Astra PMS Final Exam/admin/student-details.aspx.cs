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
    public partial class student_details : System.Web.UI.Page
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
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Admin_Login_tbl where Username='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Username"].ToString();
                }

                if (Session["stuid"] != null) { ViewState["stuid"] = Session["stuid"]; }

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
            if (ViewState["stuid"] != null && ViewState["stuid"].ToString() != "")
            {
                da = new SqlDataAdapter("select * from Student_Reg_tbl where Student_Id='" + ViewState["stuid"] + "' or Email='" + ViewState["stuid"] + "' or Enrollment_No='" + ViewState["stuid"] + "'", con);
            }
            else
            {
                da = new SqlDataAdapter("select top 1 * from Student_Reg_tbl order by Student_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                ViewState["stuid"] = ds.Tables[0].Rows[0]["Student_Id"].ToString();
                Session["stuid"] = ViewState["stuid"];

                string studentEmail = ds.Tables[0].Rows[0]["Email"].ToString();
                string sFullName = ds.Tables[0].Rows[0]["Full_Name"].ToString();
                lblFullName.Text = sFullName;
                string sPhoto = ds.Tables[0].Rows[0]["Photo_File"] != DBNull.Value ? ds.Tables[0].Rows[0]["Photo_File"].ToString().Trim() : "";
                string sInitials = "S";
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
                    {
                        photoUrl = ResolveUrl("~/uploads/profiles/" + sPhoto);
                    }
                    else
                    {
                        photoUrl = ResolveUrl(photoUrl);
                    }
                    litStudentInitials.Text = string.Format("<img src='{0}' alt='{1}' style='width:100%; height:100%; object-fit:cover; display:block;' onerror=\"this.onerror=null; this.parentElement.innerHTML='<span class=\\'fw-bold fs-2 text-primary\\'>{2}</span>';\" />", photoUrl, Server.HtmlEncode(sFullName), sInitials);
                }
                else
                {
                    litStudentInitials.Text = string.Format("<span class='fw-bold fs-2 text-primary'>{0}</span>", sInitials);
                }

                lblEnrollment.Text = ds.Tables[0].Rows[0]["Enrollment_No"].ToString();
                lblEmail.Text = studentEmail;
                lblPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
                lblBranch.Text = ds.Tables[0].Rows[0]["Branch"].ToString();
                lblCgpa.Text = ds.Tables[0].Rows[0]["Cgpa"].ToString();
                lblCgpaDetail.Text = ds.Tables[0].Rows[0]["Cgpa"].ToString();
                lblGradYear.Text = ds.Tables[0].Rows[0]["Graduation_Year"].ToString();
                string pStatus = ds.Tables[0].Rows[0]["Placement_Status"].ToString();
                lblPlacementStatus.Text = pStatus;
                if (ddlUpdatePlacementStatus.Items.FindByValue(pStatus) != null)
                {
                    ddlUpdatePlacementStatus.SelectedValue = pStatus;
                }
                string aStatus = ds.Tables[0].Rows[0]["Account_Status"].ToString();
                if (ddlUpdateAccountStatus.Items.FindByValue(aStatus) != null)
                {
                    ddlUpdateAccountStatus.SelectedValue = aStatus;
                }

                lblDob.Text = ds.Tables[0].Rows[0]["Dob"].ToString();
                lblGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
                lblAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                lblCityState.Text = ds.Tables[0].Rows[0]["City"].ToString() + ", " + ds.Tables[0].Rows[0]["State"].ToString();
                lblPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();

                lblTenth.Text = ds.Tables[0].Rows[0]["Tenth_Pct"].ToString() + "%";
                lblTwelfth.Text = ds.Tables[0].Rows[0]["Twelfth_Pct"].ToString() + "%";
                lblDiploma.Text = ds.Tables[0].Rows[0]["Diploma_Pct"].ToString() + "%";
                lblActiveBacklogs.Text = ds.Tables[0].Rows[0]["Active_Backlogs"].ToString();
                lblTotalBacklogs.Text = ds.Tables[0].Rows[0]["Total_Backlogs"].ToString();
                lblSkills.Text = ds.Tables[0].Rows[0]["Skills"].ToString();

                string resume = ds.Tables[0].Rows[0]["Resume_File"].ToString();
                lnkResumeDownload.NavigateUrl = GetSafeResumeUrl(resume);

                da = new SqlDataAdapter("select * from Student_Document_tbl where Student_Email='" + studentEmail + "' or Student_Email in (select Enrollment_No from Student_Reg_tbl where Email='" + studentEmail + "') order by Student_Id desc", con);
                DataSet dsDocs = new DataSet();
                da.Fill(dsDocs);
                gvStudentDocs.DataSource = dsDocs;
                gvStudentDocs.DataBind();
                lblDocsCount.Text = dsDocs.Tables[0].Rows.Count.ToString();

                da = new SqlDataAdapter("select * from Application_tbl where Student_Email='" + studentEmail + "' order by Application_Id desc", con);
                DataSet dsApps = new DataSet();
                da.Fill(dsApps);
                gvStudentApps.DataSource = dsApps;
                gvStudentApps.DataBind();
                lblAppCount.Text = dsApps.Tables[0].Rows.Count.ToString();

                da = new SqlDataAdapter("select * from Interview_Schedule_tbl where Student_Email='" + studentEmail + "' order by Interview_Id desc", con);
                DataSet dsInts = new DataSet();
                da.Fill(dsInts);
                gvStudentInterviews.DataSource = dsInts;
                gvStudentInterviews.DataBind();
                lblInterviewCount.Text = dsInts.Tables[0].Rows.Count.ToString();

                da = new SqlDataAdapter("select t.* from Training_Registration_tbl tr left join Training_Program_tbl t on tr.Program_Id = t.Program_Id where tr.Student_Email='" + studentEmail + "' order by t.Program_Id desc", con);
                DataSet dsTrain = new DataSet();
                da.Fill(dsTrain);
                gvStudentTraining.DataSource = dsTrain;
                gvStudentTraining.DataBind();
            }
            else
            {
                Response.Redirect("students.aspx");
            }
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

        protected void btnUpdateStudentStatus_Click(object sender, EventArgs e)
        {
            if (ViewState["stuid"] != null && ViewState["stuid"].ToString() != "")
            {
                getcon();
                cmd = new SqlCommand("update Student_Reg_tbl set Placement_Status='" + ddlUpdatePlacementStatus.SelectedValue + "', Account_Status='" + ddlUpdateAccountStatus.SelectedValue + "' where Student_Id='" + ViewState["stuid"] + "' or Email='" + ViewState["stuid"] + "'", con);
                cmd.ExecuteNonQuery();

                pnlAlert.Visible = true;
                litAlertMsg.Text = "Student status updated successfully.";
                filldata();
            }
        }
    }
}
