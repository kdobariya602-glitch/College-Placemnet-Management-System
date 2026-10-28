<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="change-password.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.change_password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Change Password</h4><p>Update the password used to sign in to your company account.</p></div>
        <div class="row">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-body-custom">
                <form id="changePasswordForm">
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
<asp:Button runat="server" ID="changePasswordBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="return false;" Text="Update Password" />
                </form>
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
  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/company.js"></script>
  <script>
    if (App.requireAuth('company', 'login.aspx')) {
      Components.initLayout('company', 'change-password.aspx', App.currentUser);
      document.getElementById('changePasswordBtn').addEventListener('click', () => Company.changePassword());
    }
  </script>
</asp:Content>
