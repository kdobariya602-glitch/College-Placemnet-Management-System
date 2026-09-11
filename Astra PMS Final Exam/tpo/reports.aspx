<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="reports.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    
<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Reports</li></ol></nav>
          <h4>Reports & Analytics</h4>
          <p>Comprehensive placement statistics and insights.</p>
        </div>

        <div class="row g-3 mb-4">
          <div class="col-md-3"><div class="dashboard-card stat-card"><div class="stat-icon red"><i class="bi bi-people"></i></div><div><div class="stat-value" id="rStudents">0</div><div class="stat-label">Students</div></div></div></div>
          <div class="col-md-3"><div class="dashboard-card stat-card"><div class="stat-icon green"><i class="bi bi-trophy"></i></div><div><div class="stat-value" id="rPlaced">0</div><div class="stat-label">Placed</div></div></div></div>
          <div class="col-md-3"><div class="dashboard-card stat-card"><div class="stat-icon blue"><i class="bi bi-file-earmark"></i></div><div><div class="stat-value" id="rApps">0</div><div class="stat-label">Applications</div></div></div></div>
          <div class="col-md-3"><div class="dashboard-card stat-card"><div class="stat-icon orange"><i class="bi bi-percent"></i></div><div><div class="stat-value" id="rRate">0%</div><div class="stat-label">Placement Rate</div></div></div></div>
        </div>

        <div class="row g-3 mb-4">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Monthly Placements</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="reportPlacementChart"></canvas></div></div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Top Recruiting Companies</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="reportCompaniesChart"></canvas></div></div>
            </div>
          </div>
        </div>

        <div class="row g-3">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Branch-wise Placement</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="reportBranchChart"></canvas></div></div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Application Status Distribution</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="reportStatusChart"></canvas></div></div>
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
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/charts.js"></script>
  <script src="../assets/js/tpo.js"></script>
  <script>
    //if (App.requireAuth('tpo', 'login.aspx')) {
    //  Components.initLayout('tpo', 'reports.aspx', App.currentUser);
    //  const s = getStats();
    //  document.getElementById('rStudents').textContent = s.totalStudents;
    //  document.getElementById('rPlaced').textContent = s.totalPlacements;
    //  document.getElementById('rApps').textContent = s.totalApplications;
    //  document.getElementById('rRate').textContent = s.placementPercentage + '%';
    //  Charts.renderReportsCharts();
      //}
      Components.initLayout('tpo', 'reports.aspx', App.currentUser);
      const s = getStats();
      document.getElementById('rStudents').textContent = s.totalStudents;
      document.getElementById('rPlaced').textContent = s.totalPlacements;
      document.getElementById('rApps').textContent = s.totalApplications;
      document.getElementById('rRate').textContent = s.placementPercentage + '%';
      Charts.renderReportsCharts();
  </script>
</asp:Content>

