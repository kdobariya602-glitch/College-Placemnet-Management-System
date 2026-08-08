<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <h4>Dashboard</h4>
          <p>Track your placement journey and upcoming opportunities.</p>
        </div>
        <div class="row g-3 mb-4">
          <div class="col-sm-6 col-xl"><div class="dashboard-card stat-card"><div class="stat-icon blue"><i class="bi bi-file-earmark-text"></i></div><div><div class="stat-value" id="statApplied">0</div><div class="stat-label">Applied Jobs</div></div></div></div>
          <div class="col-sm-6 col-xl"><div class="dashboard-card stat-card"><div class="stat-icon orange"><i class="bi bi-calendar-check"></i></div><div><div class="stat-value" id="statInterviews">0</div><div class="stat-label">Interviews Scheduled</div></div></div></div>
          <div class="col-sm-6 col-xl"><div class="dashboard-card stat-card"><div class="stat-icon purple"><i class="bi bi-building"></i></div><div><div class="stat-value" id="statSelected">0</div><div class="stat-label">Selected Companies</div></div></div></div>
          <div class="col-sm-6 col-xl"><div class="dashboard-card stat-card"><div class="stat-icon green"><i class="bi bi-trophy"></i></div><div><div class="stat-value" id="statPlacement">—</div><div class="stat-label">Placement Status</div></div></div></div>
          <div class="col-sm-6 col-xl"><div class="dashboard-card stat-card"><div class="stat-icon red"><i class="bi bi-calendar-event"></i></div><div><div class="stat-value" id="statDrives">0</div><div class="stat-label">Upcoming Drives</div></div></div></div>
        </div>
        <div class="row g-3">
          <div class="col-lg-8">
            <div class="content-card">
              <div class="card-header-custom"><h5>Upcoming Placement Drives</h5><a href="jobs.aspx" class="btn btn-sm btn-outline-custom">Browse Jobs</a></div>
              <div class="card-body-custom" id="upcomingDrivesList"></div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="content-card">
              <div class="card-header-custom"><h5>Quick Links</h5></div>
              <div class="card-body-custom">
                <div class="d-grid gap-2">
                  <a href="jobs.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-search me-2"></i>Find Jobs</a>
                  <a href="applications.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-file-earmark me-2"></i>My Applications</a>
                  <a href="profile.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-person me-2"></i>View Profile</a>
                  <a href="placement-status.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-trophy me-2"></i>Placement Status</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
<!-- ============================= BODY END ============================= -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
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
          Components.initLayout('student', 'dashboard.aspx', App.currentUser);
          Student.initDashboard();
      }
  </script>
</asp:Content>

