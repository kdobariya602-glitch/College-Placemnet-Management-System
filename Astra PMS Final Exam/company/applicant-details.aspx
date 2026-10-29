<%@ Page Title="Candidate Review" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="applicant-details.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.applicant_details" %>

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
                        <li class="breadcrumb-item"><a href="applicants.aspx">Candidate Management</a></li>
                        <li class="breadcrumb-item active">Candidate Profile</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Candidate Review & Resume Inspection</h3>
            </div>
            <div>
                <a href="applicants.aspx" class="btn btn-outline-secondary"><i class="bi bi-arrow-left me-1"></i> Back to Applicants</a>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="applicants.aspx"><i class="bi bi-people me-1"></i> Applicants</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="shortlisted.aspx"><i class="bi bi-person-check me-1"></i> Shortlisted Students</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="interviews.aspx"><i class="bi bi-calendar-event me-1"></i> Interview Schedules</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="interview-results.aspx"><i class="bi bi-clipboard-check me-1"></i> Assessment Results</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="selections.aspx"><i class="bi bi-award me-1"></i> Selections & Offers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="placement-history.aspx"><i class="bi bi-clock-history me-1"></i> Hiring History</a>
            </li>
        </ul>

        <div class="row g-4">
            <!-- Left Info Card -->
            <div class="col-lg-4">
                <div class="content-card p-4 text-center mb-4">
                    <div class="avatar-circle mx-auto mb-3 overflow-hidden border shadow-sm d-flex align-items-center justify-content-center bg-primary text-white" style="width:90px; height:90px; border-radius:50%; min-width:90px;">
                        <asp:Literal ID="litApplicantAvatar" runat="server"></asp:Literal>
                    </div>
                    <h4 class="fw-bold text-dark mb-1"><asp:Label ID="lblName" runat="server"></asp:Label></h4>
                    <p class="text-muted small mb-2"><asp:Label ID="lblEnrollment" runat="server"></asp:Label></p>
                    <div class="mb-3">
                        <asp:Label ID="lblAppStatusBadge" runat="server" CssClass="badge bg-primary px-3 py-2 fs-6"></asp:Label>
                    </div>

                    <hr class="my-3 text-muted" />

                    <div class="text-start small">
                        <div class="mb-2 d-flex justify-content-between">
                            <span class="text-muted"><i class="bi bi-envelope me-2"></i>Email:</span>
                            <span class="fw-semibold text-dark"><asp:Label ID="lblEmail" runat="server"></asp:Label></span>
                        </div>
                        <div class="mb-2 d-flex justify-content-between">
                            <span class="text-muted"><i class="bi bi-telephone me-2"></i>Phone:</span>
                            <span class="fw-semibold text-dark"><asp:Label ID="lblPhone" runat="server"></asp:Label></span>
                        </div>
                    </div>
                </div>

                <!-- Recruiter Actions -->
                <div class="content-card p-4">
                    <h6 class="fw-bold mb-3"><i class="bi bi-sliders text-primary me-2"></i>Recruiter Decision</h6>
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnShortlist" runat="server" Text="Shortlist Candidate" CssClass="btn btn-outline-primary fw-semibold" OnClick="btnShortlist_Click" />
                        <asp:Button ID="btnSelect" runat="server" Text="Mark as Selected / Hired" CssClass="btn btn-outline-success fw-semibold" OnClick="btnSelect_Click" />
                        <asp:Button ID="btnReject" runat="server" Text="Reject Application" CssClass="btn btn-outline-danger fw-semibold" OnClick="btnReject_Click" />
                    </div>
                </div>
            </div>

            <!-- Right Details -->
            <div class="col-lg-8">
                <!-- Academic Performance -->
                <div class="content-card mb-4">
                    <div class="card-header-custom p-3 border-bottom">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-mortarboard text-primary me-2"></i>Academic Scores & Background</h5>
                    </div>
                    <div class="card-body-custom p-4">
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <span class="text-muted small d-block">Department / Course</span>
                                <div class="fw-bold text-dark fs-6"><asp:Label ID="lblDeptCourse" runat="server"></asp:Label></div>
                            </div>
                            <div class="col-md-6">
                                <span class="text-muted small d-block">Batch & Semester</span>
                                <div class="fw-bold text-dark fs-6"><asp:Label ID="lblBatchSem" runat="server"></asp:Label></div>
                            </div>
                        </div>

                        <div class="row g-3 text-center">
                            <div class="col-md-3">
                                <div class="p-2 border rounded bg-light">
                                    <div class="text-muted small">10th Class</div>
                                    <div class="fw-bold fs-5 text-dark"><asp:Label ID="lbl10th" runat="server"></asp:Label>%</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="p-2 border rounded bg-light">
                                    <div class="text-muted small">12th Class</div>
                                    <div class="fw-bold fs-5 text-dark"><asp:Label ID="lbl12th" runat="server"></asp:Label>%</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="p-2 border rounded bg-primary text-white">
                                    <div class="small opacity-75">Graduation CGPA</div>
                                    <div class="fw-bold fs-5"><asp:Label ID="lblCGPA" runat="server"></asp:Label></div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="p-2 border rounded bg-light">
                                    <div class="text-muted small">Backlogs</div>
                                    <div class="fw-bold fs-5 text-dark"><asp:Label ID="lblBacklogs" runat="server"></asp:Label></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                
                <!-- Dual Mode: AI Candidate Evaluation & Fit Screening -->
                <div class="content-card mb-4" style="background: linear-gradient(135deg, #F0FDF4 0%, #EFF6FF 100%); border: 1.5px solid #BFDBFE !important;">
                    <div class="card-header-custom p-3 border-bottom d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center gap-2">
                            <span class="badge bg-primary px-2 py-1"><i class="bi bi-stars"></i> Gemini AI</span>
                            <h5 class="mb-0 fw-bold text-dark">AI Candidate Fit & Interview Screener</h5>
                        </div>
                        <asp:Button ID="btnRunAiScreening" runat="server" Text="✨ Run AI Screening" CssClass="btn btn-sm btn-primary fw-semibold px-3" OnClick="btnRunAiScreening_Click" />
                    </div>
                    <div class="card-body-custom p-4">
                        <asp:Panel ID="pnlAiScreening" runat="server">
                            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-3 p-3 bg-white rounded border">
                                <div>
                                    <span class="text-muted small d-block">Overall Placement Match Index</span>
                                    <h4 class="fw-bold mb-0 text-primary"><asp:Label ID="lblAiScore" runat="server" Text="88% Match"></asp:Label></h4>
                                </div>
                                <div>
                                    <asp:Label ID="lblAiVerdict" runat="server" CssClass="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3 py-2 fs-6" Text="Recommended for Technical Round"></asp:Label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <span class="fw-semibold text-dark small d-block mb-1"><i class="bi bi-card-checklist text-primary me-1"></i>AI Fit Summary & Assessment:</span>
                                <p class="text-muted small mb-0"><asp:Label ID="lblAiSummary" runat="server"></asp:Label></p>
                            </div>
                            <div>
                                <span class="fw-semibold text-dark small d-block mb-1"><i class="bi bi-patch-question text-primary me-1"></i>Tailored Interview Questions for this Candidate:</span>
                                <div class="p-3 bg-white rounded border small"><asp:Literal ID="litAiQuestions" runat="server"></asp:Literal></div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>

                <!-- Skills & ATS Resume Download -->
                <div class="content-card">
                    <div class="card-header-custom p-3 border-bottom">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-file-earmark-person text-primary me-2"></i>Technical Skills & Resume</h5>
                    </div>
                    <div class="card-body-custom p-4">
                        <div class="mb-4">
                            <label class="text-muted small d-block mb-2">Technical Skills & Competencies</label>
                            <asp:Label ID="lblSkills" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                        </div>

                        <div class="p-3 bg-light rounded border d-flex justify-content-between align-items-center">
                            <div>
                                <i class="bi bi-file-earmark-pdf fs-3 text-danger me-2 align-middle"></i>
                                <span class="fw-bold text-dark">Candidate ATS Resume: </span>
                                <asp:Label ID="lblResumeFileName" runat="server" Text="Resume Available"></asp:Label>
                            </div>
                            <asp:HyperLink ID="lnkResumeDownload" runat="server" CssClass="btn btn-primary" Target="_blank">
                                <i class="bi bi-download me-1"></i> Download ATS PDF
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
