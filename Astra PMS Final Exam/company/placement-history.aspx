<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="placement-history.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.placement_history" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Placement History</h4><p>Complete record of applications and outcomes at your company.</p></div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Student</th><th>Branch</th><th>Batch</th><th>Job Title</th><th>Package</th><th>Placement Date</th><th>Joining Date</th><th>Offer Status</th></tr></thead>
                <tbody id="companyHistoryTableBody"></tbody>
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
  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/company.js"></script>
  <script>
    if (App.requireAuth('company', 'login.aspx')) {
      Components.initLayout('company', 'placement-history.aspx', App.currentUser);
      Company.renderPlacementHistory();
    }
  </script>
</asp:Content>
