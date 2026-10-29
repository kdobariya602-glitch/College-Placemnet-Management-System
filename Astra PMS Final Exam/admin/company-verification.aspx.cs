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
    public partial class company_verification : System.Web.UI.Page
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
                    fillstats();
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void fillstats()
        {
            getcon();
            da = new SqlDataAdapter("select * from Company_reg_tbl where Verification_Status = 'Pending' or Verification_Status is null or Verification_Status = 'Correction Required'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPendingCount.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Company_reg_tbl where Verification_Status = 'Verified'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblVerifiedCount.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Company_reg_tbl where Verification_Status = 'Rejected'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblRejectedCount.Text = ds.Tables[0].Rows.Count.ToString();
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from Company_reg_tbl order by case when Verification_Status = 'Pending' or Verification_Status is null then 0 else 1 end, Company_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvVerification.DataSource = ds;
            gvVerification.DataBind();
        }

        void clear()
        {
        }

        protected void gvVerification_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string company_id = e.CommandArgument.ToString();

            if (e.CommandName == "approve")
            {
                getcon();
                cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Verified', Remarks = 'Verification Approved by Administration. Ready for Campus Drives.' where Company_Id = '" + company_id + "'", con);
                cmd.ExecuteNonQuery();

                getcon();
                da = new SqlDataAdapter("select Email, Company_Name from Company_reg_tbl where Company_Id = '" + company_id + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string cemail = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    cemail = ds.Tables[0].Rows[0]["Email"].ToString();
                }

                if (cemail != "")
                {
                    getcon();
                    cmd = new SqlCommand("update Company_Document_tbl set Verification_Status = 'Verified', Verified_By = 'Central Administration' where Company_Email = '" + cemail + "'", con);
                    cmd.ExecuteNonQuery();
                }

                Response.Write("<script>alert('Company successfully verified.');</script>");
                fillstats();
                fillgrid();
            }
            else if (e.CommandName == "reject")
            {
                getcon();
                cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Rejected', Remarks = 'Application rejected due to incomplete corporate credentials.' where Company_Id = '" + company_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Company registration rejected.');</script>");
                fillstats();
                fillgrid();
            }
            else if (e.CommandName == "correction")
            {
                getcon();
                cmd = new SqlCommand("update Company_reg_tbl set Verification_Status = 'Correction Required', Remarks = 'Please upload valid company registration certificate & official website details.' where Company_Id = '" + company_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Correction request sent to company.');</script>");
                fillstats();
                fillgrid();
            }
        }
    }
}
