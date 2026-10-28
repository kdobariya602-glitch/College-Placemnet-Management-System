using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam.student
{
    public partial class Student_Site2 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Server-side access control (spec #14), in addition to the
            // client-side App.requireAuth() guard each page already runs:
            // every page that uses this master requires a DB-authenticated
            // student session (set by student/login.aspx.cs on sign-in).
            // This stops a direct/no-JS request from reaching a student page
            // without having authenticated against Student_reg_tbl first.
            if (Session["student"] == null)
            {
                Response.Redirect("~/student/login.aspx", true);
            }
        }
    }
}