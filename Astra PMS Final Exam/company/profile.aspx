<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start mb-4">
          <div class="page-breadcrumb mb-0"><h4>Company Profile</h4><p>Your company information on the portal.</p></div>
          <button type="button" class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#editProfileModal" onclick="Company.openEditProfile()"><i class="bi bi-pencil me-1"></i>Edit Profile</button>
        </div>
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

      <!-- Edit Profile Modal -->
      <div class="modal fade" id="editProfileModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Edit Company Profile</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form id="editProfileForm">
                <div class="mb-3"><label class="form-label-custom">Company Name</label><input type="text" class="form-control form-control-custom" id="editCompanyName" required></div>
                <div class="mb-3"><label class="form-label-custom">Email</label><input type="email" class="form-control form-control-custom" id="editEmail" required></div>
                <div class="mb-3"><label class="form-label-custom">Contact Number</label><input type="text" class="form-control form-control-custom" id="editContact" required></div>
                <div class="mb-3"><label class="form-label-custom">Website</label><input type="text" class="form-control form-control-custom" id="editWebsite"></div>
                <div class="mb-3"><label class="form-label-custom">Location</label><input type="text" class="form-control form-control-custom" id="editLocation" required></div>
                <div class="mb-3"><label class="form-label-custom">Industry</label><input type="text" class="form-control form-control-custom" id="editIndustry"></div>
                <div class="mb-3"><label class="form-label-custom">Description</label><textarea class="form-control form-control-custom" id="editDescription" rows="3"></textarea></div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
              <button type="button" class="btn btn-primary-custom" id="saveProfileBtnModal" onclick="Company.saveProfile()">Save Changes</button>
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

