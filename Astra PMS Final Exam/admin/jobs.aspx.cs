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
            if (Session["admin"] != null)
            {
                if (!IsPostBack)
                {
                    fillcompanies();
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void fillcompanies()
        {
            getcon();
            da = new SqlDataAdapter("select Company_Name, Email from Company_reg_tbl order by Company_Name", con);
            ds = new DataSet();
            da.Fill(ds);

            ddlCompanyFilter.DataSource = ds;
            ddlCompanyFilter.DataTextField = "Company_Name";
            ddlCompanyFilter.DataValueField = "Email";
            ddlCompanyFilter.DataBind();
            ddlCompanyFilter.Items.Insert(0, new ListItem("All Companies", ""));

            ddlNewJobCompany.DataSource = ds;
            ddlNewJobCompany.DataTextField = "Company_Name";
            ddlNewJobCompany.DataValueField = "Email";
            ddlNewJobCompany.DataBind();
        }

        void fillgrid()
        {
            getcon();
            if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select * from Job_tbl where (Job_Title='" + txtSearch.Text + "' or Company_Name='" + txtSearch.Text + "' or Location='" + txtSearch.Text + "') order by Job_Id desc", con);
            }
            else if (ddlCompanyFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Job_tbl where Company_Email = '" + ddlCompanyFilter.SelectedValue + "' order by Job_Id desc", con);
            }
            else if (ddlStatusFilter.SelectedValue != "All" && ddlStatusFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Job_tbl where Status = '" + ddlStatusFilter.SelectedValue + "' order by Job_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Job_tbl order by Job_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);

            gvJobs.DataSource = ds;
            gvJobs.DataBind();
            lblCount.Text = ds.Tables[0].Rows.Count.ToString();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            gvJobs.PageIndex = 0;
            fillgrid();
        }

        protected void gvJobs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvJobs.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlCompanyFilter.SelectedIndex = 0;
            ddlStatusFilter.SelectedIndex = 0;
            fillgrid();
        }

        protected void gvJobs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int jid = Convert.ToInt32(e.CommandArgument); Session["jid"] = jid; 
            ViewState["jid"] = jid;

            if (e.CommandName == "toggle_status")
            {
                getcon();
                cmd = new SqlCommand("update Job_tbl set Status='Published' where Job_Id='" + jid + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Job Status Updated!');</script>");
                fillgrid();
            }
            else if (e.CommandName == "delete_job")
            {
                getcon();
                cmd = new SqlCommand("delete from Job_tbl where Job_Id='" + jid + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Job Deleted Successfully!');</script>");
                fillgrid();
            }
        }

        protected void btnSaveJob_Click(object sender, EventArgs e)
        {
            getcon();
            string compName = ddlNewJobCompany.SelectedItem.Text;
            cmd = new SqlCommand("insert into Job_tbl (Company_Email, Company_Name, Job_Title, Job_Type, Location, Work_Mode, Salary_CTC, Min_CGPA, Max_Backlogs, Eligible_Dept, Vacancies, App_Deadline, Required_Skills, Job_Description, Status) values ('" + ddlNewJobCompany.SelectedValue + "', '" + compName + "', '" + txtNewJobTitle.Text + "', '" + ddlNewJobType.SelectedValue + "', '" + txtNewJobLoc.Text + "', '" + ddlNewJobMode.SelectedValue + "', '" + txtNewJobCTC.Text + "', '" + txtNewJobMinCGPA.Text + "', '" + txtNewJobMaxBacklogs.Text + "', '" + txtNewJobEligibleDept.Text + "', '" + txtNewJobVacancies.Text + "', '" + txtNewJobDeadline.Text + "', '" + txtNewJobSkills.Text + "', '" + txtNewJobDesc.Text + "', 'Published')", con);
            cmd.ExecuteNonQuery();

            clear();
            Response.Write("<script>alert('Job Published Successfully!');</script>");
            fillgrid();
        }

        void clear()
        {
            txtNewJobTitle.Text = "";
            txtNewJobLoc.Text = "";
            txtNewJobCTC.Text = "";
            txtNewJobMinCGPA.Text = "";
            txtNewJobMaxBacklogs.Text = "";
            txtNewJobEligibleDept.Text = "";
            txtNewJobVacancies.Text = "";
            txtNewJobDeadline.Text = "";
            txtNewJobSkills.Text = "";
            txtNewJobDesc.Text = "";
        }
    }
}
