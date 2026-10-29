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
    public partial class User_Management : System.Web.UI.Page
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
                    ViewState["RoleFilter"] = "All";
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
            string role = "All";
            if (ViewState["RoleFilter"] != null)
            {
                role = ViewState["RoleFilter"].ToString();
            }

            if (role == "Students")
            {
                if (txtSearch.Text != "")
                {
                    da = new SqlDataAdapter("select Student_Id as User_Id, Full_Name as User_Name, Email, Phone, 'Student' as Role, Account_Status as Status from Student_Reg_tbl where Full_Name='" + txtSearch.Text + "' or Email='" + txtSearch.Text + "'", con);
                }
                else
                {
                    da = new SqlDataAdapter("select Student_Id as User_Id, Full_Name as User_Name, Email, Phone, 'Student' as Role, Account_Status as Status from Student_Reg_tbl", con);
                }
            }
            else if (role == "Companies")
            {
                if (txtSearch.Text != "")
                {
                    da = new SqlDataAdapter("select Company_Id as User_Id, Company_Name as User_Name, Email, Contact_Number as Phone, 'Company' as Role, Verification_Status as Status from Company_reg_tbl where Company_Name='" + txtSearch.Text + "' or Email='" + txtSearch.Text + "'", con);
                }
                else
                {
                    da = new SqlDataAdapter("select Company_Id as User_Id, Company_Name as User_Name, Email, Contact_Number as Phone, 'Company' as Role, Verification_Status as Status from Company_reg_tbl", con);
                }
            }
            else if (role == "TPO")
            {
                if (txtSearch.Text != "")
                {
                    da = new SqlDataAdapter("select Tpo_Id as User_Id, Full_Name as User_Name, Email, Phone, 'TPO' as Role, Status from Tpo_Login_tbl where Full_Name='" + txtSearch.Text + "' or Email='" + txtSearch.Text + "'", con);
                }
                else
                {
                    da = new SqlDataAdapter("select Tpo_Id as User_Id, Full_Name as User_Name, Email, Phone, 'TPO' as Role, Status from Tpo_Login_tbl", con);
                }
            }
            else if (role == "Admin")
            {
                if (txtSearch.Text != "")
                {
                    da = new SqlDataAdapter("select Admin_Id as User_Id, Full_Name as User_Name, Email, Phone, 'Admin' as Role, Status from Admin_Login_tbl where Full_Name='" + txtSearch.Text + "' or Email='" + txtSearch.Text + "'", con);
                }
                else
                {
                    da = new SqlDataAdapter("select Admin_Id as User_Id, Full_Name as User_Name, Email, Phone, 'Admin' as Role, Status from Admin_Login_tbl", con);
                }
            }
            else
            {
                if (txtSearch.Text != "")
                {
                    da = new SqlDataAdapter("select * from (select Student_Id as User_Id, Full_Name as User_Name, Email, Phone, 'Student' as Role, Account_Status as Status from Student_Reg_tbl union select Company_Id as User_Id, Company_Name as User_Name, Email, Contact_Number as Phone, 'Company' as Role, Verification_Status as Status from Company_reg_tbl union select Tpo_Id as User_Id, Full_Name as User_Name, Email, Phone, 'TPO' as Role, Status from Tpo_Login_tbl union select Admin_Id as User_Id, Full_Name as User_Name, Email, Phone, 'Admin' as Role, Status from Admin_Login_tbl) as U where User_Name='" + txtSearch.Text + "' or Email='" + txtSearch.Text + "'", con);
                }
                else
                {
                    da = new SqlDataAdapter("select Student_Id as User_Id, Full_Name as User_Name, Email, Phone, 'Student' as Role, Account_Status as Status from Student_Reg_tbl union select Company_Id as User_Id, Company_Name as User_Name, Email, Contact_Number as Phone, 'Company' as Role, Verification_Status as Status from Company_reg_tbl union select Tpo_Id as User_Id, Full_Name as User_Name, Email, Phone, 'TPO' as Role, Status from Tpo_Login_tbl union select Admin_Id as User_Id, Full_Name as User_Name, Email, Phone, 'Admin' as Role, Status from Admin_Login_tbl", con);
                }
            }

            ds = new DataSet();
            da.Fill(ds);

            gvUsers.DataSource = ds;
            gvUsers.DataBind();
            lblTotalUsers.Text = ds.Tables[0].Rows.Count.ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ViewState["RoleFilter"] = "All";
            fillgrid();
        }



        protected void btnTabAll_Click(object sender, EventArgs e)
        {
            ViewState["RoleFilter"] = "All";
            fillgrid();
        }

        void clear()
        {
            ViewState["RoleFilter"] = "All";
        }

        protected void btnTabStudents_Click(object sender, EventArgs e)
        {
            ViewState["RoleFilter"] = "Students";
            fillgrid();
        }

        protected void btnTabCompanies_Click(object sender, EventArgs e)
        {
            ViewState["RoleFilter"] = "Companies";
            fillgrid();
        }

        protected void btnTabTpo_Click(object sender, EventArgs e)
        {
            ViewState["RoleFilter"] = "TPO";
            fillgrid();
        }

        protected void btnTabAdmin_Click(object sender, EventArgs e)
        {
            ViewState["RoleFilter"] = "Admin";
            fillgrid();
        }

        protected void gvUsers_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "toggle_status")
            {
                getcon();
                string email = e.CommandArgument.ToString();
                cmd = new SqlCommand("update Student_Reg_tbl set Account_Status = case when Account_Status='Active' then 'Suspended' else 'Active' end where Email='" + email + "'", con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = case when Verification_Status='Verified' then 'Pending' else 'Verified' end where Email='" + email + "'", con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("update Tpo_Login_tbl set Status = case when Status='Active' then 'Inactive' else 'Active' end where Email='" + email + "'", con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("update Admin_Login_tbl set Status = case when Status='Active' then 'Inactive' else 'Active' end where Email='" + email + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('User account status updated.');</script>");
                fillgrid();
            }
        }
    }
}
