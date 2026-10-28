using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Astra_PMS_Final_Exam.tpo
{
    public partial class student_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["tpo"] == null)
            {
                Response.Redirect("login.aspx");
            }
            if (!IsPostBack)
            {
                fillDetails();
            }
        }

        void fillDetails()
        {
            string email = Request.QueryString["email"];

            if (string.IsNullOrEmpty(email))
            {
                pnlDetails.Visible = false;
                pnlNotFound.Visible = true;
                return;
            }

            con = new SqlConnection(s);
            con.Open();
            da = new SqlDataAdapter("select * from Student_reg_tbl where Email=@Email", con);
            da.SelectCommand.Parameters.AddWithValue("@Email", email);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            if (ds.Tables[0].Rows.Count == 0)
            {
                pnlDetails.Visible = false;
                pnlNotFound.Visible = true;
                return;
            }

            DataRow row = ds.Tables[0].Rows[0];

            string fullName = row["Full_Name"].ToString();
            lblFullName.Text = fullName;
            lblInitials.Text = GetInitials(fullName);
            lblBranch.Text = row["Branch"].ToString();
            lblBranch2.Text = row["Branch"].ToString();
            lblCgpa.Text = row["Cgpa"].ToString();
            lblYear.Text = row["Graduation_Year"].ToString();
            lblEmail.Text = row["Email"].ToString();
            lblPhone.Text = row["Phone"].ToString();
            lblSkills.Text = row["Skills"].ToString();

            pnlDetails.Visible = true;
            pnlNotFound.Visible = false;
        }

        string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "?";
            var parts = name.Trim().Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1) return parts[0].Substring(0, 1).ToUpper();
            return (parts[0].Substring(0, 1) + parts[parts.Length - 1].Substring(0, 1)).ToUpper();
        }
    }
}
