<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="job-roles.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.job_roles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Job Roles</li></ol></nav>
            <h4>Job Role Management</h4>
            <p>Manage the master list of job roles used in placement drives.</p>
          </div>
          <!-- <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#job_rolesModal" onclick="document.getElementById('job_rolesForm').reset();document.getElementById('job_rolesId').value='';document.getElementById('job_rolesModalTitle').textContent='Add Job Role'">
            <i class="bi bi-plus-lg me-1"></i>Add Job Role
          </button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#job_rolesModal" OnClientClick="document.getElementById(&#x27;job_rolesForm&#x27;).reset();document.getElementById(&#x27;job_rolesId&#x27;).value=&#x27;&#x27;;document.getElementById(&#x27;job_rolesModalTitle&#x27;).textContent=&#x27;Add Job Role&#x27;; return false;" Text="Add Job Role" />
        </div>
        <div class="filter-bar d-flex flex-wrap gap-3 align-items-center mb-3">
          <asp:DropDownList runat="server" ID="roleStatusFilter" ClientIDMode="Static" CssClass="form-select form-select-sm" style="width:auto">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Active" Value="active"></asp:ListItem>
                    <asp:ListItem Text="Inactive" Value="inactive"></asp:ListItem>
                </asp:DropDownList>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th></th><th>Role Title</th><th>Category</th><th>Description</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody id="jobRolesTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="jobRolesPagination"></div></div>
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

  <div class="modal fade" id="job_rolesModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title" id="job_rolesModalTitle">Add Job Role</h5><!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" /></div>
      <div class="modal-body">
        <form id="job_rolesForm">
          <input type="hidden" id="job_rolesId">
          <div class="mb-3"><label class="form-label-custom">Role Title</label><asp:TextBox runat="server" ID="roleTitle" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Category</label><asp:TextBox runat="server" ID="roleCategory" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Description</label><asp:TextBox runat="server" ID="roleDescription" ClientIDMode="Static" TextMode="MultiLine" CssClass="form-control form-control-custom" Rows="3" required="required"></asp:TextBox></div>
        </form>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <asp:Button runat="server" ID="saveJobRolesBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Admin.saveJobRole(); return false;" Text="Save" />
      </div>
    </div></div>
  </div>
  <div id="modalContainer"></div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/admin.js"></script>
  <script>
    //if (App.requireAuth('admin', 'login.aspx')) {
    //  Components.initLayout('admin', 'job-roles.aspx', App.currentUser);
    //  Admin.renderJobRolesTable();
      //}

      Components.initLayout('admin', 'job-roles.aspx', App.currentUser);
      Admin.renderJobRolesTable();
      App.filterTable('roleStatusFilter', 'jobRolesTableBody', 'status');
  </script>
</asp:Content>
