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
    public partial class dashboard : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

        public string chartFunnel = "[0,0,0,0]";
        public string chartRatio = "[0,0,0]";

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        int getcount(string sqlstr)
        {
            getcon();
            da = new SqlDataAdapter(sqlstr, con);
            DataSet dsCount = new DataSet();
            da.Fill(dsCount);
            if (dsCount.Tables[0].Rows.Count > 0 && dsCount.Tables[0].Rows[0][0] != DBNull.Value)
            {
                return Convert.ToInt32(dsCount.Tables[0].Rows[0][0]);
            }
            return 0;
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
            filldata();
        }

        void filldata()
        {
            getcon();

            da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                string compName = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                litCompanyName.Text = compName;
                lblCompName.Text = compName;
                lblCompEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblIndustryHero.Text = ds.Tables[0].Rows[0]["Industry"].ToString();
                lblLocationHero.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                string vStatus = ds.Tables[0].Rows[0]["Verification_Status"].ToString();
                lblVerificationStatusBadge.Text = vStatus;


                lblHRName.Text = ds.Tables[0].Rows[0]["HR_Name"].ToString();
                lblHRPhone.Text = ds.Tables[0].Rows[0]["Contact_Number"].ToString();
                lblWebsite.Text = ds.Tables[0].Rows[0]["Website"].ToString();
            }

            da = new SqlDataAdapter("select * from Job_tbl where Company_Email='" + Session["company"] + "' and Status in ('Active', 'Published', 'Open')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblActiveJobs.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalApplicants.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Application_tbl where Company_Email='" + Session["company"] + "' and Status='Shortlisted'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblShortlistedCount.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblHiredCount.Text = ds.Tables[0].Rows.Count.ToString();

            // ---- real chart data ----
            string ce = Session["company"].ToString();
            int cTotal = getcount("select count(*) from Application_tbl where Company_Email='" + ce + "'");
            int cReview = getcount("select count(*) from Application_tbl where Company_Email='" + ce + "' and Status in ('Applied','Submitted','Active','Under Evaluation')");
            int cShort = getcount("select count(*) from Application_tbl where Company_Email='" + ce + "' and Status in ('Shortlisted','Next Round')");
            int cHired = getcount("select count(*) from Selection_tbl where Company_Email='" + ce + "'");
            chartFunnel = "[" + cTotal + "," + cReview + "," + cShort + "," + cHired + "]";
            chartRatio = "[" + cReview + "," + cShort + "," + cHired + "]";

            // Bind ASP.NET Chart Controls
            if (ChartHiringPipeline != null && ChartHiringPipeline.Series.Count > 0) { ChartHiringPipeline.Series["Series1"].Points.Clear();
                ChartHiringPipeline.Series["Series1"].Points.AddXY("Applied", cTotal);
                ChartHiringPipeline.Series["Series1"].Points.AddXY("In Review", cReview);
                ChartHiringPipeline.Series["Series1"].Points.AddXY("Shortlisted", cShort);
                ChartHiringPipeline.Series["Series1"].Points.AddXY("Selected", cHired);

                ChartCandidateStatus.Series["Series1"].Points.Clear();
                if (cReview > 0) ChartCandidateStatus.Series["Series1"].Points.AddXY("In Review", cReview);
                if (cShort > 0) ChartCandidateStatus.Series["Series1"].Points.AddXY("Shortlisted", cShort);
                if (cHired > 0) ChartCandidateStatus.Series["Series1"].Points.AddXY("Selected", cHired);
                if (cReview == 0 && cShort == 0 && cHired == 0 && cTotal > 0)
                {
                    ChartCandidateStatus.Series["Series1"].Points.AddXY("Applications", cTotal);
                } }

            da = new SqlDataAdapter("select top 5 * from Job_tbl where Company_Email='" + Session["company"] + "' order by Job_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvMyJobs.DataSource = ds;
            gvMyJobs.DataBind();

            da = new SqlDataAdapter("select top 5 * from Application_tbl where Company_Email='" + Session["company"] + "' order by Application_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvRecentApplicants.DataSource = ds;
            gvRecentApplicants.DataBind();
        }

        protected void gvRecentApplicants_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "review_app")
            {
                Session["id"] = e.CommandArgument;
                Session["aid"] = Convert.ToInt32(e.CommandArgument); Response.Redirect("applicant-details.aspx");
            }
        }
    }
}

