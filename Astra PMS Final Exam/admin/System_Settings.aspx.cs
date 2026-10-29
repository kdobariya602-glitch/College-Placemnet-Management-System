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
    public partial class System_Settings : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from System_Settings_tbl order by Setting_Id asc", con);
            ds = new DataSet();
            da.Fill(ds);

            gvSettings.DataSource = ds;
            gvSettings.DataBind();
        }

        void clear()
        {
            hfSettingId.Value = "";
            txtSettingName.Text = "";
            txtSettingValue.Text = "";
            txtDescription.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (hfSettingId.Value != "" && txtSettingValue.Text != "")
            {
                getcon();
                cmd = new SqlCommand("update System_Settings_tbl set Setting_Value='" + txtSettingValue.Text + "', Description='" + txtDescription.Text + "', Updated_Date=GETDATE() where Setting_Id='" + hfSettingId.Value + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Setting updated successfully.');</script>");
                clear();
                fillgrid();
            }
            else
            {
                Response.Write("<script>alert('Please select a setting to edit and enter a value.');</script>");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void btnResetDefaults_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand(@"
                delete from System_Settings_tbl;
                insert into System_Settings_tbl (Setting_Name, Setting_Value, Description, Updated_Date) values
                ('College_Name', 'Astra Institute of Technology', 'Institution Name for Placement Records & Letters', GETDATE()),
                ('TPO_Email', 'tpo@astra.edu.in', 'Official TPO Cell Contact Email Address', GETDATE()),
                ('TPO_Contact', '+91 98765 43210', 'Placement Coordination Helpline Number', GETDATE()),
                ('Current_Academic_Year', '2026-2027', 'Active Campus Placement Cohort Session', GETDATE()),
                ('Placement_Policy', 'One Student One Job (Dream Job offer > 10 LPA eligible)', 'Institutional placement offer policy guideline', GETDATE()),
                ('Default_Min_CGPA', '6.0', 'Default minimum eligibility CGPA threshold', GETDATE()),
                ('Max_Allowed_Backlogs', '0', 'Standard maximum active backlogs permitted across drives', GETDATE());
            ", con);
            cmd.ExecuteNonQuery();

            Response.Write("<script>alert('System settings reset to default values.');</script>");
            clear();
            fillgrid();
        }

        protected void gvSettings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string setting_id = e.CommandArgument.ToString();

            if (e.CommandName == "edit_setting")
            {
                getcon();
                da = new SqlDataAdapter("select * from System_Settings_tbl where Setting_Id='" + setting_id + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    hfSettingId.Value = ds.Tables[0].Rows[0]["Setting_Id"].ToString();
                    txtSettingName.Text = ds.Tables[0].Rows[0]["Setting_Name"].ToString();
                    txtSettingValue.Text = ds.Tables[0].Rows[0]["Setting_Value"].ToString();
                    txtDescription.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                }
            }
        }
    }
}
