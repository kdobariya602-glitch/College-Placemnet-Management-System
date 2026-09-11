<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="resume.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.resume" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Resume</h4><p>Manage the resume link and summary shared with recruiters.</p></div>
        <div class="row g-4">
          <div class="col-lg-7">
            <div class="content-card">
              <div class="card-header-custom"><h5>Resume Details</h5></div>
              <div class="card-body-custom">
                <form id="resumeForm">
                  <div class="mb-3">
                    <label class="form-label">Resume Link (Google Drive, LinkedIn, etc.)</label>
                    <!-- <input type="url" class="form-control" id="resumeLink" placeholder="https://..."> -->
<asp:TextBox runat="server" ID="resumeLink" ClientIDMode="Static" TextMode="Url" CssClass="form-control" placeholder="https://..."></asp:TextBox>
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Resume Summary</label>
                    <!-- <textarea class="form-control" id="resumeSummary" rows="6" placeholder="A short summary recruiters will see with your applications."></textarea> -->
<asp:TextBox runat="server" ID="resumeSummary" ClientIDMode="Static" TextMode="MultiLine" CssClass="form-control" placeholder="A short summary recruiters will see with your applications." Rows="6"></asp:TextBox>
                  </div>
                  <!-- <button type="button" class="btn btn-primary-custom" id="saveResumeBtn"><i class="bi bi-save me-1"></i>Save Resume</button> -->
<asp:Button runat="server" ID="saveResumeBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="return false;" Text="Save Resume" />
                </form>
              </div>
            </div>
          </div>
          <div class="col-lg-5">
            <div class="content-card">
              <div class="card-header-custom"><h5>Current Resume</h5></div>
              <div class="card-body-custom">
                <div id="resumeStatus" class="mb-3"></div>
                <div class="d-flex gap-2 flex-wrap">
                  <a id="resumeOpenLink" href="#" target="_blank" class="btn btn-outline-custom d-none"><i class="bi bi-box-arrow-up-right me-1"></i>Open Resume Link</a>
                  <button type="button" class="btn btn-outline-danger" id="removeResumeBtn" onclick="Student.removeResume()"><i class="bi bi-trash me-1"></i>Remove Resume</button>
                </div>
                <p class="small text-muted mt-3 mb-0">Last updated: <span id="resumeUpdatedAt">—</span></p>
              </div>
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
      Components.initLayout('student', 'resume.aspx', App.currentUser);
      Student.loadResume();
      document.getElementById('saveResumeBtn').addEventListener('click', () => Student.saveResume());
    }
  </script>
</asp:Content>
