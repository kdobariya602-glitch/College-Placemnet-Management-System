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
            if (Session["admin"] != null)
            {
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
            da = new SqlDataAdapter("select * from Admin_Login_tbl where Email='" + Session["admin"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblUsername.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                string pFile = ds.Tables[0].Rows[0]["Photo"] != DBNull.Value ? ds.Tables[0].Rows[0]["Photo"].ToString() : "";
                if (!string.IsNullOrEmpty(pFile) && System.IO.File.Exists(Server.MapPath("~/uploads/profiles/" + pFile)))
                    imgProfile.ImageUrl = "../uploads/profiles/" + pFile;
                else
                    imgProfile.ImageUrl = "../assets/images/default-avatar.svg";
                lblAdminName.Text = ds.Tables[0].Rows[0]["Full_Name"].ToString();
                txtFullName.Text = ds.Tables[0].Rows[0]["Full_Name"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Admin_Login_tbl set Full_Name='" + txtFullName.Text + "' where Email='" + Session["admin"] + "'", con);
            cmd.ExecuteNonQuery();

            Response.Write("<script>alert('Profile updated successfully');</script>");
            filldata();
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (txtNewPassword.Text != "")
            {
                getcon();
                cmd = new SqlCommand("update Admin_Login_tbl set Password='" + txtNewPassword.Text + "' where Email='" + Session["admin"] + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Password updated successfully');</script>");
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";
            }
            else
            {
                Response.Write("<script>alert('Please enter password');</script>");
            }
        }

        void imgupload()
        {
            fnm = "admin_" + DateTime.Now.Ticks + System.IO.Path.GetExtension(fuPhoto.FileName).ToLower();
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
                    string sEmail = Session["admin"].ToString();
                    imgupload();

                    getcon();
                    cmd = new SqlCommand("update Admin_Login_tbl set Photo='" + fnm + "' where Email='" + sEmail + "' or Username='" + sEmail + "'", con);
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
            string sEmail = Session["admin"].ToString();
            getcon();
            cmd = new SqlCommand("update Admin_Login_tbl set Photo='' where Email='" + sEmail + "' or Username='" + sEmail + "'", con);
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Profile photo removed.'); window.location='profile.aspx';</script>");
        }

}
}
