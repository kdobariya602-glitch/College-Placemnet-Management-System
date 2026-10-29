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
    public partial class manage_tpo : System.Web.UI.Page
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

            ddlAddDepartment.DataSource = ds;
            ddlAddDepartment.DataTextField = "Dept_Name";
            ddlAddDepartment.DataValueField = "Dept_Name";
            ddlAddDepartment.DataBind();
            ddlAddDepartment.Items.Insert(0, new ListItem("All Departments (Central)", "All Departments"));
        }

        void fillstats()
        {
            getcon();

            da = new SqlDataAdapter("select * from Tpo_Login_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            litTotalTpo.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Tpo_Login_tbl where Status = 'Active'", con);
            ds = new DataSet();
            da.Fill(ds);
            litActiveTpo.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Department_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            litDeptsCovered.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Tpo_Login_tbl where Status = 'Inactive'", con);
            ds = new DataSet();
            da.Fill(ds);
            litHeadTpo.Text = ds.Tables[0].Rows.Count.ToString();
        }

        void fillgrid()
        {
            getcon();
            if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select * from Tpo_Login_tbl where (Full_Name='" + txtSearch.Text + "' or Email='" + txtSearch.Text + "' or Phone='" + txtSearch.Text + "') order by Tpo_Id desc", con);
            }
            else if (ddlFilterDept.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Tpo_Login_tbl where Department = '" + ddlFilterDept.SelectedValue + "' order by Tpo_Id desc", con);
            }
            else if (ddlFilterStatus.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Tpo_Login_tbl where Status = '" + ddlFilterStatus.SelectedValue + "' order by Tpo_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Tpo_Login_tbl order by Tpo_Id desc", con);
            }

            ds = new DataSet();
            da.Fill(ds);

            gvTpo.DataSource = ds;
            gvTpo.DataBind();
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

        protected void btnSaveTpo_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Tpo_Login_tbl (Email, Password, Full_Name, Tpo_Name, Username, Phone, Designation, Department, Status) values ('" + txtAddEmail.Text + "', '" + txtAddPassword.Text + "', '" + txtAddFullName.Text + "', '" + txtAddFullName.Text + "', '" + txtAddEmail.Text + "', '" + txtAddPhone.Text + "', '" + ddlAddDesignation.SelectedValue + "', '" + ddlAddDepartment.SelectedValue + "', 'Active')", con);
            cmd.ExecuteNonQuery();

            clear();
            Response.Write("<script>alert('TPO Officer Added Successfully!');</script>");
            fillstats();
            fillgrid();
        }

        protected void gvTpo_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string tpo_id = e.CommandArgument.ToString();

            if (e.CommandName == "ToggleStatus")
            {
                getcon();
                cmd = new SqlCommand("update Tpo_Login_tbl set Status = case when Status = 'Active' then 'Inactive' else 'Active' end where Tpo_Id = '" + tpo_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('TPO Status Updated!');</script>");
                fillstats();
                fillgrid();
            }
            else if (e.CommandName == "ResetPassword")
            {
                getcon();
                cmd = new SqlCommand("update Tpo_Login_tbl set Password = 'admin' where Tpo_Id = '" + tpo_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Password Reset to admin!');</script>");
            }
            else if (e.CommandName == "DeleteTpo")
            {
                getcon();
                cmd = new SqlCommand("delete from Tpo_Login_tbl where Tpo_Id = '" + tpo_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('TPO Record Deleted!');</script>");
                fillstats();
                fillgrid();
            }
        }

        void clear()
        {
            txtAddFullName.Text = "";
            txtAddEmail.Text = "";
            txtAddPassword.Text = "";
            txtAddPhone.Text = "";
        }
    }
}
