/**
 * Placement Management System - Chart.js Utilities
 */

const Charts = {
  placementChart: null,
  companiesChart: null,

  initAdminDashboard() {
    this.renderPlacementChart('placementChart');
    this.renderTopCompaniesChart('topCompaniesChart');
  },

  renderPlacementChart(canvasId) {
    const ctx = document.getElementById(canvasId);
    if (!ctx) return;

    if (this.placementChart) this.placementChart.destroy();

    this.placementChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: ['Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb'],
        datasets: [{
          label: 'Placements',
          data: [2, 5, 8, 12, 18, 25, 32],
          borderColor: '#1a56db',
          backgroundColor: 'rgba(26, 86, 219, 0.1)',
          borderWidth: 2,
          fill: true,
          tension: 0.4,
          pointBackgroundColor: '#1a56db',
          pointRadius: 4
        }, {
          label: 'Applications',
          data: [15, 28, 42, 55, 68, 85, 102],
          borderColor: '#14b8a6',
          backgroundColor: 'rgba(20, 184, 166, 0.05)',
          borderWidth: 2,
          fill: true,
          tension: 0.4,
          pointBackgroundColor: '#14b8a6',
          pointRadius: 4
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: 'top', labels: { font: { family: 'Poppins', size: 12 }, usePointStyle: true } }
        },
        scales: {
          y: { beginAtZero: true, grid: { color: '#f1f5f9' } },
          x: { grid: { display: false } }
        }
      }
    });
  },

  renderTopCompaniesChart(canvasId) {
    const ctx = document.getElementById(canvasId);
    if (!ctx) return;

    const data = getData();
    const companyCounts = {};
    data.applications.filter(a => a.status === 'selected').forEach(a => {
      companyCounts[a.companyName] = (companyCounts[a.companyName] || 0) + 1;
    });

    const labels = Object.keys(companyCounts);
    const values = Object.values(companyCounts);
    const colors = ['#1a56db', '#0d1b3e', '#22c55e', '#a855f7', '#f97316', '#14b8a6'];

    if (this.companiesChart) this.companiesChart.destroy();

    this.companiesChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: labels.length ? labels : ['TCS', 'Infosys', 'Wipro', 'L&T'],
        datasets: [{
          data: values.length ? values : [2, 1, 1, 1],
          backgroundColor: colors.slice(0, labels.length || 4),
          borderWidth: 0,
          hoverOffset: 8
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: '65%',
        plugins: {
          legend: { position: 'bottom', labels: { font: { family: 'Poppins', size: 11 }, padding: 15, usePointStyle: true } }
        }
      }
    });
  },

  renderReportsCharts() {
    this.renderPlacementChart('reportPlacementChart');
    this.renderTopCompaniesChart('reportCompaniesChart');
    this.renderBranchChart('reportBranchChart');
    this.renderStatusChart('reportStatusChart');
  },

  renderBranchChart(canvasId) {
    const ctx = document.getElementById(canvasId);
    if (!ctx) return;

    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['CS', 'IT', 'ECE', 'ME', 'CE'],
        datasets: [{
          label: 'Placed',
          data: [12, 8, 4, 3, 2],
          backgroundColor: '#1a56db',
          borderRadius: 6
        }, {
          label: 'Registered',
          data: [45, 32, 28, 22, 18],
          backgroundColor: '#e5e7eb',
          borderRadius: 6
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { position: 'top', labels: { font: { family: 'Poppins' } } } },
        scales: { y: { beginAtZero: true, grid: { color: '#f1f5f9' } }, x: { grid: { display: false } } }
      }
    });
  },

  renderStatusChart(canvasId) {
    const ctx = document.getElementById(canvasId);
    if (!ctx) return;

    const data = getData();
    const statuses = ['pending', 'shortlisted', 'selected', 'rejected'];
    const counts = statuses.map(s => data.applications.filter(a => a.status === s).length);

    new Chart(ctx, {
      type: 'polarArea',
      data: {
        labels: ['Pending', 'Shortlisted', 'Selected', 'Rejected'],
        datasets: [{
          data: counts,
          backgroundColor: ['rgba(249, 115, 22, 0.7)', 'rgba(59, 130, 246, 0.7)', 'rgba(168, 85, 247, 0.7)', 'rgba(220, 38, 38, 0.7)']
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { position: 'bottom', labels: { font: { family: 'Poppins', size: 11 } } } }
      }
    });
  }
};
