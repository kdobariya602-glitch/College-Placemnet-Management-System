<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="drives.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.drives" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Drives</li></ol></nav>
            <h4>Placement Drive Management</h4>
            <p>Schedule and manage campus placement drives.</p>
          </div>
          <!-- <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#driveModal"><i class="bi bi-plus-lg me-1"></i>Schedule Drive</button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#driveModal" OnClientClick="return false;" Text="Schedule Drive" />
        </div>
        <div class="filter-bar">
          <!-- <select class="form-select form-select-sm" style="width:auto" id="driveStatusFilter">
            <option value="">All Status</option>
            <option value="upcoming">Upcoming</option>
            <option value="completed">Completed</option>
          </select> -->
<asp:DropDownList runat="server" ID="driveStatusFilter" ClientIDMode="Static" CssClass="form-select form-select-sm">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Upcoming" Value="upcoming"></asp:ListItem>
                    <asp:ListItem Text="Completed" Value="completed"></asp:ListItem>
                </asp:DropDownList>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Drive Name</th><th>Company</th><th>Date</th><th>Venue</th><th>Registered</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody id="drivesTableBody"></tbody>
              </table>
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

    </div>
  </div>

  <div class="modal fade" id="driveModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title">Schedule Placement Drive</h5><!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" /></div>
      <div class="modal-body">
        <form id="driveForm">
          <!-- <div class="mb-3"><label class="form-label-custom">Drive Name</label><input type="text" class="form-control form-control-custom" id="driveName" required></div> -->
          <div class="mb-3"><label class="form-label-custom">Drive Name</label><asp:TextBox runat="server" ID="driveName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Company</label>
            <!-- <select class="form-select form-control-custom" id="driveCompany" required></select> -->
<asp:DropDownList runat="server" ID="driveCompany" ClientIDMode="Static" CssClass="form-select form-control-custom"></asp:DropDownList>
          </div>
          <div class="row">
            <div class="col-6 mb-3"><label class="form-label-custom">Date</label><!-- <input type="date" class="form-control form-control-custom" id="driveDate" required> -->
<asp:TextBox runat="server" ID="driveDate" ClientIDMode="Static" TextMode="Date" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
            <!-- <div class="col-6 mb-3"><label class="form-label-custom">Venue</label><input type="text" class="form-control form-control-custom" id="driveVenue" required></div> -->
            <div class="col-6 mb-3"><label class="form-label-custom">Venue</label><asp:TextBox runat="server" ID="driveVenue" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          </div>
          <!-- <div class="mb-3"><label class="form-label-custom">Eligibility</label><input type="text" class="form-control form-control-custom" id="driveEligibility" placeholder="CGPA ≥ 7.0, CS/IT" required></div> -->
          <div class="mb-3"><label class="form-label-custom">Eligibility</label><asp:TextBox runat="server" ID="driveEligibility" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" placeholder="CGPA ≥ 7.0, CS/IT" required="required"></asp:TextBox></div>
        </form>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <!-- <button type="button" class="btn btn-primary-custom" onclick="Admin.saveDrive()">Schedule</button> -->
        <asp:Button runat="server" ID="saveDriveBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Admin.saveDrive(); return false;" Text="Schedule" />
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
      Components.initLayout('admin', 'drives.aspx', App.currentUser);
      const sel = document.getElementById('driveCompany');
      if (sel) { getData().companies.forEach(c => { sel.innerHTML += `<option value="${c.id}">${c.name}</option>`; }); }
      Admin.renderDrivesTable();
  </script>
</asp:Content>

