<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="jobs.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.jobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Available Jobs</h4><p>Browse and apply to open placement opportunities.</p></div>
        <div class="filter-bar d-flex flex-wrap gap-3">
          <!-- <input type="text" class="form-control form-control-custom" style="max-width:300px" id="jobSearch" placeholder="Search jobs..."> -->
          <asp:TextBox runat="server" ID="jobSearch" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" style="max-width:300px" placeholder="Search jobs..."></asp:TextBox>
        </div>
        <div class="row g-3" id="jobsContainer"></div>
      </div>
      
<!-- ============================= BODY END ============================= --><!-- ============================= FOOTER START ============================= -->

</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">
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
          Components.initLayout('student', 'jobs.aspx', App.currentUser);
          Student.renderJobs();
          document.getElementById('jobSearch').addEventListener('input', (e) => Student.renderJobs(e.target.value.toLowerCase()));
      }
  </script>
</asp:Content>

