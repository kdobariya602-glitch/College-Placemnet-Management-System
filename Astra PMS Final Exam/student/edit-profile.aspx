<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="edit-profile.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.edit_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="profile.aspx">Profile</a></li><li class="breadcrumb-item active">Edit</li></ol></nav>
          <h4>Edit Profile</h4>
          <p>Update your personal and academic details.</p>
        </div>
        <div class="content-card" style="max-width:700px">
          <div class="card-body-custom">
            <form id="editProfileForm">
              <!-- <div class="mb-3"><label class="form-label-custom">Full Name</label><input type="text" class="form-control form-control-custom" id="editName" required></div> -->
              <div class="mb-3"><label class="form-label-custom">Full Name</label><asp:TextBox runat="server" ID="editName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
              <!-- <div class="mb-3"><label class="form-label-custom">Phone</label><input type="tel" class="form-control form-control-custom" id="editPhone" required></div> -->
              <div class="mb-3"><label class="form-label-custom">Phone</label><asp:TextBox runat="server" ID="editPhone" ClientIDMode="Static" TextMode="Phone" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
              <div class="row">
                <div class="col-md-6 mb-3"><label class="form-label-custom">Branch</label>
                  <!-- <select class="form-select form-control-custom" id="editBranch" required>
                    <option value="Computer Science">Computer Science</option>
                    <option value="Information Technology">Information Technology</option>
                    <option value="Electronics">Electronics</option>
                    <option value="Mechanical">Mechanical</option>
                  </select> -->
                  <asp:DropDownList runat="server" ID="editBranch" ClientIDMode="Static" CssClass="form-select form-control-custom" required="required">
                    <asp:ListItem Text="Computer Science" Value="Computer Science"></asp:ListItem>
                    <asp:ListItem Text="Information Technology" Value="Information Technology"></asp:ListItem>
                    <asp:ListItem Text="Electronics" Value="Electronics"></asp:ListItem>
                    <asp:ListItem Text="Mechanical" Value="Mechanical"></asp:ListItem>
                  </asp:DropDownList>
                </div>
                <!-- <div class="col-md-6 mb-3"><label class="form-label-custom">CGPA</label><input type="number" step="0.1" class="form-control form-control-custom" id="editCgpa" required></div> -->
                <div class="col-md-6 mb-3"><label class="form-label-custom">CGPA</label><asp:TextBox runat="server" ID="editCgpa" ClientIDMode="Static" TextMode="Number" step="0.1" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
              </div>
              <!-- <div class="mb-3"><label class="form-label-custom">Skills (comma separated)</label><input type="text" class="form-control form-control-custom" id="editSkills"></div> -->
              <div class="mb-3"><label class="form-label-custom">Skills (comma separated)</label><asp:TextBox runat="server" ID="editSkills" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom"></asp:TextBox></div>
              <div class="d-flex gap-2">
                <!-- <button type="button" class="btn btn-primary-custom" onclick="Student.saveProfile()">Save Changes</button> -->
                <asp:Button runat="server" ID="saveProfileBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Student.saveProfile(); return false;" Text="Save Changes" />
                <a href="profile.aspx" class="btn btn-outline-custom">Cancel</a>
              </div>
            </form>
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
      Components.initLayout('student', 'profile.aspx', App.currentUser);
      Student.loadEditProfile();
    }
  </script>
</asp:Content>

