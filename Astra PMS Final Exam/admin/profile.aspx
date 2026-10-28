<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Profile</li></ol></nav>
          <h4>My Profile</h4>
          <p>Admin ni personal details.</p>
        </div>

        <div class="row g-4">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5><i class="bi bi-person-circle me-2"></i>Admin Details</h5></div>
              <div class="card-body-custom">
                <div class="mb-3">
                  <label class="form-label-custom">Name</label>
                  <asp:Label runat="server" ID="lblName" ClientIDMode="Static" CssClass="form-control form-control-custom" Text="-"></asp:Label>
                </div>
                <div class="mb-3">
                  <label class="form-label-custom">Email</label>
                  <asp:Label runat="server" ID="lblEmail" ClientIDMode="Static" CssClass="form-control form-control-custom" Text="-"></asp:Label>
                </div>
                <div class="mb-3">
                  <label class="form-label-custom">Role</label>
                  <asp:Label runat="server" ID="lblRole" ClientIDMode="Static" CssClass="form-control form-control-custom" Text="Administrator"></asp:Label>
                </div>
                <a href="change-password.aspx" class="btn btn-outline-custom"><i class="bi bi-shield-lock me-1"></i>Change Password</a>
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
  <script src="../assets/js/admin.js"></script>
  <script>
      Components.initLayout('admin', 'profile.aspx', App.currentUser);
  </script>
</asp:Content>
