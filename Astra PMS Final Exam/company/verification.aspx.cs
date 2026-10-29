using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace Astra_PMS_Final_Exam.company
{
    public partial class verification : System.Web.UI.Page
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
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Company_Name"].ToString();
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
            filldata();
            filldocs();
        }

        void clear()
        {
            txtCIN.Text = "";
            txtDocTitle.Text = "";
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lblStatusText.Text = ds.Tables[0].Rows[0]["Verification_Status"].ToString();
                lblStatusBadge.Text = ds.Tables[0].Rows[0]["Verification_Status"].ToString();
                txtCIN.Text = ds.Tables[0].Rows[0]["Reg_Number"].ToString();
            }
        }

        void filldocs()
        {
            getcon();
            da = new SqlDataAdapter("select * from Company_Document_tbl where Company_Email='" + Session["company"] + "' order by Company_Doc_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvCompanyDocs.DataSource = ds;
            gvCompanyDocs.DataBind();
        }

        protected void btnSubmitVerification_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Company_reg_tbl set Reg_Number='" + txtCIN.Text + "' where Email='" + Session["company"] + "'", con);
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Verification credentials updated successfully!');</script>");
            filldata();
        }

        void fileupload()
        {
            if (fuCompanyDoc.HasFile)
            {
                fnm = "uploads/company_docs/" + fuCompanyDoc.FileName;
                fuCompanyDoc.SaveAs(Server.MapPath("~/" + fnm));
            }
        }

        protected void btnUploadDoc_Click(object sender, EventArgs e)
        {
            if (fuCompanyDoc.HasFile)
            {
                fileupload();

                getcon();
                cmd = new SqlCommand("insert into Company_Document_tbl (Company_Email, Document_Type, Document_Name, File_Path, Upload_Date, Verification_Status) values ('" + Session["company"] + "', '" + ddlDocType.SelectedValue + "', '" + txtDocTitle.Text + "', '~/" + fnm + "', GETDATE(), 'Pending')", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Document uploaded successfully!');</script>");
                txtDocTitle.Text = "";
                filldocs();
            }
            else
            {
                Response.Write("<script>alert('Please select a verification document to upload.');</script>");
            }
        }

        protected void gvCompanyDocs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete_doc")
            {
                getcon();
                cmd = new SqlCommand("delete from Company_Document_tbl where Company_Doc_Id='" + e.CommandArgument + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Document removed.');</script>");
                filldocs();
            }
        }
    }
}
