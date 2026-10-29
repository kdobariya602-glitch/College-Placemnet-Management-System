<%@ Page Title="Smart Candidate Ranking" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="talent-match.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.talent_match" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .filter-chip-btn {
            transition: all 0.2s ease-in-out;
            cursor: pointer;
        }
        .filter-chip-btn.active {
            background-color: #2563EB !important;
            color: #FFFFFF !important;
            border-color: #2563EB !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <div class="d-flex flex-wrap justify-content-between align-items-end mb-3 gap-2">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item active">Smart Candidate Ranking</li>
                    </ol>
                </nav>
                <div class="d-flex align-items-center gap-2">
                    <h3 class="fw-bold mb-0 text-gradient"><i class="bi bi-cpu text-primary me-2"></i>Astra Neural Candidate Match Engine</h3>
                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1"><i class="bi bi-stars me-1"></i>AI Ranked</span>
                </div>
                <small class="text-muted">Multi-factor compatibility index: CGPA (30%), Skill match (35%), Backlogs (10%), Academic history (15%), and Profile completeness (10%).</small>
            </div>
            <div class="d-flex flex-wrap align-items-end gap-2" style="min-width: 300px;">
                <div class="flex-grow-1">
                    <label class="form-label small fw-semibold text-muted mb-1">Select Target Vacancy</label>
                    <asp:DropDownList ID="ddlJob" runat="server" CssClass="form-select shadow-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlJob_SelectedIndexChanged"></asp:DropDownList>
                </div>
            </div>
        </div>

        <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="ai-assistant.aspx"><i class="bi bi-robot me-1"></i> AI Recruiter Assistant</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="talent-match.aspx"><i class="bi bi-trophy me-1"></i> Smart Ranking</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="ai-job-writer.aspx"><i class="bi bi-stars me-1"></i> AI Job Writer</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="ai-interview-questions.aspx"><i class="bi bi-patch-question me-1"></i> AI Interview Questions</a>
            </li>
        </ul>

        <asp:Label ID="lblMsg" runat="server"></asp:Label>

        <%= summaryHtml %>

        <div class="row g-4">
            <div class="col-lg-9">
                <div class="content-card p-3 p-md-4 shadow-sm border">
                    <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 pb-2 border-bottom gap-2">
                        <div class="d-flex align-items-center gap-2">
                            <h5 class="fw-bold mb-0"><i class="bi bi-trophy text-warning me-2"></i>Ranked Talent Leaderboard</h5>
                        </div>
                        <div class="d-flex flex-wrap align-items-center gap-2">
                            <asp:Button ID="btnAutoShortlist" runat="server" Text="AI Auto-Shortlist (>=75%)" CssClass="btn btn-primary btn-sm fw-semibold shadow-sm" OnClick="btnAutoShortlist_Click" OnClientClick="return confirm('Automatically shortlist all candidates scoring >= 75% for this vacancy?');" />
                            <button type="button" class="btn btn-outline-secondary btn-sm" onclick="exportRankedCSV()"><i class="bi bi-download me-1"></i>Export CSV</button>
                        </div>
                    </div>

                    <!-- Live Filter Chips & Search Bar -->
                    <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-2">
                        <div class="d-flex flex-wrap gap-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary filter-chip-btn active" onclick="filterCandidates('all', this)">All</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary filter-chip-btn" onclick="filterCandidates('top', this)">Top Matches (&ge;75%)</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary filter-chip-btn" onclick="filterCandidates('good', this)">Good Fit (55-74%)</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary filter-chip-btn" onclick="filterCandidates('cut', this)">Meets Cutoffs</button>
                        </div>
                        <div class="input-group" style="max-width: 240px;">
                            <span class="input-group-text bg-white border-end-0 py-1"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" id="candSearch" class="form-control form-control-sm border-start-0 py-1" placeholder="Search candidate..." onkeyup="searchCandidates()" />
                        </div>
                    </div>

                    <%= rankHtml %>
                </div>
            </div>

            <div class="col-lg-3">
                <div class="content-card p-3 shadow-sm border">
                    <h5 class="fw-bold mb-2"><i class="bi bi-diagram-3 text-primary me-2"></i>Skill Coverage</h5>
                    <small class="text-muted d-block mb-3">Applicant density across each requested skill in your job post.</small>
                    <%= coverageHtml %>
                </div>
            </div>
        </div>
    </div>

    <script>
        function filterCandidates(type, btn) {
            document.querySelectorAll('.filter-chip-btn').forEach(function(b) { b.classList.remove('active'); });
            btn.classList.add('active');
            var rows = document.querySelectorAll('.cand-row');
            rows.forEach(function(r) {
                var score = parseInt(r.getAttribute('data-score') || '0', 10);
                var cut = r.getAttribute('data-cut') || '1';
                var show = true;
                if (type === 'top') {
                    show = score >= 75;
                } else if (type === 'good') {
                    show = (score >= 55 && score < 75);
                } else if (type === 'cut') {
                    show = (cut === '1');
                }
                r.style.display = show ? '' : 'none';
            });
        }

        function searchCandidates() {
            var val = document.getElementById('candSearch').value.toLowerCase().trim();
            var rows = document.querySelectorAll('.cand-row');
            rows.forEach(function(r) {
                var text = r.innerText.toLowerCase();
                r.style.display = (text.indexOf(val) !== -1) ? '' : 'none';
            });
        }

        function exportRankedCSV() {
            var table = document.getElementById('tblRanked');
            if (!table) {
                alert("No ranked candidates available to export.");
                return;
            }
            var rows = table.querySelectorAll('tr');
            var csv = [];
            rows.forEach(function(row) {
                if (row.style.display === 'none') return;
                var cols = row.querySelectorAll('th, td');
                var rowData = [];
                cols.forEach(function(c, idx) {
                    if (idx < cols.length - 1) { // skip action button column
                        var text = c.innerText.replace(/"/g, '""').replace(/\r?\n|\r/g, ' ').trim();
                        rowData.push('"' + text + '"');
                    }
                });
                csv.push(rowData.join(','));
            });
            var csvString = csv.join('\n');
            var blob = new Blob([csvString], { type: 'text/csv;charset=utf-8;' });
            var a = document.createElement('a');
            a.href = URL.createObjectURL(blob);
            a.download = 'Astra_Candidate_Ranking_' + new Date().toISOString().slice(0,10) + '.csv';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        }
    </script>
</asp:Content>


