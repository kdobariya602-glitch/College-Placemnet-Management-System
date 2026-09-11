<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Astra_PMS_Final_Exam.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start mb-4">
          <div class="page-breadcrumb mb-0"><h4>My Profile</h4><p>View your personal and academic information.</p></div>
          <a href="edit-profile.aspx" class="btn btn-primary-custom"><i class="bi bi-pencil me-1"></i>Edit Profile</a>
        </div>
        <div class="profile-header d-flex align-items-center gap-4 flex-wrap">
          <div class="profile-header-avatar" id="profileAvatar">AS</div>
          <div><h3 class="mb-1" id="profileName">Student Name</h3><p class="opacity-75 mb-0" id="profileId">STU001</p></div>
        </div>
        <div class="row g-4">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Personal Information</h5></div>
              <div class="card-body-custom">
                <div class="profile-info-item"><i class="bi bi-envelope"></i><div><small class="text-muted">Email</small><div id="infoEmail">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-phone"></i><div><small class="text-muted">Phone</small><div id="infoPhone">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-person"></i><div><small class="text-muted">Gender</small><div id="infoGender">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-cake"></i><div><small class="text-muted">Date of Birth</small><div id="infoDob">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-geo-alt"></i><div><small class="text-muted">Address</small><div id="infoAddress">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-mortarboard"></i><div><small class="text-muted">Branch</small><div id="infoBranch">—</div></div></div>
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Academic & Placement</h5></div>
              <div class="card-body-custom">
                <div class="profile-info-item"><i class="bi bi-journal-bookmark"></i><div><small class="text-muted">Course</small><div id="infoCourse">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-people"></i><div><small class="text-muted">Batch</small><div id="infoBatch">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-graph-up"></i><div><small class="text-muted">CGPA</small><div id="infoCgpa">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-calendar"></i><div><small class="text-muted">Graduation Year</small><div id="infoYear">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-trophy"></i><div><small class="text-muted">Placement Status</small><div id="infoStatus">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-file-earmark-text"></i><div><small class="text-muted">Resume</small><div id="infoResume"><a href="resume.aspx">Manage Resume</a></div></div></div>
              </div>
            </div>
          </div>
          <div class="col-12">
            <div class="content-card">
              <div class="card-header-custom"><h5>Skills</h5></div>
              <div class="card-body-custom" id="skillsList"></div>
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
          Components.initLayout('student', 'profile.aspx', App.currentUser);
          const fresh = getData().students.find(s => s.id === App.currentUser.id);
          if (fresh) App.setSession({ ...fresh, role: 'student' });
          Student.renderProfile();
      }
  </script>
</asp:Content>
