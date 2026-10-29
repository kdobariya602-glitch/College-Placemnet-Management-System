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
    public partial class internships : System.Web.UI.Page
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
            getcon();
            da = new SqlDataAdapter("select * from Internship_tbl where Company_Email='" + Session["company"] + "' order by Internship_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            gvInternships.DataSource = ds;
            gvInternships.DataBind();

            lblTotalInternships.Text = ds.Tables[0].Rows.Count + " Openings";
        }

        void clear()
        {
            txtTitle.Text = "";
            txtStipend.Text = "";
            txtDuration.Text = "";
            ddlWorkMode.SelectedIndex = 0;
            txtLocation.Text = "";
            txtVacancies.Text = "";
            txtDeadline.Text = "";
            txtEligibility.Text = "";
            txtSkills.Text = "";
            txtDescription.Text = "";
            ddlStatus.SelectedIndex = 0;
            btnSave.Text = "Publish Internship";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtTitle.Text != "" && txtStipend.Text != "")
            {
                getcon();
                if (btnSave.Text == "Publish Internship")
                {
                    cmd = new SqlCommand("insert into Internship_tbl(Internship_Title, Company_Email, Company_Name, Description, Duration, Location, Work_Mode, Stipend, Eligibility, Required_Skills, Vacancies, Deadline, Status, Created_Date) values('" + txtTitle.Text + "', '" + Session["company"] + "', '" + nm + "', '" + txtDescription.Text + "', '" + txtDuration.Text + "', '" + txtLocation.Text + "', '" + ddlWorkMode.SelectedValue + "', '" + txtStipend.Text + "', '" + txtEligibility.Text + "', '" + txtSkills.Text + "', '" + txtVacancies.Text + "', '" + txtDeadline.Text + "', '" + ddlStatus.SelectedValue + "', GETDATE())", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Internship opportunity saved successfully.');</script>");
                }
                else if (btnSave.Text == "Update Internship")
                {
                    cmd = new SqlCommand("update Internship_tbl set Internship_Title='" + txtTitle.Text + "', Description='" + txtDescription.Text + "', Duration='" + txtDuration.Text + "', Location='" + txtLocation.Text + "', Work_Mode='" + ddlWorkMode.SelectedValue + "', Stipend='" + txtStipend.Text + "', Eligibility='" + txtEligibility.Text + "', Required_Skills='" + txtSkills.Text + "', Vacancies='" + txtVacancies.Text + "', Deadline='" + txtDeadline.Text + "', Status='" + ddlStatus.SelectedValue + "' where Internship_Id='" + ViewState["intid"] + "' and Company_Email='" + Session["company"] + "'", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Internship opportunity updated successfully.');</script>");
                }

                clear();
                fillgrid();
            }
            else
            {
                Response.Write("<script>alert('Please fill in required fields.');</script>");
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void gvInternships_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int intid = Convert.ToInt32(e.CommandArgument); ViewState["intid"] = intid;

            if (e.CommandName == "EditInternship")
            {
                getcon();
                da = new SqlDataAdapter("select * from Internship_tbl where Internship_Id='" + intid + "' and Company_Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ViewState["intid"] = intid;
                    txtTitle.Text = ds.Tables[0].Rows[0]["Internship_Title"].ToString();
                    txtStipend.Text = ds.Tables[0].Rows[0]["Stipend"].ToString();
                    string wm = ds.Tables[0].Rows[0]["Work_Mode"].ToString();
                    if (ddlWorkMode.Items.FindByValue(wm) != null)
                    {
                        ddlWorkMode.SelectedValue = wm;
                    }
                    txtLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                    txtVacancies.Text = ds.Tables[0].Rows[0]["Vacancies"].ToString();
                    txtDeadline.Text = ds.Tables[0].Rows[0]["Deadline"].ToString();
                    txtEligibility.Text = ds.Tables[0].Rows[0]["Eligibility"].ToString();
                    txtSkills.Text = ds.Tables[0].Rows[0]["Required_Skills"].ToString();
                    txtDescription.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                    string st = ds.Tables[0].Rows[0]["Status"].ToString();
                    if (ddlStatus.Items.FindByValue(st) != null)
                    {
                        ddlStatus.SelectedValue = st;
                    }

                    btnSave.Text = "Update Internship";
                }
            }
            else if (e.CommandName == "DeleteInternship")
            {
                getcon();
                cmd = new SqlCommand("delete from Internship_tbl where Internship_Id='" + intid + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Internship opportunity deleted.');</script>");
                fillgrid();
            }
        }
    }
}
