<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="notifications.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.notifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Notifications</li></ol></nav>
            <h4>Notifications</h4>
            <p>System notifications related to applications, drives and interviews.</p>
          </div>
          <!-- <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#notificationModal" onclick="document.getElementById('notificationForm').reset();document.getElementById('notificationId').value='';document.getElementById('notificationModalTitle').textContent='Send Notification'">
            <i class="bi bi-plus-lg me-1"></i>Send Notification
          </button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#notificationModal" OnClientClick="document.getElementById(&#x27;notificationForm&#x27;).reset();document.getElementById(&#x27;notificationId&#x27;).value=&#x27;&#x27;;document.getElementById(&#x27;notificationModalTitle&#x27;).textContent=&#x27;Send Notification&#x27;; return false;" Text="Send Notification" />
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Title</th><th>Message</th><th>Recipient</th><th>Date</th><th>Status</th></tr></thead>
                <tbody id="notificationsTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="notificationsPagination"></div></div>
        </div>
      </div>

<!-- ============================= BODY END ============================= -->
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">

<!-- ============================= FOOTER START ============================= -->
<div id="footerContainer"></div>
<!-- ============================= FOOTER END ============================= -->

  <div class="modal fade" id="notificationModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title" id="notificationModalTitle">Send Notification</h5><!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" /></div>
      <div class="modal-body">
        <div id="notificationForm">
          <input type="hidden" id="notificationId">
          <div class="mb-3"><label class="form-label-custom">Title</label><asp:TextBox runat="server" ID="notificationTitle" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Message</label><asp:TextBox runat="server" ID="notificationMessage" ClientIDMode="Static" TextMode="MultiLine" Rows="3" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Recipient</label>
            <!-- <select class="form-select form-control-custom" id="notificationRecipient">
              <option value="all">All</option>
              <option value="students">Students</option>
              <option value="tpo">TPO Staff</option>
              <option value="companies">Companies</option>
            </select> -->
<asp:DropDownList runat="server" ID="notificationRecipient" ClientIDMode="Static" CssClass="form-select form-control-custom">
                    <asp:ListItem Text="All" Value="all"></asp:ListItem>
                    <asp:ListItem Text="Students" Value="students"></asp:ListItem>
                    <asp:ListItem Text="TPO Staff" Value="tpo"></asp:ListItem>
                    <asp:ListItem Text="Companies" Value="companies"></asp:ListItem>
                </asp:DropDownList>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <asp:Button runat="server" ID="saveNotificationBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Admin.saveNotification(); return false;" Text="Send" />
      </div>
    </div></div>
  </div>
  <div id="modalContainer"></div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/admin.js"></script>
  <script>
      //if (App.requireAuth('admin', 'login.aspx')) {
      //    Components.initLayout('admin', 'notifications.aspx', App.currentUser);
      //    Admin.renderNotificationsTable();
      //}
      Components.initLayout('admin', 'notifications.aspx', App.currentUser);
      Admin.renderNotificationsTable();
  </script>
</asp:Content>
