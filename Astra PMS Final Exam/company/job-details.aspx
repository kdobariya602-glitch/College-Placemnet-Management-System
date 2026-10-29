<%@ Page Title="Job Opening In-Depth Details" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="job-details.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.job_details" %>

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
                        <li class="breadcrumb-item"><a href="jobs.aspx">Job Openings</a></li>
                        <li class="breadcrumb-item active">Job Details</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0"><i class="bi bi-briefcase text-primary me-2"></i>Job Opening In-Depth Specification</h3>
            </div>
            <div>
                <a href="jobs.aspx" class="btn btn-outline-secondary fw-semibold"><i class="bi bi-arrow-left me-1"></i> Back to Jobs List</a>
            </div>
        </div>

        <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="post-job.aspx"><i class="bi bi-plus-circle me-1"></i> Post New Job</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="jobs.aspx"><i class="bi bi-briefcase me-1"></i> Job Openings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="internships.aspx"><i class="bi bi-mortarboard me-1"></i> Internship Postings</a>
            </li>
        </ul>

        <div class="row g-4">
            <!-- Left Summary Card -->
            <div class="col-lg-4">
                <div class="content-card p-4 text-center mb-4 border-0 shadow-sm">
                    <div class="mx-auto mb-3 d-flex align-items-center justify-content-center bg-primary bg-opacity-10 text-primary rounded-circle" style="width:72px; height:72px;">
                        <i class="bi bi-briefcase-fill fs-2"></i>
                    </div>
                    <h4 class="fw-bold mb-1 text-dark"><asp:Literal ID="litJobTitle" runat="server"></asp:Literal></h4>
                    <p class="text-muted mb-2"><asp:Literal ID="litCompanyName" runat="server"></asp:Literal></p>
                    <div class="d-flex justify-content-center gap-2 mb-3">
                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3 py-1"><asp:Literal ID="litJobType" runat="server"></asp:Literal></span>
                        <asp:Label ID="lblStatusBadge" runat="server" CssClass="badge bg-success px-3 py-1"></asp:Label>
                    </div>

                    <div class="p-3 bg-light rounded-3 mb-3 border">
                        <div class="text-muted small text-uppercase fw-semibold mb-1">Annual CTC Package</div>
                        <div class="fs-4 fw-bold text-success"><asp:Literal ID="litPackage" runat="server"></asp:Literal></div>
                    </div>

                    <div class="d-grid gap-2">
                        <asp:HyperLink ID="lnkViewApplicants" runat="server" CssClass="btn btn-primary fw-semibold"><i class="bi bi-people me-1"></i> View Applied Candidates</asp:HyperLink>
                        <a href="post-job.aspx" class="btn btn-outline-secondary fw-semibold"><i class="bi bi-plus-circle me-1"></i> Create Another Opening</a>
                    </div>
                </div>

                <!-- Timeline / Key Dates Card -->
                <div class="content-card p-4 border-0 shadow-sm">
                    <h6 class="fw-bold mb-3 text-dark"><i class="bi bi-clock-history text-primary me-2"></i>Key Posting Timelines</h6>
                    <ul class="list-group list-group-flush small">
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span class="text-muted">Date & Time Published</span>
                            <span class="fw-bold text-dark"><asp:Literal ID="litDatePosted" runat="server"></asp:Literal></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span class="text-muted">Application Deadline</span>
                            <span class="fw-bold text-danger"><asp:Literal ID="litDeadline" runat="server"></asp:Literal></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span class="text-muted">Total Vacancies</span>
                            <span class="fw-bold text-dark"><asp:Literal ID="litVacancies" runat="server"></asp:Literal></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span class="text-muted">Work Location</span>
                            <span class="fw-bold text-dark"><asp:Literal ID="litLocation" runat="server"></asp:Literal></span>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Right In-Depth Details Cards -->
            <div class="col-lg-8">
                <!-- Academic Criteria Card -->
                <div class="content-card mb-4 border-0 shadow-sm">
                    <div class="card-header-custom p-3 border-bottom d-flex align-items-center justify-content-between bg-white">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-mortarboard-fill text-primary me-2"></i>Academic Eligibility & Criteria</h5>
                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1">Campus Rules</span>
                    </div>
                    <div class="card-body-custom p-4">
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <div class="p-3 bg-light rounded-3 border">
                                    <div class="text-muted small">Minimum CGPA Cutoff</div>
                                    <div class="fs-5 fw-bold text-dark mt-1"><asp:Literal ID="litCgpa" runat="server"></asp:Literal></div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="p-3 bg-light rounded-3 border">
                                    <div class="text-muted small">Max Active Backlogs Allowed</div>
                                    <div class="fs-5 fw-bold text-dark mt-1"><asp:Literal ID="litBacklogs" runat="server"></asp:Literal></div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="p-3 bg-light rounded-3 border">
                                    <div class="text-muted small">Eligible Academic Departments</div>
                                    <div class="fw-bold text-dark mt-1"><asp:Literal ID="litBranches" runat="server"></asp:Literal></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Technical Skills Required -->
                <div class="content-card mb-4 border-0 shadow-sm">
                    <div class="card-header-custom p-3 border-bottom d-flex align-items-center justify-content-between bg-white">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-tools text-primary me-2"></i>Required Technical Skills & Competencies</h5>
                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">ATS Matching</span>
                    </div>
                    <div class="card-body-custom p-4">
                        <div class="d-flex flex-wrap gap-2">
                            <asp:Literal ID="litSkillChips" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>

                <!-- Comprehensive Job Description -->
                <div class="content-card border-0 shadow-sm">
                    <div class="card-header-custom p-3 border-bottom d-flex align-items-center justify-content-between bg-white">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-file-earmark-text-fill text-primary me-2"></i>Comprehensive Job Description & Scope</h5>
                        <span class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25 px-2 py-1">JD Document</span>
                    </div>
                    <div class="card-body-custom p-4">
                        <div class="p-3 bg-light rounded-3 border" style="white-space: pre-wrap; font-size: 0.95rem; line-height: 1.8; color: #1E293B;">
                            <asp:Literal ID="litJobDesc" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
