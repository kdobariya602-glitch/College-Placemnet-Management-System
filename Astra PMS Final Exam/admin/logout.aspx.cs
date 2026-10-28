using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam.admin
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["admin"] = null;
            Session.Clear();
            Session.Abandon();

            // Clear the client-side display session (sidebar/navbar identity) alongside
            // the server-side auth session. Does not affect DB-driven authentication.
            Response.Write("<script>try{sessionStorage.removeItem('pms_session');}catch(e){}window.location.href='login.aspx';</script>");
            Response.End();
        }
    }
}
