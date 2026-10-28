<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="jobs.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.jobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Available Jobs</h4><p>Browse and apply to open placement opportunities.</p></div>
        <div class="filter-bar d-flex flex-wrap gap-3 align-items-center">
          <asp:TextBox runat="server" ID="jobSearch" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" style="max-width:260px" placeholder="Search jobs or company..."></asp:TextBox>
          <select id="filterCompany" class="form-select form-control-custom" style="max-width:180px"></select>
          <select id="filterType" class="form-select form-control-custom" style="max-width:160px"></select>
          <select id="filterLocation" class="form-select form-control-custom" style="max-width:170px"></select>
          <select id="filterBranch" class="form-select form-control-custom" style="max-width:190px"></select>
          <select id="sortJobs" class="form-select form-control-custom" style="max-width:180px">
            <option value="">Sort: Newest</option>
            <option value="deadline">Sort: Deadline</option>
            <option value="cgpa">Sort: Min CGPA</option>
            <option value="package">Sort: Package</option>
          </select>
          <div class="form-check">
            <input class="form-check-input" type="checkbox" id="filterEligibleOnly">
            <label class="form-check-label small" for="filterEligibleOnly">Eligible only</label>
          </div>
        </div>
        <div class="row g-3" id="jobsContainer"></div>
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
      Components.initLayout('student', 'jobs.aspx', App.currentUser);
      Student.renderJobs();
      ['jobSearch', 'filterCompany', 'filterType', 'filterLocation', 'filterBranch', 'sortJobs', 'filterEligibleOnly'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.addEventListener(el.tagName === 'INPUT' && el.type === 'text' ? 'input' : 'change', () => Student.renderJobs());
      });
    }
  </script>
</asp:Content>



