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
    public partial class applications : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Admin_Login_tbl where Username='" + Session["admin"] + "' or Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Username"].ToString();
                }

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

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
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
        }

        void fillgrid()
        {
            getcon();
            if (ddlCompanyFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + ddlCompanyFilter.SelectedValue + "' order by Application_Id desc", con);
            }
            else if (ddlStatusFilter.SelectedValue != "" && ddlStatusFilter.SelectedValue != "All")
            {
                da = new SqlDataAdapter("select * from Application_tbl where Status='" + ddlStatusFilter.SelectedValue + "' order by Application_Id desc", con);
            }
            else if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select * from Application_tbl where Student_Name='" + txtSearch.Text + "' or Job_Title='" + txtSearch.Text + "' order by Application_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Application_tbl order by Application_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            gvApplications.DataSource = ds;
            gvApplications.DataBind();
            lblCount.Text = ds.Tables[0].Rows.Count.ToString();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            gvApplications.PageIndex = 0;
            fillgrid();
        }

        protected void gvApplications_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvApplications.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            fillgrid();
        }

        void clear()
        {
            txtSearch.Text = "";
            ddlCompanyFilter.SelectedIndex = 0;
            ddlStatusFilter.SelectedIndex = 0;
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            clear();
            fillgrid();
        }

        protected void gvApplications_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string application_id = e.CommandArgument.ToString();

            if (e.CommandName == "view_student")
            {
                Session["stuid"] = e.CommandArgument.ToString();
                Response.Redirect("student-details.aspx");
            }
            else if (e.CommandName == "shortlist_app")
            {
                getcon();
                cmd = new SqlCommand("update Application_tbl set Status = 'Shortlisted', Remarks = 'Candidate shortlisted for interview round.' where Application_Id = '" + application_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Application shortlisted successfully.');</script>");
                fillgrid();
            }
            else if (e.CommandName == "select_app")
            {
                getcon();
                cmd = new SqlCommand("update Application_tbl set Status = 'Selected', Remarks = 'Candidate selected for the position.' where Application_Id = '" + application_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Candidate marked as Selected!');</script>");
                fillgrid();
            }
            else if (e.CommandName == "reject_app")
            {
                getcon();
                cmd = new SqlCommand("update Application_tbl set Status = 'Rejected', Remarks = 'Application not progressed.' where Application_Id = '" + application_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Application marked as Rejected.');</script>");
                fillgrid();
            }
        }
    }
}
