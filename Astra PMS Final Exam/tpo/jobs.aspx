<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="jobs.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.jobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Jobs</li></ol></nav>
          <h4>Job Management</h4>
          <p>View and manage all job postings across companies.</p>
        </div>
        <div class="filter-bar">
          <!-- <select class="form-select form-select-sm" style="width:auto" id="jobStatusFilter">
            <option value="">All Status</option>
            <option value="active">Active</option>
            <option value="closed">Closed</option>
          </select> -->
<asp:DropDownList runat="server" ID="jobStatusFilter" ClientIDMode="Static" CssClass="form-select form-select-sm">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pending Approval" Value="pending"></asp:ListItem>
                    <asp:ListItem Text="Active" Value="active"></asp:ListItem>
                    <asp:ListItem Text="Rejected" Value="rejected"></asp:ListItem>
                    <asp:ListItem Text="Closed" Value="closed"></asp:ListItem>
                    <asp:ListItem Text="Draft" Value="draft"></asp:ListItem>
                </asp:DropDownList>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Job Title</th><th>Company</th><th>Type</th><th>Location</th><th>Salary</th><th>Status</th><th>Deadline</th><th>Actions</th></tr></thead>
                <tbody id="jobsTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="jobsPagination"></div></div>
        </div>
      </div>
      
<!-- ============================= BODY END ============================= -->
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">
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
    //  Components.initLayout('tpo', 'jobs.aspx', App.currentUser);
    //  Tpo.renderJobsTable();
      //}
      Components.initLayout('tpo', 'jobs.aspx', App.currentUser);
      Tpo.renderJobsTable();
  </script>
</asp:Content>

