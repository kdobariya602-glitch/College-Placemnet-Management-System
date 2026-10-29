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
    public partial class talent_match : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

       
        public string summaryHtml = "";
        public string rankHtml = "";
        public string coverageHtml = "";

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
                if (!IsPostBack)
                {
                    filljobs();
                }
                fillrank();
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void filljobs()
        {
            getcon();
            da = new SqlDataAdapter("select Job_Id, Job_Title from Job_tbl where Company_Email='" + Session["company"].ToString() + "' order by Job_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count == 0)
            {
                da = new SqlDataAdapter("select Job_Id, Job_Title from Job_tbl order by Job_Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            ddlJob.DataSource = ds;
            ddlJob.DataTextField = "Job_Title";
            ddlJob.DataValueField = "Job_Id";
            ddlJob.DataBind();
        }

        protected void ddlJob_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        List<string> splitskills(string csv)
        {
            List<string> l = new List<string>();
            string[] p = csv.Split(new char[] { ',', ';', '/', '|' }, StringSplitOptions.RemoveEmptyEntries);
            for (int k = 0; k < p.Length; k++)
            {
                if (p[k].Trim() != "") l.Add(p[k].Trim());
            }
            return l;
        }

        string norm(string t)
        {
            return t.Trim().ToLower();
        }

        bool hasskill(List<string> mine, string req)
        {
            for (int k = 0; k < mine.Count; k++)
            {
                if (norm(mine[k]) == norm(req)) return true;
            }
            return false;
        }

        double num(object o)
        {
            if (o != null && o != DBNull.Value && o.ToString().Trim() != "")
            {
                return Convert.ToDouble(o);
            }
            return 0;
        }

        void fillrank()
        {
            summaryHtml = "";
            rankHtml = "";
            coverageHtml = "";
            if (ddlJob.Items.Count == 0 || ddlJob.SelectedValue == "")
            {
                rankHtml = "<div class='text-center text-muted py-4'>Post a job first to see ranked candidates.</div>";
                return;
            }

            getcon();
            string ce = Session["company"].ToString();
            da = new SqlDataAdapter("select * from Job_tbl where Job_Id='" + ddlJob.SelectedValue + "' and Company_Email='" + ce + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count == 0) return;
                        List<string> req = splitskills(ds.Tables[0].Rows[0]["Required_Skills"].ToString());
            double minCg = num(ds.Tables[0].Rows[0]["Min_CGPA"]);
            int maxB = 99;
            if (ds.Tables[0].Rows[0]["Max_Backlogs"] != DBNull.Value && ds.Tables[0].Rows[0]["Max_Backlogs"].ToString() != "")
            {
                maxB = Convert.ToInt32(ds.Tables[0].Rows[0]["Max_Backlogs"]);
            }

            da = new SqlDataAdapter("select a.Application_Id as AppId, a.Status as AppStatus, s.Full_Name, s.Branch, s.Cgpa, s.Skills, s.Active_Backlogs, s.Tenth_Pct, s.Twelfth_Pct, s.Resume_File, s.Photo_File from Application_tbl a inner join Student_Reg_tbl s on s.Email = a.Student_Email where a.Job_Id='" + ddlJob.SelectedValue + "' and a.Company_Email='" + ce + "'", con);
            DataSet dc = new DataSet();
            da.Fill(dc);

            DataTable dtCand = new DataTable();
            dtCand.Columns.Add("AppId", typeof(string));
            dtCand.Columns.Add("Name", typeof(string));
            dtCand.Columns.Add("Branch", typeof(string));
            dtCand.Columns.Add("Status", typeof(string));
            dtCand.Columns.Add("Chips", typeof(string));
            dtCand.Columns.Add("Flags", typeof(string));
            dtCand.Columns.Add("Cgpa", typeof(double));
            dtCand.Columns.Add("Score", typeof(int));
            dtCand.Columns.Add("Matched", typeof(int));

            int[] cover = new int[req.Count];
            int meetCut = 0;

            for (int r = 0; r < dc.Tables[0].Rows.Count; r++)
            {
                List<string> mine = splitskills(dc.Tables[0].Rows[r]["Skills"].ToString());
                string appId = dc.Tables[0].Rows[r]["AppId"].ToString();
                string cName = dc.Tables[0].Rows[r]["Full_Name"].ToString();
                string branch = dc.Tables[0].Rows[r]["Branch"].ToString();
                string status = dc.Tables[0].Rows[r]["AppStatus"].ToString();
                double cgpa = num(dc.Tables[0].Rows[r]["Cgpa"]);
                int matched = 0;

                for (int k = 0; k < req.Count; k++)
                {
                    if (hasskill(mine, req[k]))
                    {
                        matched++;
                        cover[k]++;
                    }
                }
                int skillPct = 50;
                if (req.Count > 0) skillPct = matched * 100 / req.Count;
                string chips = matched + "/" + req.Count;

                int backlogs = (int)num(dc.Tables[0].Rows[r]["Active_Backlogs"]);
                double t10 = num(dc.Tables[0].Rows[r]["Tenth_Pct"]);
                double t12 = num(dc.Tables[0].Rows[r]["Twelfth_Pct"]);
                double acad = (t10 + t12) / 2.0;

                double sc = 0;
                sc += Math.Min(cgpa, 10) / 10.0 * 30;      // CGPA 30
                sc += skillPct * 35 / 100.0;                  // skills 35
                if (backlogs == 0) sc += 10; else if (backlogs <= maxB) sc += 5;   // backlogs 10
                sc += Math.Min(acad, 100) / 100.0 * 15;       // 10th/12th 15
                if (dc.Tables[0].Rows[r]["Resume_File"].ToString() != "") sc += 6;   // profile 10
                if (dc.Tables[0].Rows[r]["Skills"].ToString().Trim() != "") sc += 2;
                if (dc.Tables[0].Rows[r]["Photo_File"].ToString() != "") sc += 2;
                int score = (int)Math.Round(sc);

                string flags = "";
                bool cut = true;
                if (cgpa < minCg) { flags += "<span class='badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 me-1'>Below CGPA cutoff</span>"; cut = false; }
                if (backlogs > maxB) { flags += "<span class='badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 me-1'>Backlogs over limit</span>"; cut = false; }
                if (dc.Tables[0].Rows[r]["Resume_File"].ToString() == "") flags += "<span class='badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 me-1'>No resume</span>";
                if (cut) meetCut++;

                dtCand.Rows.Add(appId, cName, branch, status, chips, flags, cgpa, score, matched);
            }

            DataView dv = dtCand.DefaultView;
            dv.Sort = "Score desc";
            DataTable dtSorted = dv.ToTable();

            // ---- summary ----
            int sum = 0;
            for (int k = 0; k < dtSorted.Rows.Count; k++) sum += Convert.ToInt32(dtSorted.Rows[k]["Score"]);
            int avg = 0;
            if (dtSorted.Rows.Count > 0) avg = sum / dtSorted.Rows.Count;
            string top = "-";
            if (dtSorted.Rows.Count > 0) top = Server.HtmlEncode(dtSorted.Rows[0]["Name"].ToString()) + " (" + dtSorted.Rows[0]["Score"] + ")";
            summaryHtml = "<div class='row g-3 mb-4'>"
                + "<div class='col-6 col-lg-3'><div class='content-card p-3 text-center'><div class='fs-3 fw-bold text-primary'>" + dtSorted.Rows.Count + "</div><div class='small text-muted'>Applicants</div></div></div>"
                + "<div class='col-6 col-lg-3'><div class='content-card p-3 text-center'><div class='fs-3 fw-bold text-success'>" + avg + "</div><div class='small text-muted'>Average match score</div></div></div>"
                + "<div class='col-6 col-lg-3'><div class='content-card p-3 text-center'><div class='fs-3 fw-bold text-info'>" + meetCut + "/" + dtSorted.Rows.Count + "</div><div class='small text-muted'>Meet your cutoffs</div></div></div>"
                + "<div class='col-6 col-lg-3'><div class='content-card p-3 text-center'><div class='fw-bold text-dark'>" + top + "</div><div class='small text-muted'>Top candidate</div></div></div></div>";

            // ---- ranked table ----
            if (dtSorted.Rows.Count == 0)
            {
                rankHtml = "<div class='text-center text-muted py-4'>No applicants for this job yet.</div>";
            }
            else
            {
                rankHtml = "<div class='table-responsive'><table id='tblRanked' class='table align-middle'><thead><tr><th>#</th><th>Candidate</th><th>CGPA</th><th>Skills matched</th><th style='min-width:170px'>Match score</th><th>Status</th><th>Flags</th><th></th></tr></thead><tbody>";
                for (int k = 0; k < dtSorted.Rows.Count; k++)
                {
                                        int cScore = Convert.ToInt32(dtSorted.Rows[k]["Score"]);
                    string cStatus = dtSorted.Rows[k]["Status"].ToString();
                    string cFlags = dtSorted.Rows[k]["Flags"].ToString();
                    string col = "secondary";
                    string tier = "Average";
                    if (cScore >= 75) { col = "success"; tier = "Top Match"; }
                    else if (cScore >= 55) { col = "primary"; tier = "Good Fit"; }
                    string sc2 = "secondary";
                    if (cStatus == "Selected") sc2 = "success";
                    else if (cStatus == "Shortlisted") sc2 = "primary";
                    else if (cStatus == "Rejected") sc2 = "danger";
                    string hasCutViolation = "1";
                    if (cFlags.Contains("Below") || cFlags.Contains("limit"))
                    {
                        hasCutViolation = "0";
                    }
                    rankHtml += "<tr class='cand-row' data-score='" + cScore + "' data-status='" + Server.HtmlEncode(cStatus) + "' data-cut='" + hasCutViolation + "'>"
                        + "<td class='fw-bold'>" + (k + 1) + "</td>"
                        + "<td><div class='fw-semibold text-dark cand-name'>" + Server.HtmlEncode(dtSorted.Rows[k]["Name"].ToString()) + "</div><small class='text-muted cand-branch'>" + Server.HtmlEncode(dtSorted.Rows[k]["Branch"].ToString()) + "</small></td>"
                        + "<td class='cand-cgpa'>" + dtSorted.Rows[k]["Cgpa"] + "</td>"
                        + "<td><span class='badge bg-light text-dark border'>" + dtSorted.Rows[k]["Chips"] + "</span></td>"
                        + "<td><div class='d-flex justify-content-between small'><span class='fw-bold cand-score'>" + cScore + "/100</span><span class='text-" + col + "'>" + tier + "</span></div><div class='progress' style='height:7px'><div class='progress-bar bg-" + col + "' style='width:" + cScore + "%'></div></div></td>"
                        + "<td><span class='badge bg-" + sc2 + " cand-status'>" + Server.HtmlEncode(cStatus) + "</span></td>"
                        + "<td>" + cFlags + "</td>"
                        + "<td><a href='applicant-details.aspx?id=" + dtSorted.Rows[k]["AppId"] + "' class='btn btn-sm btn-outline-primary'>View</a></td></tr>";
                }
                rankHtml += "</tbody></table></div>";
            }

            // ---- skill coverage of the applicant pool ----
            for (int k = 0; k < req.Count; k++)
            {
                int pct = 0;
                if (dtSorted.Rows.Count > 0) pct = cover[k] * 100 / dtSorted.Rows.Count;
                string col = "danger";
                if (pct >= 60) col = "success";
                else if (pct >= 30) col = "warning";
                coverageHtml += "<div class='mb-3'><div class='d-flex justify-content-between small'><span class='fw-semibold text-dark'>" + Server.HtmlEncode(req[k]) + "</span><span class='text-muted'>" + cover[k] + " of " + dtSorted.Rows.Count + " applicants (" + pct + "%)</span></div>"
                    + "<div class='progress' style='height:8px'><div class='progress-bar bg-" + col + "' style='width:" + pct + "%'></div></div></div>";
            }
            if (req.Count == 0)
            {
                coverageHtml = "<div class='text-muted small'>This job has no required skills listed.</div>";
            }
        }

        protected void btnAutoShortlist_Click(object sender, EventArgs e)
        {
            if (ddlJob.Items.Count == 0 || ddlJob.SelectedValue == "") return;
            getcon();
            string ce = Session["company"].ToString();
            string jobId = ddlJob.SelectedValue;

            da = new SqlDataAdapter("select * from Job_tbl where Job_Id='" + jobId + "' and Company_Email='" + ce + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count == 0) return;
                        string jTitle = ds.Tables[0].Rows[0]["Job_Title"].ToString();
            string dId = "0";
            if (ds.Tables[0].Columns.Contains("Drive_Id"))
            {
                dId = ds.Tables[0].Rows[0]["Drive_Id"].ToString();
            }
            string cName = ds.Tables[0].Rows[0]["Company_Name"].ToString();
            if (cName == "")
            {
                cName = ce;
            }

            List<string> req = splitskills(ds.Tables[0].Rows[0]["Required_Skills"].ToString());
            double minCg = num(ds.Tables[0].Rows[0]["Min_CGPA"]);
            int maxB = 99;
            if (ds.Tables[0].Rows[0]["Max_Backlogs"] != DBNull.Value && ds.Tables[0].Rows[0]["Max_Backlogs"].ToString() != "")
            {
                maxB = Convert.ToInt32(ds.Tables[0].Rows[0]["Max_Backlogs"]);
            }

            da = new SqlDataAdapter("select a.Application_Id as AppId, a.Status as AppStatus, a.Student_Email, s.Full_Name, s.Branch, s.Cgpa, s.Skills, s.Active_Backlogs, s.Tenth_Pct, s.Twelfth_Pct, s.Resume_File, s.Photo_File from Application_tbl a inner join Student_Reg_tbl s on s.Email = a.Student_Email where a.Job_Id='" + jobId + "' and a.Company_Email='" + ce + "'", con);
            DataSet dc = new DataSet();
            da.Fill(dc);

            int shortlistedCount = 0;
            for (int r = 0; r < dc.Tables[0].Rows.Count; r++)
            {
                string appId = dc.Tables[0].Rows[r]["AppId"].ToString();
                string curStatus = dc.Tables[0].Rows[r]["AppStatus"].ToString();
                string sEmail = dc.Tables[0].Rows[r]["Student_Email"].ToString();
                string sName = dc.Tables[0].Rows[r]["Full_Name"].ToString();

                if (curStatus == "Shortlisted" || curStatus == "Selected") continue;

                List<string> mine = splitskills(dc.Tables[0].Rows[r]["Skills"].ToString());
                int matched = 0;
                for (int k = 0; k < req.Count; k++) { if (hasskill(mine, req[k])) matched++; }
                int skillPct = 50;
                if (req.Count > 0) skillPct = matched * 100 / req.Count;
                int backlogs = (int)num(dc.Tables[0].Rows[r]["Active_Backlogs"]);
                double t10 = num(dc.Tables[0].Rows[r]["Tenth_Pct"]);
                double t12 = num(dc.Tables[0].Rows[r]["Twelfth_Pct"]);
                double acad = (t10 + t12) / 2.0;

                double sc = 0;
                sc += Math.Min(num(dc.Tables[0].Rows[r]["Cgpa"]), 10) / 10.0 * 30;
                sc += skillPct * 35 / 100.0;
                if (backlogs == 0) sc += 10; else if (backlogs <= maxB) sc += 5;
                sc += Math.Min(acad, 100) / 100.0 * 15;
                if (dc.Tables[0].Rows[r]["Resume_File"].ToString() != "") sc += 6;
                if (dc.Tables[0].Rows[r]["Skills"].ToString().Trim() != "") sc += 2;
                if (dc.Tables[0].Rows[r]["Photo_File"].ToString() != "") sc += 2;
                int totalScore = (int)Math.Round(sc);

                if (totalScore >= 75)
                {
                    cmd = new SqlCommand("update Application_tbl set Status='Shortlisted' where Application_Id='" + appId + "'", con);
                    cmd.ExecuteNonQuery();

                    SqlDataAdapter daS = new SqlDataAdapter("select * from Shortlist_tbl where Application_Id='" + appId + "'", con);
                    DataSet dsS = new DataSet();
                    daS.Fill(dsS);
                    if (dsS.Tables[0].Rows.Count == 0)
                    {
                        cmd = new SqlCommand("insert into Shortlist_tbl(Application_Id, Job_Id, Drive_Id, Company_Email, Company_Name, Student_Email, Student_Name, Job_Title, Shortlisted_Date, Status) values('" + appId + "', '" + jobId + "', '" + dId + "', '" + ce + "', '" + cName + "', '" + sEmail + "', '" + sName + "', '" + jTitle + "', GETDATE(), 'Shortlisted')", con);
                        cmd.ExecuteNonQuery();
                    }
                    shortlistedCount++;
                }
            }

            lblMsg.Text = "⚡ AI Auto-Shortlisting Complete: " + shortlistedCount + " top-matched candidate(s) (Score >= 75%) shortlisted successfully!";
fillrank();
        }
    }
}

