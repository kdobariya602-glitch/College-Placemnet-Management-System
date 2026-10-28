<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="post-job.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.post_job" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    
<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Post New Job</h4><p>Create a new job posting for campus recruitment.</p></div>
        <div class="content-card" style="max-width:800px">
          <div class="card-body-custom">
            <form id="postJobForm">
              <!-- <div class="mb-3"><label class="form-label-custom">Job Title</label><input type="text" class="form-control form-control-custom" id="jobTitle" required></div> -->
              <div class="mb-3"><label class="form-label-custom">Job Title</label><asp:TextBox runat="server" ID="jobTitle" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required" list="jobTitleList"></asp:TextBox><datalist id="jobTitleList"></datalist><small class="text-muted">Suggestions come from Admin &rsaquo; Job Roles.</small></div>
              <div class="row">
                <div class="col-md-6 mb-3"><label class="form-label-custom">Job Type</label>
                  <!-- <select class="form-select form-control-custom" id="jobType" required>
                    <option value="Full-time">Full-time</option>
                    <option value="Internship">Internship</option>
                    <option value="Contract">Contract</option>
                  </select> -->
<asp:DropDownList runat="server" ID="jobType" ClientIDMode="Static" CssClass="form-select form-control-custom">
                    <asp:ListItem Text="Full-time" Value="Full-time"></asp:ListItem>
                    <asp:ListItem Text="Internship" Value="Internship"></asp:ListItem>
                    <asp:ListItem Text="Contract" Value="Contract"></asp:ListItem>
                </asp:DropDownList>
                </div>
                <!-- <div class="col-md-6 mb-3"><label class="form-label-custom">Location</label><input type="text" class="form-control form-control-custom" id="jobLocation" required></div> -->
                <div class="col-md-6 mb-3"><label class="form-label-custom">Location</label><asp:TextBox runat="server" ID="jobLocation" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
              </div>
              <div class="row">
                <!-- <div class="col-md-4 mb-3"><label class="form-label-custom">Salary Package</label><input type="text" class="form-control form-control-custom" id="jobSalary" placeholder="₹6-8 LPA" required></div> -->
                <div class="col-md-4 mb-3"><label class="form-label-custom">Salary Package</label><asp:TextBox runat="server" ID="jobSalary" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" placeholder="₹6-8 LPA" required="required"></asp:TextBox></div>
                <!-- <div class="col-md-4 mb-3"><label class="form-label-custom">Min CGPA</label><input type="number" step="0.1" class="form-control form-control-custom" id="jobCgpa" required></div> -->
                <div class="col-md-4 mb-3"><label class="form-label-custom">Min CGPA</label><asp:TextBox runat="server" ID="jobCgpa" ClientIDMode="Static" TextMode="Number" step="0.1" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
                <!-- <div class="col-md-4 mb-3"><label class="form-label-custom">Openings</label><input type="number" class="form-control form-control-custom" id="jobOpenings" value="1" required></div> -->
                <div class="col-md-4 mb-3"><label class="form-label-custom">Openings</label><asp:TextBox runat="server" ID="jobOpenings" ClientIDMode="Static" TextMode="Number" CssClass="form-control form-control-custom" Text="1" required="required"></asp:TextBox></div>
              </div>
              <!-- <div class="mb-3"><label class="form-label-custom">Eligible Branches (comma separated)</label><input type="text" class="form-control form-control-custom" id="jobBranches" placeholder="Computer Science, Information Technology" required></div> -->
              <div class="mb-3"><label class="form-label-custom">Eligible Branches (comma separated)</label><asp:TextBox runat="server" ID="jobBranches" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" placeholder="Computer Science, Information Technology" required="required" list="jobBranchesList"></asp:TextBox><datalist id="jobBranchesList"></datalist><small class="text-muted">Suggestions come from Admin &rsaquo; Departments.</small></div>
              <!-- <div class="mb-3"><label class="form-label-custom">Required Skills (comma separated)</label><input type="text" class="form-control form-control-custom" id="jobSkills" placeholder="Java, Python, SQL" required></div> -->
              <div class="mb-3"><label class="form-label-custom">Required Skills (comma separated)</label><asp:TextBox runat="server" ID="jobSkills" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" placeholder="Java, Python, SQL" required="required" list="jobSkillsList"></asp:TextBox><datalist id="jobSkillsList"></datalist><small class="text-muted">Suggestions come from Admin &rsaquo; Skills master list.</small></div>
              <div class="row">
                <div class="col-md-6 mb-3"><label class="form-label-custom">Qualification</label><asp:TextBox runat="server" ID="jobQualification" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" placeholder="B.Tech / B.E. or equivalent"></asp:TextBox></div>
                <div class="col-md-6 mb-3"><label class="form-label-custom">Save As</label>
<asp:DropDownList runat="server" ID="jobStatus" ClientIDMode="Static" CssClass="form-select form-control-custom">
                    <asp:ListItem Text="Submit for TPO Approval" Value="pending"></asp:ListItem>
                    <asp:ListItem Text="Save as Draft" Value="draft"></asp:ListItem>
                </asp:DropDownList>
                <small class="text-muted">A job is only visible to students after the TPO approves it. Current status: <span id="jobCurrentStatus">—</span></small>
                </div>
              </div>
              <div class="mb-3"><label class="form-label-custom">Job Description</label><!-- <textarea class="form-control form-control-custom" id="jobDescription" rows="4" required></textarea> -->
<asp:TextBox runat="server" ID="jobDescription" ClientIDMode="Static" TextMode="MultiLine" CssClass="form-control form-control-custom" Rows="4"></asp:TextBox></div>
              <div class="mb-3"><label class="form-label-custom">Application Deadline</label><!-- <input type="date" class="form-control form-control-custom" id="jobDeadline" required> -->
<asp:TextBox runat="server" ID="jobDeadline" ClientIDMode="Static" TextMode="Date" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
              <!-- <button type="button" class="btn btn-primary-custom" onclick="Company.postJob()"><i class="bi bi-plus-lg me-1"></i>Post Job</button> -->
              <asp:Button runat="server" ID="postJobBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Company.postJob(); return false;" Text="Post Job" />
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
  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/company.js"></script>
  <script>
    if (App.requireAuth('company', 'login.aspx')) {
      Components.initLayout('company', 'post-job.aspx', App.currentUser);
      Company.initPostJobPage();
      // Populate suggestion lists from Admin-managed master data (Departments / Skills) - spec section 5.
      (function fillMasterDataLists() {
        const d = getData();
        const branchList = document.getElementById('jobBranchesList');
        if (branchList) branchList.innerHTML = (d.departments || []).map(x => `<option value="${x.name}">`).join('');
        const skillList = document.getElementById('jobSkillsList');
        if (skillList) skillList.innerHTML = (d.skillsMaster || []).map(x => `<option value="${x.name}">`).join('');
        const titleList = document.getElementById('jobTitleList');
        if (titleList) titleList.innerHTML = (d.jobRoles || []).map(x => `<option value="${x.title}">`).join('');
      })();
    }
  </script>
</asp:Content>


