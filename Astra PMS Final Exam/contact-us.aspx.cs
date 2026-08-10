using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam
{

    using System.Configuration;
    using System.Data;
    using System.Data.SqlClient;
    using System.Security.Policy;

    public partial class contact_us : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from Contact_us_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
        void clear()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtCity.Text = "";
            txtMessage.Text = "";
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            lblFullName.Text = "Full Name: " + txtFullName.Text;
            lblEmail.Text = "Email: " + txtEmail.Text;
            lblPhone.Text = "Phone: " + txtPhone.Text;
            lblCity.Text = "City: " + txtCity.Text;
            lblMessage.Text = "Message: " + txtMessage.Text;

            // Save this inquiry so the Admin can see it under Admin > Contact Messages
            ContactMessage msg = new ContactMessage
            {
                FullName = txtFullName.Text,
                Email = txtEmail.Text,
                Phone = txtPhone.Text,
                City = txtCity.Text,
                Message = txtMessage.Text,
                SubmittedOn = DateTime.Now
            };
            ContactMessageStore.Add(this.Application, msg);


            //database
            getcon();
            cmd = new SqlCommand("insert into Contact_us_tbl(Full_Name,Email_Address,Phone_Number,City,Message) values('" + txtFullName.Text + "','" + txtEmail.Text + "','" + txtPhone.Text + "','" + txtCity.Text + "','" + txtMessage.Text + "')", con);
            cmd.ExecuteNonQuery();
            fillgrid();
            clear();
        }
    }
}