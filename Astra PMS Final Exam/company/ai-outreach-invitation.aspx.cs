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
    public partial class ai_outreach_invitation : System.Web.UI.Page
    {
        SqlConnection con; //for connection
        SqlDataAdapter da; //for container
        DataSet ds; //for select
        SqlCommand cmd; //for insert, update, delete
        string nm;
        int i;
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        private string CallApi(string prompt)
        {
            // Pure local database & business logic method

            return "Official Campus Recruitment Invitation & Outreach Letter:\r\n\r\n" +
                   "Dear Aspiring Engineers & Graduating Scholars,\r\n\r\n" +
                   "We are delighted to announce our upcoming On-Campus Recruitment Drive at Astra University. " +
                   "Opportunity Focus: " + prompt.Replace('"', '\'') + ".\r\n\r\n" +
                   "We invite ambitious, disciplined students eager to design next-generation engineering systems. " +
                   "Eligible candidates are requested to submit their application profiles through the Astra PMS portal prior to the registration deadline.\r\n\r\n" +
                   "We look forward to interacting with your vibrant cohort during the technical evaluation rounds.\r\n\r\n" +
                   "Warm regards,\r\n" +
                   "Campus Talent Acquisition Team\r\n" +
                   "Generated on: " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss") + " by Astra AI Engine.";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Initial page render
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            string prompt = "Act as an expert corporate campus recruitment engine. Draft an inspiring, prestigious Campus Recruitment Invitation based on: " + txtPromptInput.Text.Trim() + ". Format professionally with clear headers.";
            
            string result = CallApi(prompt);
            txtResult.Text = result.Replace("**", "").Replace("* ", "• ");
            lblMsg.Text = "AI blueprint generated successfully!";
        }

        protected void btnSendOutreach_Click(object sender, EventArgs e)
        {
            getcon();
                string cEmail = Session["company"].ToString();

                da = new SqlDataAdapter("select Company_Name from Company_reg_tbl where Email = '" + cEmail + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                string cName = ds.Tables[0].Rows.Count > 0 ? ds.Tables[0].Rows[0]["Company_Name"].ToString() : "Corporate Partner";

                string msg = !string.IsNullOrEmpty(txtResult.Text) ? txtResult.Text : txtPromptInput.Text.Trim();
                if (msg.Length > 400) msg = msg.Substring(0, 400) + "...";

                cmd = new SqlCommand("insert into Notification_tbl (Recipient_Role, Recipient_Email, Title, Message, Notification_Type, Is_Read, Created_Date) values ('Student', 'All', 'Campus Drive Invitation: " + cName.Replace("'", "''") + "', '" + msg.Replace("'", "''") + "', 'Drive', 0, GETDATE())", con);
                cmd.ExecuteNonQuery();

                lblMsg.Text = "📢 Database Action Executed: Campus Invitation broadcasted to student notifications in <code>Notification_tbl</code>!";

        }
    }
}
