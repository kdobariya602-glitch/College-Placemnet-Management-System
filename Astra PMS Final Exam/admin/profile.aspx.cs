using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam.admin
{
    public partial class profile : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        void LoadProfile()
        {
            string adminEmail = Session["admin"].ToString();

            using (SqlConnection con = new SqlConnection(s))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from Admin_Login_tbl where Email=@Email", con);
                cmd.Parameters.AddWithValue("@Email", adminEmail);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    if (dt.Columns.Contains("Name") && row["Name"] != DBNull.Value)
                    {
                        lblName.Text = row["Name"].ToString();
                    }
                    else
                    {
                        lblName.Text = "Admin";
                    }

                    if (dt.Columns.Contains("Email") && row["Email"] != DBNull.Value)
                    {
                        lblEmail.Text = row["Email"].ToString();
                    }
                    else
                    {
                        lblEmail.Text = adminEmail;
                    }
                }
                else
                {
                    lblName.Text = "Admin";
                    lblEmail.Text = adminEmail;
                }
            }

            lblRole.Text = "Administrator";
        }
    }
}
