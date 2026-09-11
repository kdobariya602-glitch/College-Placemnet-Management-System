<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="manage-tpo.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.manage_tpo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Manage TPO</li></ol></nav>
            <h4>TPO Management</h4>
            <p>Manage Training &amp; Placement Officer accounts that can access the TPO portal.</p>
          </div>
          <!-- <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#tpoModal" onclick="document.getElementById('tpoForm').reset();document.getElementById('tpoId').value='';document.getElementById('tpoModalTitle').textContent='Add TPO Officer'">
            <i class="bi bi-plus-lg me-1"></i>Add TPO Officer
          </button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#tpoModal" OnClientClick="document.getElementById(&#x27;tpoForm&#x27;).reset();document.getElementById(&#x27;tpoId&#x27;).value=&#x27;&#x27;;document.getElementById(&#x27;tpoModalTitle&#x27;).textContent=&#x27;Add TPO Officer&#x27;; return false;" Text="Add TPO Officer" />
        </div>

        <div class="filter-bar d-flex flex-wrap gap-3 align-items-center">
          <!-- <select class="form-select form-select-sm" style="width:auto" id="statusFilter">
            <option value="">All Status</option>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
          </select> -->
<asp:DropDownList runat="server" ID="statusFilter" ClientIDMode="Static" CssClass="form-select form-select-sm">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Active" Value="active"></asp:ListItem>
                    <asp:ListItem Text="Inactive" Value="inactive"></asp:ListItem>
                </asp:DropDownList>
        </div>

        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th></th><th>Name</th><th>Email</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody id="tpoTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="tpoPagination"></div></div>
        </div>
      </div>

<!-- ============================= BODY END ============================= -->
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">

<!-- ============================= FOOTER START ============================= -->
<div id="footerContainer"></div>
<!-- ============================= FOOTER END ============================= -->

  <div class="modal fade" id="tpoModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title" id="tpoModalTitle">Add TPO Officer</h5><!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" /></div>
      <div class="modal-body">
        <form id="tpoForm">
          <input type="hidden" id="tpoId">
          <div class="mb-3"><label class="form-label-custom">Full Name</label><asp:TextBox runat="server" ID="tpoName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Email</label><asp:TextBox runat="server" ID="tpoEmail" ClientIDMode="Static" TextMode="Email" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Password</label><asp:TextBox runat="server" ID="tpoPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
        </form>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <asp:Button runat="server" ID="saveTpoBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Admin.saveTpo(); return false;" Text="Save" />
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
      //}
      Components.initLayout('admin', 'manage-tpo.aspx', App.currentUser);
      Admin.renderTpoTable();
      App.filterTable('statusFilter', 'tpoTableBody', 'status');
  </script>
</asp:Content>
