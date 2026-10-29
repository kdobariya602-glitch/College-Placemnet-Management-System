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
    public partial class notices : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from Notice_tbl", con);
            ds = new DataSet();
            da.Fill(ds);

            gvNotices.DataSource = ds;
            gvNotices.DataBind();
        }

        protected void gvNotices_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNotices.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        protected void gvNotices_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string notice_id = e.CommandArgument.ToString();

            if (e.CommandName == "toggle_status")
            {
                getcon();
                cmd = new SqlCommand("update Notice_tbl set Status = case when Status='Active' then 'Inactive' else 'Active' end where Notice_Id='" + notice_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Notice Status Updated!');</script>");
                fillgrid();
            }
            else if (e.CommandName == "delete_notice")
            {
                getcon();
                cmd = new SqlCommand("delete from Notice_tbl where Notice_Id='" + notice_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Notice Deleted Successfully!');</script>");
                fillgrid();
            }
        }

        protected void btnSaveNotice_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Notice_tbl (Title, Category, Description, Target_Audience, Department, Batch, Priority, Status, Created_By) values ('" + txtNewNoticeTitle.Text + "', '" + ddlNoticeCategory.SelectedValue + "', '" + txtNoticeDesc.Text + "', '" + ddlNoticeAudience.SelectedValue + "', '" + txtNoticeDept.Text + "', '" + txtNoticeBatch.Text + "', '" + ddlNoticePriority.SelectedValue + "', 'Active', 'Admin')", con);
            cmd.ExecuteNonQuery();

            clear();
            Response.Write("<script>alert('Notice Published Successfully!');</script>");
            fillgrid();
        }

        void clear()
        {
            txtNewNoticeTitle.Text = "";
            txtNoticeDesc.Text = "";
            txtNoticeDept.Text = "";
            txtNoticeBatch.Text = "";
        }
    }
}
