<%@ Page Title="AI Admin Assistant" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="ai-assistant.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.ai_assistant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <div class="mb-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-1">
                    <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                    <li class="breadcrumb-item active">AI Admin Assistant</li>
                </ol>
            </nav>
            <h3 class="fw-bold mb-0"><i class="bi bi-robot text-primary me-2"></i>AI Admin Assistant</h3>
            <small class="text-muted">Ask in simple words. Answers come straight from the live placement database.</small>
        </div>

        <div class="ai-tabs-scroller">
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link active" href="ai-assistant.aspx"><i class="bi bi-robot"></i><span>AI Admin System Director</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-grievance-triage.aspx"><i class="bi bi-life-preserver"></i><span>AI Grievance Triage Desk</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-institutional-audit.aspx"><i class="bi bi-bar-chart-line"></i><span>AI Institutional NAAC Audit</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-drive-policy.aspx"><i class="bi bi-calendar2-event"></i><span>AI Drive Policy & Instructions</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-policy-drafter.aspx"><i class="bi bi-sliders2"></i><span>AI Placement Policy Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-security-auditor.aspx"><i class="bi bi-shield-lock"></i><span>AI System Security Audit</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-recruiter-vetting.aspx"><i class="bi bi-shield-check"></i><span>AI Recruiter Legitimacy Audit</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-skill-standardizer.aspx"><i class="bi bi-diagram-3"></i><span>AI Skill Matrix Standardizer</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-log-forensics.aspx"><i class="bi bi-journal-text"></i><span>AI Security Log Inspector</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-redressal-advisor.aspx"><i class="bi bi-shield-exclamation"></i><span>AI Grievance Redressal Advisor</span></a></li>
        </ul>
    </div>

        

        <div class="content-card p-3">
            <div class="mb-3" style="min-height: 320px; max-height: 480px; overflow-y: auto;" id="chatBox">
                <%= chatHtml %>
            </div>

            <div class="mb-2 d-flex flex-wrap gap-2">
                <span class="badge bg-secondary bg-opacity-25 text-dark fw-bold px-2 py-2"><i class="bi bi-lightning-charge-fill text-warning me-1"></i>AI Autonomous CRUD Actions:</span>
                <a href="javascript:void(0);" class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('Approve all pending companies')"><i class="bi bi-check-circle me-1"></i>Approve All Pending Companies</a>
                <a href="javascript:void(0);" class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('Verify all pending students')"><i class="bi bi-person-check me-1"></i>Verify All Students</a>
                <a href="javascript:void(0);" class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('Resolve all open grievances')"><i class="bi bi-shield-check me-1"></i>Resolve All Grievances</a>
                <a href="javascript:void(0);" class="badge bg-warning bg-opacity-10 text-dark border border-warning border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('Post notice: Placement Drive Prep - Mandatory student session this Friday 10 AM')"><i class="bi bi-megaphone me-1"></i>Post Notice via AI</a>
            </div>

            <div class="mb-2 d-flex flex-wrap gap-2">
                <span class="badge bg-secondary bg-opacity-25 text-dark fw-bold px-2 py-2"><i class="bi bi-search me-1"></i>Database Insights:</span>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('Give me today summary')">Today's summary</a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('What is pending for verification?')">Pending verification</a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('How many grievances are open?')">Open grievances</a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('What is the placement percentage?')">Placement rate</a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('Which companies hire the most?')">Top recruiters</a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('Any upcoming drives?')">Upcoming drives</a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2" onclick="askq('Show offers and package details')">Offers & packages</a>
            </div>

            <asp:Panel ID="pnlAsk" runat="server" DefaultButton="btnAsk">
                <div class="d-flex align-items-center gap-2 mb-2">
                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1"><i class="bi bi-keyboard me-1"></i>Type &amp; Press Enter</span>
                    <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1"><i class="bi bi-mic-fill me-1"></i>Voice Speech</span>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <button type="button" id="btnMic" class="btn btn-outline-primary btn-mic-circle shadow-sm flex-shrink-0" onclick="toggleVoiceDictation()" title="Voice Dictation: Click and speak your question">
                        <i class="bi bi-mic-fill" id="micIcon"></i>
                    </button>
                    <asp:TextBox ID="txtAsk" runat="server" CssClass="form-control py-2 rounded-pill flex-grow-1 border px-3 shadow-sm" placeholder="Ask AI or type command (or click mic to speak)..." MaxLength="500"></asp:TextBox>
                    <asp:Button ID="btnAsk" runat="server" Text="Ask AI" CssClass="btn btn-primary px-4 py-2 fw-bold rounded-pill shadow-sm text-nowrap" OnClick="btnAsk_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-outline-secondary px-3 py-2 fw-semibold rounded-pill text-nowrap" OnClick="btnClear_Click" />
                </div>
                <div class="d-flex justify-content-between align-items-center mt-2 px-1">
                    <small class="text-muted" id="speechNotice"></small>
                    <small class="text-muted">Astra Neural v3.2</small>
                </div>
            </asp:Panel>
        </div>
    
        <!-- Page Guide & Capabilities Box -->
        <div class="content-card p-3 p-md-4 mt-4 border shadow-sm rounded-4 bg-light">
            <div class="d-flex align-items-center gap-2 mb-2">
                <i class="bi bi-info-circle-fill text-primary fs-5"></i>
                <h6 class="fw-bold mb-0 text-dark">AI Admin System Director - Guide &amp; Capabilities</h6>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 ms-auto small">Live Database Connected</span>
            </div>
            <div class="row g-3 small">
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-gear-wide-connected text-primary me-1"></i>What This Page Does:</div>
                        <div class="text-muted">Acts as the Autonomous System Administrator. Directly verifies students, approves or rejects recruiter companies, resolves student grievances, posts official circulars, and queries real-time database metrics.</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-play-circle-fill text-success me-1"></i>How to Use:</div>
                        <div class="text-muted">Type your question or administrative command in the box (or click the microphone icon to speak) and press Enter. You can also click any of the 1-click CRUD action badges above to execute actions instantly.</div>
                    </div>
                </div>
            </div>
        </div>

    </div><script>
        function askq(text) {
            document.getElementById('<%= txtAsk.ClientID %>').value = text;
            document.getElementById('<%= btnAsk.ClientID %>').click();
        }
        var cb = document.getElementById('chatBox');
        if (cb) { cb.scrollTop = cb.scrollHeight; }

        var recognition = null;
        var isListening = false;
        function toggleVoiceDictation() {
            var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
            if (!SpeechRecognition) {
                alert("Speech recognition is not supported in this browser. Please use Chrome, Edge, or Safari.");
                return;
            }
            var btnMic = document.getElementById('btnMic');
            var notice = document.getElementById('speechNotice');
            var txt = document.getElementById('<%= txtAsk.ClientID %>');

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
                btnMic.classList.add('mic-listening');
                if (notice) notice.innerHTML = "<span class='text-danger fw-bold'><i class='bi bi-record-circle-fill me-1'></i>Listening... Speak now</span>";
            };

            recognition.onresult = function(event) {
                var transcript = event.results[0][0].transcript;
                if (txt) {
                    txt.value = transcript;
                }
            };

            recognition.onerror = function(event) {
                console.warn("Speech recognition error:", event.error);
            };

            recognition.onend = function() {
                isListening = false;
                btnMic.classList.remove('mic-listening');
                if (notice) notice.innerHTML = "<i class='bi bi-info-circle me-1'></i>Tip: Click the microphone icon to speak your question in English or regional speech.";
            };

            recognition.start();
        }
    </script>
</asp:Content>
