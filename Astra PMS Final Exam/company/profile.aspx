<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Company Profile</h4><p>Your company information on the portal.</p></div>
        <div class="profile-header d-flex align-items-center gap-4 flex-wrap">
          <div class="profile-header-avatar" id="profileAvatar">TC</div>
          <div><h3 class="mb-1" id="profileName">Company</h3><p class="opacity-75 mb-0" id="profileId">COM001</p></div>
        </div>
        <div class="row g-4">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Contact Information</h5></div>
              <div class="card-body-custom">
                <div class="profile-info-item"><i class="bi bi-envelope"></i><div><small class="text-muted">Email</small><div id="infoEmail">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-phone"></i><div><small class="text-muted">Contact</small><div id="infoContact">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-globe"></i><div><small class="text-muted">Website</small><div id="infoWebsite">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-geo-alt"></i><div><small class="text-muted">Location</small><div id="infoLocation">—</div></div></div>
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Company Details</h5></div>
              <div class="card-body-custom">
                <div class="profile-info-item"><i class="bi bi-building"></i><div><small class="text-muted">Industry</small><div id="infoIndustry">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-check-circle"></i><div><small class="text-muted">Status</small><div id="infoStatus">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-file-text"></i><div><small class="text-muted">Description</small><div id="infoDescription">—</div></div></div>
              </div>
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
      Components.initLayout('company', 'profile.aspx', App.currentUser);
      Company.renderProfile();
    }
  </script>
</asp:Content>

