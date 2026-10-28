<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="reports-student.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.reports_student" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Student-wise Reports</li></ol></nav>
            <h4>Student-wise Reports</h4>
            <p>Placement performance broken down by individual student.</p>
          </div>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Student</th><th>Branch</th><th>Applications</th><th>Interviews</th><th>Status</th><th>Company Placed</th></tr></thead>
                <tbody id="reportsStudentTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="reportsStudentTableBodyPagination"></div></div>
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
      //    Components.initLayout('tpo', 'reports-student.aspx', App.currentUser);
      //}
      Components.initLayout('tpo', 'reports-student.aspx', App.currentUser);

      (function renderStudentWiseReport(page = 1) {
        const data = getData();
        const rows = data.students.map(s => {
          const apps = data.applications.filter(a => a.studentId === s.id);
          const interviews = apps.filter(a => a.interviewDate).length;
          const status = s.placed ? 'selected' : (apps.some(a => a.status === 'shortlisted') ? 'shortlisted' : (apps.length ? 'pending' : 'pending'));
          return {
            name: s.name, id: s.id, branch: s.branch,
            applications: apps.length, interviews,
            status, company: s.company || '—'
          };
        });

        const { items, totalPages } = App.paginate(rows, page);
        const tbody = document.getElementById('reportsStudentTableBody');
        if (!tbody) return;

        tbody.innerHTML = items.map(r => `
          <tr>
            <td><strong>${r.name}</strong><br><small class="text-muted">${r.id}</small></td>
            <td>${r.branch}</td>
            <td>${r.applications}</td>
            <td>${r.interviews}</td>
            <td>${App.getStatusBadge(r.status)}</td>
            <td>${r.company}</td>
          </tr>`).join('');

        App.renderPagination('reportsStudentTableBodyPagination', totalPages, page, (p) => renderStudentWiseReport(p));
      })();
  </script>
</asp:Content>