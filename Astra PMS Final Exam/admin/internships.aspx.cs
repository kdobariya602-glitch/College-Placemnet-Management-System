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
    public partial class internships : System.Web.UI.Page
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
            fillcompanies();
            fillinternships();
            fillinternapps();
        }

        void fillcompanies()
        {
            getcon();
            da = new SqlDataAdapter("select Company_Name, Email from Company_reg_tbl order by Company_Name", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlIntCompany.DataSource = ds;
            ddlIntCompany.DataTextField = "Company_Name";
            ddlIntCompany.DataValueField = "Email";
            ddlIntCompany.DataBind();
        }

        void fillinternships()
        {
            getcon();
            da = new SqlDataAdapter("select * from Internship_tbl order by Internship_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvInternships.DataSource = ds;
            gvInternships.DataBind();
        }

        void fillinternapps()
        {
            getcon();
            da = new SqlDataAdapter("select * from Internship_Application_tbl order by Internship_App_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvInternApps.DataSource = ds;
            gvInternApps.DataBind();
        }

        protected void gvInternships_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string internship_id = e.CommandArgument.ToString();

            if (e.CommandName == "toggle_status")
            {
                getcon();
                cmd = new SqlCommand("update Internship_tbl set Status = case when Status = 'Published' then 'Closed' else 'Published' end where Internship_Id = '" + internship_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Status updated.');</script>");
                fillinternships();
            }
            else if (e.CommandName == "delete_internship")
            {
                getcon();
                cmd = new SqlCommand("delete from Internship_tbl where Internship_Id = '" + internship_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Internship deleted.');</script>");
                fillinternships();
            }
        }

        protected void gvInternApps_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string internship_app_id = e.CommandArgument.ToString();

            if (e.CommandName == "select_app")
            {
                getcon();
                cmd = new SqlCommand("update Internship_Application_tbl set Status = 'Selected', Remarks = 'Selected for internship opportunity.' where Internship_App_Id = '" + internship_app_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Candidate selected for internship.');</script>");
                fillinternapps();
            }
            else if (e.CommandName == "reject_app")
            {
                getcon();
                cmd = new SqlCommand("update Internship_Application_tbl set Status = 'Rejected', Remarks = 'Application not accepted.' where Internship_App_Id = '" + internship_app_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Application rejected.');</script>");
                fillinternapps();
            }
        }

        protected void btnSaveInternship_Click(object sender, EventArgs e)
        {
            if (txtNewIntTitle.Text != "")
            {
                string compName = "";
                if (ddlIntCompany.SelectedItem != null)
                {
                    compName = ddlIntCompany.SelectedItem.Text;
                }
                getcon();
                cmd = new SqlCommand("insert into Internship_tbl (Internship_Title, Company_Email, Company_Name, Stipend, Duration, Work_Mode, Location, Deadline, Required_Skills, Description, Status, Created_Date) values ('" + txtNewIntTitle.Text + "', '" + ddlIntCompany.SelectedValue + "', '" + compName + "', '" + txtNewIntStipend.Text + "', '" + txtNewIntDuration.Text + "', '" + ddlNewIntMode.SelectedValue + "', '" + txtNewIntLoc.Text + "', '" + txtNewIntDeadline.Text + "', '" + txtNewIntSkills.Text + "', '" + txtNewIntDesc.Text + "', 'Published', GETDATE())", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Internship published successfully!');</script>");
                clear();
                fillinternships();
            }
            else
            {
                Response.Write("<script>alert('Internship title is required.');</script>");
            }
        }

        void clear()
        {
            txtNewIntTitle.Text = "";
            txtNewIntStipend.Text = "";
            txtNewIntDuration.Text = "";
            txtNewIntLoc.Text = "";
            txtNewIntDeadline.Text = "";
            txtNewIntSkills.Text = "";
            txtNewIntDesc.Text = "";
        }
    }
}
