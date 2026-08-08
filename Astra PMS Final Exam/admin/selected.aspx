<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="selected.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.selected" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Selected Students</li></ol></nav>
          <h4>Selected Students</h4>
          <p>Students who have been successfully placed.</p>
        </div>
        <div class="row g-3 mb-4">
          <div class="col-md-4"><div class="dashboard-card stat-card"><div class="stat-icon purple"><i class="bi bi-trophy"></i></div><div><div class="stat-value" id="selectedCount">0</div><div class="stat-label">Total Selected</div></div></div></div>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th></th><th>Student</th><th>Company</th><th>Job Title</th><th>Applied Date</th><th>Status</th></tr></thead>
                <tbody id="selectedTableBody"></tbody>
              </table>
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
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/admin.js"></script>
  <script>
    if (App.requireAuth('admin', 'login.aspx')) {
      Components.initLayout('admin', 'selected.aspx', App.currentUser);
      Admin.renderSelectedTable();
      document.getElementById('selectedCount').textContent = getData().applications.filter(a => a.status === 'selected').length;
    }
  </script>
</asp:Content>

