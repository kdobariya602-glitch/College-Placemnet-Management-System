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
    public partial class drive_details : System.Web.UI.Page
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

                if (Session["did"] != null) { ViewState["did"] = Session["did"]; }

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
            if (ViewState["did"] != null && ViewState["did"].ToString() != "")
            {
                da = new SqlDataAdapter("select * from Placement_Drive_tbl where Drive_Id='" + ViewState["did"] + "'", con);
            }
            else
            {
                da = new SqlDataAdapter("select top 1 * from Placement_Drive_tbl order by Drive_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                ViewState["did"] = ds.Tables[0].Rows[0]["Drive_Id"].ToString();
                Session["did"] = ViewState["did"];

                lblDriveName.Text = ds.Tables[0].Rows[0]["Drive_Name"].ToString();
                lblCompanyName.Text = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                lblDate.Text = ds.Tables[0].Rows[0]["Drive_Date"].ToString();
                lblTime.Text = ds.Tables[0].Rows[0]["Drive_Time"].ToString();
                lblVenue.Text = ds.Tables[0].Rows[0]["Venue"].ToString();
                lblMode.Text = ds.Tables[0].Rows[0]["Mode"].ToString();
                lblStatus.Text = ds.Tables[0].Rows[0]["Status"].ToString();

                string driveId = ViewState["did"].ToString();

                // Applications
                da = new SqlDataAdapter("select * from Application_tbl where Drive_Id='" + driveId + "' order by Application_Id desc", con);
                DataSet dsApps = new DataSet();
                da.Fill(dsApps);
                gvDriveApps.DataSource = dsApps;
                gvDriveApps.DataBind();
                lblAppCount.Text = dsApps.Tables[0].Rows.Count.ToString();
                lblTabAppCount.Text = dsApps.Tables[0].Rows.Count.ToString();

                // Shortlist
                da = new SqlDataAdapter("select * from Application_tbl where Drive_Id='" + driveId + "' and Status='Shortlisted' order by Application_Id desc", con);
                DataSet dsShort = new DataSet();
                da.Fill(dsShort);
                gvShortlist.DataSource = dsShort;
                gvShortlist.DataBind();
                lblShortlistCount.Text = dsShort.Tables[0].Rows.Count.ToString();
                lblTabShortlistCount.Text = dsShort.Tables[0].Rows.Count.ToString();

                // Interviews
                da = new SqlDataAdapter("select * from Interview_Schedule_tbl where Drive_Id='" + driveId + "' order by Interview_Id desc", con);
                DataSet dsInt = new DataSet();
                da.Fill(dsInt);
                gvInterviews.DataSource = dsInt;
                gvInterviews.DataBind();
                lblInterviewCount.Text = dsInt.Tables[0].Rows.Count.ToString();
                lblTabInterviewCount.Text = dsInt.Tables[0].Rows.Count.ToString();

                // Selections
                da = new SqlDataAdapter("select * from Selection_tbl where Drive_Id='" + driveId + "' order by Selection_Id desc", con);
                DataSet dsSel = new DataSet();
                da.Fill(dsSel);
                gvSelections.DataSource = dsSel;
                gvSelections.DataBind();
                lblSelectCount.Text = dsSel.Tables[0].Rows.Count.ToString();
                lblTabSelectCount.Text = dsSel.Tables[0].Rows.Count.ToString();
            }
            else
            {
                Response.Redirect("drives.aspx");
            }
        }
    }
}
