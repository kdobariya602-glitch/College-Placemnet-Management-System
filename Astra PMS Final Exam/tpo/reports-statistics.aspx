<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="reports-statistics.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.reports_statistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item"><a href="reports.aspx">Placement Reports</a></li><li class="breadcrumb-item active">Placement Statistics</li></ol></nav>
          <h4>Placement Statistics</h4>
          <p>Overall placement performance at a glance.</p>
        </div>

        <div class="row g-3 mb-4">
          <div class="col-md-3"><div class="dashboard-card stat-card"><div class="stat-icon red"><i class="bi bi-people"></i></div><div><div class="stat-value" id="psStudents">0</div><div class="stat-label">Total Students</div></div></div></div>
          <div class="col-md-3"><div class="dashboard-card stat-card"><div class="stat-icon green"><i class="bi bi-trophy"></i></div><div><div class="stat-value" id="psPlaced">0</div><div class="stat-label">Placed</div></div></div></div>
          <div class="col-md-3"><div class="dashboard-card stat-card"><div class="stat-icon blue"><i class="bi bi-building"></i></div><div><div class="stat-value" id="psCompanies">0</div><div class="stat-label">Companies Visited</div></div></div></div>
          <div class="col-md-3"><div class="dashboard-card stat-card"><div class="stat-icon orange"><i class="bi bi-percent"></i></div><div><div class="stat-value" id="psRate">0%</div><div class="stat-label">Placement Rate</div></div></div></div>
        </div>

        <div class="row g-3 mb-4">
          <div class="col-md-4"><div class="dashboard-card stat-card"><div class="stat-icon green"><i class="bi bi-graph-up-arrow"></i></div><div><div class="stat-value" id="psHighestPackage">—</div><div class="stat-label">Highest Package</div></div></div></div>
          <div class="col-md-4"><div class="dashboard-card stat-card"><div class="stat-icon red"><i class="bi bi-graph-down-arrow"></i></div><div><div class="stat-value" id="psLowestPackage">—</div><div class="stat-label">Lowest Package</div></div></div></div>
          <div class="col-md-4"><div class="dashboard-card stat-card"><div class="stat-icon blue"><i class="bi bi-bar-chart"></i></div><div><div class="stat-value" id="psAvgPackage">—</div><div class="stat-label">Average Package</div></div></div></div>
        </div>

        <div class="row g-3 mb-4">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Year-wise Placement Trend</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="statsYearChart"></canvas></div></div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Branch-wise Placement</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="statsBranchChart"></canvas></div></div>
            </div>
          </div>
        </div>

        <div class="row g-3">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Package Distribution</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="statsPackageChart"></canvas></div></div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Top Recruiting Companies</h5></div>
              <div class="card-body-custom"><div class="chart-container"><canvas id="statsCompaniesChart"></canvas></div></div>
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
      //    Components.initLayout('tpo', 'reports-statistics.aspx', App.currentUser);
      //}
      Components.initLayout('tpo', 'reports-statistics.aspx', App.currentUser);

      (function renderPlacementStatistics() {
        const stats = getStats();
        const data = getData();

        document.getElementById('psStudents').textContent = stats.totalStudents;
        document.getElementById('psPlaced').textContent = stats.totalPlacements;
        document.getElementById('psRate').textContent = stats.placementPercentage + '%';

        const companiesVisited = new Set(data.applications.map(a => a.companyName)).size;
        document.getElementById('psCompanies').textContent = companiesVisited;

        // Package statistics (Highest / Lowest / Average) across all selected students - spec section 11
        (function renderPackageStats() {
          const lpas = [];
          data.applications.filter(a => a.status === 'selected').forEach(a => {
            const job = data.jobs.find(j => j.id === a.jobId);
            const match = job && job.salary && job.salary.match(/(\d+)/g);
            if (match) lpas.push(Math.max(...match.map(Number)));
          });
          document.getElementById('psHighestPackage').textContent = lpas.length ? `₹${Math.max(...lpas)} LPA` : '—';
          document.getElementById('psLowestPackage').textContent = lpas.length ? `₹${Math.min(...lpas)} LPA` : '—';
          document.getElementById('psAvgPackage').textContent = lpas.length ? `₹${(lpas.reduce((a, b) => a + b, 0) / lpas.length).toFixed(1)} LPA` : '—';
        })();

        // Year-wise Placement Trend: placed vs total students per graduation year
        const yearCtx = document.getElementById('statsYearChart');
        if (yearCtx) {
          const years = [...new Set(data.students.map(s => s.year))].sort();
          const placedByYear = years.map(y => data.students.filter(s => s.year === y && s.placed).length);
          const totalByYear = years.map(y => data.students.filter(s => s.year === y).length);
          new Chart(yearCtx, {
            type: 'bar',
            data: {
              labels: years,
              datasets: [
                { label: 'Placed', data: placedByYear, backgroundColor: '#1a56db', borderRadius: 6 },
                { label: 'Registered', data: totalByYear, backgroundColor: '#e5e7eb', borderRadius: 6 }
              ]
            },
            options: {
              responsive: true, maintainAspectRatio: false,
              plugins: { legend: { position: 'top', labels: { font: { family: 'Poppins' } } } },
              scales: { y: { beginAtZero: true, grid: { color: '#f1f5f9' } }, x: { grid: { display: false } } }
            }
          });
        }

        // Branch-wise Placement
        Charts.renderBranchChart('statsBranchChart');

        // Package Distribution: bucket the salary of the job each selected student got placed in
        const packageCtx = document.getElementById('statsPackageChart');
        if (packageCtx) {
          const buckets = { '< 8 LPA': 0, '8-12 LPA': 0, '12-16 LPA': 0, '16+ LPA': 0 };
          data.applications.filter(a => a.status === 'selected').forEach(a => {
            const job = data.jobs.find(j => j.id === a.jobId);
            const match = job && job.salary.match(/(\d+)/);
            const lpa = match ? parseInt(match[1], 10) : 0;
            if (lpa < 8) buckets['< 8 LPA']++;
            else if (lpa < 12) buckets['8-12 LPA']++;
            else if (lpa < 16) buckets['12-16 LPA']++;
            else buckets['16+ LPA']++;
          });
          new Chart(packageCtx, {
            type: 'doughnut',
            data: {
              labels: Object.keys(buckets),
              datasets: [{
                data: Object.values(buckets),
                backgroundColor: ['#f97316', '#1a56db', '#14b8a6', '#a855f7'],
                borderWidth: 0, hoverOffset: 8
              }]
            },
            options: {
              responsive: true, maintainAspectRatio: false, cutout: '65%',
              plugins: { legend: { position: 'bottom', labels: { font: { family: 'Poppins', size: 11 }, padding: 15, usePointStyle: true } } }
            }
          });
        }

        // Top Recruiting Companies
        Charts.renderTopCompaniesChart('statsCompaniesChart');
      })();
  </script>
</asp:Content>