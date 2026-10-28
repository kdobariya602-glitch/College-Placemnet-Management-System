<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="change-password.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.change_password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Change Password</li></ol></nav>
          <h4>Change Password</h4>
          <p>Update the password used to sign in to the admin panel.</p>
        </div>

        <div class="row g-4">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5><i class="bi bi-key me-2"></i>Update Password</h5></div>
              <div class="card-body-custom">
                <div id="passwordForm">
                  <div class="mb-3"><label class="form-label-custom">Current Password</label><asp:TextBox runat="server" ID="currentPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
                  <div class="mb-3"><label class="form-label-custom">New Password</label><asp:TextBox runat="server" ID="newPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" required="required" minlength="6"></asp:TextBox></div>
                  <div class="mb-3"><label class="form-label-custom">Confirm New Password</label><asp:TextBox runat="server" ID="confirmPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" required="required" minlength="6"></asp:TextBox></div>
                  <asp:Button runat="server" ID="changePasswordBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Admin.changePassword(); return false;" Text="Update Password" />
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

  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/admin.js"></script>
  <script>
    //if (App.requireAuth('admin', 'login.aspx')) {
    //  Components.initLayout('admin', 'change-password.aspx', App.currentUser);
      //}
      Components.initLayout('admin', 'change-password.aspx', App.currentUser);
  </script>
</asp:Content>
