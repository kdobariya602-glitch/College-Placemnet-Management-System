using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam.tpo
{
    public partial class login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string fnm;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void signInBtn_Click(object sender, ImageClickEventArgs e)
        {
            getcon();
            cmd = new SqlCommand("select * from Tpo_Login_tbl where Email=@Email and Password=@Password", con);
            cmd.Parameters.AddWithValue("@Email", email.Text);
            cmd.Parameters.AddWithValue("@Password", password.Text);

            SqlDataReader dr = cmd.ExecuteReader();


            if (dr.Read())
            {
                Session["tpo"] = email.Text;
                Response.Redirect("dashboard.aspx");
            }
            else
            {

                Response.Write("<script>alert('Invalid credentials');</script>");
            }

        }
    }
}