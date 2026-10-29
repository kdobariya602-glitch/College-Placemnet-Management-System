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
    public partial class training : System.Web.UI.Page
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
            fillprograms();
            fillsessions();
            fillparticipants();
        }

        void clear()
        {
            clearprogram();
            clearsession();
        }

        void fillprograms()
        {
            getcon();
            da = new SqlDataAdapter("select * from Training_Program_tbl order by Program_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            gvPrograms.DataSource = ds;
            gvPrograms.DataBind();

            ddlSessionProgram.DataSource = ds;
            ddlSessionProgram.DataTextField = "Program_Name";
            ddlSessionProgram.DataValueField = "Program_Id";
            ddlSessionProgram.DataBind();
        }

        void fillsessions()
        {
            getcon();
            da = new SqlDataAdapter("select * from Training_Session_tbl order by Session_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvSessions.DataSource = ds;
            gvSessions.DataBind();
        }

        void fillparticipants()
        {
            getcon();
            da = new SqlDataAdapter("select * from Training_Participant_tbl order by Participant_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvParticipants.DataSource = ds;
            gvParticipants.DataBind();
        }

        protected void gvPrograms_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int progid = Convert.ToInt32(e.CommandArgument);
            ViewState["progid"] = progid;

            if (e.CommandName == "delete_program")
            {
                getcon();
                cmd = new SqlCommand("delete from Training_Program_tbl where Program_Id = '" + progid + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Training Program Deleted Successfully!');</script>");
                fillprograms();
            }
        }

        protected void gvSessions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int progid = Convert.ToInt32(e.CommandArgument);
            ViewState["progid"] = progid;

            if (e.CommandName == "delete_session")
            {
                getcon();
                cmd = new SqlCommand("delete from Training_Session_tbl where Session_Id = '" + progid + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Session Deleted Successfully!');</script>");
                fillsessions();
            }
        }

        protected void gvParticipants_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int progid = Convert.ToInt32(e.CommandArgument); 
            ViewState["progid"] = progid;

            if (e.CommandName == "mark_full")
            {
                getcon();
                cmd = new SqlCommand("update Training_Participant_tbl set Attendance_Pct = '100', Completion_Status = 'Completed', Certificate_Issued = 'Yes' where Participant_Id = '" + progid + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Attendance Updated Successfully!');</script>");
                fillparticipants();
            }
        }

        protected void btnSaveProgram_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Training_Program_tbl (Program_Name, Category, Description, Trainer_Name, Organization, Start_Date, End_Date, Duration, Status, Created_Date) values ('" + txtNewProgName.Text + "', '" + ddlNewProgCategory.SelectedValue + "', '" + txtNewProgDesc.Text + "', '" + txtNewProgTrainer.Text + "', '" + txtNewProgOrg.Text + "', '" + txtNewProgStart.Text + "', '" + txtNewProgEnd.Text + "', '" + txtNewProgDuration.Text + "', 'Active', GETDATE())", con);
            cmd.ExecuteNonQuery();

            clearprogram();
            Response.Write("<script>alert('Training Program Added Successfully!');</script>");
            fillprograms();
        }

        protected void btnSaveSession_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Training_Session_tbl (Program_Id, Session_Title, Topic, Session_Date, Start_Time, End_Time, Status, Created_Date) values ('" + ddlSessionProgram.SelectedValue + "', '" + txtNewSessTitle.Text + "', '" + txtNewSessTopic.Text + "', '" + txtNewSessDate.Text + "', '" + txtNewSessStart.Text + "', '" + txtNewSessEnd.Text + "', 'Completed', GETDATE())", con);
            cmd.ExecuteNonQuery();

            clearsession();
            Response.Write("<script>alert('Training Session Added Successfully!');</script>");
            fillsessions();
        }

        void clearprogram()
        {
            txtNewProgName.Text = "";
            txtNewProgTrainer.Text = "";
            txtNewProgOrg.Text = "";
            txtNewProgDuration.Text = "";
            txtNewProgDesc.Text = "";
        }

        void clearsession()
        {
            txtNewSessTitle.Text = "";
            txtNewSessTopic.Text = "";
            txtNewSessDate.Text = "";
            txtNewSessStart.Text = "";
            txtNewSessEnd.Text = "";
        }
    }
}
