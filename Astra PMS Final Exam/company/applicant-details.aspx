<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="applicant-details.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.applicant_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="applications.aspx">Applicants</a></li><li class="breadcrumb-item active">Applicant Details</li></ol></nav>
        </div>
        <div class="content-card">
          <div class="card-body-custom">
            <div class="profile-header d-flex align-items-center gap-4 flex-wrap mb-4">
              <div class="profile-header-avatar" id="applicantAvatar">—</div>
              <div>
                <h3 class="mb-1" id="applicantName">Student</h3>
                <p class="opacity-75 mb-0" id="applicantBranch">—</p>
              </div>
              <div class="ms-auto" id="applicantStatusBadge"></div>
            </div>
            <div class="row g-4 mb-4">
              <div class="col-md-3"><div class="dashboard-card text-center py-3"><i class="bi bi-mortarboard text-danger fs-4"></i><div class="small text-muted mt-1">CGPA</div><strong id="applicantCgpa">—</strong></div></div>
              <div class="col-md-3"><div class="dashboard-card text-center py-3"><i class="bi bi-briefcase text-danger fs-4"></i><div class="small text-muted mt-1">Applied For</div><strong id="applicantJob">—</strong></div></div>
              <div class="col-md-3"><div class="dashboard-card text-center py-3"><i class="bi bi-calendar-event text-danger fs-4"></i><div class="small text-muted mt-1">Applied On</div><strong id="applicantAppliedDate">—</strong></div></div>
              <div class="col-md-3"><div class="dashboard-card text-center py-3"><i class="bi bi-calendar-check text-danger fs-4"></i><div class="small text-muted mt-1">Interview Date</div><strong id="applicantInterviewDate">—</strong></div></div>
            </div>
            <div class="row g-4">
              <div class="col-lg-6">
                <h5 class="mb-3">Contact Information</h5>
                <div class="profile-info-item"><i class="bi bi-envelope"></i><div><small class="text-muted">Email</small><div id="applicantEmail">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-phone"></i><div><small class="text-muted">Phone</small><div id="applicantPhone">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-calendar3"></i><div><small class="text-muted">Graduation Year</small><div id="applicantYear">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-file-earmark-text"></i><div><small class="text-muted">Resume</small><div id="applicantResume">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-patch-check"></i><div><small class="text-muted">Eligibility</small><div id="applicantEligibility">—</div></div></div>
              </div>
              <div class="col-lg-6">
                <h5 class="mb-3">Skills</h5>
                <div id="applicantSkills"></div>
              </div>
            </div>
            <hr class="my-4">
            <h5 class="mb-3">Interview History</h5>
            <div id="applicantInterviewHistory" class="mb-4"></div>
            <div class="selection-details-wrap d-none">
              <h5 class="mb-3">Selection / Placement Details</h5>
              <div id="applicantSelectionDetails" class="mb-4"></div>
            </div>
            <hr class="my-4">
            <h5 class="mb-3">Update Application Status</h5>
            <div class="d-flex gap-2 flex-wrap">
              <!-- <button type="button" class="btn btn-outline-custom" id="btnShortlist"><i class="bi bi-star me-1"></i>Shortlist</button> -->
<asp:Button runat="server" ID="btnShortlist" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" OnClientClick="return false;" Text="Shortlist" />
              <!-- <button type="button" class="btn btn-primary-custom" id="btnSelect"><i class="bi bi-trophy me-1"></i>Select</button> -->
<asp:Button runat="server" ID="btnSelect" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="return false;" Text="Select" />
              <!-- <button type="button" class="btn btn-outline-custom text-danger" id="btnReject"><i class="bi bi-x-circle me-1"></i>Reject</button> -->
<asp:Button runat="server" ID="btnReject" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom text-danger" OnClientClick="return false;" Text="Reject" />
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
      Company.loadApplicantDetails();
    }
  </script>
</asp:Content>
