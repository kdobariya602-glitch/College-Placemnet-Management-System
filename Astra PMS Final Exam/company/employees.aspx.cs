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
    public partial class employees : System.Web.UI.Page
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

        void clear()
        {
            txtNewName.Text = "";
            txtNewDesig.Text = "";
            txtNewEmail.Text = "";
            txtNewPhone.Text = "";
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from Company_Contact_tbl where Company_Email='" + Session["company"] + "' order by Emp_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvTeam.DataSource = ds;
            gvTeam.DataBind();
        }

        protected void gvTeam_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete_member")
            {
                int empid = Convert.ToInt32(e.CommandArgument); ViewState["empid"] = empid;
                getcon();
                cmd = new SqlCommand("delete from Company_Contact_tbl where Emp_Id='" + empid + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Team member removed successfully.');</script>");
                fillgrid();
            }
        }

        protected void btnSaveMember_Click(object sender, EventArgs e)
        {
            if (txtNewName.Text != "" && txtNewEmail.Text != "")
            {
                getcon();
                cmd = new SqlCommand("insert into Company_Contact_tbl(Company_Email, Contact_Name, Designation, Email, Phone, Status) values('" + Session["company"] + "', '" + txtNewName.Text + "', '" + txtNewDesig.Text + "', '" + txtNewEmail.Text + "', '" + txtNewPhone.Text + "', 'Active')", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Team member added successfully!');</script>");
                clear();
                fillgrid();
            }
            else
            {
                Response.Write("<script>alert('Name and Email are required.');</script>");
            }
        }
    }
}
