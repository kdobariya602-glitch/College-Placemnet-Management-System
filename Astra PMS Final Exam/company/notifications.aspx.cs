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
    public partial class notifications : System.Web.UI.Page
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
                getcon();
                da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                }

                if (!IsPostBack)
                {
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from Notification_tbl where Recipient_Email='" + Session["company"] + "' or Recipient_Email='ALL' order by Notification_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            gvNotifications.DataSource = ds;
            gvNotifications.DataBind();
            lblUnreadCount.Text = ds.Tables[0].Rows.Count + " Notifications";
        }

        protected void btnMarkAllRead_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Notification_tbl set Is_Read=1 where Recipient_Email='" + Session["company"] + "' or Recipient_Email='ALL'", con);
            cmd.ExecuteNonQuery();

            fillgrid();
        }

        protected void gvNotifications_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MarkAsRead")
            {
                getcon();
                cmd = new SqlCommand("update Notification_tbl set Is_Read=1 where Notification_Id='" + e.CommandArgument + "' and (Recipient_Email='" + Session["company"] + "' or Recipient_Email='ALL')", con);
                cmd.ExecuteNonQuery();

                fillgrid();
            }
        }
    }
}
