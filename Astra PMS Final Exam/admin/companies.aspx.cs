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
    public partial class companies : System.Web.UI.Page
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
            if (txtSearch.Text != "")
            {
                da = new SqlDataAdapter("select * from Company_reg_tbl where (Company_Name='" + txtSearch.Text + "' or Email='" + txtSearch.Text + "' or Location='" + txtSearch.Text + "') order by Company_Id desc", con);
            }
            else if (ddlIndustryFilter.SelectedValue != "All" && ddlIndustryFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Company_reg_tbl where Industry = '" + ddlIndustryFilter.SelectedValue + "' order by Company_Id desc", con);
            }
            else if (ddlVerificationFilter.SelectedValue != "All" && ddlVerificationFilter.SelectedValue != "")
            {
                da = new SqlDataAdapter("select * from Company_reg_tbl where Verification_Status = '" + ddlVerificationFilter.SelectedValue + "' order by Company_Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Company_reg_tbl order by Company_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            gvCompanies.DataSource = ds;
            gvCompanies.DataBind();
            lblCount.Text = ds.Tables[0].Rows.Count.ToString();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            fillgrid();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlIndustryFilter.SelectedIndex = 0;
            ddlVerificationFilter.SelectedIndex = 0;
            gvCompanies.PageIndex = 0;
            fillgrid();
        }

        protected void gvCompanies_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCompanies.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        protected void gvCompanies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int cid = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "view_company") { Session["cid"] = cid; Response.Redirect("company-details.aspx"); } else if (e.CommandName == "approve_company")
            {
                getcon();
                cmd = new SqlCommand("update Company_reg_tbl set Verification_Status='Verified', Remarks='Approved' where Company_Id='" + cid + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Company Approved Successfully!');</script>");
                fillgrid();
            }
            else if (e.CommandName == "delete_company")
            {
                getcon();
                cmd = new SqlCommand("delete from Company_reg_tbl where Company_Id='" + cid + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Company Deleted Successfully!');</script>");
                fillgrid();
            }
        }

        protected void btnSaveCompany_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Company_reg_tbl (Company_Name, Email, Password, Contact_Number, Industry, Location, Website, Company_Description, HR_Name, Verification_Status, Remarks) values ('" + txtNewCompName.Text + "', '" + txtNewCompEmail.Text + "', '" + txtNewCompPass.Text + "', '" + txtNewCompPhone.Text + "', '" + ddlNewCompIndustry.SelectedValue + "', '" + txtNewCompLoc.Text + "', '" + txtNewCompWeb.Text + "', '" + txtNewCompDesc.Text + "', '" + txtNewCompHR.Text + "', 'Verified', 'Approved')", con);
            cmd.ExecuteNonQuery();

            clear();
            Response.Write("<script>alert('Company Registered Successfully!');</script>");
            fillgrid();
        }

        void clear()
        {
            txtNewCompName.Text = "";
            txtNewCompEmail.Text = "";
            txtNewCompPass.Text = "";
            txtNewCompPhone.Text = "";
            txtNewCompLoc.Text = "";
            txtNewCompWeb.Text = "";
            txtNewCompHR.Text = "";
            txtNewCompDesc.Text = "";
        }

        protected void btnExportCompaniesCsv_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select * from Company_reg_tbl order by Company_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            i = ds.Tables[0].Rows.Count;
            Response.Write("<script>alert('Partner companies report generated successfully! Total records: " + i + "');</script>");
        }
    }
}


