<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="create-drive.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.create_drive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item"><a href="drives.aspx">Placement Drives</a></li><li class="breadcrumb-item active">Create Placement Drive</li></ol></nav>
          <h4>Create Placement Drive</h4>
          <p>Schedule a new placement drive for a recruiting company.</p>
        </div>

        <div class="content-card">
          <div class="card-header-custom"><h5><i class="bi bi-calendar-plus me-2 text-danger"></i>Drive Details</h5></div>
          <div class="card-body-custom">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label-custom">Drive Name</label>
                <asp:TextBox runat="server" ID="driveName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label-custom">Approved Job</label>
                <asp:DropDownList runat="server" ID="driveJobSelect" ClientIDMode="Static" CssClass="form-select form-control-custom" onchange="Tpo.onDriveJobSelected()" required="required">
                    <asp:ListItem Text="Select an approved job" Value=""></asp:ListItem>
                </asp:DropDownList>
                <small class="text-muted">A drive can only be created from a job TPO has already approved.</small>
              </div>
              <div class="col-md-4 mb-3">
                <label class="form-label-custom">Drive Date</label>
                <asp:TextBox runat="server" ID="driveDate" ClientIDMode="Static" TextMode="Date" CssClass="form-control form-control-custom" required="required"></asp:TextBox>
              </div>
              <div class="col-md-4 mb-3">
                <label class="form-label-custom">Registration Deadline</label>
                <asp:TextBox runat="server" ID="driveDeadline" ClientIDMode="Static" TextMode="Date" CssClass="form-control form-control-custom" required="required"></asp:TextBox>
              </div>
              <div class="col-md-4 mb-3">
                <label class="form-label-custom">Venue</label>
                <asp:TextBox runat="server" ID="driveVenue" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox>
              </div>
              <div class="col-md-4 mb-3">
                <label class="form-label-custom">Job Role</label>
                <asp:TextBox runat="server" ID="driveJobRole" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required" ReadOnly="true"></asp:TextBox>
              </div>
              <div class="col-md-4 mb-3">
                <label class="form-label-custom">Minimum CGPA</label>
                <asp:TextBox runat="server" ID="driveMinCgpa" ClientIDMode="Static" TextMode="Number" step="0.1" min="0" max="10" CssClass="form-control form-control-custom" required="required"></asp:TextBox>
              </div>
              <div class="col-md-4 mb-3">
                <label class="form-label-custom">Eligible Branches</label>
                <asp:TextBox runat="server" ID="driveBranches" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" placeholder="e.g. CS, IT" required="required"></asp:TextBox>
              </div>
              <div class="col-md-4 mb-3">
                <label class="form-label-custom">Package (LPA)</label>
                <asp:TextBox runat="server" ID="drivePackage" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom"></asp:TextBox>
              </div>
              <div class="col-12 mb-3">
                <label class="form-label-custom">Description</label>
                <asp:TextBox runat="server" ID="driveDescription" ClientIDMode="Static" TextMode="MultiLine" Rows="4" CssClass="form-control form-control-custom"></asp:TextBox>
              </div>
            </div>
            <div class="d-flex gap-2">
              <asp:Button runat="server" ID="createDriveBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Tpo.createDrive(); return false;" Text="Create Drive" />
              <a href="drives.aspx" class="btn btn-outline-custom">Cancel</a>
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
  <script src="../assets/js/tpo.js"></script>
  <script>
      //if (App.requireAuth('tpo', 'login.aspx')) {
      //    Components.initLayout('tpo', 'create-drive.aspx', App.currentUser);
      //}
      Components.initLayout('tpo', 'create-drive.aspx', App.currentUser);
      Tpo.populateApprovedJobDropdown('driveJobSelect');
  </script>
</asp:Content>