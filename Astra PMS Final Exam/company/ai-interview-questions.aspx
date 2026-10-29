<%@ Page Title="AI Interview Questions" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="ai-interview-questions.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.ai_interview_questions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @media print {
            .sidebar, .top-navbar, .page-header, .no-print, nav[aria-label="breadcrumb"], .col-lg-4 {
                display: none !important;
            }
            .col-lg-8 {
                width: 100% !important;
            }
            .content-card {
                border: none !important;
                box-shadow: none !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <div class="ai-tabs-scroller">
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link" href="ai-assistant.aspx"><i class="bi bi-robot"></i><span>AI Recruiter Copilot</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-job-writer.aspx"><i class="bi bi-pencil-square"></i><span>AI Job Description Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link active" href="ai-interview-questions.aspx"><i class="bi bi-patch-question"></i><span>AI Technical Questions Generator</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-candidate-screener.aspx"><i class="bi bi-person-check"></i><span>AI Candidate Screener</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-campus-feedback.aspx"><i class="bi bi-chat-heart"></i><span>AI Campus Feedback Review</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-offer-drafter.aspx"><i class="bi bi-award"></i><span>AI Offer Letter Terms Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-scorecard-generator.aspx"><i class="bi bi-card-checklist"></i><span>AI Scorecard & Evaluation Remarks</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-internship-scope.aspx"><i class="bi bi-rocket-takeoff"></i><span>AI Internship Scope Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-talent-matching.aspx"><i class="bi bi-trophy"></i><span>AI Neural Candidate Matcher</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-outreach-invitation.aspx"><i class="bi bi-megaphone"></i><span>AI Campus Invitation Drafter</span></a></li>
        </ul>
    </div>
        <div class="mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-1">
                    <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                    <li class="breadcrumb-item active">AI Interview Questions</li>
                </ol>
            </nav>
            <div class="d-flex align-items-center gap-2">
                <h3 class="fw-bold mb-0 text-gradient"><i class="bi bi-question-circle text-primary me-2"></i>AI Interview Kit &amp; Question Studio</h3>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1"><i class="bi bi-cpu me-1"></i>Astra Neural v3.0</span>
            </div>
            <small class="text-muted">Generate job-aligned technical, HR, and behavioral interview questions mapped directly to your vacancy requirements.</small>
        </div>

        

        <asp:Label ID="lblMsg" runat="server"></asp:Label>

        <div class="row g-4">
            <div class="col-lg-4 no-print">
                <div class="content-card p-3 shadow-sm border mb-4">
                    <h6 class="fw-bold mb-3 pb-2 border-bottom"><i class="bi bi-sliders text-primary me-2"></i>Assessment Parameters</h6>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Select Target Job Vacancy</label>
                        <asp:DropDownList ID="ddlJob" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Interview Round</label>
                        <asp:DropDownList ID="ddlRound" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Technical Assessment" Value="Technical"></asp:ListItem>
                            <asp:ListItem Text="HR & Culture Fit" Value="HR"></asp:ListItem>
                            <asp:ListItem Text="Aptitude & Problem Solving" Value="Aptitude"></asp:ListItem>
                            <asp:ListItem Text="Comprehensive Mixed (Tech + HR)" Value="Mixed"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Candidate Experience Level</label>
                        <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Fresher / Entry-Level (Campus)" Value="Fresher"></asp:ListItem>
                            <asp:ListItem Text="Experienced / Specialized" Value="Experienced"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <asp:Button ID="btnGen" runat="server" Text="Generate Interview Kit" CssClass="btn btn-primary w-100 fw-semibold shadow-sm py-2" OnClick="btnGen_Click" />
                </div>

                <!-- Recruiter Quick Tips Card -->
                <div class="content-card p-3 shadow-sm border">
                    <h6 class="fw-bold mb-2"><i class="bi bi-lightbulb text-warning me-2"></i>Interview Best Practices</h6>
                    <ul class="list-unstyled small text-muted mb-0 d-flex flex-column gap-2">
                        <li><i class="bi bi-check2-circle text-success me-1"></i>Use the <b>STAR Method</b> (Situation, Task, Action, Result) for behavioral questions.</li>
                        <li><i class="bi bi-check2-circle text-success me-1"></i>Score each question live using the candidate score box (0-10) for automated tallying.</li>
                        <li><i class="bi bi-check2-circle text-success me-1"></i>Print or export the sheet directly to carry into your physical or virtual interview room.</li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="content-card p-3 p-md-4 shadow-sm border" id="printableKit">
                    <% if (qHtml != "") { %>
                    <div class="d-flex flex-wrap gap-2 mb-3 no-print">
                        <button type="button" class="btn btn-sm btn-outline-secondary active filter-btn" onclick="filterQuestions('all', this)">All Questions</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary filter-btn" onclick="filterQuestions('Technical', this)">Technical Only</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary filter-btn" onclick="filterQuestions('HR', this)">HR &amp; Behavioral</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary filter-btn" onclick="filterQuestions('Aptitude', this)">Aptitude</button>
                    </div>
                    <% } %>

                    <%= qHtml %>

                    <% if (qHtml == "") { %>
                    <div class="text-center py-5">
                        <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-inline-flex align-items-center justify-content-center p-4 mb-3" style="width: 72px; height: 72px;">
                            <i class="bi bi-cpu fs-1"></i>
                        </div>
                        <h5 class="fw-bold">No Interview Questions Generated Yet</h5>
                        <p class="text-muted small mb-0" style="max-width: 420px; margin: 0 auto;">Select one of your posted vacancies and round type from the left panel, then click <b>Generate Interview Kit</b> to synthesize questions and scoring benchmarks.</p>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    
        <!-- Page Guide & Capabilities Box -->
        <div class="content-card p-3 p-md-4 mt-4 border shadow-sm rounded-4 bg-light">
            <div class="d-flex align-items-center gap-2 mb-2">
                <i class="bi bi-info-circle-fill text-primary fs-5"></i>
                <h6 class="fw-bold mb-0 text-dark">AI Technical Questions Generator - Guide &amp; Capabilities</h6>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 ms-auto small">Live Database Connected</span>
            </div>
            <div class="row g-3 small">
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-gear-wide-connected text-primary me-1"></i>What This Page Does:</div>
                        <div class="text-muted">Generates role-tailored technical, coding, and situational interview questions with model answers and evaluation rubrics for campus recruitment.</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-play-circle-fill text-success me-1"></i>How to Use:</div>
                        <div class="text-muted">Select the target role, round, and difficulty level, click "Generate Questions with AI", and click "Save to Company Interview Bank" to access them during interviews.</div>
                    </div>
                </div>
            </div>
        </div>

    </div><script>
        function calculateTotalScore() {
            var inputs = document.querySelectorAll('.q-score-input');
            if (inputs.length === 0) return;
            var sum = 0;
            inputs.forEach(function(inp) {
                var val = parseFloat(inp.value) || 0;
                sum += Math.max(0, Math.min(10, val));
            });
            var avgPct = Math.round((sum / (inputs.length * 10)) * 100);
            var scoreEl = document.getElementById('candidateTotalScore');
            var verdictEl = document.getElementById('candidateVerdict');
            if (scoreEl) scoreEl.innerText = avgPct;
            if (verdictEl) {
                if (avgPct >= 75) {
                    verdictEl.className = "badge bg-success ms-2";
                    verdictEl.innerText = "Highly Recommended";
                } else if (avgPct >= 50) {
                    verdictEl.className = "badge bg-warning text-dark ms-2";
                    verdictEl.innerText = "Borderline / Second Review";
                } else {
                    verdictEl.className = "badge bg-danger ms-2";
                    verdictEl.innerText = "Not Recommended";
                }
            }
        }

        function filterQuestions(category, btn) {
            document.querySelectorAll('.filter-btn').forEach(function(b) { b.classList.remove('active'); });
            btn.classList.add('active');
            var items = document.querySelectorAll('.question-item');
            items.forEach(function(item) {
                if (category === 'all') {
                    item.style.display = 'block';
                } else {
                    var cat = item.getAttribute('data-cat') || '';
                    if (cat.indexOf(category) !== -1) {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                }
            });
        }

        function copyInterviewQuestions() {
            var kit = document.getElementById('printableKit');
            if (!kit) return;
            var text = "=== ASTRA PMS - CANDIDATE INTERVIEW QUESTION SET ===\n\n";
            var questions = kit.querySelectorAll('.question-item');
            questions.forEach(function(q, idx) {
                var title = q.querySelector('h6') ? q.querySelector('h6').innerText : '';
                var key = q.querySelector('.text-muted') ? q.querySelector('.text-muted').innerText : '';
                text += (idx + 1) + ". " + title + "\n   " + key + "\n\n";
            });
            navigator.clipboard.writeText(text).then(function() {
                alert("Interview questions copied to clipboard successfully!");
            });
        }
    </script>
</asp:Content>
