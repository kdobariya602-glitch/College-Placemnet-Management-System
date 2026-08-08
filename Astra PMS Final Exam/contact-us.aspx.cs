using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Astra_PMS_Final_Exam
{
    public partial class contact_us : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            lblFullName.Text = "Full Name: " + txtFullName.Text;
            lblEmail.Text = "Email: " + txtEmail.Text;
            lblPhone.Text = "Phone: " + txtPhone.Text;
            lblCity.Text = "City: " + txtCity.Text;
            lblMessage.Text = "Message: " + txtMessage.Text;

            // Save this inquiry so the Admin can see it under Admin > Contact Messages
            ContactMessage msg = new ContactMessage
            {
                FullName = txtFullName.Text,
                Email = txtEmail.Text,
                Phone = txtPhone.Text,
                City = txtCity.Text,
                Message = txtMessage.Text,
                SubmittedOn = DateTime.Now
            };
            ContactMessageStore.Add(this.Application, msg);
        }
    }
}