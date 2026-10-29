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
    public partial class grievances : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from Grievance_tbl order by Grievance_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvGrievances.DataSource = ds;
            gvGrievances.DataBind();

            da = new SqlDataAdapter("select * from Grievance_tbl where Status='Open'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblOpenCount.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Grievance_tbl where Status='In Review'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblReviewCount.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Grievance_tbl where Status='Resolved'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblResolvedCount.Text = ds.Tables[0].Rows.Count.ToString();
        }

        protected void gvGrievances_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvGrievances.PageIndex = e.NewPageIndex;
            fillgrid();
        }

        protected void gvGrievances_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int gid = Convert.ToInt32(e.CommandArgument); ViewState["gid"] = gid;

            if (e.CommandName == "open_respond")
            {
                getcon();
                da = new SqlDataAdapter("select * from Grievance_tbl where Grievance_Id='" + gid + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                lblModalSubject.Text = ds.Tables[0].Rows[0]["Subject"].ToString();
                string st = ds.Tables[0].Rows[0]["Status"].ToString();
                if (ddlModalStatus.Items.FindByValue(st) != null)
                {
                    ddlModalStatus.SelectedValue = st;
                }
                ViewState["gid"] = gid;

                Response.Write("<script>window.onload = function() { bootstrap.Modal.getOrCreateInstance(document.getElementById('modalRespond')).show(); };</script>");
            }
            else if (e.CommandName == "delete_grievance")
            {
                getcon();
                cmd = new SqlCommand("delete from Grievance_tbl where Grievance_Id='" + gid + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Grievance ticket deleted successfully.');</script>");
                fillgrid();
            }
        }

                

        

        protected void btnAiDraftResolution_Click(object sender, EventArgs e)
        {
            string subject = lblModalSubject.Text;
            string resolution = "Dear Student,\n\n" +
                         "The Astra University Placement Directorate has thoroughly examined your concern regarding '" + (!string.IsNullOrEmpty(subject) ? subject : "placement procedure") + "'.\n\n" +
                         "Action Taken: Our central technical and placement audit committee has verified the records and applied the necessary administrative adjustments in the PMS portal. Your profile status and eligibility have been appropriately updated.\n\n" +
                         "Should you require further clarification, you are welcome to visit the Central TPO Office during office hours (10:00 AM - 4:00 PM).\n\n" +
                         "Best Regards,\nCentral Grievance Redressal Committee,\nAstra University Placement Directorate";

            txtModalResponse.Text = resolution;
            ddlModalStatus.SelectedValue = "Resolved";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "PopModalGrievance", "var myModal = new bootstrap.Modal(document.getElementById('modalRespond')); myModal.show();", true);
        }

        void clear()
        {
            txtModalResponse.Text = "";
            ViewState["gid"] = null;
        }

        protected void btnSubmitResponse_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Grievance_tbl set Status='" + ddlModalStatus.SelectedValue + "', Response='" + txtModalResponse.Text + "', Responded_By='" + Session["admin"].ToString() + "', Responded_Date=GETDATE() where Grievance_Id='" + ViewState["gid"] + "'", con);
            cmd.ExecuteNonQuery();

            Response.Write("<script>alert('Response recorded successfully.');</script>");
            clear();
            fillgrid();
        }
    }
}
