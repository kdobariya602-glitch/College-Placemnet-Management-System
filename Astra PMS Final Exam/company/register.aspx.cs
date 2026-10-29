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
    public partial class register : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillgrid();
            }
        }

        void fillgrid()
        {
            // GridView1 is kept hidden on public registration page to protect company privacy and prevent data exposure
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
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

        protected void registerBtn_Click(object sender, EventArgs e)
        {
            string cName = companyName.Text.Trim();
            string cEmail = email.Text.Trim();
            string cPass = password.Text.Trim();
            string cContact = contact.Text.Trim();
            string cIndustry = industry.Text.Trim();
            string cLoc = location.Text.Trim();
            string cWeb = website.Text.Trim();

            string cDesc = description.Text.Trim();

            if (cName != "" && cEmail != "" && cPass != "")
            {
                getcon();

                // Check if already registered
                da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + cEmail + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Response.Write("<script>alert('Official email is already registered! Please sign in or use a different email.');</script>");
                    return;
                }

                string cContactVal = cContact;

                string cIndustryVal = cIndustry;

                string cLocVal = cLoc;

                cmd = new SqlCommand("insert into Company_reg_tbl(Company_Name, Email, Password, Contact_Number, Industry, Location, Website, Company_Description, Verification_Status, Created_Date) values('" + cName + "','" + cEmail + "','" + cPass + "','" + cContactVal + "','" + cIndustryVal + "','" + cLocVal + "','" + cWeb + "','" + cDesc + "','Verified', GETDATE())", con);
                cmd.ExecuteNonQuery();

                clear();
                Response.Write("<script>alert('Corporate registration successful! Please login to access your recruiter dashboard.'); window.location='login.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Please fill all required corporate details.');</script>");
            }
        }
    }
}