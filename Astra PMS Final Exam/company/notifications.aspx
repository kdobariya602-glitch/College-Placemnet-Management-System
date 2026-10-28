<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="notifications.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.notifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    
<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Notifications</h4><p>Stay updated on applications and recruitment activities.</p></div>
        <div class="filter-bar d-flex gap-2 flex-wrap align-items-center mb-3">
          <select class="form-select form-select-sm" style="width:auto" id="notifTypeFilter">
            <option value="">All Types</option>
            <option value="New Application">New Application</option>
            <option value="Application Update">Application Status</option>
            <option value="Shortlisted">Student Shortlisted</option>
            <option value="Interview Scheduled">Interview Scheduled</option>
            <option value="Interview Rescheduled">Interview Rescheduled</option>
            <option value="Interview Cancelled">Interview Cancelled</option>
            <option value="Selected!">Student Selected</option>
            <option value="Offer Update">Placement Confirmed</option>
          </select>
          <div class="form-check">
            <input class="form-check-input" type="checkbox" id="notifUnreadOnly">
            <label class="form-check-label small" for="notifUnreadOnly">Unread only</label>
          </div>
        </div>
        <div class="content-card">
          <div class="card-body-custom" id="notificationsList"></div>
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
      Components.initLayout('company', 'notifications.aspx', App.currentUser);
      Company.initNotificationFilters();
      Company.renderNotifications();
    }
  </script>
</asp:Content>

