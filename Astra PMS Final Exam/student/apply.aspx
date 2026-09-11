<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="apply.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.apply" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="jobs.aspx">Jobs</a></li><li class="breadcrumb-item active">Apply</li></ol></nav>
          <h4>Apply for Job</h4>
          <p>Review your details and submit your application.</p>
        </div>
        <div class="content-card" style="max-width:700px">
          <div class="card-body-custom">
            <div class="alert alert-info"><i class="bi bi-info-circle me-2"></i>Your profile information will be shared with the recruiter.</div>
            <form id="applyForm">
              <!-- <div class="mb-3"><label class="form-label-custom">Full Name</label><input type="text" class="form-control form-control-custom" id="applyName" readonly></div> -->
              <div class="mb-3"><label class="form-label-custom">Full Name</label><asp:TextBox runat="server" ID="applyName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" ReadOnly="true"></asp:TextBox></div>
              <!-- <div class="mb-3"><label class="form-label-custom">Email</label><input type="email" class="form-control form-control-custom" id="applyEmail" readonly></div> -->
              <div class="mb-3"><label class="form-label-custom">Email</label><asp:TextBox runat="server" ID="applyEmail" ClientIDMode="Static" TextMode="Email" CssClass="form-control form-control-custom" ReadOnly="true"></asp:TextBox></div>
              <div class="row">
                <!-- <div class="col-6 mb-3"><label class="form-label-custom">Branch</label><input type="text" class="form-control form-control-custom" id="applyBranch" readonly></div> -->
                <div class="col-6 mb-3"><label class="form-label-custom">Branch</label><asp:TextBox runat="server" ID="applyBranch" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" ReadOnly="true"></asp:TextBox></div>
                <!-- <div class="col-6 mb-3"><label class="form-label-custom">CGPA</label><input type="text" class="form-control form-control-custom" id="applyCgpa" readonly></div> -->
                <div class="col-6 mb-3"><label class="form-label-custom">CGPA</label><asp:TextBox runat="server" ID="applyCgpa" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" ReadOnly="true"></asp:TextBox></div>
              </div>
              <!-- <div class="mb-3"><label class="form-label-custom">Cover Letter (Optional)</label><textarea class="form-control form-control-custom" id="coverLetter" rows="4" placeholder="Why are you a good fit for this role?"></textarea></div> -->
              <div class="mb-3"><label class="form-label-custom">Cover Letter (Optional)</label><asp:TextBox runat="server" ID="coverLetter" ClientIDMode="Static" TextMode="MultiLine" Rows="4" CssClass="form-control form-control-custom" placeholder="Why are you a good fit for this role?"></asp:TextBox></div>
              <div class="form-check mb-4">
                <!-- <input class="form-check-input" type="checkbox" id="agreeTerms" required> -->
                <asp:CheckBox runat="server" ID="agreeTerms" ClientIDMode="Static" CssClass="form-check-input" required="required" />
                <label class="form-check-label small" for="agreeTerms">I confirm that all information provided is accurate.</label>
              </div>
              <div class="d-flex gap-2">
                <!-- <button type="button" class="btn btn-primary-custom" onclick="Student.submitApplication()">Submit Application</button> -->
                <asp:Button runat="server" ID="submitApplicationBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Student.submitApplication(); return false;" Text="Submit Application" />
                <a href="jobs.aspx" class="btn btn-outline-custom">Cancel</a>
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
      Components.initLayout('student', 'jobs.aspx', App.currentUser);
      const u = App.currentUser;
      document.getElementById('applyName').value = u.name;
      document.getElementById('applyEmail').value = u.email;
      document.getElementById('applyBranch').value = u.branch;
      document.getElementById('applyCgpa').value = u.cgpa;
    }
  </script>
</asp:Content>

