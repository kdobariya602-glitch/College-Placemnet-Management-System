<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="departments.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.departments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Departments</li></ol></nav>
            <h4>Department Management</h4>
            <p>Manage academic departments offered by the institute.</p>
          </div>
          <!-- <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#departmentsModal" onclick="document.getElementById('departmentsForm').reset();document.getElementById('departmentsId').value='';document.getElementById('departmentsModalTitle').textContent='Add Department'">
            <i class="bi bi-plus-lg me-1"></i>Add Department
          </button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#departmentsModal" OnClientClick="document.getElementById(&#x27;departmentsForm&#x27;).reset();document.getElementById(&#x27;departmentsId&#x27;).value=&#x27;&#x27;;document.getElementById(&#x27;departmentsModalTitle&#x27;).textContent=&#x27;Add Department&#x27;; return false;" Text="Add Department" />
        </div>
        <div class="filter-bar d-flex flex-wrap gap-3 align-items-center mb-3">
          <asp:DropDownList runat="server" ID="deptStatusFilter" ClientIDMode="Static" CssClass="form-select form-select-sm" style="width:auto">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Active" Value="active"></asp:ListItem>
                    <asp:ListItem Text="Inactive" Value="inactive"></asp:ListItem>
                </asp:DropDownList>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th></th><th>Department</th><th>Code</th><th>HOD</th><th>Students</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody id="departmentsTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="departmentsPagination"></div></div>
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

  <div class="modal fade" id="departmentsModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title" id="departmentsModalTitle">Add Department</h5><!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" /></div>
      <div class="modal-body">
        <form id="departmentsForm">
          <input type="hidden" id="departmentsId">
          <div class="mb-3"><label class="form-label-custom">Department Name</label><asp:TextBox runat="server" ID="deptName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Department Code</label><asp:TextBox runat="server" ID="deptCode" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Head of Department</label><asp:TextBox runat="server" ID="deptHod" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
        </form>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <asp:Button runat="server" ID="saveDepartmentsBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Admin.saveDepartment(); return false;" Text="Save" />
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
    //  Components.initLayout('admin', 'departments.aspx', App.currentUser);
    //  Admin.renderDepartmentsTable();
      //}

      Components.initLayout('admin', 'departments.aspx', App.currentUser);
      Admin.renderDepartmentsTable();
      App.filterTable('deptStatusFilter', 'departmentsTableBody', 'status');
  </script>
</asp:Content>
