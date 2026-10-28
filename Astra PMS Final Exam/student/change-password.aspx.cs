using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Astra_PMS_Final_Exam.student
{
    public partial class change_password : System.Web.UI.Page
    {
        SqlConnection con;
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        // Password is a DB-backed column (Student_reg_tbl.Password), so it is
        // changed directly in SQL Server here rather than in localStorage.
        // The logged-in student is identified via Session["student"], which
        // login.aspx.cs sets to the authenticated Email on sign-in.
        protected void changePasswordBtn_Click(object sender, EventArgs e)
        {
            if (Session["student"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            string studentEmail = Session["student"].ToString();
            string current = currentPassword.Text;
            string next = newPassword.Text;
            string confirm = confirmPassword.Text;

            if (next != confirm)
            {
                ShowMessage("New password and confirmation do not match", "error");
                return;
            }
            if (next.Length < 6)
            {
                ShowMessage("New password must be at least 6 characters", "error");
                return;
            }

            getcon();
            SqlCommand cmd = new SqlCommand("select Password from Student_reg_tbl where Email=@Email", con);
            cmd.Parameters.AddWithValue("@Email", studentEmail);
            object dbPasswordObj = cmd.ExecuteScalar();
            con.Close();

            if (dbPasswordObj == null || dbPasswordObj.ToString() != current)
            {
                ShowMessage("Current password is incorrect", "error");
                return;
            }

            getcon();
            SqlCommand upd = new SqlCommand("update Student_reg_tbl set Password=@Password where Email=@Email", con);
            upd.Parameters.AddWithValue("@Password", next);
            upd.Parameters.AddWithValue("@Email", studentEmail);
            upd.ExecuteNonQuery();
            con.Close();

            currentPassword.Text = "";
            newPassword.Text = "";
            confirmPassword.Text = "";

            string escapedPassword = next.Replace("\\", "\\\\").Replace("'", "\\'");
            string escapedEmail = studentEmail.Replace("\\", "\\\\").Replace("'", "\\'");

            string script = "try{" +
                "var s=JSON.parse(sessionStorage.getItem('pms_session')||'{}');" +
                "s.password='" + escapedPassword + "';" +
                "sessionStorage.setItem('pms_session', JSON.stringify(s));" +
                "if (typeof getData==='function' && typeof saveData==='function') {" +
                "  var d=getData();" +
                "  var idx=d.students.findIndex(function(x){ return x.email && x.email.toLowerCase()==='" + escapedEmail.ToLower() + "'; });" +
                "  if (idx>-1) { d.students[idx].password='" + escapedPassword + "'; saveData(d); }" +
                "}" +
                "}catch(e){}" +
                "if(window.App){ App.showToast('Password updated successfully'); } else { alert('Password updated successfully'); }";

            ClientScript.RegisterStartupScript(GetType(), "pwdOk", script, true);
        }

        void ShowMessage(string message, string type)
        {
            string escaped = message.Replace("\\", "\\\\").Replace("'", "\\'");
            string script = "if(window.App){ App.showToast('" + escaped + "', '" + type + "'); } else { alert('" + escaped + "'); }";
            ClientScript.RegisterStartupScript(GetType(), "pwdMsg", script, true);
        }
    }
}
