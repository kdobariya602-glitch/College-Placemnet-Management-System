<%@ Page Title="AI Grievance Triage" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="ai-grievance-triage.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.ai_grievance_triage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .triage-card {
            transition: all 0.2s ease-in-out;
        }
        .triage-card:hover {
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <div class="ai-tabs-scroller">
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link" href="ai-assistant.aspx"><i class="bi bi-robot"></i><span>AI Admin System Director</span></a></li>
            <li class="nav-item"><a class="nav-link active" href="ai-grievance-triage.aspx"><i class="bi bi-life-preserver"></i><span>AI Grievance Triage Desk</span></a></li>
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
        <div class="mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-1">
                    <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                    <li class="breadcrumb-item active">AI Grievance Triage</li>
                </ol>
            </nav>
            <div class="d-flex align-items-center gap-2">
                <h3 class="fw-bold mb-0 text-gradient"><i class="bi bi-life-preserver text-primary me-2"></i>Astra Neural Grievance Triage &amp; Resolution Engine</h3>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1"><i class="bi bi-cpu me-1"></i>Neural v3.0</span>
            </div>
            <small class="text-muted">Automated natural language sentiment classification, priority indexing, and empathetic resolution drafting for student placement grievances.</small>
        </div>

        

        <asp:Label ID="lblMsg" runat="server"></asp:Label>

        <!-- Triage Summary Banner -->
        <div class="content-card p-3 p-md-4 mb-4 border-start border-4 border-primary shadow-sm">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-2">
                <div class="d-flex align-items-center gap-2">
                    <h6 class="fw-bold mb-0"><i class="bi bi-stars text-primary me-2"></i>Real-time Triage Analytics</h6>
                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1">Auto-Sentiment AI</span>
                </div>
                <div class="d-flex flex-wrap align-items-center gap-2 mt-2 mt-md-0">
                    <asp:DropDownList ID="ddlFilterStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterStatus_SelectedIndexChanged" CssClass="form-select form-select-sm shadow-sm" style="width: auto; min-width: 165px;">
                        <asp:ListItem Value="open" Text="Open &amp; In Review" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="all" Text="All Grievances"></asp:ListItem>
                        <asp:ListItem Value="resolved" Text="Resolved"></asp:ListItem>
                    </asp:DropDownList>
                    <div class="input-group input-group-sm shadow-sm mx-1" style="min-width: 240px; width: auto;">
                        <span class="input-group-text bg-white border-end-0 ps-3 pe-2"><i class="bi bi-search text-muted me-1"></i></span>
                        <input type="text" id="triageSearch" class="form-control border-start-0 ps-2 pe-3" placeholder="Filter grievances..." onkeyup="filterGrievances()" />
                    </div>
                    <asp:LinkButton ID="btnSimulate" runat="server" CssClass="btn btn-sm btn-primary shadow-sm fw-semibold text-nowrap d-inline-flex align-items-center px-3" OnClick="btnSimulate_Click" ToolTip="Simulate a new incoming student grievance for AI triage testing">
                        <i class="bi bi-plus-circle me-1"></i>Simulate Demo Grievance
                    </asp:LinkButton>
                </div>
            </div>
            <div class="d-flex flex-wrap align-items-center gap-2 pt-1">
                <%= sumHtml %>
            </div>
        </div>

        <div id="grievanceList">
            <asp:Repeater ID="rptG" runat="server" OnItemCommand="rptG_ItemCommand">
                <ItemTemplate>
                    <div class="content-card p-3 p-md-4 mb-3 triage-card border shadow-sm grievance-item" data-search='<%# safe(Eval("Subject")).ToLower() %> <%# safe(Eval("Student_Name")).ToLower() %> <%# safe(Eval("Description")).ToLower() %>'>
                        <div class="d-flex flex-wrap justify-content-between align-items-start gap-2 mb-3">
                            <div>
                                <div class="fs-6 fw-bold text-dark mb-1"><%# safe(Eval("Subject")) %></div>
                                <div class="small text-muted d-flex align-items-center gap-2">
                                    <span><i class="bi bi-person me-1"></i><%# safe(Eval("Student_Name")) %></span>
                                    <span>&bull;</span>
                                    <span>Current: <span class='<%# Convert.ToString(Eval("Status")) == "Resolved" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-warning bg-opacity-10 text-dark border border-warning border-opacity-25" %>'><%# safe(Eval("Status")) %></span></span>
                                </div>
                            </div>
                            <div class="d-flex flex-wrap align-items-center gap-1">
                                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1"><i class="bi bi-tag me-1"></i><%# cat(Eval("Subject"), Eval("Description")) %></span>
                                <span class="badge <%# badgecls(Eval("Subject"), Eval("Description")) %> px-2 py-1"><i class="bi bi-lightning-charge me-1"></i><%# pri(Eval("Subject"), Eval("Description")) %></span>
                                <span class="badge bg-light text-muted border px-2 py-1"><i class="bi bi-check-circle me-1"></i><%# confidence(Eval("Subject"), Eval("Description")) %></span>
                            </div>
                        </div>

                        <div class="p-3 rounded bg-light border border-opacity-50 small mb-3">
                            <span class="fw-semibold text-muted d-block mb-1">Student Statement:</span>
                            <span class="text-dark"><%# safe(Eval("Description")) %></span>
                        </div>

                        <div class="p-3 rounded border border-primary border-opacity-25 small mb-3" style="background: rgba(37, 99, 235, 0.03);">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <span class="fw-bold text-primary"><i class="bi bi-robot me-1"></i><%# Convert.ToString(Eval("Status")) == "Resolved" ? "Official Sent Reply:" : "AI Synthesized Official Reply:" %></span>
                                <button type="button" class="btn btn-xs btn-outline-secondary py-0 px-2" style="font-size:0.75rem;" onclick="copyReplyText(this)"><i class="bi bi-clipboard me-1"></i>Copy</button>
                            </div>
                            <div class="reply-text text-dark" style="line-height: 1.6;"><%# (Convert.ToString(Eval("Status")) == "Resolved" && Eval("Response") != DBNull.Value && !string.IsNullOrEmpty(Convert.ToString(Eval("Response")))) ? safe(Eval("Response")) : reply(Eval("Subject"), Eval("Description"), Eval("Student_Name")) %></div>
                        </div>

                        <div class="d-flex flex-wrap align-items-center gap-2">
                            <asp:LinkButton ID="lnkSend" runat="server" CommandName="send" CommandArgument='<%# Eval("Grievance_Id") %>' Visible='<%# Convert.ToString(Eval("Status")) != "Resolved" %>' CssClass="btn btn-primary btn-sm fw-semibold shadow-sm" OnClientClick="return confirm('Send this AI drafted reply and mark grievance as Resolved?');">
                                <i class="bi bi-send-check me-1"></i>Send Reply &amp; Resolve
                            </asp:LinkButton>
                            
                            <asp:LinkButton ID="lnkReopen" runat="server" CommandName="reopen" CommandArgument='<%# Eval("Grievance_Id") %>' CssClass="btn btn-outline-secondary btn-sm" Visible='<%# Convert.ToString(Eval("Status")) == "Resolved" %>'>
                                <i class="bi bi-arrow-counterclockwise me-1"></i>Re-open for Review
                            </asp:LinkButton>

                            <a href='grievances.aspx' class="btn btn-outline-primary btn-sm"><i class="bi bi-pencil me-1"></i>Grievance Management</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    
        <!-- Page Guide & Capabilities Box -->
        <div class="content-card p-3 p-md-4 mt-4 border shadow-sm rounded-4 bg-light">
            <div class="d-flex align-items-center gap-2 mb-2">
                <i class="bi bi-info-circle-fill text-primary fs-5"></i>
                <h6 class="fw-bold mb-0 text-dark">AI Grievance Triage Desk - Guide &amp; Capabilities</h6>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 ms-auto small">Live Database Connected</span>
            </div>
            <div class="row g-3 small">
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-gear-wide-connected text-primary me-1"></i>What This Page Does:</div>
                        <div class="text-muted">Performs natural language sentiment analysis on student placement complaints, classifies ticket urgency, drafts official administrative responses, and marks grievances as resolved in Grievance_tbl.</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-play-circle-fill text-success me-1"></i>How to Use:</div>
                        <div class="text-muted">Filter grievances by status or search keywords. Review the AI-synthesized reply, make any edits, and click "Send Reply & Resolve" to update the student ticket in the database.</div>
                    </div>
                </div>
            </div>
        </div>

    </div><script>
        function filterGrievances() {
            var input = document.getElementById('triageSearch').value.toLowerCase().trim();
            var items = document.querySelectorAll('.grievance-item');
            items.forEach(function(item) {
                var searchData = item.getAttribute('data-search') || '';
                if (!input || searchData.indexOf(input) !== -1) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        }

        function copyReplyText(btn) {
            var card = btn.closest('.grievance-item') || btn.closest('.border');
            if (!card) return;
            var textEl = card.querySelector('.reply-text');
            if (!textEl) return;
            var text = textEl.innerText || textEl.textContent;
            navigator.clipboard.writeText(text).then(function() {
                var orig = btn.innerHTML;
                btn.innerHTML = '<i class="bi bi-check2 text-success me-1"></i>Copied!';
                setTimeout(function() { btn.innerHTML = orig; }, 1800);
            });
        }
    </script>
</asp:Content>
