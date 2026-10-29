<%@ Page Title="AI Recruiter Legitimacy Audit" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="ai-recruiter-vetting.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.ai_recruiter_vetting" %>

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
                    <li class="breadcrumb-item active">AI Recruiter Legitimacy Audit</li>
                </ol>
            </nav>
            <h3 class="fw-bold mb-0"><i class="bi bi-stars text-primary me-2"></i>AI Recruiter Legitimacy Audit &amp; Direct Verification</h3>
            <small class="text-muted">Verify corporate registrations, compliance status, and approve/reject or delete records directly via AI.</small>
        </div>

        <div class="ai-tabs-scroller">
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link" href="ai-assistant.aspx"><i class="bi bi-robot"></i><span>AI Admin System Director</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-grievance-triage.aspx"><i class="bi bi-life-preserver"></i><span>AI Grievance Triage Desk</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-institutional-audit.aspx"><i class="bi bi-bar-chart-line"></i><span>AI Institutional NAAC Audit</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-drive-policy.aspx"><i class="bi bi-calendar2-event"></i><span>AI Drive Policy & Instructions</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-policy-drafter.aspx"><i class="bi bi-sliders2"></i><span>AI Placement Policy Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-security-auditor.aspx"><i class="bi bi-shield-lock"></i><span>AI System Security Audit</span></a></li>
            <li class="nav-item"><a class="nav-link active" href="ai-recruiter-vetting.aspx"><i class="bi bi-shield-check"></i><span>AI Recruiter Legitimacy Audit</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-skill-standardizer.aspx"><i class="bi bi-diagram-3"></i><span>AI Skill Matrix Standardizer</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-log-forensics.aspx"><i class="bi bi-journal-text"></i><span>AI Security Log Inspector</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-redressal-advisor.aspx"><i class="bi bi-shield-exclamation"></i><span>AI Grievance Redressal Advisor</span></a></li>
        </ul>
    </div>

        <asp:Label ID="lblMsg" runat="server"></asp:Label>

        <div class="row g-4">
            <div class="col-lg-5">
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-white mb-3">
                    <h5 class="fw-bold mb-3 text-dark"><i class="bi bi-building-check text-primary me-2"></i>Select Registered Company</h5>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Select from Database</label>
                        <asp:DropDownList ID="ddlCompanies" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlCompanies_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="form-label small fw-semibold text-muted mb-0">Employer Profile / CIN / Parameters</label>
                            <button type="button" id="btnMic" class="btn btn-sm btn-outline-primary rounded-pill py-0 px-2" onclick="toggleVoice()" title="Speak parameters">
                                <i class="bi bi-mic-fill me-1"></i>Voice Input
                            </button>
                        </div>
                        <asp:TextBox ID="txtPromptInput" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" Text="Tech Innovations Pvt Ltd, CIN: U72200MH2020PTC123456, Domain: EdTech/SaaS" placeholder="Type your prompt/parameters here or click Voice Speak to dictate..."></asp:TextBox>
                        <div class="form-text small" id="voiceNotice">Speak or customize parameters to fine-tune AI synthesis.</div>
                    </div>

                    <div class="d-grid gap-2">
                        <asp:Button ID="btnGenerate" runat="server" Text="Audit with Gemini AI" CssClass="btn btn-primary fw-bold py-2 shadow-sm rounded-pill" OnClick="btnGenerate_Click" />
                    </div>
                </div>

                <!-- Database Autonomous Action Card -->
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-light border">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-lightning-charge-fill text-warning me-2"></i>Autonomous Database Execution</h6>
                    <p class="small text-muted mb-3">Execute live CRUD actions directly on the database without navigating away to manual pages:</p>
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnApproveRecruiter" runat="server" Text="✅ Verify & Approve Recruiter in Database" CssClass="btn btn-success fw-bold py-2 shadow-sm rounded-pill" OnClick="btnApproveRecruiter_Click" />
                        <asp:Button ID="btnRejectRecruiter" runat="server" Text="❌ Reject Recruiter Registration" CssClass="btn btn-warning fw-bold py-2 shadow-sm rounded-pill" OnClick="btnRejectRecruiter_Click" />
                        <asp:Button ID="btnDeleteRecruiter" runat="server" Text="🗑️ Delete Company Record Permanently" CssClass="btn btn-outline-danger btn-sm py-2 rounded-pill" OnClick="btnDeleteRecruiter_Click" OnClientClick="return confirm('Permanently delete this company from the database?');" />
                    </div>
                </div>
            </div>

            <div class="col-lg-7">
                <div class="content-card p-4 border-0 shadow-sm rounded-4 bg-white">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-file-earmark-text text-primary me-2"></i>AI Legitimacy &amp; Vetting Report</h5>
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
                <h6 class="fw-bold mb-0 text-dark">AI Recruiter Legitimacy Audit - Guide &amp; Capabilities</h6>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 ms-auto small">Live Database Connected</span>
            </div>
            <div class="row g-3 small">
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-gear-wide-connected text-primary me-1"></i>What This Page Does:</div>
                        <div class="text-muted">Screens recruiter company registrations, verifies corporate domain emails and business credibility, and approves or rejects company records in Company_reg_tbl.</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-play-circle-fill text-success me-1"></i>How to Use:</div>
                        <div class="text-muted">Enter vetting criteria or select pending companies, run the AI legitimacy audit, and click "Approve Validated Recruiters" to verify them in the live database.</div>
                    </div>
                </div>
            </div>
        </div>

    </div></asp:Content>
