<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="students.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.students" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    
<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Students</li></ol></nav>
            <h4>Student Management</h4>
            <p>Manage registered students and their placement records.</p>
          </div>
          <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#studentModal" onclick="document.getElementById('studentForm').reset();document.getElementById('studentId').value='';document.getElementById('studentModalTitle').textContent='Add Student'">
            <i class="bi bi-plus-lg me-1"></i>Add Student
          </button>
        </div>

        <div class="filter-bar d-flex flex-wrap gap-3 align-items-center">
          <select class="form-select form-select-sm" style="width:auto" id="statusFilter">
            <option value="">All Status</option>
            <option value="placed">Placed</option>
            <option value="unplaced">Unplaced</option>
          </select>
        </div>

        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th></th><th>Student</th><th>Email</th><th>Branch</th><th>CGPA</th><th>Placement</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody id="studentsTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="studentsPagination"></div></div>
        </div>
      </div>
      
<!-- ============================= BODY END ============================= -->
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">
    
<!-- ============================= FOOTER START ============================= -->
<div id="footerContainer"></div>
<!-- ============================= FOOTER END ============================= -->

  <div class="modal fade" id="studentModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title" id="studentModalTitle">Add Student</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <div id="studentForm">
          <input type="hidden" id="studentId">
          <!-- <div class="mb-3"><label class="form-label-custom">Full Name</label><input type="text" class="form-control form-control-custom" id="studentName" required></div> -->
          <div class="mb-3"><label class="form-label-custom">Full Name</label><asp:TextBox runat="server" ID="studentName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <!-- <div class="mb-3"><label class="form-label-custom">Email</label><input type="email" class="form-control form-control-custom" id="studentEmail" required></div> -->
          <div class="mb-3"><label class="form-label-custom">Email</label><asp:TextBox runat="server" ID="studentEmail" ClientIDMode="Static" TextMode="Email" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <!-- <div class="mb-3"><label class="form-label-custom">Phone</label><input type="tel" class="form-control form-control-custom" id="studentPhone" required></div> -->
          <div class="mb-3"><label class="form-label-custom">Phone</label><asp:TextBox runat="server" ID="studentPhone" ClientIDMode="Static" TextMode="Phone" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="row">
            <div class="col-6 mb-3"><label class="form-label-custom">Branch</label>
              <select class="form-select form-control-custom" id="studentBranch" required>
                <option value="Computer Science">Computer Science</option>
                <option value="Information Technology">Information Technology</option>
                <option value="Electronics">Electronics</option>
                <option value="Mechanical">Mechanical</option>
              </select>
            </div>
            <!-- <div class="col-6 mb-3"><label class="form-label-custom">CGPA</label><input type="number" step="0.1" min="0" max="10" class="form-control form-control-custom" id="studentCgpa" required></div> -->
            <div class="col-6 mb-3"><label class="form-label-custom">CGPA</label><asp:TextBox runat="server" ID="studentCgpa" ClientIDMode="Static" TextMode="Number" step="0.1" min="0" max="10" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
        <!-- <button type="button" class="btn btn-primary-custom" onclick="Admin.saveStudent()">Save</button> -->
        <asp:Button runat="server" ID="saveStudentBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Admin.saveStudent(); return false;" Text="Save" />
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
      if (App.requireAuth('admin', 'login.aspx')) {
          Components.initLayout('admin', 'students.aspx', App.currentUser);
          Admin.renderStudentsTable();
          App.filterTable('statusFilter', 'studentsTableBody', 'status');
      }
  </script>
</asp:Content>