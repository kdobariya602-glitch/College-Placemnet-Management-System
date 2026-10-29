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
    public partial class profile : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from Company_reg_tbl where Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lblCompanyName.Text = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                txtCompName.Text = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                string pFile = ds.Tables[0].Rows[0]["Logo_File"] != DBNull.Value ? ds.Tables[0].Rows[0]["Logo_File"].ToString() : "";
                if (!string.IsNullOrEmpty(pFile) && System.IO.File.Exists(Server.MapPath("~/uploads/profiles/" + pFile)))
                    imgProfile.ImageUrl = "../uploads/profiles/" + pFile;
                else
                    imgProfile.ImageUrl = "../assets/images/default-avatar.svg";
                txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblIndustry.Text = ds.Tables[0].Rows[0]["Industry"].ToString();
                if (ddlIndustry.Items.FindByValue(ds.Tables[0].Rows[0]["Industry"].ToString()) != null)
                {
                    ddlIndustry.SelectedValue = ds.Tables[0].Rows[0]["Industry"].ToString();
                }
                txtWebsite.Text = ds.Tables[0].Rows[0]["Website"].ToString();
                txtHRName.Text = ds.Tables[0].Rows[0]["HR_Name"].ToString();
                txtPhone.Text = ds.Tables[0].Rows[0]["Contact_Number"].ToString();
                txtLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                lblVerificationBadge.Text = ds.Tables[0].Rows[0]["Verification_Status"].ToString();
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Company_reg_tbl set Company_Name='" + txtCompName.Text + "', Industry='" + ddlIndustry.SelectedValue + "', Website='" + txtWebsite.Text + "', HR_Name='" + txtHRName.Text + "', Contact_Number='" + txtPhone.Text + "', HR_Phone='" + txtPhone.Text + "', Location='" + txtLocation.Text + "' where Email='" + Session["company"] + "'", con);
            i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                Response.Write("<script>alert('Company profile details updated successfully!');</script>");
                filldata();
            }
        }

        void imgupload()
        {
            fnm = "company_" + DateTime.Now.Ticks + System.IO.Path.GetExtension(fuPhoto.FileName).ToLower();
            string dir = Server.MapPath("~/uploads/profiles/");
            if (!System.IO.Directory.Exists(dir)) System.IO.Directory.CreateDirectory(dir);
            fuPhoto.SaveAs(dir + fnm);
        }

        protected void btnUploadPhoto_Click(object sender, EventArgs e)
        {
            if (fuPhoto.HasFile)
            {
                string ext = System.IO.Path.GetExtension(fuPhoto.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
                {
                    string sEmail = Session["company"].ToString();
                    imgupload();

                    getcon();
                    cmd = new SqlCommand("update Company_reg_tbl set Logo_File='" + fnm + "' where Email='" + sEmail + "'", con);
                    cmd.ExecuteNonQuery();

                    Response.Write("<script>alert('Profile photo updated successfully!'); window.location='profile.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('Please select a valid image file (JPG, PNG, GIF).');</script>");
                }
            }
        }

        protected void btnDeletePhoto_Click(object sender, EventArgs e)
        {
            string sEmail = Session["company"].ToString();
            getcon();
            cmd = new SqlCommand("update Company_reg_tbl set Logo_File='' where Email='" + sEmail + "'", con);
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Profile photo removed.'); window.location='profile.aspx';</script>");
        }

}
}
