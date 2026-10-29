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
                da = new SqlDataAdapter("select * from Admin_Login_tbl where (Email='" + email.Text + "' or Username='" + email.Text + "') and Password='" + password.Text + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                i = ds.Tables[0].Rows.Count;
                if (i > 0)
                {
                    Session["admin"] = ds.Tables[0].Rows[0]["Email"].ToString();
                    Session["admin_name"] = ds.Tables[0].Rows[0]["Full_Name"].ToString();

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
            if (resetEmail.Text != "")
            {
                getcon();
                da = new SqlDataAdapter("select * from Admin_Login_tbl where Email='" + resetEmail.Text + "' or Username='" + resetEmail.Text + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                i = ds.Tables[0].Rows.Count;
                if (i > 0)
                {
                    Response.Write("<script>alert('Self-service password recovery is disabled for Administrator accounts. For security, please contact the Database Administrator or server IT to recover credentials.');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Administrator account not found with this email.');</script>");
                }
                resetEmail.Text = "";
                resetNewPassword.Text = "";
                resetConfirmPassword.Text = "";
            }
            else
            {
                Response.Write("<script>alert('Please enter your registered email.');</script>");
            }
        }
    }
}
