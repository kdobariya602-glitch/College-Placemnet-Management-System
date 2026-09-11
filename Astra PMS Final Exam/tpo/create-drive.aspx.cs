﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam.tpo
{
    public partial class create_drive : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["tpo"] == null)
            {
                Response.Redirect("login.aspx");
            }
        }
    }
}