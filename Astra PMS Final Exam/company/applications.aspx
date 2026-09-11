<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="applications.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>View Applications</h4><p>Review applications from students for your job posts.</p></div>
        <div class="filter-bar d-flex gap-2 flex-wrap">
          <!-- <select class="form-select form-select-sm" style="width:auto" id="appStatusFilter">
            <option value="">All Status</option>
            <option value="pending">Pending</option>
            <option value="shortlisted">Shortlisted</option>
            <option value="selected">Selected</option>
            <option value="rejected">Rejected</option>
          </select> -->
<asp:DropDownList runat="server" ID="appStatusFilter" ClientIDMode="Static" CssClass="form-select form-select-sm" Style="width:auto">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pending" Value="pending"></asp:ListItem>
                    <asp:ListItem Text="Shortlisted" Value="shortlisted"></asp:ListItem>
                    <asp:ListItem Text="Selected" Value="selected"></asp:ListItem>
                    <asp:ListItem Text="Rejected" Value="rejected"></asp:ListItem>
                </asp:DropDownList>
          <select class="form-select form-select-sm" style="width:auto" id="appJobFilter"><option value="">All Jobs</option></select>
          <select class="form-select form-select-sm" style="width:auto" id="appBranchFilter"><option value="">All Branches</option></select>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th></th><th>Student</th><th>Job</th><th>Status</th><th>Applied</th><th>Action</th></tr></thead>
                <tbody id="applicationsTableBody"></tbody>
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
  <script src="../assets/js/company.js"></script>
  <script>
    if (App.requireAuth('company', 'login.aspx')) {
      Components.initLayout('company', 'applications.aspx', App.currentUser);
      Company.initApplicationsFilters();
      Company.renderApplications();
    }
  </script>
</asp:Content>

