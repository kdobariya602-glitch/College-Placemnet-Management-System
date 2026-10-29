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
    public partial class selections : System.Web.UI.Page
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
                    filldropdowns();
                    fillstats();
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void filldropdowns()
        {
            getcon();
            da = new SqlDataAdapter("select * from Student_Reg_tbl order by Full_Name", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlSelStudent.DataSource = ds;
            ddlSelStudent.DataTextField = "Full_Name";
            ddlSelStudent.DataValueField = "Email";
            ddlSelStudent.DataBind();

            da = new SqlDataAdapter("select * from Company_reg_tbl order by Company_Name", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlSelCompany.DataSource = ds;
            ddlSelCompany.DataTextField = "Company_Name";
            ddlSelCompany.DataValueField = "Email";
            ddlSelCompany.DataBind();
        }

        void fillstats()
        {
            getcon();
            da = new SqlDataAdapter("select * from Selection_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalSelected.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Selection_tbl where Offer_Status = 'Offer Issued' or Offer_Status = 'Accepted'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblOffersIssued.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Selection_tbl where Joining_Status = 'Joined'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblCandidatesJoined.Text = ds.Tables[0].Rows.Count.ToString();
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from Selection_tbl order by Selection_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvSelections.DataSource = ds;
            gvSelections.DataBind();
        }

        protected void gvSelections_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSelections.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        protected void gvSelections_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string selection_id = e.CommandArgument.ToString();

            if (e.CommandName == "mark_joined")
            {
                getcon();
                da = new SqlDataAdapter("select * from Selection_tbl where Selection_Id = '" + selection_id + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string stemail = "", compname = "", jtitle = "", pkg = "", sname = "", enroll = "", dept = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    stemail = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                    compname = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                    jtitle = ds.Tables[0].Rows[0]["Job_Title"].ToString();
                    pkg = ds.Tables[0].Rows[0]["Package_CTC"].ToString();
                    sname = ds.Tables[0].Rows[0]["Student_Name"].ToString();
                    enroll = ds.Tables[0].Rows[0]["Enrollment_No"].ToString();
                    dept = ds.Tables[0].Rows[0]["Department"].ToString();
                }

                getcon();
                cmd = new SqlCommand("update Selection_tbl set Offer_Status = 'Joined', Joining_Status = 'Joined', Joining_Date = getdate(), Remarks = 'Candidate verified as joined company.' where Selection_Id = '" + selection_id + "'", con);
                cmd.ExecuteNonQuery();

                getcon();
                cmd = new SqlCommand("update Student_Reg_tbl set Placement_Status = 'Placed' where Email = '" + stemail + "'", con);
                cmd.ExecuteNonQuery();

                // Synchronize into Placement_History_tbl
                da = new SqlDataAdapter("select Course, Batch from Student_Reg_tbl where Email='" + stemail + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string scourse = "", sbatch = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    scourse = ds.Tables[0].Rows[0]["Course"].ToString();
                    sbatch = ds.Tables[0].Rows[0]["Batch"].ToString();
                }

                da = new SqlDataAdapter("select * from Placement_History_tbl where Student_Email='" + stemail + "' and Company_Name='" + compname + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count == 0)
                {
                    cmd = new SqlCommand("insert into Placement_History_tbl(Student_Email, Student_Name, Enrollment_No, Department, Course, Batch, Company_Name, Job_Title, Package_CTC, Selection_Date, Joining_Date, Joining_Status, Academic_Year, Placement_Season, Created_Date) values('" + stemail + "', '" + sname + "', '" + enroll + "', '" + dept + "', '" + scourse + "', '" + sbatch + "', '" + compname + "', '" + jtitle + "', '" + pkg + "', GETDATE(), GETDATE(), 'Joined', '" + sbatch + "', 'Campus " + sbatch + "', GETDATE())", con);
                    cmd.ExecuteNonQuery();
                }

                // Notify candidate
                cmd = new SqlCommand("insert into Notification_tbl (Recipient_Role, Recipient_Email, Title, Message, Notification_Type, Is_Read, Created_Date) values ('Student', '" + stemail + "', 'Joining Confirmed', 'Congratulations! Your joining at " + compname + " has been verified and recorded in the Placement History.', 'Offer', 0, GETDATE())", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Candidate marked as Joined and placement history synchronized.');</script>");
                fillstats();
                fillgrid();
            }
            else if (e.CommandName == "delete_selection")
            {
                getcon();
                cmd = new SqlCommand("delete from Selection_tbl where Selection_Id = '" + selection_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Selection record removed.');</script>");
                fillstats();
                fillgrid();
            }
        }

        protected void btnSaveSelection_Click(object sender, EventArgs e)
        {
            if (txtSelJobTitle.Text != "" && txtSelPackage.Text != "")
            {
                getcon();
                string semail = ddlSelStudent.SelectedValue;
                string cemail = ddlSelCompany.SelectedValue;
                string cname = "";
                if (ddlSelCompany.SelectedItem != null)
                {
                    cname = ddlSelCompany.SelectedItem.Text;
                }

                da = new SqlDataAdapter("select Full_Name, Enrollment_No, Branch from Student_Reg_tbl where Email = '" + semail + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string sname = "", enroll = "", dept = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sname = ds.Tables[0].Rows[0]["Full_Name"].ToString();
                    enroll = ds.Tables[0].Rows[0]["Enrollment_No"].ToString();
                    dept = ds.Tables[0].Rows[0]["Branch"].ToString();
                }

                string offDateSql = "GETDATE()";
                if (txtSelOfferDate.Text != "")
                {
                    offDateSql = "'" + txtSelOfferDate.Text + "'";
                }

                string joinDateSql = "NULL";
                if (txtSelJoiningDate.Text != "")
                {
                    joinDateSql = "'" + txtSelJoiningDate.Text + "'";
                }

                getcon();
                cmd = new SqlCommand("insert into Selection_tbl (Application_Id, Job_Id, Drive_Id, Company_Email, Company_Name, Job_Title, Student_Email, Student_Name, Enrollment_No, Department, Package_CTC, Selection_Date, Offer_Status, Offer_Date, Joining_Date, Joining_Status, Created_Date) values (0, 0, 0, '" + cemail + "', '" + cname + "', '" + txtSelJobTitle.Text + "', '" + semail + "', '" + sname + "', '" + enroll + "', '" + dept + "', '" + txtSelPackage.Text + "', GETDATE(), 'Offer Issued', " + offDateSql + ", " + joinDateSql + ", 'Pending', GETDATE())", con);
                cmd.ExecuteNonQuery();

                getcon();
                cmd = new SqlCommand("update Student_Reg_tbl set Placement_Status = 'Placed' where Email = '" + semail + "'", con);
                cmd.ExecuteNonQuery();

                clear();
                Response.Write("<script>alert('Placement selection recorded successfully!');</script>");
                fillstats();
                fillgrid();
            }
            else
            {
                Response.Write("<script>alert('Please fill in all required fields.');</script>");
            }
        }

        void clear()
        {
            txtSelJobTitle.Text = "";
            txtSelPackage.Text = "";
            txtSelOfferDate.Text = "";
            txtSelJoiningDate.Text = "";
        }
    }
}
