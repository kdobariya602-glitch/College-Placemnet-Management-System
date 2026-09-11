using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam.admin
{
    public partial class messages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                BindMessages();
            }
        }

        private void BindMessages()
        {
            List<ContactMessage> allMessages = ContactMessageStore.GetAll(this.Application);
            rptMessages.DataSource = allMessages;
            rptMessages.DataBind();

            lblNoMessages.Visible = allMessages.Count == 0;
        }
    }
}
