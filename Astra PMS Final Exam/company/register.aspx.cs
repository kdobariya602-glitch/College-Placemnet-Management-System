using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam.company
{
    public partial class register : System.Web.UI.Page
    {

        SqlConnection con; //For connection
        SqlDataAdapter da; // for container
        DataSet ds; // for select
        SqlCommand cmd; // For insert, update, delete

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
            da = new SqlDataAdapter("select * from Company_reg_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void clear()
        {
            companyName.Text = "";
            email.Text = "";
            password.Text = "";
            contact.Text = "";
            industry.Text = "";
            location.Text = "";
            website.Text = "";
            description.Text = "";
        }

        protected void registerBtn_Click(object sender, ImageClickEventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Company_reg_tbl(Company_Name,Email,Password,Contact_Number,Industry,Location,Website,Company_Description)values('" + companyName.Text + "','" + email.Text + "','" + password.Text + "','" + contact.Text + "','" + industry.Text + "','" + location.Text + "','" + website.Text + "','" + description.Text + "')", con);
            cmd.ExecuteNonQuery();
            //fillgrid();
            clear();


            Response.Redirect("login.aspx");
        }

        //protected void registerBtn_Click1(object sender, ImageClickEventArgs e)
        //{

        //}
    }
}