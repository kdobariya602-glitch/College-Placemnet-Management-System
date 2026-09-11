<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="placement-status.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.placement_status" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    
<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Placement Status</h4><p>Monitor your overall placement progress and timeline.</p></div>
        <div id="placementStatus" class="mb-4"></div>
        <div class="content-card mb-4" id="placementDetailsCard" style="display:none;">
          <div class="card-header-custom"><h5>Placement Details</h5></div>
          <div class="card-body-custom">
            <div class="row g-3">
              <div class="col-md-6 profile-info-item"><i class="bi bi-building"></i><div><small class="text-muted">Company</small><div id="pdCompany">—</div></div></div>
              <div class="col-md-6 profile-info-item"><i class="bi bi-briefcase"></i><div><small class="text-muted">Job</small><div id="pdJob">—</div></div></div>
              <div class="col-md-6 profile-info-item"><i class="bi bi-currency-rupee"></i><div><small class="text-muted">Package</small><div id="pdPackage">—</div></div></div>
              <div class="col-md-6 profile-info-item"><i class="bi bi-trophy"></i><div><small class="text-muted">Offer Status</small><div id="pdOfferStatus">—</div></div></div>
              <div class="col-md-6 profile-info-item"><i class="bi bi-calendar-check"></i><div><small class="text-muted">Placement Date</small><div id="pdPlacementDate">—</div></div></div>
              <div class="col-md-6 profile-info-item"><i class="bi bi-calendar-event"></i><div><small class="text-muted">Joining Date</small><div id="pdJoiningDate">—</div></div></div>
              <div class="col-md-6 profile-info-item"><i class="bi bi-file-earmark-text"></i><div><small class="text-muted">Offer Letter</small><div id="pdOfferLetter">—</div></div></div>
              <div class="col-md-6 profile-info-item"><i class="bi bi-chat-left-text"></i><div><small class="text-muted">Remarks</small><div id="pdRemarks">—</div></div></div>
            </div>
          </div>
        </div>
        <div class="content-card mb-4">
          <div class="card-header-custom"><h5>Placement Progress</h5></div>
          <div class="card-body-custom">
            <div class="mb-2 d-flex justify-content-between"><span>Profile Completion</span><span>100%</span></div>
            <div class="progress progress-custom mb-4"><div class="progress-bar" style="width:100%"></div></div>
            <div class="mb-2 d-flex justify-content-between"><span>Applications Submitted</span><span id="appProgress">0%</span></div>
            <div class="progress progress-custom"><div class="progress-bar" id="appProgressBar" style="width:0%"></div></div>
          </div>
        </div>
        <div class="content-card">
          <div class="card-header-custom"><h5>Application Timeline</h5></div>
          <div class="card-body-custom" id="placementTimeline"></div>
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
  <script src="../assets/js/student.js"></script>
  <script>
    if (App.requireAuth('student', 'login.aspx')) {
      Components.initLayout('student', 'placement-status.aspx', App.currentUser);
      Student.renderPlacementStatus();
      const apps = getData().applications.filter(a => a.studentId === App.currentUser.id).length;
      const pct = Math.min(apps * 20, 100);
      document.getElementById('appProgress').textContent = pct + '%';
      document.getElementById('appProgressBar').style.width = pct + '%';
    }
  </script>
</asp:Content>

