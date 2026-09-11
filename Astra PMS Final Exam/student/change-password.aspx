<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="change-password.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.change_password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Change Password</h4><p>Update the password used to sign in to your student account.</p></div>
        <div class="row">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-body-custom">
                <div id="changePasswordForm">
                  <div class="mb-3">
                    <label class="form-label">Current Password</label>
                    <!-- <input type="password" class="form-control" id="currentPassword" required> -->
<asp:TextBox runat="server" ID="currentPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control" required="required"></asp:TextBox>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">New Password</label>
                    <!-- <input type="password" class="form-control" id="newPassword" required minlength="6"> -->
<asp:TextBox runat="server" ID="newPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control" required="required" minlength="6"></asp:TextBox>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Confirm New Password</label>
                    <!-- <input type="password" class="form-control" id="confirmPassword" required minlength="6"> -->
<asp:TextBox runat="server" ID="confirmPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control" required="required" minlength="6"></asp:TextBox>
                  </div>
                  <!-- <button type="button" class="btn btn-primary-custom" id="changePasswordBtn"><i class="bi bi-shield-check me-1"></i>Update Password</button> -->
<asp:Button runat="server" ID="changePasswordBtn" ClientIDMode="Static" CssClass="btn btn-primary-custom" OnClientClick="return validateChangePasswordForm();" OnClick="changePasswordBtn_Click" Text="Update Password" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
<!-- ============================= BODY END ============================= -->
</asp:Content>
<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">
<!-- ============================= FOOTER START ============================= -->
<div id="footerContainer"></div>
<!-- ============================= FOOTER END ============================= -->

    </div>
  </div>
  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/student.js"></script>
  <script>
    if (App.requireAuth('student', 'login.aspx')) {
      Components.initLayout('student', 'change-password.aspx', App.currentUser);
    }

    // Password itself is a DB-backed field (Student_reg_tbl.Password), so the
    // actual change happens server-side in changePasswordBtn_Click against
    // SQL Server. This only does a quick client-side sanity check before the
    // postback is allowed through.
    function validateChangePasswordForm() {
      const next = document.getElementById('newPassword').value;
      const confirm = document.getElementById('confirmPassword').value;
      if (next.length < 6) {
        App.showToast('New password must be at least 6 characters', 'error');
        return false;
      }
      if (next !== confirm) {
        App.showToast('New password and confirmation do not match', 'error');
        return false;
      }
      return true;
    }
  </script>
</asp:Content>
