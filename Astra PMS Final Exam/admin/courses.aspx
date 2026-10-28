<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="courses.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.courses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Courses</li></ol></nav>
            <h4>Course Management</h4>
            <p>Manage courses offered under each department.</p>
          </div>
          <!-- <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#coursesModal" onclick="document.getElementById('coursesForm').reset();document.getElementById('coursesId').value='';document.getElementById('coursesModalTitle').textContent='Add Course'">
            <i class="bi bi-plus-lg me-1"></i>Add Course
          </button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#coursesModal" OnClientClick="document.getElementById(&#x27;coursesForm&#x27;).reset();document.getElementById(&#x27;coursesId&#x27;).value=&#x27;&#x27;;document.getElementById(&#x27;coursesModalTitle&#x27;).textContent=&#x27;Add Course&#x27;; return false;" Text="Add Course" />
        </div>
        <div class="filter-bar d-flex flex-wrap gap-3 align-items-center mb-3">
          <asp:DropDownList runat="server" ID="courseStatusFilter" ClientIDMode="Static" CssClass="form-select form-select-sm" style="width:auto">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Active" Value="active"></asp:ListItem>
                    <asp:ListItem Text="Inactive" Value="inactive"></asp:ListItem>
                </asp:DropDownList>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th></th><th>Course</th><th>Code</th><th>Department</th><th>Duration</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody id="coursesTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="coursesPagination"></div></div>
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

  <div class="modal fade" id="coursesModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title" id="coursesModalTitle">Add Course</h5><!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" /></div>
      <div class="modal-body">
        <form id="coursesForm">
          <input type="hidden" id="coursesId">
          <div class="mb-3"><label class="form-label-custom">Course Name</label><asp:TextBox runat="server" ID="courseName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Course Code</label><asp:TextBox runat="server" ID="courseCode" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Department</label><asp:TextBox runat="server" ID="courseDept" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Duration (Years)</label><asp:TextBox runat="server" ID="courseDuration" ClientIDMode="Static" TextMode="Number" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
        </form>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <asp:Button runat="server" ID="saveCoursesBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Admin.saveCourse(); return false;" Text="Save" />
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
    //  Components.initLayout('admin', 'courses.aspx', App.currentUser);
    //  Admin.renderCoursesTable();
      //}

      Components.initLayout('admin', 'courses.aspx', App.currentUser);
      Admin.renderCoursesTable();
      App.filterTable('courseStatusFilter', 'coursesTableBody', 'status');
  </script>
</asp:Content>
