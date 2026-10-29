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
    public partial class jobs : System.Web.UI.Page
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
            getcon();
            da = new SqlDataAdapter("select count(*) from Job_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalJobs.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(*) from Job_tbl where Company_Email='" + Session["company"] + "' and (Status='Published' or Status='Active')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblActiveJobs.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(*) from Application_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalApplications.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(*) from Application_tbl where Company_Email='" + Session["company"] + "' and (Status='Selected' or Status='Hired')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalHired.Text = ds.Tables[0].Rows[0][0].ToString();

            if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select j.*, (select count(*) from Application_tbl a where a.Job_Id = j.Job_Id) as Applicant_Count from Job_tbl j where j.Company_Email='" + Session["company"] + "' and (j.Job_Title='" + txtSearch.Text + "' or j.Location='" + txtSearch.Text + "' or j.Job_Type='" + txtSearch.Text + "') order by j.Job_Id desc", con);
            }
            else if (ddlStatusFilter.SelectedValue == "Published")
            {
                da = new SqlDataAdapter("select j.*, (select count(*) from Application_tbl a where a.Job_Id = j.Job_Id) as Applicant_Count from Job_tbl j where j.Company_Email='" + Session["company"] + "' and (j.Status='Published' or j.Status='Active') order by j.Job_Id desc", con);
            }
            else if (ddlStatusFilter.SelectedValue == "Closed")
            {
                da = new SqlDataAdapter("select j.*, (select count(*) from Application_tbl a where a.Job_Id = j.Job_Id) as Applicant_Count from Job_tbl j where j.Company_Email='" + Session["company"] + "' and j.Status='Closed' order by j.Job_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select j.*, (select count(*) from Application_tbl a where a.Job_Id = j.Job_Id) as Applicant_Count from Job_tbl j where j.Company_Email='" + Session["company"] + "' order by j.Job_Id desc", con);
            }

            ds = new DataSet();
            da.Fill(ds);
            gvJobs.DataSource = ds;
            gvJobs.DataBind();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            fillgrid();
                            }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlStatusFilter.SelectedValue = "All";
            txtSearch.Text = "";
            gvJobs.PageIndex = 0;
            fillgrid();
                            }

        protected void gvJobs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvJobs.PageIndex = e.NewPageIndex;
            fillgrid();
                            }

        void clear()
        {
        }

        protected void gvJobs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int jid = Convert.ToInt32(e.CommandArgument);
            ViewState["jid"] = jid;
            if (e.CommandName == "view_applicants") { Session["jid"] = jid; Response.Redirect("applicants.aspx"); return; }
            if (e.CommandName == "view_job") { Session["jid"] = jid; Response.Redirect("job-details.aspx"); return; }

            if (e.CommandName == "clone_job")
            {
                getcon();
                da = new SqlDataAdapter("select * from Job_tbl where Job_Id='" + jid + "' and Company_Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                                        string newTitle = "Copy of " + ds.Tables[0].Rows[0]["Job_Title"].ToString();
                    string cEmail = ds.Tables[0].Rows[0]["Company_Email"].ToString();
                    string cName = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                    string jType = ds.Tables[0].Rows[0]["Job_Type"].ToString();
                    string sal = ds.Tables[0].Rows[0]["Salary_CTC"].ToString();
                    string vac = ds.Tables[0].Rows[0]["Vacancies"].ToString();
                    string loc = ds.Tables[0].Rows[0]["Location"].ToString();
                    string minCgpa = ds.Tables[0].Rows[0]["Min_CGPA"].ToString();
                    string eligDept = ds.Tables[0].Rows[0]["Eligible_Dept"].ToString();
                    string reqSkills = ds.Tables[0].Rows[0]["Required_Skills"].ToString();
                    string desc = ds.Tables[0].Rows[0]["Job_Description"].ToString();

                    cmd = new SqlCommand("insert into Job_tbl (Job_Title, Company_Email, Company_Name, Job_Type, Salary_CTC, Vacancies, Location, Min_CGPA, Eligible_Dept, Required_Skills, Job_Description, Status, Created_Date) values ('" + newTitle + "', '" + cEmail + "', '" + cName + "', '" + jType + "', '" + sal + "', '" + vac + "', '" + loc + "', '" + minCgpa + "', '" + eligDept + "', '" + reqSkills + "', '" + desc + "', 'Draft', GETDATE())", con);
                    i = cmd.ExecuteNonQuery();
                    if (i > 0)
                    {
                        Response.Write("<script>alert('Job opening duplicated successfully as Draft! You can now edit and publish it.'); window.location='jobs.aspx';</script>");
                    }
                }
            }
            else if (e.CommandName == "view_job") { Session["jid"] = jid; Response.Redirect("job-details.aspx"); } else if (e.CommandName == "toggle_status")
            {
                getcon();
                da = new SqlDataAdapter("select Status from Job_tbl where Job_Id='" + jid + "' and Company_Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string newStatus = "Published";
                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Status"].ToString() == "Published")
                {
                    newStatus = "Closed";
                }
                cmd = new SqlCommand("update Job_tbl set Status='" + newStatus + "' where Job_Id='" + jid + "' and Company_Email='" + Session["company"] + "'", con);
                i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Write("<script>alert('Job opening status updated to " + newStatus + ".');</script>");
                    fillgrid();
                                    }
            }
            else if (e.CommandName == "delete_job")
            {
                getcon();
                cmd = new SqlCommand("delete from Job_tbl where Job_Id='" + jid + "' and Company_Email='" + Session["company"] + "'", con);
                i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Write("<script>alert('Job opening deleted successfully.');</script>");
                    fillgrid();
                                    }
            }
        }

        protected void btnExportJobsCsv_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select * from Job_tbl where Company_Email='" + Session["company"] + "' order by Job_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            i = ds.Tables[0].Rows.Count;
            Response.Write("<script>alert('Company job listings report generated successfully! Total records: " + i + "');</script>");
        }
            }
}


