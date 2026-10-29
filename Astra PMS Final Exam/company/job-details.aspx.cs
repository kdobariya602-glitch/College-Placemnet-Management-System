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
    public partial class job_details : System.Web.UI.Page
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

                if (Session["jid"] != null) { ViewState["jid"] = Session["jid"]; }

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
            if (ViewState["jid"] != null && ViewState["jid"].ToString() != "")
            {
                da = new SqlDataAdapter("select * from Job_tbl where Job_Id='" + ViewState["jid"] + "' and Company_Email='" + Session["company"] + "'", con);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count == 0)
                {
                    da = new SqlDataAdapter("select * from Job_tbl where Job_Id='" + ViewState["jid"] + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                }
            }

            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                da = new SqlDataAdapter("select top 1 * from Job_tbl where Company_Email='" + Session["company"] + "' order by Job_Id desc", con);
                ds = new DataSet();
                da.Fill(ds);
            }

            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                da = new SqlDataAdapter("select top 1 * from Job_tbl order by Job_Id desc", con);
                ds = new DataSet();
                da.Fill(ds);
            }

            if (ds.Tables[0].Rows.Count > 0)
            {
                ViewState["jid"] = ds.Tables[0].Rows[0]["Job_Id"].ToString();
                Session["jid"] = ViewState["jid"];

                                litJobTitle.Text = ds.Tables[0].Rows[0]["Job_Title"].ToString();
                litCompanyName.Text = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                litJobType.Text = ds.Tables[0].Rows[0]["Job_Type"].ToString();
                litPackage.Text = "Rs. " + ds.Tables[0].Rows[0]["Salary_CTC"].ToString() + " LPA";

                string status = ds.Tables[0].Rows[0]["Status"].ToString();
                lblStatusBadge.Text = status;
                if (status == "Published" || status == "Active")
                {
}
                else
                {
}

                lnkViewApplicants.NavigateUrl = "applicants.aspx?jid=" + ViewState["jid"];

                litDatePosted.Text = ds.Tables[0].Rows[0]["Created_Date"] != DBNull.Value ? Convert.ToDateTime(ds.Tables[0].Rows[0]["Created_Date"]).ToString("dd-MMM-yyyy hh:mm tt") : "Not Recorded";
                litDeadline.Text = ds.Tables[0].Rows[0]["App_Deadline"] != DBNull.Value ? Convert.ToDateTime(ds.Tables[0].Rows[0]["App_Deadline"]).ToString("dd-MMM-yyyy") : "Open / Continuous";
                litVacancies.Text = ds.Tables[0].Rows[0]["Vacancies"] != DBNull.Value ? ds.Tables[0].Rows[0]["Vacancies"].ToString() + " Openings" : "Not Specified";
                litLocation.Text = ds.Tables[0].Rows[0]["Location"] != DBNull.Value ? ds.Tables[0].Rows[0]["Location"].ToString() : "Campus / Multiple";

                litCgpa.Text = ds.Tables[0].Rows[0]["Min_CGPA"] != DBNull.Value ? ds.Tables[0].Rows[0]["Min_CGPA"].ToString() + " Minimum" : "No CGPA cutoff";
                litBacklogs.Text = ds.Tables[0].Rows[0]["Max_Backlogs"] != DBNull.Value ? ds.Tables[0].Rows[0]["Max_Backlogs"].ToString() : "0";
                litBranches.Text = ds.Tables[0].Rows[0]["Eligible_Dept"] != DBNull.Value ? ds.Tables[0].Rows[0]["Eligible_Dept"].ToString() : "All Engineering, MCA & Management Disciplines";

                string skillsCsv = ds.Tables[0].Rows[0]["Required_Skills"] != DBNull.Value ? ds.Tables[0].Rows[0]["Required_Skills"].ToString() : "";
                string skillChipsHtml = "";
                if (!string.IsNullOrEmpty(skillsCsv))
                {
                    string[] skills = skillsCsv.Split(new char[] { ',', ';', '/' }, StringSplitOptions.RemoveEmptyEntries);
                    for (int k = 0; k < skills.Length; k++)
                    {
                        skillChipsHtml += "<span class='badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3 py-2 fw-semibold fs-6'>" + skills[k].Trim() + "</span> ";
                    }
                }
                else
                {
                    skillChipsHtml = "<span class='text-muted'>General competencies</span>";
                }
                litSkillChips.Text = skillChipsHtml;

                litJobDesc.Text = ds.Tables[0].Rows[0]["Job_Description"] != DBNull.Value ? ds.Tables[0].Rows[0]["Job_Description"].ToString() : "No detailed description posted.";
            }
            else
            {
                Response.Redirect("jobs.aspx");
            }
        }
    }
}
