<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="applications.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>My Applications</h4><p>Track the status of all your job applications.</p></div>
        <div class="content-card mb-3">
          <div class="card-body-custom">
            <div class="row g-2">
              <div class="col-md-4"><input type="text" class="form-control form-control-custom" id="appSearch" placeholder="Search by job or company..." oninput="Student.renderApplications()"></div>
              <div class="col-md-3">
                <select class="form-select form-control-custom" id="appFilterCompany" onchange="Student.renderApplications()"><option value="">All Companies</option></select>
              </div>
              <div class="col-md-3">
                <select class="form-select form-control-custom" id="appFilterJob" onchange="Student.renderApplications()"><option value="">All Jobs</option></select>
              </div>
              <div class="col-md-2">
                <select class="form-select form-control-custom" id="appFilterStatus" onchange="Student.renderApplications()">
                  <option value="">All Status</option>
                  <option value="pending">Applied / Under Review</option>
                  <option value="shortlisted">Shortlisted</option>
                  <option value="selected">Selected</option>
                  <option value="rejected">Rejected</option>
                </select>
              </div>
            </div>
          </div>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Application ID</th><th>Job Title</th><th>Company</th><th>Status</th><th>Applied Date</th><th>Interview Date</th><th>Next Step</th><th></th></tr></thead>
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

    </div>
  </div>
  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/student.js"></script>
  <script>
    if (App.requireAuth('student', 'login.aspx')) {
      Components.initLayout('student', 'applications.aspx', App.currentUser);
      Student.renderApplications();
    }
  </script>
    </asp:Content>


