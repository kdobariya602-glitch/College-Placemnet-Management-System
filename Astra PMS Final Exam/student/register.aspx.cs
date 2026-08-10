using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Astra_PMS_Final_Exam.student
{
    public partial class register : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string fnm;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            fillgrid();


        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillgrid()
        {
            getcon();
<<<<<<< HEAD
            da = new SqlDataAdapter("select * from Company_reg_tbl", con);
=======
            da = new SqlDataAdapter("select * from Student_reg_tbl", con);
>>>>>>> 0b3b662 (Save local changes)
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void clear()
        {
            fullName.Text = "";
            email.Text = "";
            password.Text = "";
            phone.Text = "";
            branch.SelectedIndex = 0;
            cgpa.Text = "";
            year.Text = "";
            skills.Text = "";  
        }

        protected void registerBtn_Click(object sender, ImageClickEventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Student_Reg_tbl(Full_Name,Email,Password,Phone,Branch,Cgpa,Graduation_Year,Skills)values('" + fullName.Text + "','" + email.Text + "','" + password.Text + "','" + phone.Text + "','" + branch.SelectedValue + "','" + cgpa.Text + "','" + year.Text + "','" + skills.Text + "')", con);
            cmd.ExecuteNonQuery();
            fillgrid();
            clear();


            Response.Redirect("login.aspx");
        }
    }
}