<%@ Page Title="Post New Job" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="post-job.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.post_job" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <!-- Breadcrumb & Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="jobs.aspx">Post Openings</a></li>
                        <li class="breadcrumb-item active">Post Job</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Publish Campus Job Opening</h3>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="post-job.aspx"><i class="bi bi-plus-circle me-1"></i> Post New Job</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="jobs.aspx"><i class="bi bi-briefcase me-1"></i> Job Openings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="internships.aspx"><i class="bi bi-mortarboard me-1"></i> Internship Postings</a>
            </li>
        </ul>

        
        <!-- Dual Mode: AI Smart Generator Card -->
        <div class="card border-0 shadow-sm mb-4" style="background: linear-gradient(135deg, #EFF6FF 0%, #F5F3FF 100%); border: 1.5px solid #C7D2FE !important;">
            <div class="card-body p-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-3">
                    <div class="d-flex align-items-center gap-2">
                        <div class="avatar-circle shadow-sm" style="width:40px; height:40px; border-radius:10px; background:linear-gradient(135deg,#1D4ED8,#7C3AED); color:#fff; display:flex; align-items:center; justify-content:center; font-size:1.2rem;">
                            <i class="bi bi-stars"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0 text-dark">✨ AI Job Specification Drafter (Gemini Powered)</h5>
                            <span class="text-muted small">Choose your mode: Auto-draft all requirements with AI, or type manually in the form below.</span>
                        </div>
                    </div>
                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3 py-2 fw-semibold">
                        <i class="bi bi-lightning-charge-fill text-warning me-1"></i> Dual Mode Active
                    </span>
                </div>

                <asp:Panel ID="pnlAiStatus" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show py-2 mb-3">
                    <asp:Literal ID="litAiStatus" runat="server"></asp:Literal>
                    <button type="button" class="btn-close py-2" data-bs-dismiss="alert"></button>
                </asp:Panel>

                <div class="row g-2 align-items-center">
                    <div class="col-md-7">
                        <asp:TextBox ID="txtAiRole" runat="server" CssClass="form-control form-control-lg bg-white" placeholder="Enter Job Role (e.g. Full Stack Developer, Data Analyst, Cloud DevOps, AI Engineer)..."></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlAiExp" runat="server" CssClass="form-select form-select-lg bg-white">
                            <asp:ListItem Text="Fresher / Entry Level (0-1 Yrs)" Value="Fresher"></asp:ListItem>
                            <asp:ListItem Text="Graduate Trainee / Intern" Value="Intern"></asp:ListItem>
                            <asp:ListItem Text="Associate (1-2 Yrs)" Value="Associate"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnAiDraft" runat="server" Text="✨ AI Auto-Draft" CssClass="btn btn-primary btn-lg w-100 fw-bold shadow-sm" OnClick="btnAiDraft_Click" />
                    </div>
                </div>

                <!-- 1-Click Role Presets -->
                <div class="d-flex flex-wrap align-items-center gap-2 mt-3 pt-2 border-top border-primary border-opacity-10">
                    <span class="text-muted small fw-semibold"><i class="bi bi-bookmark-star me-1"></i>Quick Presets:</span>
                    <button type="button" class="btn btn-sm btn-white border shadow-sm px-2 py-1 text-dark small" onclick="setAiRole('Associate Software Engineer (Full Stack)');">Software Engineer</button>
                    <button type="button" class="btn btn-sm btn-white border shadow-sm px-2 py-1 text-dark small" onclick="setAiRole('Data Analyst & BI Specialist');">Data Analyst</button>
                    <button type="button" class="btn btn-sm btn-white border shadow-sm px-2 py-1 text-dark small" onclick="setAiRole('Cloud & DevOps Associate');">Cloud & DevOps</button>
                    <button type="button" class="btn btn-sm btn-white border shadow-sm px-2 py-1 text-dark small" onclick="setAiRole('AI / Machine Learning Engineer');">AI / ML Engineer</button>
                    <button type="button" class="btn btn-sm btn-white border shadow-sm px-2 py-1 text-dark small" onclick="setAiRole('QA Automation & Test Engineer');">QA Automation</button>
                </div>
            </div>
        </div>

        <script>
            function setAiRole(role) {
                var el = document.getElementById('<%= txtAiRole.ClientID %>');
                if (el) {
                    el.value = role;
                    el.focus();
                }
            }
        </script>

        <!-- Form Card -->
        <div class="content-card border-0 shadow-sm">
            <div class="card-header-custom p-3 border-bottom bg-white d-flex align-items-center justify-content-between">
                <h5 class="mb-0 fw-bold"><i class="bi bi-briefcase-fill text-primary me-2"></i>Job Requirements & Eligibility Criteria</h5>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 small">Recruiter Announcement</span>
            </div>
            <div class="card-body-custom p-4">
                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label fw-semibold">Job Title / Designation *</label>
                        <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" placeholder="e.g. Associate Software Engineer / Data Analyst"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Employment Type</label>
                        <asp:DropDownList ID="ddlJobType" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Full-Time" Value="Full-Time"></asp:ListItem>
                            <asp:ListItem Text="Internship + PPO" Value="Internship + PPO"></asp:ListItem>
                            <asp:ListItem Text="Internship" Value="Internship"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Annual CTC / Package (LPA) *</label>
                        <asp:TextBox ID="txtPackage" runat="server" CssClass="form-control" placeholder="e.g. 10.50"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Total Vacancies *</label>
                        <asp:TextBox ID="txtOpenings" runat="server" CssClass="form-control" Text="15"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Work Location / Mode</label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="Bengaluru / Hyderabad / Remote"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Minimum CGPA</label>
                        <asp:TextBox ID="txtCGPA" runat="server" CssClass="form-control" Text="6.50"></asp:TextBox>
                        <asp:RangeValidator ID="rvCGPA" runat="server" ControlToValidate="txtCGPA" MinimumValue="0.0" MaximumValue="10.0" Type="Double" ErrorMessage="CGPA must be 0.0 - 10.0" ForeColor="Red" Display="Dynamic" CssClass="small"></asp:RangeValidator>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Max Backlogs Allowed</label>
                        <asp:TextBox ID="txtBacklogs" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Application Deadline *</label>
                        <asp:TextBox ID="txtDeadline" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold">Eligible Branches / Disciplines</label>
                        <asp:TextBox ID="txtEligibleBranches" runat="server" CssClass="form-control" Text="B.Tech (CSE, IT, ECE), MCA, M.Tech"></asp:TextBox>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold">Key Skills Required</label>
                        <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" placeholder="C#, ASP.NET, SQL, React, Cloud, Problem Solving"></asp:TextBox>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold">Detailed Job Description & Responsibilities</label>
                        <asp:TextBox ID="txtJobDesc" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Describe day-to-day responsibilities, training period details, and candidate requirements..."></asp:TextBox>
                    </div>
                </div>

                <div class="mt-4">
                    <asp:Button ID="btnPublishJob" runat="server" Text="Publish Campus Job Opening" CssClass="btn btn-primary fw-semibold px-4 py-2" OnClick="btnPublishJob_Click" />
                </div>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener('DOMContentLoaded', function() {
            var title = sessionStorage.getItem("astra_prefill_job_title");
            var skills = sessionStorage.getItem("astra_prefill_job_skills");
            var desc = sessionStorage.getItem("astra_prefill_job_desc");

            if (title || skills || desc) {
                var elTitle = document.getElementById('<%= txtJobTitle.ClientID %>');
                var elSkills = document.getElementById('<%= txtSkills.ClientID %>');
                var elDesc = document.getElementById('<%= txtJobDesc.ClientID %>');

                if (title && elTitle && !elTitle.value) elTitle.value = title;
                if (skills && elSkills && !elSkills.value) elSkills.value = skills;
                if (desc && elDesc && !elDesc.value) elDesc.value = desc;

                sessionStorage.removeItem("astra_prefill_job_title");
                sessionStorage.removeItem("astra_prefill_job_skills");
                sessionStorage.removeItem("astra_prefill_job_desc");

                var alertBox = document.createElement('div');
                alertBox.className = 'alert alert-success alert-dismissible fade show mb-3';
                alertBox.innerHTML = '<strong><i class="bi bi-stars me-2"></i>Job Form Auto-Populated!</strong> Parameters transferred successfully from AI Job Writer. Review and publish when ready.<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                var pageContent = document.querySelector('.page-content');
                if (pageContent) pageContent.insertBefore(alertBox, pageContent.children[1]);
            }
        });
    </script>
</asp:Content>
