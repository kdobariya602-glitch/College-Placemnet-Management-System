<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="applications.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<%--<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <!-- ============================= HEADER START (Top bar / Navbar / Sidebar include) ============================= -->
  <div class="app-wrapper">
    <div id="sidebarContainer"></div>
    <div id="mobileSidebarContainer"></div>
    <div class="main-content" id="mainContent">
      <div id="navbarContainer"></div>
<!-- ============================= HEADER END ============================= -->
</asp:Content>--%>
<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder2">
    
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Applications</li></ol></nav>
          <h4>Applications Management</h4>
          <p>Review and manage all student job applications.</p>
        </div>
        <div class="filter-bar">
          <asp:DropDownList runat="server" ID="appCompanyFilter" ClientIDMode="Static" CssClass="form-select form-select-sm" style="width:auto">
                    <asp:ListItem Text="All Companies" Value=""></asp:ListItem>
                </asp:DropDownList>
          <asp:DropDownList runat="server" ID="appJobFilter" ClientIDMode="Static" CssClass="form-select form-select-sm" style="width:auto">
                    <asp:ListItem Text="All Jobs" Value=""></asp:ListItem>
                </asp:DropDownList>
          <asp:DropDownList runat="server" ID="appDriveFilter" ClientIDMode="Static" CssClass="form-select form-select-sm" style="width:auto">
                    <asp:ListItem Text="All Drives" Value=""></asp:ListItem>
                </asp:DropDownList>
          <!-- <select class="form-select form-select-sm" style="width:auto" id="appStatusFilter">
            <option value="">All Status</option>
            <option value="pending">Pending</option>
            <option value="shortlisted">Shortlisted</option>
            <option value="selected">Selected</option>
            <option value="rejected">Rejected</option>
          </select> -->
<asp:DropDownList runat="server" ID="appStatusFilter" ClientIDMode="Static" CssClass="form-select form-select-sm">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pending" Value="pending"></asp:ListItem>
                    <asp:ListItem Text="Shortlisted" Value="shortlisted"></asp:ListItem>
                    <asp:ListItem Text="Selected" Value="selected"></asp:ListItem>
                    <asp:ListItem Text="Rejected" Value="rejected"></asp:ListItem>
                </asp:DropDownList>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Student</th><th>Job</th><th>Company</th><th>Status</th><th>Applied</th><th>Interview</th><th>Action</th></tr></thead>
                <tbody id="applicationsTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="applicationsPagination"></div></div>
        </div>
      </div>
      
<!-- ============================= BODY END ============================= -->
</asp:Content>
<asp:Content ID="Content4" runat="server" contentplaceholderid="ContentPlaceHolder3">
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
  <script src="../assets/js/tpo.js"></script>
  <script>
      //if (App.requireAuth('tpo', 'login.aspx')) {
      //    Components.initLayout('tpo', 'applications.aspx', App.currentUser);
      //    Tpo.renderApplicationsTable();
      //}

      Components.initLayout('tpo', 'applications.aspx', App.currentUser);
      Tpo.populateCompanyDropdown('appCompanyFilter');
      Tpo.populateJobDropdown('appJobFilter');
      Tpo.populateDriveDropdown('appDriveFilter');
      Tpo.renderApplicationsTable();
      document.getElementById('appCompanyFilter')?.addEventListener('change', () => Tpo.renderApplicationsTable());
      document.getElementById('appJobFilter')?.addEventListener('change', () => Tpo.renderApplicationsTable());
      document.getElementById('appDriveFilter')?.addEventListener('change', () => Tpo.renderApplicationsTable());
  </script>
</asp:Content>