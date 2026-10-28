<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="companies.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.companies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Companies</li></ol></nav>
            <h4>Company Management</h4>
            <p>Manage recruiting companies and their profiles.</p>
          </div>
          <!-- <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#companyModal" onclick="document.getElementById('companyForm').reset();document.getElementById('companyId').value='';document.getElementById('companyModalTitle').textContent='Add Company'">
            <i class="bi bi-plus-lg me-1"></i>Add Company
          </button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#companyModal" OnClientClick="document.getElementById(&#x27;companyForm&#x27;).reset();document.getElementById(&#x27;companyId&#x27;).value=&#x27;&#x27;;document.getElementById(&#x27;companyModalTitle&#x27;).textContent=&#x27;Add Company&#x27;; return false;" Text="Add Company" />
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th></th><th>Company</th><th>Email</th><th>Industry</th><th>Location</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody id="companiesTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="companiesPagination"></div></div>
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

  <div class="modal fade" id="companyModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title" id="companyModalTitle">Add Company</h5><!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" /></div>
      <div class="modal-body">
        <form id="companyForm">
          <input type="hidden" id="companyId">
          <!-- <div class="mb-3"><label class="form-label-custom">Company Name</label><input type="text" class="form-control form-control-custom" id="companyName" required></div> -->
          <div class="mb-3"><label class="form-label-custom">Company Name</label><asp:TextBox runat="server" ID="companyName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <!-- <div class="mb-3"><label class="form-label-custom">Email</label><input type="email" class="form-control form-control-custom" id="companyEmail" required></div> -->
          <div class="mb-3"><label class="form-label-custom">Email</label><asp:TextBox runat="server" ID="companyEmail" ClientIDMode="Static" TextMode="Email" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="row">
            <!-- <div class="col-6 mb-3"><label class="form-label-custom">Industry</label><input type="text" class="form-control form-control-custom" id="companyIndustry" required></div> -->
            <div class="col-6 mb-3"><label class="form-label-custom">Industry</label><asp:TextBox runat="server" ID="companyIndustry" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
            <!-- <div class="col-6 mb-3"><label class="form-label-custom">Location</label><input type="text" class="form-control form-control-custom" id="companyLocation" required></div> -->
            <div class="col-6 mb-3"><label class="form-label-custom">Location</label><asp:TextBox runat="server" ID="companyLocation" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          </div>
          <!-- <div class="mb-3"><label class="form-label-custom">Contact</label><input type="tel" class="form-control form-control-custom" id="companyContact" required></div> -->
          <div class="mb-3"><label class="form-label-custom">Contact</label><asp:TextBox runat="server" ID="companyContact" ClientIDMode="Static" TextMode="Phone" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
        </form>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <!-- <button type="button" class="btn btn-primary-custom" onclick="Admin.saveCompany()">Save</button> -->
        <asp:Button runat="server" ID="saveCompanyBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Admin.saveCompany(); return false;" Text="Save" />
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
    //  Components.initLayout('admin', 'companies.aspx', App.currentUser);
    //  Admin.renderCompaniesTable();
      //}

      Components.initLayout('admin', 'companies.aspx', App.currentUser);
      Admin.renderCompaniesTable();
  </script>
</asp:Content>

