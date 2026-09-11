<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="selected.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.selected" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Selected Students</h4><p>Students selected for placement at your company.</p></div>
        <div class="filter-bar d-flex gap-2 flex-wrap mb-3">
          <select class="form-select form-select-sm" style="width:auto" id="selectedJobFilter"></select>
          <select class="form-select form-select-sm" style="width:auto" id="selectedBranchFilter"></select>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th></th><th>Student</th><th>Job Title</th><th>Package</th><th>Selection Date</th><th>Joining Date</th><th>Offer Status</th><th>Action</th></tr></thead>
                <tbody id="selectedTableBody"></tbody>
              </table>
            </div>
          </div>
        </div>
      </div>

      <!-- Edit Selection / Offer Modal -->
      <div class="modal fade" id="editSelectionModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Edit Selection Details</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <input type="hidden" id="editSelectionAppId">
              <div class="mb-3"><label class="form-label-custom">Offer Status</label>
                <select class="form-select form-control-custom" id="editOfferStatus">
                  <option value="Selected">Selected</option>
                  <option value="Offer Received">Offer Received</option>
                  <option value="Joined">Joined</option>
                  <option value="Not Joined">Not Joined</option>
                </select>
              </div>
              <div class="mb-3"><label class="form-label-custom">Joining Date</label><input type="date" class="form-control form-control-custom" id="editJoiningDate"></div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
              <button type="button" class="btn btn-primary-custom" onclick="Company.saveSelectionEdit()">Save</button>
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
      Components.initLayout('company', 'selected.aspx', App.currentUser);
      Company.initSelectedFilters();
      Company.renderSelected();
    }
  </script>
</asp:Content>

