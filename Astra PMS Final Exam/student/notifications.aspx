<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="notifications.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.notifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start mb-4">
          <div class="page-breadcrumb mb-0"><h4>Notifications</h4><p>Updates about your applications and drives.</p></div>
          <!-- <button type="button" class="btn btn-outline-custom" id="markAllReadBtn"><i class="bi bi-check2-all me-1"></i>Mark All as Read</button> -->
<asp:Button runat="server" ID="markAllReadBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" OnClientClick="return false;" Text="Mark All as Read" />
        </div>
        <div class="content-card mb-3">
          <div class="card-body-custom">
            <div class="row g-2">
              <div class="col-md-8"><input type="text" class="form-control form-control-custom" id="notificationSearch" placeholder="Search notifications..." oninput="Student.renderNotifications()"></div>
              <div class="col-md-4">
                <select class="form-select form-control-custom" id="notificationFilter" onchange="Student.renderNotifications()">
                  <option value="">All</option>
                  <option value="unread">Unread</option>
                  <option value="read">Read</option>
                </select>
              </div>
            </div>
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
      Components.initLayout('student', 'notifications.aspx', App.currentUser);
      Student.renderNotifications();
      document.getElementById('markAllReadBtn').addEventListener('click', () => Student.markAllNotificationsRead());
    }
  </script>
</asp:Content>
