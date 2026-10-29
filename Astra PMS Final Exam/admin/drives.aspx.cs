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

    public partial class drives : System.Web.UI.Page

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

            da = new SqlDataAdapter("select Company_Name, Email from Company_reg_tbl order by Company_Name", con);

            ds = new DataSet();

            da.Fill(ds);

            ddlNewDriveCompany.DataSource = ds;

            ddlNewDriveCompany.DataTextField = "Company_Name";

            ddlNewDriveCompany.DataValueField = "Email";

            ddlNewDriveCompany.DataBind();

            da = new SqlDataAdapter("select Season_Name from Placement_Season_tbl order by Season_Id desc", con);

            ds = new DataSet();

            da.Fill(ds);

            ddlNewDriveSeason.DataSource = ds;

            ddlNewDriveSeason.DataTextField = "Season_Name";

            ddlNewDriveSeason.DataValueField = "Season_Name";

            ddlNewDriveSeason.DataBind();

            if (ddlNewDriveSeason.Items.Count == 0)

            {

                ddlNewDriveSeason.Items.Add(new ListItem("Campus Placement Season 2026-2027", "Campus Placement Season 2026-2027"));

                ddlNewDriveSeason.Items.Add(new ListItem("Winter Placement Season 2026", "Winter Placement Season 2026"));

                ddlNewDriveSeason.Items.Add(new ListItem("Summer Internship Drive 2026", "Summer Internship Drive 2026"));

            }

        }

                public string FormatAppWindow(object opening, object closing)
        {
            if (opening != null && closing != null && opening != DBNull.Value && closing != DBNull.Value && opening.ToString() != "" && closing.ToString() != "")
            {
                return Convert.ToDateTime(opening).ToString("dd MMM") + " to " + Convert.ToDateTime(closing).ToString("dd MMM yyyy");
            }
            return "Active Now";
        }

        public string FormatDriveDate(object driveDate)
        {
            if (driveDate != null && driveDate != DBNull.Value && driveDate.ToString() != "")
            {
                return Convert.ToDateTime(driveDate).ToString("dd MMM yyyy");
            }
            return "Date TBA";
        }

        void fillgrid()

        {

            getcon();

            

            if (txtSearch.Text != "")

            {

                da = new SqlDataAdapter("select * from Placement_Drive_tbl where Drive_Name='" + txtSearch.Text + "' or Company_Name='" + txtSearch.Text + "' or Job_Title='" + txtSearch.Text + "' order by Drive_Id desc", con);

            }

            else if (ddlStatusFilter.SelectedValue != "")

            {

                da = new SqlDataAdapter("select * from Placement_Drive_tbl where Status = '" + ddlStatusFilter.SelectedValue + "' order by Drive_Id desc", con);

            }

            else

            {

                da = new SqlDataAdapter("select * from Placement_Drive_tbl order by Drive_Id desc", con);

            }

            ds = new DataSet();

            da.Fill(ds);

            gvDrives.DataSource = ds;

            gvDrives.DataBind();

            lblCount.Text = ds.Tables[0].Rows.Count.ToString();

        }

        protected void Filter_Changed(object sender, EventArgs e)

        {

            gvDrives.PageIndex = 0;

            fillgrid();

        }

        protected void gvDrives_PageIndexChanging(object sender, GridViewPageEventArgs e)

        {

            gvDrives.PageIndex = e.NewPageIndex;

            fillgrid();

        }

        protected void btnSearch_Click(object sender, EventArgs e)

        {

            fillgrid();

        }

        protected void btnReset_Click(object sender, EventArgs e)

        {

            txtSearch.Text = "";

            ddlStatusFilter.SelectedIndex = 0;

            fillgrid();

        }

        protected void gvDrives_RowCommand(object sender, GridViewCommandEventArgs e)

        {

            int did = Convert.ToInt32(e.CommandArgument); ViewState["did"] = did;

            if (e.CommandName == "view_drive") { Session["did"] = did; Response.Redirect("drive-details.aspx"); } else if (e.CommandName == "toggle_status")

            {

                getcon();

                cmd = new SqlCommand("update Placement_Drive_tbl set Status = case when Status = 'Open' then 'Closed' else 'Open' end where Drive_Id = '" + did + "'", con);

                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Drive status updated.');</script>");

                fillgrid();

            }

            else if (e.CommandName == "delete_drive")

            {

                getcon();

                cmd = new SqlCommand("delete from Placement_Drive_tbl where Drive_Id = '" + did + "'", con);

                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Drive deleted successfully.');</script>");

                fillgrid();

            }

        }

                

        

        protected void btnAdminAiDraftDrive_Click(object sender, EventArgs e)
        {
            string driveTopic = !string.IsNullOrEmpty(txtAdminAiDrivePrompt.Text) ? txtAdminAiDrivePrompt.Text.Trim() : "University Campus Recruitment 2026";
            txtNewDriveName.Text = driveTopic;
            txtNewDriveJobTitle.Text = "Associate Software Engineer";
            txtNewDriveVenue.Text = "Central Auditorium & Computer Labs 1-4";
            txtNewDriveInstructions.Text = "Mandatory formal dress code, 2 copies of updated resume, college ID card, reporting 15 mins early.";
            txtNewDriveTime.Text = "09:30 AM";
            txtNewDriveDate.Text = DateTime.Now.AddDays(14).ToString("yyyy-MM-dd");
            txtNewDriveOpenDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtNewDriveCloseDate.Text = DateTime.Now.AddDays(7).ToString("yyyy-MM-dd");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "PopAdminDriveModal", "var m = new bootstrap.Modal(document.getElementById('modalCreateDrive')); m.show();", true);
        }

        private string GetDefaultInstructions(string driveTopic)

        {

            return "Official Guidelines for Candidates appearing in " + driveTopic + ":\n" +

                   "1. Attire: Strict formal university placement dress code.\n" +

                   "2. Checklist: 2 printed copies of verified ATS resume, Government ID proof, Astra University ID card.\n" +

                   "3. Protocol: Electronic gadgets/smartphones prohibited inside evaluation halls.\n" +

                   "4. Attendance: Mandatory physical biometric registration at Central Auditorium entrance.";

        }

        protected void btnSaveDrive_Click(object sender, EventArgs e)

        {

            getcon();

            string dDate = "NULL";

            if (txtNewDriveDate.Text != "")

            {

                dDate = "'" + txtNewDriveDate.Text + "'";

            }

            string opDate = "NULL";

            if (txtNewDriveOpenDate.Text != "")

            {

                opDate = "'" + txtNewDriveOpenDate.Text + "'";

            }

            string clDate = "NULL";

            if (txtNewDriveCloseDate.Text != "")

            {

                clDate = "'" + txtNewDriveCloseDate.Text + "'";

            }

            string compEmail = ddlNewDriveCompany.SelectedValue;

            string compName = ddlNewDriveCompany.SelectedItem != null ? ddlNewDriveCompany.SelectedItem.Text : "Corporate Partner";

            cmd = new SqlCommand("insert into Placement_Drive_tbl (Drive_Name, Company_Email, Company_Name, Job_Title, Season_Name, Drive_Date, Drive_Time, Venue, Mode, Meeting_Link, App_Opening, App_Closing, Instructions, Status, Created_Date) values ('" + txtNewDriveName.Text + "', '" + compEmail + "', '" + compName + "', '" + txtNewDriveJobTitle.Text + "', '" + ddlNewDriveSeason.SelectedValue + "', " + dDate + ", '" + txtNewDriveTime.Text + "', '" + txtNewDriveVenue.Text + "', '" + ddlNewDriveMode.SelectedValue + "', '" + txtNewDriveLink.Text + "', " + opDate + ", " + clDate + ", '" + txtNewDriveInstructions.Text + "', 'Open', GETDATE())", con);

            cmd.ExecuteNonQuery();

            clear();

            Response.Write("<script>alert('Placement drive scheduled and published successfully!');</script>");

            fillgrid();

        }

        void clear()

        {

            txtNewDriveName.Text = "";

            txtNewDriveJobTitle.Text = "";

            txtNewDriveDate.Text = "";

            txtNewDriveTime.Text = "";

            txtNewDriveVenue.Text = "";

            txtNewDriveLink.Text = "";

            txtNewDriveOpenDate.Text = "";

            txtNewDriveCloseDate.Text = "";

            txtNewDriveInstructions.Text = "";

            txtAdminAiDrivePrompt.Text = "";

        }

    }

}

