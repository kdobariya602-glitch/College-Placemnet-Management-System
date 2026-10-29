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
    public partial class Placement_Configuration : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from Academic_Year_tbl order by Year_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            gvAcademicYears.DataSource = ds;
            gvAcademicYears.DataBind();
        }

        protected void btnSaveYear_Click(object sender, EventArgs e)
        {
            if (txtYearName.Text != "")
            {
                string sDate = "GETDATE()";
                if (txtStartDate.Text != "")
                {
                    sDate = "'" + txtStartDate.Text + "'";
                }

                string eDate = "DATEADD(year, 1, GETDATE())";
                if (txtEndDate.Text != "")
                {
                    eDate = "'" + txtEndDate.Text + "'";
                }

                getcon();
                cmd = new SqlCommand("insert into Academic_Year_tbl (Year_Name, Start_Date, End_Date, Is_Current, Status, Created_Date) values ('" + txtYearName.Text + "', " + sDate + ", " + eDate + ", 0, 'Active', GETDATE())", con);
                cmd.ExecuteNonQuery();

                clear();
                Response.Write("<script>alert('Academic Year configured successfully.');</script>");
                fillgrid();
            }
            else
            {
                Response.Write("<script>alert('Please provide an academic year name.');</script>");
            }
        }

        void clear()
        {
            txtYearName.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
        }

        protected void gvAcademicYears_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string year_id = e.CommandArgument.ToString();

            if (e.CommandName == "set_current")
            {
                getcon();
                cmd = new SqlCommand("update Academic_Year_tbl set Is_Current=0", con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("update Academic_Year_tbl set Is_Current=1 where Year_Id='" + year_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Current active academic year updated.');</script>");
                fillgrid();
            }
            else if (e.CommandName == "toggle_status")
            {
                getcon();
                cmd = new SqlCommand("update Academic_Year_tbl set Status = case when Status='Active' then 'Archived' else 'Active' end where Year_Id='" + year_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Academic year status toggled.');</script>");
                fillgrid();
            }
        }
    }
}
