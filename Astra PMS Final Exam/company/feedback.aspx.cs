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
    public partial class feedback : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from Company_Feedback_tbl where Company_Email='" + Session["company"] + "' order by Feedback_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvFeedback.DataSource = ds;
            gvFeedback.DataBind();
        }

        protected void btnSubmitFeedback_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Company_Feedback_tbl (Company_Email, Company_Name, Overall_Experience, Student_Quality, Coordination_Rating, Infrastructure_Rating, Process_Rating, Suggestions, Feedback_Date) values ('" + Session["company"] + "', '" + nm + "', '" + ddlOverall.SelectedValue + "', '" + ddlStudentQuality.SelectedValue + "', '" + ddlCoordination.SelectedValue + "', '" + ddlInfrastructure.SelectedValue + "', '" + ddlProcess.SelectedValue + "', '" + txtSuggestions.Text + "', GETDATE())", con);
            i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                Response.Write("<script>alert('Thank you! Your feedback has been submitted successfully.');</script>");
                txtSuggestions.Text = "";
                fillgrid();
            }
        }
    }
}
