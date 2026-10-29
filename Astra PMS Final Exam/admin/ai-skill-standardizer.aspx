<%@ Page Title="AI Skill Matrix Standardizer" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="ai-skill-standardizer.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.ai_skill_standardizer" %>

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
                    <li class="breadcrumb-item active">AI Skill Matrix Standardizer</li>
                </ol>
            </nav>
            <h3 class="fw-bold mb-0"><i class="bi bi-stars text-primary me-2"></i>AI Skill Matrix Standardizer</h3>
            <small class="text-muted">Align university engineering branches with NASSCOM / IEEE national skill standards.</small>
        </div>

        <div class="ai-tabs-scroller">
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link" href="ai-assistant.aspx"><i class="bi bi-robot"></i><span>AI Admin System Director</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-grievance-triage.aspx"><i class="bi bi-life-preserver"></i><span>AI Grievance Triage Desk</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-institutional-audit.aspx"><i class="bi bi-bar-chart-line"></i><span>AI Institutional NAAC Audit</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-drive-policy.aspx"><i class="bi bi-calendar2-event"></i><span>AI Drive Policy & Instructions</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-policy-drafter.aspx"><i class="bi bi-sliders2"></i><span>AI Placement Policy Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-security-auditor.aspx"><i class="bi bi-shield-lock"></i><span>AI System Security Audit</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-recruiter-vetting.aspx"><i class="bi bi-shield-check"></i><span>AI Recruiter Legitimacy Audit</span></a></li>
            <li class="nav-item"><a class="nav-link active" href="ai-skill-standardizer.aspx"><i class="bi bi-diagram-3"></i><span>AI Skill Matrix Standardizer</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-log-forensics.aspx"><i class="bi bi-journal-text"></i><span>AI Security Log Inspector</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-redressal-advisor.aspx"><i class="bi bi-shield-exclamation"></i><span>AI Grievance Redressal Advisor</span></a></li>
        </ul>
    </div>

        

        <asp:Label ID="lblMsg" runat="server"></asp:Label>

        <div class="row g-4">
            <div class="col-lg-5">
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-white">
                    <h5 class="fw-bold mb-3 text-dark"><i class="bi bi-sliders text-primary me-2"></i>AI Prompt Parameters (Type or Speak)</h5>
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="form-label small fw-semibold text-muted mb-0">Engineering Disciplines</label>
                            <button type="button" id="btnMic" class="btn btn-sm btn-outline-primary rounded-pill py-0 px-2" onclick="toggleVoice()" title="Voice input">
                                <i class="bi bi-mic-fill me-1"></i>Voice Input
                            </button>
                        </div>
                        <asp:TextBox ID="txtPromptInput" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" Text="Computer Science, Information Technology, AI & Data Science 4-Year Matrix" placeholder="Type your prompt/parameters here or click Voice Speak to dictate..."></asp:TextBox>
                        <div class="form-text small">Customize or augment these parameters to fine-tune AI synthesis.</div>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnGenerate" runat="server" Text="Generate with Gemini AI" CssClass="btn btn-primary fw-bold py-2 shadow-sm rounded-pill" OnClick="btnGenerate_Click" />
                    </div>
                </div>

                <!-- Database Autonomous Action Card -->
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-light border mt-3">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-lightning-charge-fill text-warning me-2"></i>Autonomous Database Execution</h6>
                    <p class="small text-muted mb-3">Broadcast standardized engineering skill benchmarks to student cohorts:</p>
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnStandardizeSkills" runat="server" Text="🎯 Publish Standardized Skill Framework Notice" CssClass="btn btn-success fw-bold py-2 shadow-sm rounded-pill" OnClick="btnStandardizeSkills_Click" />
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
                <h6 class="fw-bold mb-0 text-dark">AI Skill Matrix Standardizer - Guide &amp; Capabilities</h6>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 ms-auto small">Live Database Connected</span>
            </div>
            <div class="row g-3 small">
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-gear-wide-connected text-primary me-1"></i>What This Page Does:</div>
                        <div class="text-muted">Normalizes inconsistent skill inputs across student profiles and recruiter job descriptions into standard industry taxonomy (e.g., standardizing "React.js" to "React").</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-play-circle-fill text-success me-1"></i>How to Use:</div>
                        <div class="text-muted">Enter custom skill variations or fetch unmapped skills, click "Generate with Gemini AI", and click "Update Live Skill Matrix" to update skill tags across database tables.</div>
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
