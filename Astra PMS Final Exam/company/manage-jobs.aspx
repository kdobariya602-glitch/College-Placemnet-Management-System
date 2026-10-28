<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="manage-jobs.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.manage_jobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start mb-4">
          <div class="page-breadcrumb mb-0"><h4>Manage Job Posts</h4><p>View and manage your active job listings.</p></div>
          <a href="post-job.aspx" class="btn btn-primary-custom"><i class="bi bi-plus-lg me-1"></i>Post Job</a>
        </div>
        <div class="filter-bar d-flex gap-2 flex-wrap mb-3">
          <input type="text" class="form-control form-control-sm" style="max-width:220px" id="jobSearchInput" placeholder="Search jobs...">
          <select class="form-select form-select-sm" style="width:auto" id="jobStatusFilter">
            <option value="">All Status</option>
            <option value="draft">Draft</option>
            <option value="pending">Pending TPO Approval</option>
            <option value="active">Approved</option>
            <option value="rejected">Rejected</option>
            <option value="closed">Closed</option>
          </select>
          <select class="form-select form-select-sm" style="width:auto" id="jobSortSelect">
            <option value="newest">Newest First</option>
            <option value="oldest">Oldest First</option>
            <option value="title">Title (A-Z)</option>
            <option value="deadline">Deadline</option>
          </select>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Title</th><th>Type</th><th>Location</th><th>Salary</th><th>Applications</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody id="jobsTableBody"></tbody>
              </table>
            </div>
          </div>
        </div>
      </div>

      <!-- View Job Modal -->
      <div class="modal fade" id="viewJobModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Job Details</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="viewJobModalBody"></div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Close</button>
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
      Components.initLayout('company', 'manage-jobs.aspx', App.currentUser);
      Company.initManageJobsFilters();
      Company.renderManageJobs();
    }
  </script>
</asp:Content>

