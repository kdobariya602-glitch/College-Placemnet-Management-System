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
    public partial class dashboard : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string fnm, nm;
        int i;

        // chart data (aspx script ma <%= %> thi print thay che) - real DB data
        public string chartDeptLabels = "[]";
        public string chartDeptPlaced = "[]";
        public string chartDeptPipe = "[]";
        public string chartRatio = "[0,0]";
        public string actionItems = "";
        public int actionCount = 0;
        public string placementPct = "0";

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
                    fillstats();
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void fillstats()
        {
            getcon();

            // ---- department wise placed / in pipeline (real data) ----
            da = new SqlDataAdapter("select s.Branch, sum(case when isnull(s.Placement_Status,'')='Placed' then 1 else 0 end) as Placed, sum(case when isnull(s.Placement_Status,'')<>'Placed' and a.Student_Email is not null then 1 else 0 end) as Pipe from Student_Reg_tbl s left join (select distinct Student_Email from Application_tbl) a on s.Email = a.Student_Email where isnull(s.Branch,'')<>'' group by s.Branch order by s.Branch", con);
            DataSet dsD = new DataSet();
            da.Fill(dsD);
            string dL = "";
            string dP = "";
            string dQ = "";
            for (int r = 0; r < dsD.Tables[0].Rows.Count; r++)
            {
                if (r > 0) { dL += ","; dP += ","; dQ += ","; }
                dL += "'" + dsD.Tables[0].Rows[r]["Branch"].ToString() + "'";
                dP += dsD.Tables[0].Rows[r]["Placed"].ToString();
                dQ += dsD.Tables[0].Rows[r]["Pipe"].ToString();
            }
            chartDeptLabels = "[" + dL + "]";
            chartDeptPlaced = "[" + dP + "]";
            chartDeptPipe = "[" + dQ + "]";

            da = new SqlDataAdapter("select (select count(*) from Student_Reg_tbl where isnull(Placement_Status,'')='Placed') as Pl, (select count(*) from Student_Reg_tbl where isnull(Placement_Status,'')<>'Placed') as Un", con);
            DataSet dsRt = new DataSet();
            da.Fill(dsRt);
            chartRatio = "[" + dsRt.Tables[0].Rows[0]["Pl"].ToString() + "," + dsRt.Tables[0].Rows[0]["Un"].ToString() + "]";
            da = new SqlDataAdapter("select * from Student_Reg_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalStudents.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Selection_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPlacedStudents.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Company_reg_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalCompanies.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Job_tbl where Status = 'Published'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblActiveJobs.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Placement_Drive_tbl where Status = 'Open'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblActiveDrives.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Application_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalApplications.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Training_Program_tbl where Status = 'Active'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTrainingCount.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Company_reg_tbl where Verification_Status = 'Pending' or Verification_Status is null", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPendingCompanies.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Grievance_tbl where Status in ('Open', 'Pending', 'In Review')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblOpenGrievances.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select * from Application_tbl where Status in ('Applied', 'Submitted', 'Under Review')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPendingApps.Text = ds.Tables[0].Rows.Count.ToString();

            da = new SqlDataAdapter("select count(*) from Student_Reg_tbl where isnull(Account_Status,'') in ('Pending', 'Unverified', 'Under Review')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPendingStudents.Text = ds.Tables[0].Rows.Count > 0 ? ds.Tables[0].Rows[0][0].ToString() : "0";

            lblActiveJobCount.Text = lblActiveJobs.Text;

            fillactions();
        }

        int getcount(string sqlstr)
        {
            getcon();
            da = new SqlDataAdapter(sqlstr, con);
            DataSet dsCount = new DataSet();
            da.Fill(dsCount);
            if (dsCount.Tables[0].Rows.Count > 0 && dsCount.Tables[0].Rows[0][0] != DBNull.Value)
            {
                return Convert.ToInt32(dsCount.Tables[0].Rows[0][0]);
            }
            return 0;
        }

        void addaction(int n, string icon, string color, string text, string link)
        {
            if (n > 0)
            {
                actionItems += "<a href='" + link + "' class='d-flex align-items-center justify-content-between text-decoration-none py-2 border-bottom'><span class='small fw-semibold text-dark'><i class='bi " + icon + " text-" + color + " me-2 fs-5'></i>" + text + "</span><span class='badge bg-" + color + " rounded-pill'>" + n + "</span></a>";
                actionCount++;
            }
        }

        // admin mate "Action Required" - jya turant dhyan aapvu joiye te badhu ek jagya e
        void fillactions()
        {
            actionItems = "";
            actionCount = 0;
            addaction(getcount("select count(*) from Company_reg_tbl where Verification_Status = 'Pending' or Verification_Status is null"), "bi-building-check", "warning", "Companies waiting for verification", "company-verification.aspx");
            addaction(getcount("select count(*) from Grievance_tbl where Status in ('Open', 'Pending', 'In Review')"), "bi-chat-left-text", "danger", "Open student grievances", "grievances.aspx");
            addaction(getcount("select count(*) from Application_tbl where Status in ('Applied', 'Submitted', 'Under Review')"), "bi-file-earmark-text", "primary", "Applications not yet reviewed", "applications.aspx");
            addaction(getcount("select count(*) from Job_tbl where Status in ('Published','Active','Open') and App_Deadline between cast(getdate() as date) and dateadd(day,3,cast(getdate() as date))"), "bi-alarm", "danger", "Jobs closing in next 3 days", "jobs.aspx");
            addaction(getcount("select count(*) from Selection_tbl where isnull(Offer_Status,'') not in ('Accepted','Declined')"), "bi-envelope-paper", "info", "Offers waiting for student response", "selections.aspx");
            addaction(getcount("select count(*) from Student_Reg_tbl where isnull(Resume_File,'')='' and isnull(Placement_Status,'')<>'Placed'"), "bi-file-earmark-person", "secondary", "Unplaced students without a resume", "students.aspx");

            int total = getcount("select count(*) from Student_Reg_tbl");
            int placed = getcount("select count(*) from Student_Reg_tbl where isnull(Placement_Status,'')='Placed'");
            if (total > 0) placementPct = Math.Round(placed * 100.0 / total, 1).ToString();

            if (actionCount == 0)
            {
                actionItems = "<div class='text-center text-success py-3'><i class='bi bi-check-circle-fill fs-3'></i><div class='fw-semibold mt-1'>Nothing pending - everything is up to date.</div></div>";
            }
        }

        public string GetStudentPhoto(object photoObj, object nameObj)
        {
            string photo = photoObj != null ? photoObj.ToString().Trim() : "";
            string name = nameObj != null ? nameObj.ToString().Trim() : "Student";
            if (!string.IsNullOrEmpty(photo))
            {
                string path = photo;
                if (!path.StartsWith("http") && !path.StartsWith("/") && !path.StartsWith("~"))
                {
                    path = ResolveUrl("~/uploads/profiles/" + photo);
                }
                else
                {
                    path = ResolveUrl(path);
                }
                return string.Format("<img src='{0}' alt='{1}' class='rounded-circle border me-2 shadow-sm' style='width:34px; height:34px; min-width:34px; object-fit:cover;' onerror=\"this.onerror=null; this.src='../assets/images/default-avatar.svg';\" />", path, Server.HtmlEncode(name));
            }
            return "<img src='../assets/images/default-avatar.svg' alt='Avatar' class='rounded-circle border me-2 shadow-sm' style='width:34px; height:34px; min-width:34px; object-fit:cover;' />";
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select top 5 * from Placement_Drive_tbl order by Drive_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvDrives.DataSource = ds;
            gvDrives.DataBind();

            da = new SqlDataAdapter("select top 5 * from Selection_tbl order by Selection_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvSelections.DataSource = ds;
            gvSelections.DataBind();

            da = new SqlDataAdapter("select top 5 * from Student_Reg_tbl order by Student_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvStudents.DataSource = ds;
            gvStudents.DataBind();

            // Bind ASP.NET Chart Controls
            ChartAdminDept.Series["Placed"].Points.Clear();
            da = new SqlDataAdapter("select top 5 d.Dept_Name, (select count(*) from Selection_tbl s where s.Department=d.Dept_Name) as PlacedCount from Department_tbl d order by d.Dept_Id", con);
            DataSet dsDeptChart = new DataSet();
            da.Fill(dsDeptChart);
            for (int r = 0; r < dsDeptChart.Tables[0].Rows.Count; r++)
            {
                string dName = dsDeptChart.Tables[0].Rows[r]["Dept_Name"].ToString();
                int pCnt = Convert.ToInt32(dsDeptChart.Tables[0].Rows[r]["PlacedCount"]);
                ChartAdminDept.Series["Placed"].Points.AddXY(dName, pCnt);
            }

            int placedTotal = getcount("select count(distinct Student_Email) from Selection_tbl");
            int studentTotal = getcount("select count(*) from Student_Reg_tbl");
            int activeTotal = 0;
            if (studentTotal > placedTotal)
            {
                activeTotal = studentTotal - placedTotal;
            }

            ChartAdminRatio.Series["Series1"].Points.Clear();
            int pt1 = ChartAdminRatio.Series["Series1"].Points.AddXY("Placed", placedTotal);
            int pt2 = ChartAdminRatio.Series["Series1"].Points.AddXY("In Process", activeTotal);
            ChartAdminRatio.Series["Series1"].Points[pt1].Color = System.Drawing.ColorTranslator.FromHtml("#1D4ED8");
            ChartAdminRatio.Series["Series1"].Points[pt2].Color = System.Drawing.ColorTranslator.FromHtml("#93C5FD");
        }
    
        protected void gvDrives_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view_drive")
            {
                Session["did"] = e.CommandArgument.ToString();
                Response.Redirect("drive-details.aspx");
            }
        }

        protected void gvSelections_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view_student")
            {
                Session["stuid"] = e.CommandArgument.ToString();
                Response.Redirect("student-details.aspx");
            }
        }

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view_student")
            {
                Session["stuid"] = e.CommandArgument.ToString();
                Response.Redirect("student-details.aspx");
            }
        }
    }
}