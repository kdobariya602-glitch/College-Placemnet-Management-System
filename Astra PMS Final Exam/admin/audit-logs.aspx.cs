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
    public partial class audit_logs : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string nm;
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
                getcon();
                da = new SqlDataAdapter("select * from Admin_Login_tbl where Username='" + Session["admin"] + "' or Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Username"].ToString();
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
            if (ddlRole.SelectedValue != "All" && txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select * from Activity_Log_tbl where User_Role='" + ddlRole.SelectedValue + "' and (User_Email like '%" + txtSearch.Text + "%' or Action like '%" + txtSearch.Text + "%' or Module like '%" + txtSearch.Text + "%' or Description like '%" + txtSearch.Text + "%') order by Log_Id desc", con);
            }
            else if (ddlRole.SelectedValue != "All")
            {
                da = new SqlDataAdapter("select * from Activity_Log_tbl where User_Role='" + ddlRole.SelectedValue + "' order by Log_Id desc", con);
            }
            else if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select * from Activity_Log_tbl where (User_Email like '%" + txtSearch.Text + "%' or Action like '%" + txtSearch.Text + "%' or Module like '%" + txtSearch.Text + "%' or Description like '%" + txtSearch.Text + "%') order by Log_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Activity_Log_tbl order by Log_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            gvLogs.DataSource = ds;
            gvLogs.DataBind();
            lblTotalLogs.Text = ds.Tables[0].Rows.Count.ToString();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            fillgrid();
        }

        void clear()
        {
            ddlRole.SelectedValue = "All";
            txtSearch.Text = "";
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            clear();
            fillgrid();
        }

        protected void gvLogs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLogs.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        protected void btnExportLogsCsv_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select * from Activity_Log_tbl order by Log_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            i = ds.Tables[0].Rows.Count;
            Response.Write("<script>alert('Total audit log records: " + i + "');</script>");
        }

        protected void btnClearOldLogs_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("delete from Activity_Log_tbl where Log_Id not in (select top 50 Log_Id from Activity_Log_tbl order by Log_Id desc)", con);
            i = cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Old logs cleared successfully!');</script>");
            fillgrid();
        }
    }
}
