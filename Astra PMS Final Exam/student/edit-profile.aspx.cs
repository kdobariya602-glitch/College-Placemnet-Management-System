using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace Astra_PMS_Final_Exam.student
{
    public partial class edit_profile : System.Web.UI.Page
    {
        SqlConnection con;
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Field values are populated client-side from the session
            // (Student.loadEditProfile(), assets/js/student.js) since the
            // session already mirrors the DB profile set at login.
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        // Full_Name, Phone, Branch, Cgpa and Skills are DB-backed columns in
        // Student_reg_tbl, so they are updated directly against SQL Server
        // here (never only in localStorage). Gender/DOB/Address/Course/Photo
        // are not part of the DB schema, so — per the spec — they stay in the
        // JS/localStorage layer; the script below syncs them there using the
        // values the student just submitted.
        protected void saveProfileBtn_Click(object sender, EventArgs e)
        {
            if (Session["student"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            string studentEmail = Session["student"].ToString();

            if (string.IsNullOrWhiteSpace(editName.Text) || string.IsNullOrWhiteSpace(editPhone.Text))
            {
                ShowMessage("Name and phone are required", "error");
                return;
            }

            getcon();
            SqlCommand cmd = new SqlCommand(
                "update Student_reg_tbl set Full_Name=@Full_Name, Phone=@Phone, Branch=@Branch, Cgpa=@Cgpa, Skills=@Skills where Email=@Email", con);
            cmd.Parameters.AddWithValue("@Full_Name", editName.Text.Trim());
            cmd.Parameters.AddWithValue("@Phone", editPhone.Text.Trim());
            cmd.Parameters.AddWithValue("@Branch", editBranch.SelectedValue);
            cmd.Parameters.AddWithValue("@Cgpa", editCgpa.Text.Trim());
            cmd.Parameters.AddWithValue("@Skills", editSkills.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", studentEmail);
            cmd.ExecuteNonQuery();
            con.Close();

            ClientScript.RegisterStartupScript(GetType(), "profileSaved", BuildSyncScript(studentEmail), true);
        }

        string BuildSyncScript(string studentEmail)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("try{");
            sb.Append("var s=JSON.parse(sessionStorage.getItem('pms_session')||'{}');");
            sb.Append("s.name='").Append(JsEscape(editName.Text.Trim())).Append("';");
            sb.Append("s.phone='").Append(JsEscape(editPhone.Text.Trim())).Append("';");
            sb.Append("s.branch='").Append(JsEscape(editBranch.SelectedValue)).Append("';");
            sb.Append("s.cgpa=").Append(JsNumber(editCgpa.Text.Trim())).Append(";");
            sb.Append("s.skills=[").Append(JsSkillsArray(editSkills.Text.Trim())).Append("];");
            sb.Append("s.gender='").Append(JsEscape(editGender.SelectedValue)).Append("';");
            sb.Append("s.dob='").Append(JsEscape(editDob.Text.Trim())).Append("';");
            sb.Append("s.address='").Append(JsEscape(editAddress.Text.Trim())).Append("';");
            sb.Append("s.course='").Append(JsEscape(editCourse.SelectedValue)).Append("';");
            sb.Append("s.photoUrl='").Append(JsEscape(editPhotoUrl.Text.Trim())).Append("';");
            sb.Append("sessionStorage.setItem('pms_session', JSON.stringify(s));");
            sb.Append("if (typeof getData==='function' && typeof saveData==='function') {");
            sb.Append("  var d=getData();");
            sb.Append("  var idx=d.students.findIndex(function(x){ return x.email && x.email.toLowerCase()==='").Append(JsEscape(studentEmail.ToLower())).Append("'; });");
            sb.Append("  if (idx>-1) { d.students[idx]=Object.assign({}, d.students[idx], s); saveData(d); }");
            sb.Append("}");
            sb.Append("if(window.App){ App.showToast('Profile updated'); } else { alert('Profile updated'); }");
            sb.Append("setTimeout(function(){ window.location.href='profile.aspx'; }, 800);");
            sb.Append("}catch(e){}");
            return sb.ToString();
        }

        void ShowMessage(string message, string type)
        {
            string escaped = JsEscape(message);
            string script = "if(window.App){ App.showToast('" + escaped + "', '" + type + "'); } else { alert('" + escaped + "'); }";
            ClientScript.RegisterStartupScript(GetType(), "profileMsg", script, true);
        }

        static string JsEscape(string v)
        {
            if (string.IsNullOrEmpty(v)) return "";
            return v.Replace("\\", "\\\\").Replace("'", "\\'").Replace("\r", "").Replace("\n", " ");
        }

        static string JsNumber(string v)
        {
            double d;
            return double.TryParse(v, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out d)
                ? d.ToString(System.Globalization.CultureInfo.InvariantCulture)
                : "0";
        }

        static string JsSkillsArray(string csv)
        {
            var parts = csv.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            var escaped = Array.ConvertAll(parts, p => "'" + JsEscape(p.Trim()) + "'");
            return string.Join(",", escaped);
        }
    }
}
