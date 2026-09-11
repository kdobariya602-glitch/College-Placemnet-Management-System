﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Astra_PMS_Final_Exam.tpo
{
    public partial class company_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["tpo"] == null)
            {
                Response.Redirect("login.aspx");
            }
            if (!IsPostBack)
            {
                fillgrid();
            }
        }

        void fillgrid()
        {
            con = new SqlConnection(s);
            con.Open();
            da = new SqlDataAdapter("select * from Company_reg_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}