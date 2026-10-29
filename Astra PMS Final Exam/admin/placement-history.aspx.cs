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
    public partial class placement_history : System.Web.UI.Page
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

        public string FormatDate(object obj)
        {
            if (obj == null || obj == DBNull.Value) return "-";
            string str = obj.ToString().Trim();
            if (string.IsNullOrEmpty(str)) return "-";
            if (!string.IsNullOrEmpty(str)) { return Convert.ToDateTime(str).ToString("dd MMM yyyy"); }
            return str;
        }

        public string SafeStatus(object obj)
        {
            if (obj == null || obj == DBNull.Value) return "Archived";
            string str = obj.ToString().Trim();
            return string.IsNullOrEmpty(str) ? "Archived" : str;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                if (!IsPostBack)
                {
                    filldropdowns();
                    fillstats();
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

            ddlFilterDept.DataSource = ds;
            ddlFilterDept.DataTextField = "Dept_Name";
            ddlFilterDept.DataValueField = "Dept_Name";
            ddlFilterDept.DataBind();
            ddlFilterDept.Items.Insert(0, new ListItem("All Departments", ""));

            ddlAddDept.DataSource = ds;
            ddlAddDept.DataTextField = "Dept_Name";
            ddlAddDept.DataValueField = "Dept_Name";
            ddlAddDept.DataBind();

            da = new SqlDataAdapter("select distinct Batch_Name from Batch_tbl", con);
            ds = new DataSet();
            da.Fill(ds);

            ddlFilterBatch.DataSource = ds;
            ddlFilterBatch.DataTextField = "Batch_Name";
            ddlFilterBatch.DataValueField = "Batch_Name";
            ddlFilterBatch.DataBind();
            ddlFilterBatch.Items.Insert(0, new ListItem("All Batches", ""));

            ddlAddBatch.DataSource = ds;
            ddlAddBatch.DataTextField = "Batch_Name";
            ddlAddBatch.DataValueField = "Batch_Name";
            ddlAddBatch.DataBind();
        }

        void fillstats()
        {
            getcon();
            da = new SqlDataAdapter("select count(*) from Placement_History_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            litTotalHistory.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select count(distinct Company_Name) from Placement_History_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            litUniqueCompanies.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("select max(Package_Numeric) as Max_Package, avg(Package_Numeric) as Avg_Package from Placement_History_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Max_Package"] != DBNull.Value && !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Max_Package"].ToString()))
            {
                litHighestCTC.Text = "Rs. " + ds.Tables[0].Rows[0]["Max_Package"].ToString() + " LPA";
                litAverageCTC.Text = "Rs. " + string.Format("{0:0.00}", ds.Tables[0].Rows[0]["Avg_Package"]) + " LPA";
            }
            else
            {
                litHighestCTC.Text = "Rs. 0 LPA";
                litAverageCTC.Text = "Rs. 0 LPA";
            }
        }

        void fillgrid()
        {
            getcon();
            if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select * from Placement_History_tbl where (Student_Name='" + txtSearch.Text + "' or Company_Name='" + txtSearch.Text + "' or Enrollment_No='" + txtSearch.Text + "') order by History_Id desc", con);
            }
            else if (ddlFilterDept.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Placement_History_tbl where Department = '" + ddlFilterDept.SelectedValue + "' order by History_Id desc", con);
            }
            else if (ddlFilterBatch.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Placement_History_tbl where Batch = '" + ddlFilterBatch.SelectedValue + "' order by History_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Placement_History_tbl order by History_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);

            gvHistory.DataSource = ds;
            gvHistory.DataBind();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilterDept.SelectedIndex = 0;
            ddlFilterBatch.SelectedIndex = 0;
            ddlFilterStatus.SelectedIndex = 0;
            fillgrid();
        }

        protected void btnSaveHistory_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Placement_History_tbl (Student_Email, Student_Name, Enrollment_No, Department, Course, Batch, Company_Name, Job_Title, Package_CTC, Selection_Date, Joining_Date, Joining_Status, Academic_Year, Placement_Season, Created_Date) values ('" + txtAddStudentEmail.Text + "', '" + txtAddStudentName.Text + "', '" + txtAddEnrollment.Text + "', '" + ddlAddDept.SelectedValue + "', '" + txtAddCourse.Text + "', '" + ddlAddBatch.SelectedValue + "', '" + txtAddCompany.Text + "', '" + txtAddJobTitle.Text + "', '" + txtAddPackage.Text + "', GETDATE(), GETDATE(), '" + ddlAddJoiningStatus.SelectedValue + "', '" + txtAddAcademicYear.Text + "', '" + txtAddSeason.Text + "', GETDATE())", con);
            cmd.ExecuteNonQuery();

            clear();
            Response.Write("<script>alert('Placement archive record saved successfully.');</script>");
            fillstats();
            fillgrid();
        }

        protected void gvHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string history_id = e.CommandArgument.ToString();

            if (e.CommandName == "DeleteRecord")
            {
                getcon();
                cmd = new SqlCommand("delete from Placement_History_tbl where History_Id = '" + history_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Record deleted from archives.');</script>");
                fillstats();
                fillgrid();
            }
        }

        void clear()
        {
            txtAddStudentName.Text = "";
            txtAddStudentEmail.Text = "";
            txtAddEnrollment.Text = "";
            txtAddCourse.Text = "";
            txtAddCompany.Text = "";
            txtAddJobTitle.Text = "";
            txtAddPackage.Text = "";
            txtAddAcademicYear.Text = "";
            txtAddSeason.Text = "";
        }
    }
}
