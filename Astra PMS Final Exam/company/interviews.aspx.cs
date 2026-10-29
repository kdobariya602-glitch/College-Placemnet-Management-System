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
                    fillcandidates();
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void fillcandidates()
        {
            getcon();
            da = new SqlDataAdapter("select distinct Student_Name, Student_Email from Shortlist_tbl where Company_Email='" + Session["company"] + "' union select distinct Student_Name, Student_Email from Application_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count == 0)
            {
                da = new SqlDataAdapter("select Full_Name as Student_Name, Email as Student_Email from Student_Reg_tbl where Account_Status='Active'", con);
            }
            ds = new DataSet();
            da.Fill(ds);

            ddlCandidate.DataSource = ds;
            ddlCandidate.DataTextField = "Student_Name";
            ddlCandidate.DataValueField = "Student_Email";
            ddlCandidate.DataBind();
            ddlCandidate.Items.Insert(0, new ListItem("-- Select Candidate --", ""));
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from Interview_tbl where Company_Email='" + Session["company"] + "' order by Interview_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            gvInterviews.DataSource = ds;
            gvInterviews.DataBind();

            lblTotalCount.Text = ds.Tables[0].Rows.Count + " Scheduled";
        }

        void clear()
        {
            ddlCandidate.SelectedIndex = 0;
            ddlRound.SelectedIndex = 0;
            ddlMode.SelectedIndex = 0;
            txtDate.Text = "";
            txtTime.Text = "";
            txtVenue.Text = "";
            txtInterviewer.Text = "";
            txtInstructions.Text = "";
            btnSave.Text = "Schedule Interview";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlCandidate.SelectedValue != "" && txtDate.Text != "")
            {
                getcon();
                da = new SqlDataAdapter("select * from Shortlist_tbl where Student_Email='" + ddlCandidate.SelectedValue + "' and Company_Email='" + Session["company"] + "' order by Shortlist_Id desc", con);
                ds = new DataSet();
                da.Fill(ds);

                if (btnSave.Text == "Schedule Interview")
                {
                    string appId = ds.Tables[0].Rows[0]["Application_Id"].ToString();
                    cmd = new SqlCommand("insert into Interview_tbl(Application_Id, Job_Id, Drive_Id, Company_Email, Company_Name, Student_Email, Student_Name, Round_Name, Interview_Date, Interview_Time, Mode, Venue, Meeting_Link, Interviewer_Name, Instructions, Status, Result, Created_Date) values('" + appId + "', '" + ds.Tables[0].Rows[0]["Job_Id"] + "', '" + ds.Tables[0].Rows[0]["Drive_Id"] + "', '" + Session["company"] + "', '" + nm + "', '" + ddlCandidate.SelectedValue + "', '" + ddlCandidate.SelectedItem.Text + "', '" + ddlRound.SelectedValue + "', '" + txtDate.Text + "', '" + txtTime.Text + "', '" + ddlMode.SelectedValue + "', '" + txtVenue.Text + "', '" + txtVenue.Text + "', '" + txtInterviewer.Text + "', '" + txtInstructions.Text + "', 'Scheduled', 'Pending', GETDATE())", con);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("update Application_tbl set Status='Interview Scheduled' where Application_Id='" + appId + "'", con);
                    cmd.ExecuteNonQuery();

                    Response.Write("<script>alert('Interview schedule saved successfully.');</script>");
                }
                else if (btnSave.Text == "Update Interview Schedule")
                {
                    cmd = new SqlCommand("update Interview_tbl set Round_Name='" + ddlRound.SelectedValue + "', Interview_Date='" + txtDate.Text + "', Interview_Time='" + txtTime.Text + "', Mode='" + ddlMode.SelectedValue + "', Venue='" + txtVenue.Text + "', Meeting_Link='" + txtVenue.Text + "', Interviewer_Name='" + txtInterviewer.Text + "', Instructions='" + txtInstructions.Text + "' where Interview_Id='" + ViewState["Interview_Id"] + "' and Company_Email='" + Session["company"] + "'", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Interview schedule updated successfully.');</script>");
                }

                clear();
                fillgrid();
            }
            else
            {
                Response.Write("<script>alert('Please fill required fields.');</script>");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void gvInterviews_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditInterview")
            {
                getcon();
                da = new SqlDataAdapter("select * from Interview_tbl where Interview_Id='" + e.CommandArgument + "' and Company_Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ViewState["Interview_Id"] = e.CommandArgument.ToString();
                    string cand = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                    if (ddlCandidate.Items.FindByValue(cand) != null)
                    {
                        ddlCandidate.SelectedValue = cand;
                    }
                    string rnd = ds.Tables[0].Rows[0]["Round_Name"].ToString();
                    if (ddlRound.Items.FindByValue(rnd) != null)
                    {
                        ddlRound.SelectedValue = rnd;
                    }
                    string md = ds.Tables[0].Rows[0]["Mode"].ToString();
                    if (ddlMode.Items.FindByValue(md) != null)
                    {
                        ddlMode.SelectedValue = md;
                    }
                    txtDate.Text = ds.Tables[0].Rows[0]["Interview_Date"].ToString();
                    txtTime.Text = ds.Tables[0].Rows[0]["Interview_Time"].ToString();
                    txtVenue.Text = ds.Tables[0].Rows[0]["Venue"].ToString();
                    txtInterviewer.Text = ds.Tables[0].Rows[0]["Interviewer_Name"].ToString();
                    txtInstructions.Text = ds.Tables[0].Rows[0]["Instructions"].ToString();

                    btnSave.Text = "Update Interview Schedule";
                }
            }
            else if (e.CommandName == "CancelInterview")
            {
                getcon();
                cmd = new SqlCommand("update Interview_tbl set Status='Cancelled' where Interview_Id='" + e.CommandArgument + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Interview cancelled successfully.');</script>");
                fillgrid();
            }
            else if (e.CommandName == "evaluate_interview")
            {
                Session["Interview_Id"] = e.CommandArgument;
                Response.Redirect("interview-results.aspx");
            }
        }
    }
}
