<%@ Page Title="AI Neural Candidate Matcher" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="ai-talent-matching.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.ai_talent_matching" %>

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
                    <li class="breadcrumb-item active">AI Neural Candidate Matcher</li>
                </ol>
            </nav>
            <h3 class="fw-bold mb-0"><i class="bi bi-stars text-primary me-2"></i>AI Neural Candidate Matcher</h3>
            <small class="text-muted">Match job requirements with student profiles and generate ranked candidate recommendations.</small>
        </div>

        <div class="ai-tabs-scroller">
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link" href="ai-assistant.aspx"><i class="bi bi-robot"></i><span>AI Recruiter Copilot</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-job-writer.aspx"><i class="bi bi-pencil-square"></i><span>AI Job Description Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-interview-questions.aspx"><i class="bi bi-patch-question"></i><span>AI Technical Questions Generator</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-candidate-screener.aspx"><i class="bi bi-person-check"></i><span>AI Candidate Screener</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-campus-feedback.aspx"><i class="bi bi-chat-heart"></i><span>AI Campus Feedback Review</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-offer-drafter.aspx"><i class="bi bi-award"></i><span>AI Offer Letter Terms Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-scorecard-generator.aspx"><i class="bi bi-card-checklist"></i><span>AI Scorecard & Evaluation Remarks</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-internship-scope.aspx"><i class="bi bi-rocket-takeoff"></i><span>AI Internship Scope Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link active" href="ai-talent-matching.aspx"><i class="bi bi-trophy"></i><span>AI Neural Candidate Matcher</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-outreach-invitation.aspx"><i class="bi bi-megaphone"></i><span>AI Campus Invitation Drafter</span></a></li>
        </ul>
    </div>

        

        <asp:Label ID="lblMsg" runat="server"></asp:Label>

        <div class="row g-4">
            <div class="col-lg-5">
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-white">
                    <h5 class="fw-bold mb-3 text-dark"><i class="bi bi-sliders text-primary me-2"></i>AI Prompt Parameters (Type or Speak)</h5>
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="form-label small fw-semibold text-muted mb-0">Target Skill Matrix & Minimum CGPA</label>
                            <button type="button" id="btnMic" class="btn btn-sm btn-outline-primary rounded-pill py-0 px-2" onclick="toggleVoice()" title="Voice input">
                                <i class="bi bi-mic-fill me-1"></i>Voice Input
                            </button>
                        </div>
                        <asp:TextBox ID="txtPromptInput" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" Text="ASP.NET Core, C#, Web API, Entity Framework, Minimum 7.5 CGPA, Zero Active Backlogs" placeholder="Type your prompt/parameters here or click Voice Speak to dictate..."></asp:TextBox>
                        <div class="form-text small">Customize or augment these parameters to fine-tune AI synthesis.</div>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnGenerate" runat="server" Text="Generate with Gemini AI" CssClass="btn btn-primary fw-bold py-2 shadow-sm rounded-pill" OnClick="btnGenerate_Click" />
                    </div>
                </div>

                <!-- Database Autonomous Action Card -->
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-light border mt-3">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-lightning-charge-fill text-warning me-2"></i>Autonomous Database Execution</h6>
                    <p class="small text-muted mb-3">Directly shortlist high-match applicants in the recruitment pipeline:</p>
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnAutoShortlist" runat="server" Text="🎯 Auto-Shortlist Matched Candidates in Database" CssClass="btn btn-success fw-bold py-2 shadow-sm rounded-pill" OnClick="btnAutoShortlist_Click" />
                    </div>
                </div>
            </div>

            <div class="col-lg-7">
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-white">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-file-earmark-text text-primary me-2"></i>AI Generated Output</h5>
                        <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill" onclick="copyResultText()"><i class="bi bi-clipboard me-1"></i>Copy Output</button>
                    </div>
                    <asp:TextBox ID="txtResult" runat="server" TextMode="MultiLine" Rows="14" CssClass="form-control font-monospace" ReadOnly="true" style="font-size:0.9rem; line-height:1.6; background-color:#F8FAFC;"></asp:TextBox>
                </div>
            </div>
        </div>
    
        <!-- Page Guide & Capabilities Box -->
        <div class="content-card p-3 p-md-4 mt-4 border shadow-sm rounded-4 bg-light">
            <div class="d-flex align-items-center gap-2 mb-2">
                <i class="bi bi-info-circle-fill text-primary fs-5"></i>
                <h6 class="fw-bold mb-0 text-dark">AI Neural Candidate Matcher - Guide &amp; Capabilities</h6>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 ms-auto small">Live Database Connected</span>
            </div>
            <div class="row g-3 small">
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-gear-wide-connected text-primary me-1"></i>What This Page Does:</div>
                        <div class="text-muted">Scans all registered campus students to find candidates matching your required skill stack and CGPA criteria, shortlisting them directly.</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-play-circle-fill text-success me-1"></i>How to Use:</div>
                        <div class="text-muted">Enter target skills or select an active opening, click "Find Matching Talent", review matched students, and click "Direct Shortlist Candidates" in Application_tbl.</div>
                    </div>
                </div>
            </div>
        </div>

    </div><script type="text/javascript">
        var recognition = null;
        var isListening = false;
        function toggleVoice() {
            var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
            if (!SpeechRecognition) {
                alert("Speech recognition not supported in this browser. Please use Chrome or Edge.");
                return;
            }
            var btn = document.getElementById('btnMic');
            var txt = document.getElementById('<%= txtPromptInput.ClientID %>');

            if (isListening && recognition) {
                recognition.stop();
                return;
            }

            recognition = new SpeechRecognition();
            recognition.continuous = false;
            recognition.interimResults = false;
            recognition.lang = 'en-IN';

            recognition.onstart = function() {
                isListening = true;
                if (btn) btn.classList.add('mic-listening');
            };

            recognition.onresult = function(event) {
                var transcript = event.results[0][0].transcript;
                if (txt) {
                    txt.value = transcript;
                }
            };

            recognition.onend = function() {
                isListening = false;
                if (btn) btn.classList.remove('mic-listening');
            };

            recognition.start();
        }
    </script>

</asp:Content>
