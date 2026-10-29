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
    public partial class shortlisted : System.Web.UI.Page
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
                    filljobs();
                    fillstats();
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void filljobs()
        {
            getcon();
            da = new SqlDataAdapter("select * from Job_tbl where Company_Email='" + Session["company"] + "' order by Job_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            ddlJobFilter.DataSource = ds;
            ddlJobFilter.DataTextField = "Job_Title";
            ddlJobFilter.DataValueField = "Job_Id";
            ddlJobFilter.DataBind();
            ddlJobFilter.Items.Insert(0, new ListItem("-- All Job Postings --", ""));
        }

        void fillstats()
        {
            getcon();
            da = new SqlDataAdapter("select * from Shortlist_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalShortlisted.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Interview_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblInterviewsScheduled.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalSelected.Text = ds.Tables[0].Rows.Count.ToString();
        }

        void fillgrid()
        {
            getcon();
            if (txtSearch.Text != "" && ddlJobFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select s.*, (select top 1 a.Resume_File from Application_tbl a where a.Application_Id = s.Application_Id) as Resume_File from Shortlist_tbl s where s.Company_Email='" + Session["company"] + "' and s.Job_Id='" + ddlJobFilter.SelectedValue + "' and (s.Student_Name='" + txtSearch.Text + "' or s.Student_Email='" + txtSearch.Text + "') order by s.Shortlist_Id desc", con);
            }
            else if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select s.*, (select top 1 a.Resume_File from Application_tbl a where a.Application_Id = s.Application_Id) as Resume_File from Shortlist_tbl s where s.Company_Email='" + Session["company"] + "' and (s.Student_Name='" + txtSearch.Text + "' or s.Student_Email='" + txtSearch.Text + "') order by s.Shortlist_Id desc", con);
            }
            else if (ddlJobFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select s.*, (select top 1 a.Resume_File from Application_tbl a where a.Application_Id = s.Application_Id) as Resume_File from Shortlist_tbl s where s.Company_Email='" + Session["company"] + "' and s.Job_Id='" + ddlJobFilter.SelectedValue + "' order by s.Shortlist_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select s.*, (select top 1 a.Resume_File from Application_tbl a where a.Application_Id = s.Application_Id) as Resume_File from Shortlist_tbl s where s.Company_Email='" + Session["company"] + "' order by s.Shortlist_Id desc", con);
            }

            ds = new DataSet();
            da.Fill(ds);

            gvShortlist.DataSource = ds;
            gvShortlist.DataBind();
        }

        protected void ddlJobFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvShortlist.PageIndex = 0;
            fillgrid();
        }

        protected void gvShortlist_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvShortlist.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        void clear()
        {
            if (ddlJobFilter.Items.Count > 0) ddlJobFilter.SelectedIndex = 0;
            txtSearch.Text = "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void gvShortlist_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewApp")
            {
                Session["Application_Id"] = e.CommandArgument;
                Session["aid"] = Convert.ToInt32(e.CommandArgument); Response.Redirect("applicant-details.aspx");
            }
            else if (e.CommandName == "RemoveCandidate")
            {
                getcon();
                cmd = new SqlCommand("delete from Shortlist_tbl where Application_Id='" + e.CommandArgument + "' and Company_Email='" + Session["company"] + "'", con);
                i = cmd.ExecuteNonQuery();
                if (i > 0)
                {
                    Response.Write("<script>alert('Candidate removed from shortlist.');</script>");
                    fillstats();
                    fillgrid();
                }
            }
        }
    }
}
