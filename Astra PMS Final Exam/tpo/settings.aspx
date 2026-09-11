<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="settings.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Settings</li></ol></nav>
          <h4>Settings</h4>
          <p>Manage your account settings and preferences.</p>
        </div>

        <div class="row g-4">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5><i class="bi bi-person me-2"></i>Profile Information</h5></div>
              <div class="card-body-custom">
                <div class="d-flex align-items-center gap-3 mb-4">
                  <div class="profile-header-avatar" id="settingsAvatar">RK</div>
                  <div>
                    <h5 class="mb-0" id="settingsName">TPO</h5>
                    <p class="text-muted mb-0" id="settingsEmail">tpo@university.edu</p>
                  </div>
                </div>
                <div class="profile-info-item"><i class="bi bi-shield-check"></i><div><small class="text-muted">Role</small><div>Training & Placement Officer</div></div></div>
                <div class="profile-info-item"><i class="bi bi-building"></i><div><small class="text-muted">Department</small><div>Training & Placement Cell</div></div></div>
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5><i class="bi bi-key me-2"></i>Change Password</h5></div>
              <div class="card-body-custom">
                <form id="passwordForm">
                  <!-- <div class="mb-3"><label class="form-label-custom">Current Password</label><input type="password" class="form-control form-control-custom" id="currentPassword" required></div> -->
                  <div class="mb-3"><label class="form-label-custom">Current Password</label><asp:TextBox runat="server" ID="currentPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
                  <!-- <div class="mb-3"><label class="form-label-custom">New Password</label><input type="password" class="form-control form-control-custom" id="newPassword" required minlength="6"></div> -->
                  <div class="mb-3"><label class="form-label-custom">New Password</label><asp:TextBox runat="server" ID="newPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" required="required" minlength="6"></asp:TextBox></div>
                  <!-- <div class="mb-3"><label class="form-label-custom">Confirm Password</label><input type="password" class="form-control form-control-custom" id="confirmPassword" required></div> -->
                  <div class="mb-3"><label class="form-label-custom">Confirm Password</label><asp:TextBox runat="server" ID="confirmPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
                  <!-- <button type="button" class="btn btn-primary-custom" onclick="Tpo.changePassword()">Update Password</button> -->
                  <asp:Button runat="server" ID="changePasswordBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Tpo.changePassword(); return false;" Text="Update Password" />
                </form>
              </div>
            </div>
          </div>
        </div>

        <div class="content-card mt-4">
          <div class="card-header-custom"><h5><i class="bi bi-sliders me-2"></i>System Preferences</h5></div>
          <div class="card-body-custom">
            <div class="accordion" id="settingsAccordion">
              <div class="accordion-item border-0 mb-2">
                <h2 class="accordion-header"><!-- <button class="accordion-button rounded" type="button" data-bs-toggle="collapse" data-bs-target="#notifSettings">Notification Settings</button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="accordion-button rounded" data-bs-toggle="collapse" data-bs-target="#notifSettings" OnClientClick="return false;" Text="Notification Settings" /></h2>
                <div id="notifSettings" class="accordion-collapse collapse show" data-bs-parent="#settingsAccordion">
                  <div class="accordion-body">
                    <div class="form-check form-switch mb-2"><!-- <input class="form-check-input" type="checkbox" checked id="emailNotif"> -->
<asp:CheckBox runat="server" ID="emailNotif" ClientIDMode="Static" CssClass="form-check-input" Checked="true" /><label class="form-check-label" for="emailNotif">Email Notifications</label></div>
                    <div class="form-check form-switch mb-2"><!-- <input class="form-check-input" type="checkbox" checked id="appNotif"> -->
<asp:CheckBox runat="server" ID="appNotif" ClientIDMode="Static" CssClass="form-check-input" Checked="true" /><label class="form-check-label" for="appNotif">Application Alerts</label></div>
                    <div class="form-check form-switch"><!-- <input class="form-check-input" type="checkbox" checked id="driveNotif"> -->
<asp:CheckBox runat="server" ID="driveNotif" ClientIDMode="Static" CssClass="form-check-input" Checked="true" /><label class="form-check-label" for="driveNotif">Drive Reminders</label></div>
                  </div>
                </div>
              </div>
              <div class="accordion-item border-0">
                <h2 class="accordion-header"><!-- <button class="accordion-button collapsed rounded" type="button" data-bs-toggle="collapse" data-bs-target="#displaySettings">Display Settings</button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="accordion-button collapsed rounded" data-bs-toggle="collapse" data-bs-target="#displaySettings" OnClientClick="return false;" Text="Display Settings" /></h2>
                <div id="displaySettings" class="accordion-collapse collapse" data-bs-parent="#settingsAccordion">
                  <div class="accordion-body">
                    <div class="form-check form-switch mb-2"><!-- <input class="form-check-input" type="checkbox" checked id="compactSidebar"> -->
<asp:CheckBox runat="server" ID="compactSidebar" ClientIDMode="Static" CssClass="form-check-input" Checked="true" /><label class="form-check-label" for="compactSidebar">Compact Sidebar</label></div>
                    <div class="form-check form-switch"><!-- <input class="form-check-input" type="checkbox" id="darkMode"> -->
<asp:CheckBox runat="server" ID="darkMode" ClientIDMode="Static" CssClass="form-check-input" /><label class="form-check-label" for="darkMode">Dark Mode (Coming Soon)</label></div>
                  </div>
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
  <script src="../assets/js/tpo.js"></script>
  <script>
    //if (App.requireAuth('tpo', 'login.aspx')) {
    //  Components.initLayout('tpo', 'settings.aspx', App.currentUser);
    //  document.getElementById('settingsName').textContent = App.currentUser.name;
    //  document.getElementById('settingsEmail').textContent = App.currentUser.email;
    //  document.getElementById('settingsAvatar').textContent = App.getInitials(App.currentUser.name);
      //}
      Components.initLayout('tpo', 'settings.aspx', App.currentUser);
      if (App.currentUser) {
        document.getElementById('settingsName').textContent = App.currentUser.name;
        document.getElementById('settingsEmail').textContent = App.currentUser.email;
        document.getElementById('settingsAvatar').textContent = App.getInitials(App.currentUser.name);
      }
  </script>
</asp:Content>

