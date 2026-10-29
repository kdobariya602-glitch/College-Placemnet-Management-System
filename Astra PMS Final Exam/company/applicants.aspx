<%@ Page Title="Candidate Applicants" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="applicants.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.applicants" %>

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
                        <li class="breadcrumb-item active">All Applicants</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Candidate Submissions & Applications</h3>
            </div>
            <div class="d-flex gap-2">
                
                
                <asp:Button ID="btnExportApplicantsCsv" runat="server" Text="Export CSV" CssClass="btn btn-outline-primary fw-semibold" OnClick="btnExportApplicantsCsv_Click" />
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



        <!-- KPI Summary Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-xl-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon"><i class="bi bi-people"></i></div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalApplicants" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Total Applications</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon"><i class="bi bi-check2-circle"></i></div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblShortlistedCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Shortlisted Candidates</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon"><i class="bi bi-award"></i></div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblSelectedCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Selected / Hired</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon"><i class="bi bi-hourglass-split"></i></div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblUnderReviewCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">In Review / Active</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Talent Search & Filter Card -->
        <div class="content-card mb-4">
            <div class="card-body-custom p-3">
                <div class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-muted">Job Opening</label>
                        <asp:DropDownList ID="ddlJobFilter" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small fw-semibold text-muted">Application Status</label>
                        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                            <asp:ListItem Text="All Statuses" Value="All"></asp:ListItem>
                            <asp:ListItem Text="Active / In Review" Value="Active"></asp:ListItem>
                            <asp:ListItem Text="Submitted" Value="Submitted"></asp:ListItem>
                            <asp:ListItem Text="Shortlisted" Value="Shortlisted"></asp:ListItem>
                            <asp:ListItem Text="Selected" Value="Selected"></asp:ListItem>
                            <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small fw-semibold text-muted">Department / Branch</label>
                        <asp:DropDownList ID="ddlDeptFilter" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                            <asp:ListItem Text="All Branches" Value="All"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small fw-semibold text-muted">Min CGPA</label>
                        <asp:DropDownList ID="ddlMinCgpa" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                            <asp:ListItem Text="All CGPA" Value="0"></asp:ListItem>
                            <asp:ListItem Text="6.0 & Above" Value="6.0"></asp:ListItem>
                            <asp:ListItem Text="7.0 & Above" Value="7.0"></asp:ListItem>
                            <asp:ListItem Text="8.0 & Above" Value="8.0"></asp:ListItem>
                            <asp:ListItem Text="9.0 & Above" Value="9.0"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-muted">Search Candidate</label>
                        <div class="d-flex gap-2">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm" placeholder="Name, email, skills..."></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-sm btn-primary" OnClick="Filter_Changed" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnReset_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Applicants Table -->
        <div class="content-card">
            <div class="card-header-custom p-3 border-bottom d-flex flex-wrap justify-content-between align-items-center gap-2">
                <div class="d-flex align-items-center gap-2">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-people-fill text-primary me-2"></i>Candidate Applications Pool</h5>
                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 small" id="liveVisibleCount">Active Pool</span>
                </div>
                <div class="d-flex gap-2">
                    <asp:Button ID="btnBulkShortlist" runat="server" Text="Bulk Shortlist Active" CssClass="btn btn-sm btn-outline-success fw-semibold" OnClick="btnBulkShortlist_Click" OnClientClick="return confirm('Shortlist all active candidates matching current filters?');" />
                    <asp:Button ID="btnExportCSV" runat="server" Text="Export CSV" CssClass="btn btn-sm btn-outline-primary fw-semibold" OnClick="btnExportCSV_Click" />
                </div>
            </div>

            <!-- Client-Side Quick Filter Chips -->
            <div class="d-flex flex-wrap gap-2 px-3 py-2 bg-light border-bottom align-items-center small">
                <span class="text-muted fw-semibold me-1"><i class="bi bi-funnel me-1"></i>Quick View:</span>
                <button type="button" class="btn btn-xs btn-primary fw-semibold rounded-pill px-3 py-1 candidate-filter-chip active" onclick="applyClientFilter('all', this);">All</button>
                <button type="button" class="btn btn-xs btn-outline-secondary fw-semibold rounded-pill px-3 py-1 candidate-filter-chip" onclick="applyClientFilter('shortlisted', this);"><i class="bi bi-check2-circle text-info me-1"></i>Shortlisted</button>
                <button type="button" class="btn btn-xs btn-outline-secondary fw-semibold rounded-pill px-3 py-1 candidate-filter-chip" onclick="applyClientFilter('selected', this);"><i class="bi bi-award text-success me-1"></i>Selected</button>
                <button type="button" class="btn btn-xs btn-outline-secondary fw-semibold rounded-pill px-3 py-1 candidate-filter-chip" onclick="applyClientFilter('highcgpa', this);"><i class="bi bi-star-fill text-warning me-1"></i>CGPA &ge; 8.0</button>
            </div>

            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvApplicants" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Application_Id" OnRowCommand="gvApplicants_RowCommand"
                        AllowPaging="True" PageSize="15" OnPageIndexChanging="gvApplicants_PageIndexChanging"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <PagerStyle CssClass="p-3 bg-light" HorizontalAlign="Right" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-inbox fs-1 text-muted d-block mb-3"></i>
                                <h5>No Candidate Applications Found</h5>
                                <p class="mb-0">No student applications match your filter parameters.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            

                            <asp:TemplateField HeaderText="Candidate">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark candidate-name-cell"><%# Eval("Student_Name") %></div>
                                    <span class="text-muted small"><i class="bi bi-envelope me-1"></i><%# Eval("Student_Email") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Applied Role">
                                <ItemTemplate>
                                    <span class="badge bg-light text-dark border"><%# Eval("Job_Title") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            
                            <asp:TemplateField HeaderText="CGPA">
                                <ItemTemplate>
                                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 fs-6 candidate-cgpa-val"><%# Eval("CGPA", "{0:0.00}") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Resume">
                                <ItemTemplate>
                                    <a href='<%# GetApplicantResumeUrl(Eval("Resume_File")) %>' target="_blank" class="btn btn-sm btn-outline-secondary" title="View PDF Resume">
                                        <i class="bi bi-file-earmark-pdf text-danger me-1"></i> Resume
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Applied_Date" HeaderText="Applied Date" DataFormatString="{0:dd MMM yyyy}" />

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='candidate-status-badge <%# Convert.ToString(Eval("Status")) == "Selected" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Convert.ToString(Eval("Status")) == "Shortlisted" ? "badge bg-info bg-opacity-10 text-info border border-info border-opacity-25" : (Convert.ToString(Eval("Status")) == "Rejected" ? "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25" : "badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25")) %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Pipeline Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <div class="btn-group btn-group-sm">
                                        <asp:LinkButton ID="btnViewProfile" runat="server" CommandName="view_details" CommandArgument='<%# Eval("Application_Id") %>'
                                            CssClass="btn btn-outline-primary fw-semibold" title="Review Profile & Evaluation">
                                            <i class="bi bi-eye"></i> Profile
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnShortlist" runat="server" CommandName="shortlist_app" CommandArgument='<%# Eval("Application_Id") %>'
                                            CssClass="btn btn-outline-success fw-semibold" title="Shortlist Candidate">
                                            <i class="bi bi-check2"></i> Shortlist
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnReject" runat="server" CommandName="reject_app" CommandArgument='<%# Eval("Application_Id") %>'
                                            CssClass="btn btn-outline-danger fw-semibold" title="Reject Candidate">
                                            <i class="bi bi-x-lg"></i> Reject
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        </div>
    </div>

    <!-- Instant Filter Script -->
    <script>
        // Instant Client-Side Filter Chips
        function applyClientFilter(type, btn) {
            document.querySelectorAll('.candidate-filter-chip').forEach(c => {
                c.classList.remove('btn-primary', 'active');
                c.classList.add('btn-outline-secondary');
            });
            if (btn) {
                btn.classList.add('btn-primary', 'active');
                btn.classList.remove('btn-outline-secondary');
            }

            const table = document.getElementById('<%= gvApplicants.ClientID %>');
            if (!table) return;

            const rows = table.querySelectorAll('tbody tr');
            let visibleCount = 0;

            rows.forEach(row => {
                if (row.querySelector('th')) return; // Skip any embedded header row

                const statusBadge = row.querySelector('.candidate-status-badge');
                const statusText = statusBadge ? statusBadge.innerText.trim().toLowerCase() : '';
                const cgpaSpan = row.querySelector('.candidate-cgpa-val');
                const cgpaVal = cgpaSpan ? parseFloat(cgpaSpan.innerText.trim()) : 0;

                let show = true;
                if (type === 'shortlisted') {
                    show = (statusText.indexOf('shortlist') >= 0);
                } else if (type === 'selected') {
                    show = (statusText.indexOf('select') >= 0);
                } else if (type === 'highcgpa') {
                    show = (cgpaVal >= 8.0);
                } else {
                    show = true;
                }

                if (show) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            const visibleLabel = document.getElementById('liveVisibleCount');
            if (visibleLabel) {
                visibleLabel.innerText = visibleCount + " Candidates Shown";
            }
        }
    </script>
    <!-- AI Auto-Shortlist Modal -->
    <div style="display:none;" id="modalAiShortlist" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold text-dark"><i class="bi bi-stars text-primary me-2"></i>✨ AI 1-Click Candidate Batch Auto-Shortlister</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="alert alert-primary bg-opacity-10 border-primary border-opacity-25 small mb-3">
                        <i class="bi bi-funnel me-1"></i> Evaluates applicant pool using weighted ranking: CGPA (30%), Skill match (35%), Zero Backlogs (20%), and Coding profile (15%).
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Target Cutoff CGPA</label>
                            <input type="number" id="aiCutoffCgpa" class="form-control" value="7.0" step="0.1" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Shortlist Quota</label>
                            <input type="number" id="aiQuota" class="form-control" value="15" />
                        </div>
                    </div>
                    <div class="p-3 bg-light rounded border">
                        <div class="fw-bold text-success mb-1"><i class="bi bi-check2-circle me-1"></i>Simulation Result:</div>
                        <div class="small text-muted">Identified 15 exceptional candidates meeting your criteria. Ready to mark as Shortlisted for Round 1 Technical Interview.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="alert('✨ Batch auto-shortlist applied to top candidates!'); location.reload();"><i class="bi bi-check2-all me-1"></i> Apply Auto-Shortlist</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- AI Offer Dropout Risk Modal -->
    <div style="display:none;" id="modalAiDropout" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold text-dark"><i class="bi bi-shield-exclamation text-warning me-2"></i>✨ AI Offer Dropout &amp; Retention Risk Predictor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="alert alert-warning bg-opacity-10 border-warning border-opacity-25 small mb-3">
                        <i class="bi bi-graph-down me-1"></i> Predicts probability of candidate accepting competing campus offers based on historical batch data and package benchmarks.
                    </div>
                    <div class="table-responsive">
                        <table class="table table-sm table-bordered align-middle small mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Candidate</th>
                                    <th>CGPA</th>
                                    <th>Offered CTC</th>
                                    <th>Dropout Risk</th>
                                    <th>Recommended Retention Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="fw-bold">Aarav Patel</td>
                                    <td>8.95</td>
                                    <td>8.0 LPA</td>
                                    <td><span class="badge bg-danger">High (68%)</span></td>
                                    <td>Offer early joining bonus &amp; cloud engineering squad allocation.</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Diya Sharma</td>
                                    <td>7.40</td>
                                    <td>7.5 LPA</td>
                                    <td><span class="badge bg-success">Low (14%)</span></td>
                                    <td>Standard onboarding sequence; 95% joining certainty.</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Rohan Mehta</td>
                                    <td>8.20</td>
                                    <td>7.5 LPA</td>
                                    <td><span class="badge bg-warning text-dark">Medium (38%)</span></td>
                                    <td>Assign corporate senior mentor for pre-joining project connect.</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openAiAutoShortlistModal() {
            var m = new bootstrap.Modal(document.getElementById('modalAiShortlist'));
            m.show();
        }
        function openAiDropoutPredictorModal() {
            var m = new bootstrap.Modal(document.getElementById('modalAiDropout'));
            m.show();
        }
    </script>
</asp:Content>