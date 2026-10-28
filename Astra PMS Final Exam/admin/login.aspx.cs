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
            cmd = new SqlCommand("select * from Admin_Login_tbl where Email=@Email and Password=@Password", con);
            cmd.Parameters.AddWithValue("@Email", email.Text);
            cmd.Parameters.AddWithValue("@Password", password.Text);

            SqlDataReader dr = cmd.ExecuteReader();


            if (dr.Read())
            {
                Session["admin"] = email.Text;

                // Best-effort display name for the client-side UI layer (sidebar/navbar avatar).
                // This does not affect authentication, which remains fully DB-driven above.
                string displayName = "Admin";
                try
                {
                    if (HasColumn(dr, "Name") && dr["Name"] != DBNull.Value)
                    {
                        displayName = dr["Name"].ToString();
                    }
                }
                catch { /* ignore, fall back to default */ }

                dr.Close();
                con.Close();

                string safeName = displayName.Replace("'", "\\'");
                string safeEmail = email.Text.Replace("'", "\\'");

                Response.Write("<script>" +
                    "try{sessionStorage.setItem('pms_session', JSON.stringify({id:'admin1', name:'" + safeName + "', email:'" + safeEmail + "', role:'admin'}));}catch(e){}" +
                    "window.location.href='dashboard.aspx';" +
                    "</script>");
                Response.End();
            }
            else
            {
                dr.Close();
                con.Close();
                Response.Write("<script>alert('Invalid credentials');</script>");
            }

        }

        static bool HasColumn(SqlDataReader r, string columnName)
        {
            for (int i = 0; i < r.FieldCount; i++)
            {
                if (r.GetName(i).Equals(columnName, StringComparison.OrdinalIgnoreCase)) return true;
            }
            return false;
        }
    }
}