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
        }

        void fillstats()
        {
            getcon();
            da = new SqlDataAdapter("select * from Placement_History_tbl where Company_Name='" + nm + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            litTotalHires.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Placement_History_tbl where Company_Name='" + nm + "' and Joining_Status='Joined'", con);
            ds = new DataSet();
            da.Fill(ds);
            litTotalJoined.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select max(Package_Numeric) as Max_Package, avg(Package_Numeric) as Avg_Package from Placement_History_tbl where Company_Name='" + nm + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Max_Package"] != DBNull.Value && !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["Max_Package"].ToString()))
            {
                decimal maxVal = Convert.ToDecimal(ds.Tables[0].Rows[0]["Max_Package"]);
                decimal avgVal = Convert.ToDecimal(ds.Tables[0].Rows[0]["Avg_Package"]);
                litHighestCTC.Text = "Rs. " + maxVal.ToString("0.00") + " LPA";
                litAverageCTC.Text = "Rs. " + avgVal.ToString("0.00") + " LPA";
            }
            else
            {
                litHighestCTC.Text = "Rs. 0.00 LPA";
                litAverageCTC.Text = "Rs. 0.00 LPA";
            }
        }

        void fillgrid()
        {
            getcon();
            if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select * from Placement_History_tbl where Company_Name='" + nm + "' and (Student_Name='" + txtSearch.Text + "' or Job_Title='" + txtSearch.Text + "')", con);
            }
            else if (ddlFilterDept.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Placement_History_tbl where Company_Name='" + nm + "' and Department='" + ddlFilterDept.SelectedValue + "'", con);
            }
            else if (ddlFilterStatus.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Placement_History_tbl where Company_Name='" + nm + "' and Joining_Status='" + ddlFilterStatus.SelectedValue + "'", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Placement_History_tbl where Company_Name='" + nm + "' order by History_Id desc", con);
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
            ddlFilterStatus.SelectedIndex = 0;
            fillgrid();
        }
    }
}
