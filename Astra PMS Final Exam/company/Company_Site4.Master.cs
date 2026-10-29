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
    public partial class Company_Site4 : System.Web.UI.MasterPage
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
            if (Session["company"] != null)
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
            litDropdownEmail.Text = Session["company"].ToString();
            getcon();
            da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                litHeaderUserName.Text = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                string navPhoto = ds.Tables[0].Rows[0]["Logo_File"] != DBNull.Value ? ds.Tables[0].Rows[0]["Logo_File"].ToString() : "";
                if (!string.IsNullOrEmpty(navPhoto) && System.IO.File.Exists(Server.MapPath("~/uploads/profiles/" + navPhoto)))
                {
                    litAvatarInitials.Text = "<img src='../uploads/profiles/" + navPhoto + "' style='width:100%; height:100%; border-radius:50%; object-fit:cover;' />";
                }
            }

            da = new SqlDataAdapter("select count(*) from Notification_tbl where (Recipient_Email='" + Session["company"] + "' or Recipient_Email='ALL') and (Is_Read=0 or Is_Read is null)", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0 && Convert.ToInt32(ds.Tables[0].Rows[0][0]) > 0)
            {
                litNotifBadge.Text = "<span class=\"position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger border border-light\" style=\"font-size:0.65rem;\">" + ds.Tables[0].Rows[0][0].ToString() + "</span>";
            }
        }
    }
}
