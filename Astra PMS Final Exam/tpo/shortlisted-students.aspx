<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="shortlisted-students.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.shortlisted_students" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Shortlisted Students</li></ol></nav>
            <h4>Shortlisted Students</h4>
            <p>Students shortlisted after the screening round of placement drives.</p>
          </div>
        </div>
        <div class="filter-bar"><!-- <select class="form-select form-select-sm" style="width:auto" id="shortlistedCompanyFilter"><option value="">All Companies</option></select> -->
<asp:DropDownList runat="server" ID="shortlistedCompanyFilter" ClientIDMode="Static" CssClass="form-select form-select-sm">
                    <asp:ListItem Text="All Companies" Value=""></asp:ListItem>
                </asp:DropDownList></div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Student</th><th>Job Role</th><th>Company</th><th>Drive Date</th><th>Interview Date</th><th>Status</th></tr></thead>
                <tbody id="shortlistedTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="shortlistedTableBodyPagination"></div></div>
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
      //    Components.initLayout('tpo', 'shortlisted-students.aspx', App.currentUser);
      //}
      Components.initLayout('tpo', 'shortlisted-students.aspx', App.currentUser);
      Tpo.populateCompanyDropdown('shortlistedCompanyFilter');
      Tpo.renderShortlistedTable();
      document.getElementById('shortlistedCompanyFilter')?.addEventListener('change', () => Tpo.renderShortlistedTable());
  </script>
</asp:Content>