<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="eligible-drives.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.eligible_drives" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Eligible Drives</h4><p>Upcoming drives you qualify for based on your CGPA and branch.</p></div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Drive</th><th>Company</th><th>Job</th><th>Date</th><th>Time</th><th>Venue</th><th>Mode</th><th>Eligibility</th><th></th></tr></thead>
                <tbody id="eligibleDrivesTableBody"></tbody>
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
  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/student.js"></script>
  <script>
    if (App.requireAuth('student', 'login.aspx')) {
      Components.initLayout('student', 'eligible-drives.aspx', App.currentUser);
      Student.renderEligibleDrives();
    }
  </script>
</asp:Content>
