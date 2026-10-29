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
    public partial class interviews : System.Web.UI.Page
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
                    filldropdowns();
                    fillgrid();
                    fillpanels();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void filldropdowns()
        {
            getcon();
            da = new SqlDataAdapter("select * from Application_tbl where Status='Shortlisted' or Status='Applied' order by Application_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlCandidate.DataSource = ds;
            ddlCandidate.DataTextField = "Student_Name";
            ddlCandidate.DataValueField = "Application_Id";
            ddlCandidate.DataBind();
            ddlCandidate.Items.Insert(0, new ListItem("-- Select Candidate --", ""));

            da = new SqlDataAdapter("select * from Company_reg_tbl order by Company_Name", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlPanelCompany.DataSource = ds;
            ddlPanelCompany.DataTextField = "Company_Name";
            ddlPanelCompany.DataValueField = "Email";
            ddlPanelCompany.DataBind();
            ddlPanelCompany.Items.Insert(0, new ListItem("-- Select Company --", ""));
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from Interview_tbl order by Interview_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvInterviews.DataSource = ds;
            gvInterviews.DataBind();
        }

        protected void gvInterviews_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvInterviews.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        void fillpanels()
        {
            getcon();
            da = new SqlDataAdapter("select * from Interview_Panel_tbl order by Panel_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvPanels.DataSource = ds;
            gvPanels.DataBind();
        }

        protected void gvInterviews_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int iid = Convert.ToInt32(e.CommandArgument); ViewState["iid"] = iid;

            if (e.CommandName == "pass_round")
            {
                getcon();
                cmd = new SqlCommand("update Interview_tbl set Result = 'Passed', Status = 'Completed', Remarks = 'Candidate cleared round with positive recommendation.' where Interview_Id = '" + iid + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Candidate marked as PASSED for this interview round.');</script>");
                fillgrid();
            }
            else if (e.CommandName == "fail_round")
            {
                getcon();
                cmd = new SqlCommand("update Interview_tbl set Result = 'Failed', Status = 'Completed', Remarks = 'Candidate did not meet criteria for this round.' where Interview_Id = '" + iid + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Candidate marked as FAILED for this round.');</script>");
                fillgrid();
            }
            else if (e.CommandName == "delete_interview")
            {
                getcon();
                cmd = new SqlCommand("delete from Interview_tbl where Interview_Id = '" + iid + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Interview schedule removed.');</script>");
                fillgrid();
            }
        }

        protected void gvPanels_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int iid = Convert.ToInt32(e.CommandArgument); ViewState["iid"] = iid;

            if (e.CommandName == "delete_panel")
            {
                getcon();
                cmd = new SqlCommand("delete from Interview_Panel_tbl where Panel_Id = '" + iid + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Panel removed.');</script>");
                fillpanels();
            }
        }

        protected void btnSaveInterview_Click(object sender, EventArgs e)
        {
            if (ddlCandidate.SelectedIndex >= 0 && ddlCandidate.SelectedValue != "")
            {
                string appid = ddlCandidate.SelectedValue;
                getcon();
                da = new SqlDataAdapter("select * from Application_tbl where Application_Id = '" + appid + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string semail = "", sname = "", cemail = "", cname = "", jtitle = "", jid = "", did = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    semail = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                    sname = ds.Tables[0].Rows[0]["Student_Name"].ToString();
                    cemail = ds.Tables[0].Rows[0]["Company_Email"].ToString();
                    cname = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                    jtitle = ds.Tables[0].Rows[0]["Job_Title"].ToString();
                    jid = ds.Tables[0].Rows[0]["Job_Id"].ToString();
                    did = ds.Tables[0].Rows[0]["Drive_Id"].ToString();
                }

                getcon();
                cmd = new SqlCommand("insert into Interview_tbl (Application_Id, Job_Id, Drive_Id, Company_Email, Company_Name, Student_Email, Student_Name, Round_Name, Interview_Date, Interview_Time, Mode, Venue, Meeting_Link, Interviewer_Name, Instructions, Status, Result, Created_Date) values ('" + appid + "', '" + jid + "', '" + did + "', '" + cemail + "', '" + cname + "', '" + semail + "', '" + sname + "', '" + ddlRoundName.SelectedValue + "', '" + txtIntDate.Text + "', '" + txtIntTime.Text + "', '" + ddlIntMode.SelectedValue + "', '" + txtIntVenue.Text + "', '" + txtIntLink.Text + "', '" + txtIntInterviewer.Text + "', '" + txtIntInstructions.Text + "', 'Scheduled', 'Pending', GETDATE())", con);
                cmd.ExecuteNonQuery();

                getcon();
                cmd = new SqlCommand("update Application_tbl set Status = 'Interview Scheduled' where Application_Id = '" + appid + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Interview scheduled successfully!');</script>");
                fillgrid();
            }
            else
            {
                Response.Write("<script>alert('Please select an eligible candidate.');</script>");
            }
        }

        protected void btnSavePanel_Click(object sender, EventArgs e)
        {
            if (txtPanelName.Text != "" && txtPanelInterviewer.Text != "")
            {
                string compName = "";
                if (ddlPanelCompany.SelectedItem != null)
                {
                    compName = ddlPanelCompany.SelectedItem.Text;
                }
                getcon();
                cmd = new SqlCommand("insert into Interview_Panel_tbl (Company_Email, Company_Name, Panel_Name, Interviewer_Name, Designation, Email, Phone, Round_Assigned, Status, Created_Date) values ('" + ddlPanelCompany.SelectedValue + "', '" + compName + "', '" + txtPanelName.Text + "', '" + txtPanelInterviewer.Text + "', '" + txtPanelDesig.Text + "', '" + txtPanelEmail.Text + "', '" + txtPanelPhone.Text + "', 'Technical Round', 'Active', GETDATE())", con);
                cmd.ExecuteNonQuery();

                clear();
                Response.Write("<script>alert('Interview panel created successfully.');</script>");
                fillpanels();
            }
            else
            {
                Response.Write("<script>alert('Panel name and interviewer name are required.');</script>");
            }
        }

        void clear()
        {
            txtPanelName.Text = "";
            txtPanelInterviewer.Text = "";
            txtPanelDesig.Text = "";
            txtPanelEmail.Text = "";
            txtPanelPhone.Text = "";
        }
    }
}
