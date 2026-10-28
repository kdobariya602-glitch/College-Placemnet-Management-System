using System;

namespace Astra_PMS_Final_Exam
{
    public partial class login : System.Web.UI.Page
    {
        // Student sign-in / forgot-password on this page are handled fully
        // client-side (App.login / App.resetPassword in assets/js/app.js,
        // against the localStorage data seeded from assets/js/data.js) via
        // OnClientClick on signInBtn / resetBtn in login.aspx. No server
        // postback and no SQL Server (Student_reg_tbl) involved here.
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void signInBtn_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {

        }
    }
}
