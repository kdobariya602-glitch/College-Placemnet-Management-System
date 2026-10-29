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
    public partial class interview_results : System.Web.UI.Page
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

        string getctc(string jobId)
        {
            if (jobId == "") return "Not Disclosed";
            getcon();
            da = new SqlDataAdapter("select Salary_CTC from Job_tbl where Job_Id='" + jobId + "'", con);
            DataSet dsCtc = new DataSet();
            da.Fill(dsCtc);
            if (dsCtc.Tables[0].Rows.Count > 0 && dsCtc.Tables[0].Rows[0][0] != DBNull.Value && dsCtc.Tables[0].Rows[0][0].ToString().Trim() != "")
            {
                return dsCtc.Tables[0].Rows[0][0].ToString().Trim();
            }
            return "Not Disclosed";
        }

        string getoverall()
        {
            double tot = 0;
            int cnt = 0;
            if (txtTechScore.Text != "")
            {
                tot += Convert.ToDouble(txtTechScore.Text);
                cnt++;
            }
            if (txtAptScore.Text != "")
            {
                tot += Convert.ToDouble(txtAptScore.Text);
                cnt++;
            }
            if (txtHRScore.Text != "")
            {
                tot += Convert.ToDouble(txtHRScore.Text);
                cnt++;
            }
            if (txtGDScore.Text != "")
            {
                tot += Convert.ToDouble(txtGDScore.Text);
                cnt++;
            }
            if (cnt == 0)
                return "0";
            return Math.Round(tot / cnt, 2).ToString();
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
                    fillsessions();
                    fillgrid();

                    if (Session["iid"] != null) { ViewState["iid"] = Session["iid"]; }

                    if (ViewState["iid"] != null && ddlInterviewSession.Items.FindByValue(ViewState["iid"].ToString()) != null)
                    {
                        ddlInterviewSession.SelectedValue = ViewState["iid"].ToString();
                        ddlInterviewSession_SelectedIndexChanged(null, null);
                    }
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void fillsessions()
        {
            getcon();
            da = new SqlDataAdapter("select Interview_Id, (Student_Name + ' - ' + Round_Name + ' (' + Job_Title + ')') as DisplayText from Interview_Schedule_tbl where Company_Email='" + Session["company"] + "' order by Interview_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlInterviewSession.Items.Clear();
            ddlInterviewSession.Items.Add(new ListItem("-- Select Candidate & Round --", ""));
            for (int k = 0; k < ds.Tables[0].Rows.Count; k++)
            {
                ddlInterviewSession.Items.Add(new ListItem(ds.Tables[0].Rows[k]["DisplayText"].ToString(), ds.Tables[0].Rows[k]["Interview_Id"].ToString()));
            }
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select r.*, i.Round_Name, i.Scheduled_Date from Interview_Evaluation_tbl r left join Interview_Schedule_tbl i on r.Interview_Id = i.Id where r.Company_Email='" + Session["company"] + "' order by r.Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvResults.DataSource = ds;
            gvResults.DataBind();
        }

        protected void ddlInterviewSession_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlInterviewSession.SelectedValue == "")
            {
                pnlCandidateInfo.Visible = false;
                return;
            }

            getcon();
            da = new SqlDataAdapter("select * from Interview_Schedule_tbl where Interview_Id='" + ddlInterviewSession.SelectedValue + "' and Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                pnlCandidateInfo.Visible = true;
                lblCandName.Text = ds.Tables[0].Rows[0]["Student_Name"].ToString();
                lblCandEmail.Text = ds.Tables[0].Rows[0]["Student_Email"].ToString();
                lblCandRound.Text = ds.Tables[0].Rows[0]["Round_Name"].ToString();

                string interviewId = ddlInterviewSession.SelectedValue;
                da = new SqlDataAdapter("select * from Interview_Evaluation_tbl where Interview_Id='" + interviewId + "'", con);
                DataSet dsEval = new DataSet();
                da.Fill(dsEval);
                if (dsEval.Tables[0].Rows.Count > 0)
                {
                    txtTechScore.Text = dsEval.Tables[0].Rows[0]["Technical_Score"].ToString();
                    txtAptScore.Text = dsEval.Tables[0].Rows[0]["Aptitude_Score"].ToString();
                    txtHRScore.Text = dsEval.Tables[0].Rows[0]["HR_Score"].ToString();
                    txtGDScore.Text = dsEval.Tables[0].Rows[0]["GD_Score"].ToString();
                    if (ddlRecommendation.Items.FindByValue(dsEval.Tables[0].Rows[0]["Final_Decision"].ToString()) != null)
                        ddlRecommendation.SelectedValue = dsEval.Tables[0].Rows[0]["Final_Decision"].ToString();
                    txtRemarks.Text = dsEval.Tables[0].Rows[0]["Feedback"].ToString();
                    btnSaveEvaluation.Text = "Update Evaluation Result";
                    ViewState["eval_id"] = dsEval.Tables[0].Rows[0]["Interview_Id"].ToString();
                }
                else
                {
                    txtTechScore.Text = "";
                    txtAptScore.Text = "";
                    txtHRScore.Text = "";
                    txtGDScore.Text = "";
                    ddlRecommendation.SelectedIndex = 0;
                    txtRemarks.Text = "";
                    btnSaveEvaluation.Text = "Save Evaluation Result";
                    ViewState["eval_id"] = null;
                }
            }
        }

        protected void btnSaveEvaluation_Click(object sender, EventArgs e)
        {
            if (ddlInterviewSession.SelectedValue == "")
            {
                Response.Write("<script>alert('Please select an interview session.');</script>");
                return;
            }

            getcon();
            da = new SqlDataAdapter("select * from Interview_Schedule_tbl where Interview_Id='" + ddlInterviewSession.SelectedValue + "' and Company_Email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count == 0) return;

            string intId = ddlInterviewSession.SelectedValue;
            string sEmail = ds.Tables[0].Rows[0]["Student_Email"].ToString();
            string sName = ds.Tables[0].Rows[0]["Student_Name"].ToString();
            string enroll = ds.Tables[0].Rows[0]["Enrollment_No"].ToString();
            string dept = ds.Tables[0].Rows[0]["Department"].ToString();
            string jId = ds.Tables[0].Rows[0]["Job_Id"].ToString();
            string dId = ds.Tables[0].Rows[0]["Drive_Id"].ToString();
            string jTitle = ds.Tables[0].Rows[0]["Job_Title"].ToString();
            string cEmail = Session["company"].ToString();
            string cName = nm != null ? nm : cEmail;

            string tech = txtTechScore.Text != "" ? txtTechScore.Text : "0";
            string apt = txtAptScore.Text != "" ? txtAptScore.Text : "0";
            string hr = txtHRScore.Text != "" ? txtHRScore.Text : "0";
            string gd = txtGDScore.Text != "" ? txtGDScore.Text : "0";
            string overall = getoverall();
            string decision = ddlRecommendation.SelectedValue;
            string rating = ddlRating.SelectedValue;
            string feedback = txtRemarks.Text.Replace("'", "''");

            if (ViewState["eval_id"] != null)
            {
                cmd = new SqlCommand("update Interview_Evaluation_tbl set Technical_Score='" + tech + "', Aptitude_Score='" + apt + "', HR_Score='" + hr + "', GD_Score='" + gd + "', Overall_Score='" + overall + "', Final_Decision='" + decision + "', Rating='" + rating + "', Feedback='" + feedback + "', Evaluated_Date=GETDATE() where Interview_Id='" + ViewState["eval_id"] + "'", con);
                cmd.ExecuteNonQuery();
            }
            else
            {
                cmd = new SqlCommand("insert into Interview_Evaluation_tbl(Interview_Id, Job_Id, Drive_Id, Company_Email, Company_Name, Student_Email, Student_Name, Enrollment_No, Technical_Score, Aptitude_Score, HR_Score, GD_Score, Overall_Score, Final_Decision, Rating, Feedback, Evaluated_Date) values('" + intId + "', '" + jId + "', '" + dId + "', '" + cEmail + "', '" + cName + "', '" + sEmail + "', '" + sName + "', '" + enroll + "', '" + tech + "', '" + apt + "', '" + hr + "', '" + gd + "', '" + overall + "', '" + decision + "', '" + rating + "', '" + feedback + "', GETDATE())", con);
                cmd.ExecuteNonQuery();
            }

            cmd = new SqlCommand("update Interview_Schedule_tbl set Status='Completed' where Interview_Id='" + intId + "'", con);
            cmd.ExecuteNonQuery();

            if (decision == "Selected for Offer")
            {
                cmd = new SqlCommand("update Application_tbl set Status='Selected' where Student_Email='" + sEmail + "' and Job_Id='" + jId + "'", con);
                cmd.ExecuteNonQuery();

                da = new SqlDataAdapter("select * from Selection_tbl where Student_Email='" + sEmail + "' and Job_Id='" + jId + "'", con);
                DataSet dsSel = new DataSet();
                da.Fill(dsSel);
                if (dsSel.Tables[0].Rows.Count == 0)
                {
                    string ctc = getctc(jId);
                    cmd = new SqlCommand("insert into Selection_tbl(Job_Id, Drive_Id, Company_Email, Company_Name, Job_Title, Student_Email, Student_Name, Enrollment_No, Department, Package_CTC, Offer_Date, Offer_Status, Created_Date) values('" + jId + "', '" + dId + "', '" + cEmail + "', '" + cName + "', '" + jTitle + "', '" + sEmail + "', '" + sName + "', '" + enroll + "', '" + dept + "', '" + ctc + "', GETDATE(), 'Offered', GETDATE())", con);
                    cmd.ExecuteNonQuery();
                    cmd = new SqlCommand("update Student_Reg_tbl set Placement_Status='Placed' where Email='" + sEmail + "'", con);
                    cmd.ExecuteNonQuery();
                }
            }
            else if (decision == "Rejected")
            {
                cmd = new SqlCommand("update Application_tbl set Status='Rejected' where Student_Email='" + sEmail + "' and Job_Id='" + jId + "'", con);
                cmd.ExecuteNonQuery();
            }

            Response.Write("<script>alert('Evaluation submitted successfully!');</script>");
            fillgrid();
            ddlInterviewSession.SelectedIndex = 0;
            pnlCandidateInfo.Visible = false;
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtTechScore.Text = "";
            txtAptScore.Text = "";
            txtHRScore.Text = "";
            txtGDScore.Text = "";
            ddlRating.SelectedIndex = 0;
            ddlRecommendation.SelectedIndex = 0;
            txtRemarks.Text = "";
            ddlInterviewSession.SelectedIndex = 0;
            pnlCandidateInfo.Visible = false;
        }

        protected void gvResults_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int evalid = Convert.ToInt32(e.CommandArgument);
            ViewState["evalid"] = evalid;

            if (e.CommandName == "edit_result")
            {
                getcon();
                da = new SqlDataAdapter("select * from Interview_Evaluation_tbl where Interview_Id='" + evalid + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string intId = ds.Tables[0].Rows[0]["Interview_Id"].ToString();
                    if (ddlInterviewSession.Items.FindByValue(intId) != null)
                    {
                        ddlInterviewSession.SelectedValue = intId;
                        ddlInterviewSession_SelectedIndexChanged(null, null);
                    }
                }
            }
            else if (e.CommandName == "delete_result")
            {
                getcon();
                cmd = new SqlCommand("delete from Interview_Evaluation_tbl where Interview_Id='" + evalid + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
            }
        }
    }
}
