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
    public partial class login : System.Web.UI.Page
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

        }

        protected void signInBtn_Click(object sender, EventArgs e)
        {
            if (email.Text != "" && password.Text != "")
            {
                getcon();
                da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + email.Text + "' and Password='" + password.Text + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                i = ds.Tables[0].Rows.Count;
                if (i > 0)
                {
                    Session["company"] = ds.Tables[0].Rows[0]["Email"].ToString();
                    Session["company_id"] = ds.Tables[0].Rows[0]["Company_Id"].ToString();
                    Session["company_name"] = ds.Tables[0].Rows[0]["Company_Name"].ToString();

                    Response.Redirect("dashboard.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Invalid Email or Password');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Please enter Email and Password');</script>");
            }
        }

        protected void resetBtn_Click(object sender, EventArgs e)
        {
            if (resetEmail.Text != "" && resetNewPassword.Text != "")
            {
                getcon();
                da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + resetEmail.Text + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                i = ds.Tables[0].Rows.Count;
                if (i > 0)
                {
                    cmd = new SqlCommand("update Company_reg_tbl set Password='" + resetNewPassword.Text + "' where Email='" + resetEmail.Text + "'", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Password reset successfully! Please login with your new password.');</script>");
                    resetEmail.Text = "";
                    resetNewPassword.Text = "";
                    resetConfirmPassword.Text = "";
                }
                else
                {
                    Response.Write("<script>alert('Company account not found with this email.');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Please fill email and new password.');</script>");
            }
        }
    }
}