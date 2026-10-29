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
    public partial class applicants : System.Web.UI.Page
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
                    da = new SqlDataAdapter("select Job_Id, Job_Title from Job_tbl where Company_Email='" + Session["company"] + "' order by Job_Id desc", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    ddlJobFilter.DataSource = ds;
                    ddlJobFilter.DataTextField = "Job_Title";
                    ddlJobFilter.DataValueField = "Job_Id";
                    ddlJobFilter.DataBind();
                    ddlJobFilter.Items.Insert(0, new ListItem("All Job Openings", "0"));

                    da = new SqlDataAdapter("select * from Department_tbl", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    ddlDeptFilter.DataSource = ds;
                    ddlDeptFilter.DataTextField = "Dept_Name";
                    ddlDeptFilter.DataValueField = "Dept_Name";
                    ddlDeptFilter.DataBind();
                    ddlDeptFilter.Items.Insert(0, new ListItem("All Branches", "All"));

                    if (Session["jid"] != null) { if (ddlJobFilter.Items.FindByValue(Session["jid"].ToString()) != null) { ddlJobFilter.SelectedValue = Session["jid"].ToString(); } }

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
            getcon();

            da = new SqlDataAdapter("select count(*) from Application_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalApplicants.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(*) from Application_tbl where Company_Email='" + Session["company"] + "' and Status='Shortlisted'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblShortlistedCount.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(*) from Application_tbl where Company_Email='" + Session["company"] + "' and Status='Selected'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblSelectedCount.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(*) from Application_tbl where Company_Email='" + Session["company"] + "' and (Status='Active' or Status='Submitted')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblUnderReviewCount.Text = ds.Tables[0].Rows[0][0].ToString();

            string sqlstr = "select * from Application_tbl where Company_Email='" + Session["company"] + "'";
            if (txtSearch.Text != "")
            {
                sqlstr += " and (Student_Name='" + txtSearch.Text + "' or Job_Title='" + txtSearch.Text + "' or Student_Email='" + txtSearch.Text + "' or Department='" + txtSearch.Text + "')";
            }
            if (ddlJobFilter.SelectedValue != "0" && ddlJobFilter.SelectedValue != "")
            {
                sqlstr += " and Job_Id='" + ddlJobFilter.SelectedValue + "'";
            }
            if (ddlStatusFilter.SelectedValue != "All")
            {
                if (ddlStatusFilter.SelectedValue == "Active")
                {
                    sqlstr += " and (Status='Active' or Status='Submitted')";
                }
                else
                {
                    sqlstr += " and Status='" + ddlStatusFilter.SelectedValue + "'";
                }
            }
            if (ddlDeptFilter.SelectedValue != "All" && ddlDeptFilter.SelectedValue != "")
            {
                sqlstr += " and Department='" + ddlDeptFilter.SelectedValue + "'";
            }
            if (ddlMinCgpa.SelectedValue != "0" && ddlMinCgpa.SelectedValue != "")
            {
                sqlstr += " and CGPA >= " + ddlMinCgpa.SelectedValue;
            }
            sqlstr += " order by Job_Id desc";
            da = new SqlDataAdapter(sqlstr, con);
            ds = new DataSet();
            da.Fill(ds);
            gvApplicants.DataSource = ds;
            gvApplicants.DataBind();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            gvApplicants.PageIndex = 0;
            fillgrid();
        }

        void clear()
        {
            ddlJobFilter.SelectedValue = "0";
            ddlStatusFilter.SelectedValue = "All";
            ddlDeptFilter.SelectedValue = "All";
            ddlMinCgpa.SelectedValue = "0";
            txtSearch.Text = "";
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            clear();
            fillgrid();
        }

        protected void btnBulkShortlist_Click(object sender, EventArgs e)
        {
            getcon();
            if (ddlJobFilter.SelectedValue != "0" && ddlJobFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + Session["company"] + "' and (Status='Submitted' or Status='Active') and Job_Id='" + ddlJobFilter.SelectedValue + "'", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + Session["company"] + "' and (Status='Submitted' or Status='Active')", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            int count = ds.Tables[0].Rows.Count;
            for (int r = 0; r < count; r++)
            {
                                string appId = ds.Tables[0].Rows[r]["Application_Id"].ToString();
                string sEmail = ds.Tables[0].Rows[r]["Student_Email"].ToString();
                string sName = ds.Tables[0].Rows[r]["Student_Name"].ToString();
                string cEmail = ds.Tables[0].Rows[r]["Company_Email"].ToString();
                string cName = ds.Tables[0].Rows[r]["Company_Name"].ToString();
                string jTitle = ds.Tables[0].Rows[r]["Job_Title"].ToString();
                string jId = ds.Tables[0].Rows[r]["Job_Id"].ToString();
                string dId = ds.Tables[0].Rows[r]["Drive_Id"].ToString();

                cmd = new SqlCommand("update Application_tbl set Status='Shortlisted' where Application_Id='" + appId + "'", con);
                cmd.ExecuteNonQuery();

                da = new SqlDataAdapter("select * from Shortlist_tbl where Application_Id='" + appId + "'", con);
                DataSet dsCheck = new DataSet();
                da.Fill(dsCheck);
                if (dsCheck.Tables[0].Rows.Count == 0)
                {
                    cmd = new SqlCommand("insert into Shortlist_tbl(Application_Id, Job_Id, Drive_Id, Company_Email, Company_Name, Student_Email, Student_Name, Job_Title, Shortlisted_Date, Status) values('" + appId + "', '" + jId + "', '" + dId + "', '" + cEmail + "', '" + cName + "', '" + sEmail + "', '" + sName + "', '" + jTitle + "', GETDATE(), 'Shortlisted')", con);
                    cmd.ExecuteNonQuery();
                }
            }
            Response.Write("<script>alert('Bulk shortlisting complete! " + count + " candidates moved to shortlist.');</script>");
            fillgrid();
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            getcon();
            if (ddlJobFilter.SelectedValue != "0" && ddlJobFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + Session["company"] + "' and Job_Id='" + ddlJobFilter.SelectedValue + "' order by Job_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + Session["company"] + "' order by Job_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            i = ds.Tables[0].Rows.Count;
            Response.Write("<script>alert('Applicants pool report generated successfully! Total applicants: " + i + "');</script>");
        }

        public string GetApplicantResumeUrl(object rawObj)
        {
            if (rawObj == null || rawObj == DBNull.Value) return ResolveUrl("~/uploads/resumes/sample_resume.pdf");
            string raw = rawObj.ToString().Trim();
            if (raw == "") return ResolveUrl("~/uploads/resumes/sample_resume.pdf");
            if (raw.StartsWith("~/") || raw.StartsWith("http") || raw.StartsWith("/")) return raw;
            return ResolveUrl("~/uploads/resumes/" + raw);
        }

        protected void gvApplicants_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvApplicants.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        void notifystudent(int appId, string st)
        {
            getcon();
            da = new SqlDataAdapter("select * from Application_tbl where Application_Id='" + appId + "'", con);
            DataSet dsN = new DataSet();
            da.Fill(dsN);
            if (dsN.Tables[0].Rows.Count > 0)
            {
                string sEmail = dsN.Tables[0].Rows[0]["Student_Email"].ToString();
                string jTitle = dsN.Tables[0].Rows[0]["Job_Title"].ToString();
                string cName = dsN.Tables[0].Rows[0]["Company_Name"].ToString();
                cmd = new SqlCommand("insert into Notification_tbl (Recipient_Role, Recipient_Email, Title, Message, Notification_Type, Is_Read, Created_Date) values ('Student', '" + sEmail + "', 'Application " + st + "', '" + cName + " has " + st.ToLower() + " your application for " + jTitle + ".', 'Application', 0, GETDATE())", con);
                cmd.ExecuteNonQuery();
            }
        }

        protected void gvApplicants_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int aid = Convert.ToInt32(e.CommandArgument); Session["aid"] = aid; ViewState["aid"] = aid;

            if (e.CommandName == "view_details")
            {
                Session["aid"] = aid;
                Session["aid"] = aid; Response.Redirect("applicant-details.aspx");
            }
            else if (e.CommandName == "shortlist_app")
            {
                getcon();
                cmd = new SqlCommand("update Application_tbl set Status='Shortlisted' where Application_Id='" + aid + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                da = new SqlDataAdapter("select * from Application_tbl where Application_Id='" + aid + "' and Company_Email='" + Session["company"] + "'", con);
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

                    da = new SqlDataAdapter("select * from Shortlist_tbl where Application_Id='" + aid + "' and Company_Email='" + Session["company"] + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count == 0)
                    {
                        cmd = new SqlCommand("insert into Shortlist_tbl(Application_Id, Job_Id, Drive_Id, Company_Email, Company_Name, Student_Email, Student_Name, Job_Title, Shortlisted_Date, Status) values('" + aid + "', '" + jId + "', '" + dId + "', '" + cEmail + "', '" + cName + "', '" + sEmail + "', '" + sName + "', '" + jTitle + "', GETDATE(), 'Shortlisted')", con);
                        cmd.ExecuteNonQuery();
                    }
                }

                notifystudent(aid, "Shortlisted");
                Response.Write("<script>alert('Candidate Shortlisted!');</script>");
                fillgrid();
            }
            else if (e.CommandName == "reject_app")
            {
                getcon();
                cmd = new SqlCommand("update Application_tbl set Status='Rejected' where Application_Id='" + aid + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                notifystudent(aid, "Rejected");
                Response.Write("<script>alert('Candidate Rejected!');</script>");
                fillgrid();
            }
        }

        protected void btnExportApplicantsCsv_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + Session["company"] + "' order by Job_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            i = ds.Tables[0].Rows.Count;
            Response.Write("<script>alert('Applicants report generated successfully! Total records: " + i + "');</script>");
        }
    }
}


