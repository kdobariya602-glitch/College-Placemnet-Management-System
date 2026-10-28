<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="academic-details.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.academic_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start mb-4">
          <div class="page-breadcrumb mb-0"><h4>Academic Details</h4><p>Your branch, CGPA, and academic record on file.</p></div>
          <a href="edit-profile.aspx" class="btn btn-primary-custom"><i class="bi bi-pencil me-1"></i>Update Details</a>
        </div>
        <div class="row g-4">
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Academic Record</h5></div>
              <div class="card-body-custom">
                <div class="profile-info-item"><i class="bi bi-mortarboard"></i><div><small class="text-muted">Branch</small><div id="acBranch">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-journal-bookmark"></i><div><small class="text-muted">Course</small><div id="acCourse">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-graph-up"></i><div><small class="text-muted">CGPA</small><div id="acCgpa">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-calendar"></i><div><small class="text-muted">Batch / Graduation Year</small><div id="acYear">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-person-badge"></i><div><small class="text-muted">Student ID</small><div id="acId">—</div></div></div>
                <div class="profile-info-item"><i class="bi bi-collection"></i>
                  <div class="flex-grow-1">
                    <small class="text-muted">Current Semester</small>
                    <div class="d-flex gap-2 align-items-center mt-1">
                      <select class="form-select form-control-custom form-select-sm" id="acSemester" style="max-width:140px">
                        <option value="1st">1st</option><option value="2nd">2nd</option><option value="3rd">3rd</option><option value="4th">4th</option>
                        <option value="5th">5th</option><option value="6th">6th</option><option value="7th">7th</option><option value="8th">8th</option>
                      </select>
                      <button type="button" class="btn btn-sm btn-primary-custom" onclick="Student.saveSemester()">Save</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="content-card">
              <div class="card-header-custom"><h5>Skills</h5></div>
              <div class="card-body-custom" id="acSkillsList"></div>
            </div>
          </div>
          <div class="col-12">
            <div class="content-card">
              <div class="card-header-custom"><h5>Eligibility Overview</h5></div>
              <div class="card-body-custom">
                <p class="text-muted small mb-3">Based on your CGPA, here is how you stack up against active openings.</p>
                <div id="acEligibilitySummary"></div>
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
      Components.initLayout('student', 'academic-details.aspx', App.currentUser);
      const fresh = getData().students.find(s => s.id === App.currentUser.id);
      if (fresh) App.setSession({ ...fresh, role: 'student' });
      Student.renderAcademicDetails();
    }
  </script>
</asp:Content>
