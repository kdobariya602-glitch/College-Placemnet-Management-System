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
    public partial class change_password : System.Web.UI.Page
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
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            if (!(string.IsNullOrEmpty(txtCurrentPassword.Text)) && !(string.IsNullOrEmpty(txtNewPassword.Text)) && !(string.IsNullOrEmpty(txtConfirmPassword.Text)))
            {
                if (txtNewPassword.Text == txtConfirmPassword.Text)
                {
                    getcon();
                    cmd = new SqlCommand("select count(*) from Company_reg_tbl where Email='" + Session["company"] + "' and Password='" + txtCurrentPassword.Text + "'", con);
                    i = Convert.ToInt32(cmd.ExecuteScalar());
                    if (i > 0)
                    {
                        getcon();
                        cmd = new SqlCommand("update Company_reg_tbl set Password='" + txtNewPassword.Text + "' where Email='" + Session["company"] + "'", con);
                        cmd.ExecuteNonQuery();
                        Response.Write("<script>alert('Password changed successfully!');</script>");
                        clear();
                    }
                    else
                    {
                        Response.Write("<script>alert('Current password is incorrect!');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('New password and confirm password do not match!');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Please fill all fields.');</script>");
            }
        }

        void clear()
        {
            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
        }
    }
}
