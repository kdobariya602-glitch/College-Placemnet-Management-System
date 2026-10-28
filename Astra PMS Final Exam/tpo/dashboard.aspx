<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item active">Dashboard</li></ol></nav>
          <h4>Dashboard</h4>
          <p>Welcome back! Here's an overview of placement activities.</p>
        </div>

        <div class="row g-3 mb-4">
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon red"><i class="bi bi-people"></i></div>
              <div><div class="stat-value" id="statStudents">0</div><div class="stat-label">Total Students</div><div class="stat-change positive"><i class="bi bi-arrow-up"></i> 12% this month</div></div>
            </div>
          </div>
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon blue"><i class="bi bi-building"></i></div>
              <div><div class="stat-value" id="statCompanies">0</div><div class="stat-label">Total Companies</div><div class="stat-change positive"><i class="bi bi-arrow-up"></i> 3 new</div></div>
            </div>
          </div>
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon green"><i class="bi bi-briefcase"></i></div>
              <div><div class="stat-value" id="statJobs">0</div><div class="stat-label">Active Jobs</div><div class="stat-change positive"><i class="bi bi-arrow-up"></i> 5 posted</div></div>
            </div>
          </div>
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon purple"><i class="bi bi-trophy"></i></div>
              <div><div class="stat-value" id="statPlacements">0</div><div class="stat-label">Total Placements</div><div class="stat-change positive"><i class="bi bi-arrow-up"></i> 8 this week</div></div>
            </div>
          </div>
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon orange"><i class="bi bi-percent"></i></div>
              <div><div class="stat-value" id="statPercentage">0%</div><div class="stat-label">Placement Rate</div><div class="stat-change positive"><i class="bi bi-arrow-up"></i> +5%</div></div>
            </div>
          </div>
        </div>

        <div class="row g-3 mb-4">
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon teal"><i class="bi bi-calendar-event"></i></div>
              <div><div class="stat-value" id="statDrives">0</div><div class="stat-label">Placement Drives</div></div>
            </div>
          </div>
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon blue"><i class="bi bi-file-earmark-text"></i></div>
              <div><div class="stat-value" id="statApplications">0</div><div class="stat-label">Applications</div></div>
            </div>
          </div>
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon orange"><i class="bi bi-star"></i></div>
              <div><div class="stat-value" id="statShortlisted">0</div><div class="stat-label">Shortlisted</div></div>
            </div>
          </div>
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon red"><i class="bi bi-mic"></i></div>
              <div><div class="stat-value" id="statInterviews">0</div><div class="stat-label">Interviews</div></div>
            </div>
          </div>
          <div class="col-sm-6 col-xl">
            <div class="dashboard-card stat-card">
              <div class="stat-icon green"><i class="bi bi-patch-check"></i></div>
              <div><div class="stat-value" id="statSelected">0</div><div class="stat-label">Selected</div></div>
            </div>
          </div>
        </div>

        <div class="row g-3 mb-4">
          <div class="col-lg-8">
            <div class="content-card">
              <div class="card-header-custom"><h5><i class="bi bi-graph-up me-2 text-danger"></i>Monthly Placement Trends</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="placementChart"></canvas></div></div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="content-card">
              <div class="card-header-custom"><h5><i class="bi bi-pie-chart me-2 text-danger"></i>Top Recruiting Companies</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="topCompaniesChart"></canvas></div></div>
            </div>
          </div>
        </div>

        <div class="row g-3">
          <div class="col-lg-8">
            <div class="content-card">
              <div class="card-header-custom"><h5><i class="bi bi-clock-history me-2 text-danger"></i>Recent Activities</h5><a href="applications.aspx" class="btn btn-sm btn-outline-custom">View All</a></div>
              <div class="card-body-custom" id="activityList"></div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="content-card">
              <div class="card-header-custom"><h5><i class="bi bi-lightning me-2 text-danger"></i>Quick Actions</h5></div>
              <div class="card-body-custom">
                <div class="d-grid gap-2">
                  <a href="students.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-person-plus me-2"></i>Add Student</a>
                  <a href="companies.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-building-add me-2"></i>Add Company</a>
                  <a href="drives.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-calendar-plus me-2"></i>Schedule Drive</a>
                  <a href="reports.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-file-bar-graph me-2"></i>Generate Report</a>
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
  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/charts.js"></script>
  <script src="../assets/js/tpo.js"></script>
  <script>
    //if (App.requireAuth('tpo', 'login.aspx')) {
    //  Components.initLayout('tpo', 'dashboard.aspx', App.currentUser);
    //  Tpo.initDashboard();
      //}

      Components.initLayout('tpo', 'dashboard.aspx', App.currentUser);
      Tpo.initDashboard();
  </script>
</asp:Content>
