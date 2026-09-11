using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;


namespace Astra_PMS_Final_Exam.tpo
{

    public partial class students : System.Web.UI.Page
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
                return;
            }

            if (!IsPostBack)
            {
                fillgrid();
            }
        }

        void fillgrid()
        {
            con = new SqlConnection(s);
            con.Open();
            da = new SqlDataAdapter("select * from Student_reg_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteStudent")
            {
                string email = e.CommandArgument.ToString();
                con = new SqlConnection(s);
                con.Open();
                SqlCommand cmd = new SqlCommand("delete from Student_reg_tbl where Email=@Email", con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.ExecuteNonQuery();
                con.Close();
                fillgrid();
            }
        }

        protected void SaveStudentBtn_Click(object sender, EventArgs e)
        {
            string originalEmail = studentId.Value; // empty when adding a new student

            con = new SqlConnection(s);
            con.Open();

            if (string.IsNullOrEmpty(originalEmail))
            {
                // Add new student
                SqlCommand cmd = new SqlCommand(
                    "insert into Student_reg_tbl(Full_Name,Email,Password,Phone,Branch,Cgpa,Graduation_Year,Skills) " +
                    "values(@Full_Name,@Email,@Password,@Phone,@Branch,@Cgpa,@Graduation_Year,@Skills)", con);
                cmd.Parameters.AddWithValue("@Full_Name", studentName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", studentEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", "student123");
                cmd.Parameters.AddWithValue("@Phone", studentPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@Branch", studentBranch.SelectedValue);
                cmd.Parameters.AddWithValue("@Cgpa", studentCgpa.Text.Trim());
                cmd.Parameters.AddWithValue("@Graduation_Year", DateTime.Now.Year.ToString());
                cmd.Parameters.AddWithValue("@Skills", string.Empty);
                cmd.ExecuteNonQuery();
            }
            else
            {
                // Update existing student (identified by their original email)
                SqlCommand cmd = new SqlCommand(
                    "update Student_reg_tbl set Full_Name=@Full_Name, Email=@Email, Phone=@Phone, Branch=@Branch, Cgpa=@Cgpa where Email=@OldEmail", con);
                cmd.Parameters.AddWithValue("@Full_Name", studentName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", studentEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Phone", studentPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@Branch", studentBranch.SelectedValue);
                cmd.Parameters.AddWithValue("@Cgpa", studentCgpa.Text.Trim());
                cmd.Parameters.AddWithValue("@OldEmail", originalEmail);
                cmd.ExecuteNonQuery();
            }

            con.Close();
            fillgrid();
        }

    }
}