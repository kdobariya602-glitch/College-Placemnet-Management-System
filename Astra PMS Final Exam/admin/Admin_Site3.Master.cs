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
    public partial class Admin_Site3 : System.Web.UI.MasterPage
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
            if (Session["admin"] != null)
            {
                if (!IsPostBack)
                {
                    filldata();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void filldata()
        {
            litDropdownEmail.Text = Session["admin"].ToString();
            getcon();
            da = new SqlDataAdapter("select * from Admin_Login_tbl where Email='" + Session["admin"] + "' or Username='" + Session["admin"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                string fn = ds.Tables[0].Rows[0]["Full_Name"].ToString();
                if (fn != "")
                {
                    litHeaderUserName.Text = fn;
                string navPhoto = ds.Tables[0].Rows[0]["Photo"] != DBNull.Value ? ds.Tables[0].Rows[0]["Photo"].ToString() : "";
                if (!string.IsNullOrEmpty(navPhoto) && System.IO.File.Exists(Server.MapPath("~/uploads/profiles/" + navPhoto)))
                {
                    litAvatarInitials.Text = "<img src='../uploads/profiles/" + navPhoto + "' style='width:100%; height:100%; border-radius:50%; object-fit:cover;' />";
                }
                }
                else
                {
                    litHeaderUserName.Text = "Administrator";
                }
            }
        }
    }
}
