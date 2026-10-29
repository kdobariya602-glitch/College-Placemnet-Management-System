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
    public partial class academic_masters : System.Web.UI.Page
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
            fillall();
        }

        void clear()
        {
            cleardept();
            clearcourse();
            clearbatch();
            clearyear();
            clearseason();
        }

        void fillall()
        {
            filldepts();
            fillcourses();
            fillbatches();
            fillyears();
            fillseasons();
        }

        void filldepts()
        {
            getcon();
            da = new SqlDataAdapter("select * from Department_tbl order by Dept_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvDepts.DataSource = ds;
            gvDepts.DataBind();

            ddlCourseDept.DataSource = ds;
            ddlCourseDept.DataTextField = "Dept_Name";
            ddlCourseDept.DataValueField = "Dept_Name";
            ddlCourseDept.DataBind();
        }

        void fillcourses()
        {
            getcon();
            da = new SqlDataAdapter("select * from Course_tbl order by Course_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvCourses.DataSource = ds;
            gvCourses.DataBind();
        }

        void fillbatches()
        {
            getcon();
            da = new SqlDataAdapter("select * from Batch_tbl order by Batch_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvBatches.DataSource = ds;
            gvBatches.DataBind();
        }

        void fillyears()
        {
            getcon();
            da = new SqlDataAdapter("select * from Academic_Year_tbl order by Year_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvYears.DataSource = ds;
            gvYears.DataBind();
        }

        void fillseasons()
        {
            getcon();
            da = new SqlDataAdapter("select * from Placement_Season_tbl order by Season_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            gvSeasons.DataSource = ds;
            gvSeasons.DataBind();
        }

        protected void btnAddDept_Click(object sender, EventArgs e)
        {
            if (txtDeptName.Text != "" && txtDeptCode.Text != "")
            {
                getcon();
                cmd = new SqlCommand("insert into Department_tbl (Dept_Name, Dept_Code, HOD_Name, HOD_Email, HOD_Phone, Status) values ('" + txtDeptName.Text + "', '" + txtDeptCode.Text + "', '" + txtDeptHOD.Text + "', '" + txtDeptEmail.Text + "', '" + txtDeptPhone.Text + "', 'Active')", con);
                cmd.ExecuteNonQuery();

                cleardept();
                Response.Write("<script>alert('Department created successfully.');</script>");
                filldepts();
            }
            else
            {
                Response.Write("<script>alert('Department name and code are required.');</script>");
            }
        }

        protected void gvDepts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string dept_id = e.CommandArgument.ToString();

            if (e.CommandName == "delete_dept")
            {
                getcon();
                cmd = new SqlCommand("delete from Department_tbl where Dept_Id = '" + dept_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Department removed.');</script>");
                filldepts();
            }
        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            if (txtCourseName.Text != "" && txtCourseCode.Text != "")
            {
                getcon();
                cmd = new SqlCommand("insert into Course_tbl (Course_Name, Course_Code, Dept_Name, Degree_Level, Duration_Years, Semester_Count, Status) values ('" + txtCourseName.Text + "', '" + txtCourseCode.Text + "', '" + ddlCourseDept.SelectedValue + "', '" + ddlDegreeLevel.SelectedValue + "', '" + txtCourseDuration.Text + "', '" + txtCourseSemCount.Text + "', 'Active')", con);
                cmd.ExecuteNonQuery();

                clearcourse();
                Response.Write("<script>alert('Course created successfully.');</script>");
                fillcourses();
            }
            else
            {
                Response.Write("<script>alert('Course name and code are required.');</script>");
            }
        }

        protected void gvCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string course_id = e.CommandArgument.ToString();

            if (e.CommandName == "delete_course")
            {
                getcon();
                cmd = new SqlCommand("delete from Course_tbl where Course_Id = '" + course_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Course removed.');</script>");
                fillcourses();
            }
        }

        protected void btnAddBatch_Click(object sender, EventArgs e)
        {
            if (txtBatchName.Text != "")
            {
                getcon();
                cmd = new SqlCommand("insert into Batch_tbl (Batch_Name, Start_Year, End_Year, Coordinator_Name, Intake, Status) values ('" + txtBatchName.Text + "', '" + txtBatchStartYear.Text + "', '" + txtBatchEndYear.Text + "', '" + txtBatchCoord.Text + "', '" + txtBatchIntake.Text + "', 'Active')", con);
                cmd.ExecuteNonQuery();

                clearbatch();
                Response.Write("<script>alert('Batch created successfully.');</script>");
                fillbatches();
            }
            else
            {
                Response.Write("<script>alert('Batch name is required.');</script>");
            }
        }

        protected void gvBatches_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string batch_id = e.CommandArgument.ToString();

            if (e.CommandName == "delete_batch")
            {
                getcon();
                cmd = new SqlCommand("delete from Batch_tbl where Batch_Id = '" + batch_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Batch removed.');</script>");
                fillbatches();
            }
        }

        protected void btnAddYear_Click(object sender, EventArgs e)
        {
            if (txtYearName.Text != "")
            {
                getcon();
                cmd = new SqlCommand("insert into Academic_Year_tbl (Year_Name, Start_Date, End_Date, Is_Current, Status) values ('" + txtYearName.Text + "', '" + txtYearStart.Text + "', '" + txtYearEnd.Text + "', 0, 'Active')", con);
                cmd.ExecuteNonQuery();

                clearyear();
                Response.Write("<script>alert('Academic Year added.');</script>");
                fillyears();
            }
            else
            {
                Response.Write("<script>alert('Academic year name is required.');</script>");
            }
        }

        protected void gvYears_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string year_id = e.CommandArgument.ToString();

            if (e.CommandName == "set_current")
            {
                getcon();
                cmd = new SqlCommand("update Academic_Year_tbl set Is_Current = 0; update Academic_Year_tbl set Is_Current = 1 where Year_Id = '" + year_id + "'", con);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Active academic year updated.');</script>");
                fillyears();
            }
        }

        protected void btnAddSeason_Click(object sender, EventArgs e)
        {
            if (txtSeasonName.Text != "")
            {
                getcon();
                cmd = new SqlCommand("insert into Placement_Season_tbl (Season_Name, Start_Date, End_Date, Description, Is_Active, Status) values ('" + txtSeasonName.Text + "', '" + txtSeasonStart.Text + "', '" + txtSeasonEnd.Text + "', '" + txtSeasonDesc.Text + "', 1, 'Active')", con);
                cmd.ExecuteNonQuery();

                clearseason();
                Response.Write("<script>alert('Placement season created.');</script>");
                fillseasons();
            }
            else
            {
                Response.Write("<script>alert('Season name is required.');</script>");
            }
        }

        protected void gvSeasons_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string season_id = e.CommandArgument.ToString();

            if (e.CommandName == "delete_season")
            {
                getcon();
                cmd = new SqlCommand("delete from Placement_Season_tbl where Season_Id = '" + season_id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Placement season removed.');</script>");
                fillseasons();
            }
        }

        void cleardept()
        {
            txtDeptName.Text = "";
            txtDeptCode.Text = "";
            txtDeptHOD.Text = "";
            txtDeptEmail.Text = "";
            txtDeptPhone.Text = "";
        }

        void clearcourse()
        {
            txtCourseName.Text = "";
            txtCourseCode.Text = "";
            txtCourseDuration.Text = "";
            txtCourseSemCount.Text = "";
        }

        void clearbatch()
        {
            txtBatchName.Text = "";
            txtBatchStartYear.Text = "";
            txtBatchEndYear.Text = "";
            txtBatchCoord.Text = "";
            txtBatchIntake.Text = "";
        }

        void clearyear()
        {
            txtYearName.Text = "";
            txtYearStart.Text = "";
            txtYearEnd.Text = "";
        }

        void clearseason()
        {
            txtSeasonName.Text = "";
            txtSeasonStart.Text = "";
            txtSeasonEnd.Text = "";
            txtSeasonDesc.Text = "";
        }
    }
}
