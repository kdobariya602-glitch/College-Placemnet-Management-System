<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="student-details.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.student_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item"><a href="students.aspx">Student Management</a></li><li class="breadcrumb-item active">Student Details</li></ol></nav>
          <h4>Student Details</h4>
          <p>Detailed academic and contact information of the selected student.</p>
        </div>

        <asp:Panel ID="pnlNotFound" runat="server" Visible="false" CssClass="content-card">
          <div class="card-body-custom text-center py-5">
            <i class="bi bi-person-x fs-1 text-muted"></i>
            <p class="mt-2 mb-3">No student selected. Please open a student's details from the Student Management page.</p>
            <a href="students.aspx" class="btn btn-primary-custom"><i class="bi bi-arrow-left me-1"></i>Back to Student Management</a>
          </div>
        </asp:Panel>

        <asp:Panel ID="pnlDetails" runat="server" CssClass="content-card">
          <div class="card-body-custom">
            <div class="profile-header d-flex align-items-center gap-4 flex-wrap mb-4">
              <div class="profile-header-avatar"><asp:Label ID="lblInitials" runat="server"></asp:Label></div>
              <div>
                <h3 class="mb-1"><asp:Label ID="lblFullName" runat="server"></asp:Label></h3>
                <p class="opacity-75 mb-0"><asp:Label ID="lblBranch" runat="server"></asp:Label></p>
              </div>
            </div>
            <div class="row g-4 mb-4">
              <div class="col-md-4"><div class="dashboard-card text-center py-3"><i class="bi bi-mortarboard text-danger fs-4"></i><div class="small text-muted mt-1">CGPA</div><strong><asp:Label ID="lblCgpa" runat="server"></asp:Label></strong></div></div>
              <div class="col-md-4"><div class="dashboard-card text-center py-3"><i class="bi bi-calendar3 text-danger fs-4"></i><div class="small text-muted mt-1">Graduation Year</div><strong><asp:Label ID="lblYear" runat="server"></asp:Label></strong></div></div>
              <div class="col-md-4"><div class="dashboard-card text-center py-3"><i class="bi bi-diagram-3 text-danger fs-4"></i><div class="small text-muted mt-1">Branch</div><strong><asp:Label ID="lblBranch2" runat="server"></asp:Label></strong></div></div>
            </div>
            <div class="row g-4">
              <div class="col-lg-6">
                <h5 class="mb-3">Contact Information</h5>
                <div class="profile-info-item"><i class="bi bi-envelope"></i><div><small class="text-muted">Email</small><div><asp:Label ID="lblEmail" runat="server"></asp:Label></div></div></div>
                <div class="profile-info-item"><i class="bi bi-phone"></i><div><small class="text-muted">Phone</small><div><asp:Label ID="lblPhone" runat="server"></asp:Label></div></div></div>
              </div>
              <div class="col-lg-6">
                <h5 class="mb-3">Skills</h5>
                <div><asp:Label ID="lblSkills" runat="server"></asp:Label></div>
              </div>
            </div>
          </div>
        </asp:Panel>
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
  <script src="../assets/js/tpo.js"></script>
  <script>
      Components.initLayout('tpo', 'student-details.aspx', App.currentUser);
  </script>
</asp:Content>