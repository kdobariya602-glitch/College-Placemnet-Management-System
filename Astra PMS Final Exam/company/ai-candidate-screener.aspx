<%@ Page Title="AI Candidate Screener" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="ai-candidate-screener.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.ai_candidate_screener" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .mic-listening {
            animation: pulse-red 1.2s infinite;
            background-color: #EF4444 !important;
            border-color: #EF4444 !important;
            color: #FFFFFF !important;
        }
        @keyframes pulse-red {
            0% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(239, 68, 68, 0); }
            100% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0); }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <div class="mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-1">
                    <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                    <li class="breadcrumb-item">Astra AI Hub</li>
                    <li class="breadcrumb-item active">AI Candidate Screener</li>
                </ol>
            </nav>
            <h3 class="fw-bold mb-0"><i class="bi bi-stars text-primary me-2"></i>AI Candidate Screener &amp; Direct Shortlisting</h3>
            <small class="text-muted">Screen applicant resumes against technical requirements, get AI recommendations, and shortlist or reject directly into the database.</small>
        </div>

        <div class="ai-tabs-scroller">
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link" href="ai-assistant.aspx"><i class="bi bi-robot"></i><span>AI Recruiter Copilot</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-job-writer.aspx"><i class="bi bi-pencil-square"></i><span>AI Job Description Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-interview-questions.aspx"><i class="bi bi-patch-question"></i><span>AI Technical Questions Generator</span></a></li>
            <li class="nav-item"><a class="nav-link active" href="ai-candidate-screener.aspx"><i class="bi bi-person-check"></i><span>AI Candidate Screener</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-campus-feedback.aspx"><i class="bi bi-chat-heart"></i><span>AI Campus Feedback Review</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-offer-drafter.aspx"><i class="bi bi-award"></i><span>AI Offer Letter Terms Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-scorecard-generator.aspx"><i class="bi bi-card-checklist"></i><span>AI Scorecard & Evaluation Remarks</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-internship-scope.aspx"><i class="bi bi-rocket-takeoff"></i><span>AI Internship Scope Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-talent-matching.aspx"><i class="bi bi-trophy"></i><span>AI Neural Candidate Matcher</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-outreach-invitation.aspx"><i class="bi bi-megaphone"></i><span>AI Campus Invitation Drafter</span></a></li>
        </ul>
    </div>

        <asp:Label ID="lblMsg" runat="server"></asp:Label>

        <div class="row g-4">
            <div class="col-lg-5">
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-white mb-3">
                    <h5 class="fw-bold mb-3 text-dark"><i class="bi bi-person-bounding-box text-primary me-2"></i>Select Applicant from Database</h5>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Applicant Pool</label>
                        <asp:DropDownList ID="ddlApplicants" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlApplicants_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="form-label small fw-semibold text-muted mb-0">Candidate Credentials & Target Role</label>
                            <button type="button" id="btnMic" class="btn btn-sm btn-outline-primary rounded-pill py-0 px-2" onclick="toggleVoice()" title="Speak parameters">
                                <i class="bi bi-mic-fill me-1"></i>Voice Input
                            </button>
                        </div>
                        <asp:TextBox ID="txtPromptInput" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" Text="Candidate: B.Tech CSE, 8.4 CGPA, React, Node.js, SQL | Role: Full Stack Developer" placeholder="Type your prompt/parameters here or click Voice Speak to dictate..."></asp:TextBox>
                        <div class="form-text small" id="voiceNotice">Speak or customize candidate details to fine-tune AI evaluation.</div>
                    </div>

                    <div class="d-grid gap-2">
                        <asp:Button ID="btnGenerate" runat="server" Text="Screen with Gemini AI" CssClass="btn btn-primary fw-bold py-2 shadow-sm rounded-pill" OnClick="btnGenerate_Click" />
                    </div>
                </div>

                <!-- Database Autonomous Action Card -->
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-light border">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-lightning-charge-fill text-warning me-2"></i>Autonomous Database Execution</h6>
                    <p class="small text-muted mb-3">Directly record screening decision in <code>Application_tbl</code>:</p>
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnShortlist" runat="server" Text="⭐ Shortlist Candidate in Database" CssClass="btn btn-success fw-bold py-2 shadow-sm rounded-pill" OnClick="btnShortlist_Click" />
                        <asp:Button ID="btnReject" runat="server" Text="❌ Mark as Not Progressed" CssClass="btn btn-outline-danger fw-bold py-2 rounded-pill" OnClick="btnReject_Click" />
                    </div>
                </div>
            </div>

            <div class="col-lg-7">
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-white">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-file-earmark-text text-primary me-2"></i>AI Screening Evaluation Output</h5>
                        <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill" onclick="copyResultText()"><i class="bi bi-clipboard me-1"></i>Copy Output</button>
                    </div>
                    <asp:TextBox ID="txtResult" runat="server" TextMode="MultiLine" Rows="16" CssClass="form-control font-monospace" ReadOnly="true" style="font-size:0.9rem; line-height:1.6; background-color:#F8FAFC;"></asp:TextBox>
                </div>
            </div>
        </div>
    
        <!-- Page Guide & Capabilities Box -->
        <div class="content-card p-3 p-md-4 mt-4 border shadow-sm rounded-4 bg-light">
            <div class="d-flex align-items-center gap-2 mb-2">
                <i class="bi bi-info-circle-fill text-primary fs-5"></i>
                <h6 class="fw-bold mb-0 text-dark">AI Candidate Screener - Guide &amp; Capabilities</h6>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 ms-auto small">Live Database Connected</span>
            </div>
            <div class="row g-3 small">
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-gear-wide-connected text-primary me-1"></i>What This Page Does:</div>
                        <div class="text-muted">Screens applicant profiles against job specifications, calculates qualification match percentages, and updates candidate shortlist statuses in Application_tbl.</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-play-circle-fill text-success me-1"></i>How to Use:</div>
                        <div class="text-muted">Enter screening parameters or select an active job posting, click "Generate Candidate Screening", and click "Shortlist Matched Candidates" to update the live database.</div>
                    </div>
                </div>
            </div>
        </div>

    </div></asp:Content>
