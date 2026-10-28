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
          <!-- <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#studentModal" onclick="resetStudentForm()">
            <i class="bi bi-plus-lg me-1"></i>Add Student
          </button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#studentModal" OnClientClick="resetStudentForm(); return false;" Text="Add Student" />
        </div>

              <div class="content-card">
          <div class="card-body-custom p-0">
               <div class="table-responsive">            
              <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" HorizontalAlign="Center" Width="100%" GridLines="None" BorderWidth="0px" UseAccessibleHeader="True" HeaderStyle-CssClass="table-custom-head" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowCommand="GridView1_RowCommand">
    <Columns>
        <asp:TemplateField HeaderText="Full_Name">
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Full_Name") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Email">
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Phone">
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Branch">
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Branch") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Cgpa">
            <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Cgpa") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Graduation_Year">
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Graduation_Year") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Skills">
            <ItemTemplate>
                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Skills") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <button type="button" class="btn-icon me-1" title="Edit" onclick="editStudentRow('<%# Eval("Email") %>','<%# Eval("Full_Name") %>','<%# Eval("Phone") %>','<%# Eval("Branch") %>','<%# Eval("Cgpa") %>')"><i class="bi bi-pencil"></i></button>
                <asp:LinkButton runat="server" CssClass="btn-icon danger" CommandName="DeleteStudent" CommandArgument='<%# Eval("Email") %>' OnClientClick="return confirm('Delete this student?');" ToolTip="Delete"><i class="bi bi-trash"></i></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
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

  <div class="modal fade" id="studentModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title" id="studentModalTitle">Add Student</h5><!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" /></div>
      <div class="modal-body">
        <div id="studentForm">
          <asp:HiddenField runat="server" ID="studentId" ClientIDMode="Static" />
          <div class="mb-3"><label class="form-label-custom">Full Name</label><asp:TextBox runat="server" ID="studentName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Email</label><asp:TextBox runat="server" ID="studentEmail" ClientIDMode="Static" TextMode="Email" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Phone</label><asp:TextBox runat="server" ID="studentPhone" ClientIDMode="Static" TextMode="Phone" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          <div class="row">
            <div class="col-6 mb-3"><label class="form-label-custom">Branch</label>
              <asp:DropDownList runat="server" ID="studentBranch" ClientIDMode="Static" CssClass="form-select form-control-custom">
                <asp:ListItem Text="Computer Science" Value="Computer Science"></asp:ListItem>
                <asp:ListItem Text="Information Technology" Value="Information Technology"></asp:ListItem>
                <asp:ListItem Text="Electronics" Value="Electronics"></asp:ListItem>
                <asp:ListItem Text="Mechanical" Value="Mechanical"></asp:ListItem>
              </asp:DropDownList>
            </div>
            <div class="col-6 mb-3"><label class="form-label-custom">CGPA</label><asp:TextBox runat="server" ID="studentCgpa" ClientIDMode="Static" TextMode="Number" step="0.1" min="0" max="10" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <asp:Button runat="server" ID="saveStudentBtn" ClientIDMode="Static" CssClass="btn btn-primary-custom" OnClick="SaveStudentBtn_Click" Text="Save" />
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
      Components.initLayout('admin', 'students.aspx', App.currentUser);

      function resetStudentForm() {
        document.getElementById('studentModalTitle').textContent = 'Add Student';
        document.getElementById('studentId').value = '';
        document.getElementById('studentName').value = '';
        document.getElementById('studentEmail').value = '';
        document.getElementById('studentPhone').value = '';
        document.getElementById('studentBranch').value = 'Computer Science';
        document.getElementById('studentCgpa').value = '';
      }

      function editStudentRow(email, name, phone, branch, cgpa) {
        document.getElementById('studentModalTitle').textContent = 'Edit Student';
        document.getElementById('studentId').value = email;
        document.getElementById('studentName').value = name;
        document.getElementById('studentEmail').value = email;
        document.getElementById('studentPhone').value = phone;
        document.getElementById('studentBranch').value = branch;
        document.getElementById('studentCgpa').value = cgpa;
        new bootstrap.Modal(document.getElementById('studentModal')).show();
      }
  </script>
</asp:Content>