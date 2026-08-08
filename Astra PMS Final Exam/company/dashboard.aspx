<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Dashboard</h4><p>Overview of your recruitment activities.</p></div>
        <div class="row g-3 mb-4">
          <div class="col-sm-6 col-lg-3"><div class="dashboard-card stat-card"><div class="stat-icon blue"><i class="bi bi-briefcase"></i></div><div><div class="stat-value" id="statJobs">0</div><div class="stat-label">Job Posts</div></div></div></div>
          <div class="col-sm-6 col-lg-3"><div class="dashboard-card stat-card"><div class="stat-icon orange"><i class="bi bi-file-earmark-text"></i></div><div><div class="stat-value" id="statApplications">0</div><div class="stat-label">Applications</div></div></div></div>
          <div class="col-sm-6 col-lg-3"><div class="dashboard-card stat-card"><div class="stat-icon purple"><i class="bi bi-star"></i></div><div><div class="stat-value" id="statShortlisted">0</div><div class="stat-label">Shortlisted</div></div></div></div>
          <div class="col-sm-6 col-lg-3"><div class="dashboard-card stat-card"><div class="stat-icon green"><i class="bi bi-trophy"></i></div><div><div class="stat-value" id="statSelected">0</div><div class="stat-label">Selected</div></div></div></div>
        </div>
        <div class="row g-3">
          <div class="col-lg-8">
            <div class="content-card">
              <div class="card-header-custom"><h5>Recent Applications</h5><a href="applications.aspx" class="btn btn-sm btn-outline-custom">View All</a></div>
              <div class="card-body-custom" id="recentApplications"></div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="content-card">
              <div class="card-header-custom"><h5>Quick Actions</h5></div>
              <div class="card-body-custom">
                <div class="d-grid gap-2">
                  <a href="post-job.aspx" class="btn btn-primary-custom"><i class="bi bi-plus-lg me-2"></i>Post New Job</a>
                  <a href="applications.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-people me-2"></i>Review Applications</a>
                  <a href="shortlist.aspx" class="btn btn-outline-custom text-start"><i class="bi bi-star me-2"></i>Shortlisted</a>
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
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/company.js"></script>
  <script>
    if (App.requireAuth('company', 'login.aspx')) {
      Components.initLayout('company', 'dashboard.aspx', App.currentUser);
      Company.initDashboard();
    }
  </script>
</asp:Content>
