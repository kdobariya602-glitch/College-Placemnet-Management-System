using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam.company
{
    public partial class selections : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

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
                    filldropdowns();
                    if (Session["stuEmail"] != null)
                    {
                        if (ddlCandidate.Items.FindByValue(Session["stuEmail"].ToString()) != null)
                        {
                            ddlCandidate.SelectedValue = Session["stuEmail"].ToString();
                        }
                        Session["stuEmail"] = null;
                    }
                    fillstats();
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void filldropdowns()
        {
            getcon();
            da = new SqlDataAdapter("select distinct Student_Email, Student_Name from Interview_tbl where Company_Email='" + Session["company"] + "' union select distinct Student_Email, Student_Name from Shortlist_tbl where Company_Email='" + Session["company"] + "' union select distinct Student_Email, Student_Name from Application_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count == 0)
            {
                da = new SqlDataAdapter("select Email as Student_Email, Full_Name as Student_Name from Student_Reg_tbl where Account_Status='Active'", con);
            }
            ds = new DataSet();
            da.Fill(ds);

            ddlCandidate.DataSource = ds;
            ddlCandidate.DataTextField = "Student_Name";
            ddlCandidate.DataValueField = "Student_Email";
            ddlCandidate.DataBind();
            ddlCandidate.Items.Insert(0, new ListItem("-- Select Candidate --", ""));

            da = new SqlDataAdapter("select Job_Id, Job_Title, Salary_CTC from Job_tbl where Company_Email='" + Session["company"] + "' order by Job_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count == 0)
            {
                da = new SqlDataAdapter("select Job_Id, Job_Title, Salary_CTC from Job_tbl order by Job_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);

            ddlJob.DataSource = ds;
            ddlJob.DataTextField = "Job_Title";
            ddlJob.DataValueField = "Job_Id";
            ddlJob.DataBind();
            ddlJob.Items.Insert(0, new ListItem("-- Select Job Position --", ""));
        }

        void fillstats()
        {
            getcon();
            da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalOffers.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + Session["company"] + "' and Offer_Status='Accepted'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblAcceptedOffers.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + Session["company"] + "' and Offer_Status='Offered'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPendingOffers.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + Session["company"] + "' and Offer_Status='Joined'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblJoinedOffers.Text = ds.Tables[0].Rows.Count.ToString();
        }

        

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from Selection_tbl where Company_Email='" + Session["company"] + "' order by Selection_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            gvSelections.DataSource = ds;
            gvSelections.DataBind();
        }

        void clear()
        {
            ViewState["Selection_Id"] = null;
            hfSelectionId.Value = "";
            ddlCandidate.SelectedIndex = -1;
            ddlJob.SelectedIndex = -1;
            txtPackage.Text = "";
            txtDesignation.Text = "";
            txtOfferDate.Text = "";
            txtJoiningDate.Text = "";
            txtRemarks.Text = "";
            btnSaveOffer.Text = "Issue Offer";
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from Selection_tbl where Selection_Id='" + ViewState["Selection_Id"] + "' and Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ddlCandidate.Items.FindByValue(ds.Tables[0].Rows[0]["Student_Email"].ToString()) != null)
                {
                    ddlCandidate.SelectedValue = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                }
                if (ddlJob.Items.FindByValue(ds.Tables[0].Rows[0]["Job_Id"].ToString()) != null)
                {
                    ddlJob.SelectedValue = ds.Tables[0].Rows[0]["Job_Id"].ToString();
                }
                txtPackage.Text = ds.Tables[0].Rows[0]["Package_CTC"].ToString();
                txtOfferDate.Text = ds.Tables[0].Rows[0]["Offer_Date"].ToString();
                txtJoiningDate.Text = ds.Tables[0].Rows[0]["Joining_Date"].ToString();
                txtRemarks.Text = ds.Tables[0].Rows[0]["Remarks"].ToString();
            }
        }

        protected void btnSaveOffer_Click(object sender, EventArgs e)
        {
            if (btnSaveOffer.Text == "Issue Offer")
            {
                getcon();
                da = new SqlDataAdapter("select * from Student_Reg_tbl where Email='" + ddlCandidate.SelectedValue + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string candName = ds.Tables[0].Rows[0]["Full_Name"].ToString();
                string candEnroll = ds.Tables[0].Rows[0]["Enrollment_No"].ToString();
                string candDept = ds.Tables[0].Rows[0]["Branch"].ToString();

                da = new SqlDataAdapter("select top 1 Application_Id from Application_tbl where Student_Email='" + ddlCandidate.SelectedValue + "' and Company_Email='" + Session["company"] + "' and Job_Id='" + ddlJob.SelectedValue + "' order by Application_Id desc", con);
                ds = new DataSet();
                da.Fill(ds);
                string appId = "0";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    appId = ds.Tables[0].Rows[0]["Application_Id"].ToString();
                }
                else
                {
                    da = new SqlDataAdapter("select top 1 Application_Id from Application_tbl where Student_Email='" + ddlCandidate.SelectedValue + "' and Company_Email='" + Session["company"] + "' order by Application_Id desc", con);
                    ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        appId = ds.Tables[0].Rows[0]["Application_Id"].ToString();
                    }
                }

                cmd = new SqlCommand("insert into Selection_tbl (Application_Id, Job_Id, Company_Email, Company_Name, Job_Title, Student_Email, Student_Name, Enrollment_No, Department, Package_CTC, Selection_Date, Offer_Status, Offer_Date, Remarks, Created_Date) values ('" + appId + "', '" + ddlJob.SelectedValue + "', '" + Session["company"] + "', '" + nm + "', '" + ddlJob.SelectedItem.Text + "', '" + ddlCandidate.SelectedValue + "', '" + candName + "', '" + candEnroll + "', '" + candDept + "', '" + txtPackage.Text + "', GETDATE(), 'Offered', GETDATE(), '" + txtRemarks.Text + "', GETDATE())", con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("update Application_tbl set Status='Selected' where Student_Email='" + ddlCandidate.SelectedValue + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("update Student_Reg_tbl set Placement_Status='Placed' where Email='" + ddlCandidate.SelectedValue + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Job offer extended successfully!');</script>");
                clear();
                fillstats();
                fillgrid();
            }
            else
            {
                getcon();
                cmd = new SqlCommand("update Selection_tbl set Job_Id='" + ddlJob.SelectedValue + "', Job_Title='" + ddlJob.SelectedItem.Text + "', Package_CTC='" + txtPackage.Text + "', Offer_Date='" + txtOfferDate.Text + "', Joining_Date='" + txtJoiningDate.Text + "', Remarks='" + txtRemarks.Text + "' where Selection_Id='" + ViewState["Selection_Id"] + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Offer updated successfully!');</script>");
                clear();
                fillstats();
                fillgrid();
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void gvSelections_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditOffer")
            {
                int selid = Convert.ToInt32(e.CommandArgument); ViewState["selid"] = selid;
                ViewState["selid"] = selid;
                btnSaveOffer.Text = "Update Offer";
                filldata();
            }
            else if (e.CommandName == "RevokeOffer")
            {
                getcon();
                cmd = new SqlCommand("delete from Selection_tbl where Selection_Id='" + e.CommandArgument + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Job offer revoked.');</script>");
                fillstats();
                fillgrid();
            }
            else if (e.CommandName == "MarkJoined")
            {
                getcon();
                da = new SqlDataAdapter("select * from Selection_tbl where Selection_Id='" + e.CommandArgument + "' and Company_Email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                string stuEmail = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                string cName = ds.Tables[0].Rows[0]["Company_Name"].ToString();
                string jTitle = ds.Tables[0].Rows[0]["Job_Title"].ToString();
                string sName = ds.Tables[0].Rows[0]["Student_Name"].ToString();
                string enroll = ds.Tables[0].Rows[0]["Enrollment_No"].ToString();
                string dept = ds.Tables[0].Rows[0]["Department"].ToString();
                string pkg = ds.Tables[0].Rows[0]["Package_CTC"].ToString();

                cmd = new SqlCommand("update Selection_tbl set Offer_Status='Joined', Joining_Status='Joined', Joining_Date=GETDATE() where Selection_Id='" + e.CommandArgument + "' and Company_Email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("update Student_Reg_tbl set Placement_Status='Placed' where Email='" + stuEmail + "'", con);
                cmd.ExecuteNonQuery();

                da = new SqlDataAdapter("select * from Student_Reg_tbl where Email='" + stuEmail + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string course = "B.Tech";
                string batch = "2026";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["Course"].ToString() != "")
                    {
                        course = ds.Tables[0].Rows[0]["Course"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["Batch"].ToString() != "")
                    {
                        batch = ds.Tables[0].Rows[0]["Batch"].ToString();
                    }
                }

                da = new SqlDataAdapter("select * from Placement_History_tbl where Student_Email='" + stuEmail + "' and Company_Name='" + cName + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count == 0)
                {
                    cmd = new SqlCommand("insert into Placement_History_tbl(Student_Email, Student_Name, Enrollment_No, Department, Course, Batch, Company_Name, Job_Title, Package_CTC, Selection_Date, Joining_Date, Joining_Status, Academic_Year, Placement_Season, Created_Date) values('" + stuEmail + "', '" + sName + "', '" + enroll + "', '" + dept + "', '" + course + "', '" + batch + "', '" + cName + "', '" + jTitle + "', '" + pkg + "', GETDATE(), GETDATE(), 'Joined', '2025-26', 'Campus 2026', GETDATE())", con);
                    cmd.ExecuteNonQuery();
                }

                Response.Write("<script>alert('Candidate marked as Joined successfully.');</script>");
                fillstats();
                fillgrid();
            }
        }
    }
}
