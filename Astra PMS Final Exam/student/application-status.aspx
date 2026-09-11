<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="application-status.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.application_status" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Application Status</h4><p>A quick breakdown of where each application stands.</p></div>
        <div class="row g-3 mb-4">
          <div class="col-sm-6 col-xl"><div class="dashboard-card stat-card"><div class="stat-icon orange"><i class="bi bi-hourglass-split"></i></div><div><div class="stat-value" id="statPending">0</div><div class="stat-label">Pending</div></div></div></div>
          <div class="col-sm-6 col-xl"><div class="dashboard-card stat-card"><div class="stat-icon blue"><i class="bi bi-star"></i></div><div><div class="stat-value" id="statShortlisted">0</div><div class="stat-label">Shortlisted</div></div></div></div>
          <div class="col-sm-6 col-xl"><div class="dashboard-card stat-card"><div class="stat-icon green"><i class="bi bi-trophy"></i></div><div><div class="stat-value" id="statSelectedCount">0</div><div class="stat-label">Selected</div></div></div></div>
          <div class="col-sm-6 col-xl"><div class="dashboard-card stat-card"><div class="stat-icon red"><i class="bi bi-x-circle"></i></div><div><div class="stat-value" id="statRejected">0</div><div class="stat-label">Rejected</div></div></div></div>
        </div>
        <div class="content-card">
          <div class="card-header-custom"><h5>Status by Application</h5></div>
          <div class="card-body-custom" id="statusBreakdownList"></div>
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
      Components.initLayout('student', 'application-status.aspx', App.currentUser);
      Student.renderApplicationStatus();
    }
  </script>
</asp:Content>
