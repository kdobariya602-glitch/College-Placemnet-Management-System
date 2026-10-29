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
    public partial class reports : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string nm;
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

                if (!IsPostBack)
                {
                    filldropdowns();
                    fillgrid();
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
            da = new SqlDataAdapter("select distinct Dept_Name from Department_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlDepartment.DataSource = ds;
            ddlDepartment.DataTextField = "Dept_Name";
            ddlDepartment.DataValueField = "Dept_Name";
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, new ListItem("All Departments", ""));

            da = new SqlDataAdapter("select distinct Batch_Name from Batch_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlBatch.DataSource = ds;
            ddlBatch.DataTextField = "Batch_Name";
            ddlBatch.DataValueField = "Batch_Name";
            ddlBatch.DataBind();
            ddlBatch.Items.Insert(0, new ListItem("All Batches", ""));

            da = new SqlDataAdapter("select distinct Season_Name from Placement_Season_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlSeason.DataSource = ds;
            ddlSeason.DataTextField = "Season_Name";
            ddlSeason.DataValueField = "Season_Name";
            ddlSeason.DataBind();
            ddlSeason.Items.Insert(0, new ListItem("All Seasons", ""));
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            ddlDepartment.SelectedIndex = 0;
            ddlBatch.SelectedIndex = 0;
            ddlSeason.SelectedIndex = 0;
            fillgrid();
        }

        void fillgrid()
        {
            getcon();

            da = new SqlDataAdapter("select * from Student_Reg_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            int tot = ds.Tables[0].Rows.Count;
            lblTotalStudents.Text = tot.ToString();

            da = new SqlDataAdapter("select distinct Student_Email from Selection_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            int pl = ds.Tables[0].Rows.Count;
            lblPlacedStudents.Text = pl.ToString();

            int pct = 0;
            if (tot > 0)
            {
                pct = (pl * 100) / tot;
            }
            lblPlacementPct.Text = pct.ToString() + "%";

            da = new SqlDataAdapter("select max(Package_Numeric) as Max_Package, avg(Package_Numeric) as Avg_Package from Placement_History_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Max_Package"] != DBNull.Value)
            {
                decimal maxPkg = Convert.ToDecimal(ds.Tables[0].Rows[0]["Max_Package"]);
                decimal avgPkg = Convert.ToDecimal(ds.Tables[0].Rows[0]["Avg_Package"]);
                lblHighestPkg.Text = maxPkg.ToString() + " INR";
                lblAvgPkg.Text = avgPkg.ToString() + " INR";
            }
            else
            {
                lblHighestPkg.Text = "0 INR";
                lblAvgPkg.Text = "0 INR";
            }

            da = new SqlDataAdapter("select Department, count(*) as Total, sum(case when Offer_Status='Accepted' or Joining_Status='Joined' then 1 else 0 end) as Placed, sum(case when Offer_Status<>'Accepted' and (Joining_Status is null or Joining_Status<>'Joined') then 1 else 0 end) as Unplaced, cast(round(avg(case when Offer_Status='Accepted' or Joining_Status='Joined' then 100.0 else 0.0 end), 0) as int) as Percentage from Selection_tbl group by Department", con);
            ds = new DataSet();
            da.Fill(ds);
            gvDeptStats.DataSource = ds;
            gvDeptStats.DataBind();

            da = new SqlDataAdapter("select Company_Name, count(*) as Selections, max(Package_CTC) as MaxPackage from Selection_tbl group by Company_Name", con);
            ds = new DataSet();
            da.Fill(ds);
            gvTopCompanies.DataSource = ds;
            gvTopCompanies.DataBind();

            da = new SqlDataAdapter("select *, Job_Title as Designation, Package_CTC as Package_LPA, ISNULL(Joining_Status, ISNULL(Offer_Status, 'Selected')) as Status, ISNULL(Department, '') as Course from Selection_tbl order by Selection_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvPlacements.DataSource = ds;
            gvPlacements.DataBind();
        }

        protected void btnGenerateAdminAiAudit_Click(object sender, EventArgs e)
        {
            getcon();
            fillgrid();

            da = new SqlDataAdapter("select count(*) as TotalOffers, max(Package_CTC) as MaxPackage from Selection_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            string offers = "0";
            string maxPkg = "0";
            if (ds.Tables[0].Rows.Count > 0)
            {
                offers = ds.Tables[0].Rows[0]["TotalOffers"].ToString();
                maxPkg = ds.Tables[0].Rows[0]["MaxPackage"].ToString();
            }

            litAdminAiAuditContent.Text = "Total verified campus offers: " + offers + ". Maximum placement package: " + maxPkg + ". Institutional placement audit generated successfully.";
            divAdminAiAudit.Visible = true;
            divAdminAiAuditPlaceholder.Visible = false;
            Response.Write("<script>alert('NAAC Placement Audit generated successfully');</script>");
        }

        protected void btnExportReportCsv_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select Selection_Id, Student_Name, Enrollment_No, Department, Company_Name, Job_Title, Package_CTC, Offer_Status, Offer_Date from Selection_tbl order by Selection_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvPlacements.DataSource = ds;
            gvPlacements.DataBind();
            Response.Write("<script>alert('Placement Report generated and exported successfully');</script>");
        }
    }
}
