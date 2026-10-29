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
    public partial class company_details : System.Web.UI.Page
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
                getcon();
                da = new SqlDataAdapter("select * from Admin_Login_tbl where Username='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Username"].ToString();
                }

                if (Session["cid"] != null) { ViewState["cid"] = Session["cid"]; }

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
            getcon();
            if (ViewState["cid"] != null && ViewState["cid"].ToString() != "")
            {
                da = new SqlDataAdapter("select * from Company_reg_tbl where Company_Id='" + ViewState["cid"] + "' or Email='" + ViewState["cid"] + "'", con);
            }
            else
            {
                da = new SqlDataAdapter("select top 1 * from Company_reg_tbl order by Company_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                ViewState["cid"] = ds.Tables[0].Rows[0]["Company_Id"].ToString();
                Session["cid"] = ViewState["cid"];

                lblCompanyName.Text = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblPhone.Text = ds.Tables[0].Rows[0]["Contact_Number"].ToString();

                string web = ds.Tables[0].Rows[0]["Website"].ToString();
                lnkWebsite.InnerText = web;
                lnkWebsite.HRef = web.StartsWith("http") ? web : "https://" + web;
                litWebsite.Text = web;

                lblLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                lblIndustry.Text = ds.Tables[0].Rows[0]["Industry"].ToString();
                lblVerificationStatus.Text = ds.Tables[0].Rows[0]["Verification_Status"].ToString();
                lblDescription.Text = ds.Tables[0].Rows[0]["Company_Description"].ToString();
                lblHRName.Text = ds.Tables[0].Rows[0]["HR_Name"].ToString();

                if (ds.Tables[0].Columns.Contains("Remarks") && ds.Tables[0].Rows[0]["Remarks"] != DBNull.Value)
                {
                    txtAdminRemarks.Text = ds.Tables[0].Rows[0]["Remarks"].ToString();
                }

                if (ddlUpdateVerification.Items.FindByValue(lblVerificationStatus.Text) != null)
                {
                    ddlUpdateVerification.SelectedValue = lblVerificationStatus.Text;
                }

                string compEmail = ds.Tables[0].Rows[0]["Email"].ToString();

                da = new SqlDataAdapter("select * from Job_tbl where Company_Email='" + compEmail + "' order by Job_Id desc", con);
                DataSet dsJobs = new DataSet();
                da.Fill(dsJobs);
                gvJobs.DataSource = dsJobs;
                gvJobs.DataBind();
                lblJobCount.Text = dsJobs.Tables[0].Rows.Count.ToString();

                da = new SqlDataAdapter("select * from Placement_Drive_tbl where Company_Email='" + compEmail + "' order by Drive_Id desc", con);
                DataSet dsDrives = new DataSet();
                da.Fill(dsDrives);
                gvDrives.DataSource = dsDrives;
                gvDrives.DataBind();
                lblDriveCount.Text = dsDrives.Tables[0].Rows.Count.ToString();

                da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + compEmail + "' order by Selection_Id desc", con);
                DataSet dsSels = new DataSet();
                da.Fill(dsSels);
                gvSelections.DataSource = dsSels;
                gvSelections.DataBind();
            }
            else
            {
                Response.Redirect("companies.aspx");
            }
        }

        protected void btnUpdateVerification_Click(object sender, EventArgs e)
        {
            if (ViewState["cid"] != null && ViewState["cid"].ToString() != "")
            {
                getcon();
                cmd = new SqlCommand("update Company_reg_tbl set Verification_Status='" + ddlUpdateVerification.SelectedValue + "', Remarks='" + txtAdminRemarks.Text.Replace("'", "''") + "' where Company_Id='" + ViewState["cid"] + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Company verification updated successfully!');</script>");
                filldata();
            }
        }
    }
}
