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
    public partial class students : System.Web.UI.Page
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
            getcon();
            if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select * from Student_Reg_tbl where (Full_Name='" + txtSearch.Text + "' or Email='" + txtSearch.Text + "' or Enrollment_No='" + txtSearch.Text + "' or Skills='" + txtSearch.Text + "') order by Student_Id desc", con);
            }
            else if (ddlBranchFilter.SelectedValue != "All" && ddlBranchFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Student_Reg_tbl where Branch = '" + ddlBranchFilter.SelectedValue + "' order by Student_Id desc", con);
            }
            else if (ddlStatusFilter.SelectedValue != "All" && ddlStatusFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Student_Reg_tbl where Placement_Status = '" + ddlStatusFilter.SelectedValue + "' order by Student_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Student_Reg_tbl order by Student_Id desc", con);
            }

            ds = new DataSet();
            da.Fill(ds);
            gvStudents.DataSource = ds;
            gvStudents.DataBind();
            lblCount.Text = ds.Tables[0].Rows.Count.ToString();
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
            ddlBranchFilter.SelectedIndex = 0;
            ddlStatusFilter.SelectedIndex = 0;
            gvStudents.PageIndex = 0;
            fillgrid();
        }

        protected void gvStudents_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvStudents.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int stuid = Convert.ToInt32(e.CommandArgument); 
            Session["stuid"] = stuid; 
            ViewState["stuid"] = stuid;

            if (e.CommandName == "view_student") 
            { 
                Session["stuid"] = stuid; 
                Response.Redirect("student-details.aspx"); 
            } 
            else if (e.CommandName == "toggle_status")
            {
                getcon();
                da = new SqlDataAdapter("select Account_Status from Student_Reg_tbl where Student_Id='" + stuid + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string newStatus = "Active";
                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Account_Status"].ToString() == "Active")
                {
                    newStatus = "Inactive";
                }
                cmd = new SqlCommand("update Student_Reg_tbl set Account_Status='" + newStatus + "' where Student_Id='" + stuid + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Student Status Updated to " + newStatus + "!');</script>");
                fillgrid();
            }
            else if (e.CommandName == "delete_student")
            {
                getcon();
                cmd = new SqlCommand("delete from Student_Reg_tbl where Student_Id='" + stuid + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Student Deleted Successfully!');</script>");
                fillgrid();
            }
        }

        protected void btnSaveStudent_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Student_Reg_tbl (Full_Name, Enrollment_No, Email, Password, Phone, Branch, Cgpa, Graduation_Year, Semester, Skills, Placement_Status, Account_Status) values ('" + txtNewName.Text + "', '" + txtNewEnroll.Text + "', '" + txtNewEmail.Text + "', '" + txtNewPass.Text + "', '" + txtNewPhone.Text + "', '" + ddlNewBranch.SelectedValue + "', '" + txtNewCgpa.Text + "', '" + txtNewGradYear.Text + "', '" + txtNewSem.Text + "', '" + txtNewSkills.Text + "', 'Seeking Placement', 'Active')", con);
            cmd.ExecuteNonQuery();

            clear();
            Response.Write("<script>alert('Student Registered Successfully!');</script>");
            fillgrid();
        }

        void clear()
        {
            txtNewName.Text = "";
            txtNewEnroll.Text = "";
            txtNewEmail.Text = "";
            txtNewPass.Text = "";
            txtNewPhone.Text = "";
            txtNewCgpa.Text = "";
            txtNewGradYear.Text = "";
            txtNewSem.Text = "";
            txtNewSkills.Text = "";
        }
    }
}
