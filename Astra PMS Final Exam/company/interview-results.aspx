<%@ Page Title="Interview Results & Evaluation" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="interview-results.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.interview_results" %>

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
                        <li class="breadcrumb-item"><a href="interviews.aspx">Candidate Management</a></li>
                        <li class="breadcrumb-item active">Evaluation & Results</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Interview Evaluation & Scorecard</h3>
                <p class="text-muted small mb-0">Record candidate performance, technical scores, interview remarks, and hiring decisions.</p>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="applicants.aspx"><i class="bi bi-people me-1"></i> Applicants</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="shortlisted.aspx"><i class="bi bi-person-check me-1"></i> Shortlisted Students</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="interviews.aspx"><i class="bi bi-calendar-event me-1"></i> Interview Schedules</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="interview-results.aspx"><i class="bi bi-clipboard-check me-1"></i> Assessment Results</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="selections.aspx"><i class="bi bi-award me-1"></i> Selections & Offers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="placement-history.aspx"><i class="bi bi-clock-history me-1"></i> Hiring History</a>
            </li>
        </ul>

        <div class="row g-4">
            <!-- Left: Evaluation Input Form -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-pencil-square text-primary me-2"></i>Candidate Evaluation Card</h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Select Interview Session <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlInterviewSession" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlInterviewSession_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>

                        <div class="p-3 bg-light rounded border mb-3">
                            <div class="small fw-semibold text-primary mb-1">Candidate Details</div>
                            <div class="fw-bold text-dark"><asp:Label ID="lblCandName" runat="server"></asp:Label></div>
                            <div class="text-muted small"><asp:Label ID="lblCandEmail" runat="server"></asp:Label></div>
                            <div class="text-muted small mt-1">Round: <span class="fw-semibold text-dark"><asp:Label ID="lblCandRound" runat="server"></asp:Label></span></div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Technical Score (0-100)</label>
                                <asp:TextBox ID="txtTechScore" runat="server" CssClass="form-control" TextMode="Number" placeholder="e.g. 85"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Aptitude / Problem Solving</label>
                                <asp:TextBox ID="txtAptScore" runat="server" CssClass="form-control" TextMode="Number" placeholder="e.g. 80"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">HR / Communication Score</label>
                                <asp:TextBox ID="txtHRScore" runat="server" CssClass="form-control" TextMode="Number" placeholder="e.g. 90"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Group Discussion Score</label>
                                <asp:TextBox ID="txtGDScore" runat="server" CssClass="form-control" TextMode="Number" placeholder="e.g. 75"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Performance Rating <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="Excellent">5 Stars - Excellent</asp:ListItem>
                                    <asp:ListItem Value="Very Good">4 Stars - Very Good</asp:ListItem>
                                    <asp:ListItem Value="Good">3 Stars - Good</asp:ListItem>
                                    <asp:ListItem Value="Average">2 Stars - Average</asp:ListItem>
                                    <asp:ListItem Value="Poor">1 Star - Unsatisfactory</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Recommendation / Decision <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlRecommendation" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="Selected for Offer">Selected for Offer</asp:ListItem>
                                    <asp:ListItem Value="Pass - Next Round">Pass - Next Round</asp:ListItem>
                                    <asp:ListItem Value="On Hold">On Hold / Waitlist</asp:ListItem>
                                    <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label class="form-label fw-semibold small text-muted mb-0">Interviewer Remarks & Strengths</label>
                                <button type="button" class="btn btn-sm btn-outline-primary py-0 px-2 fw-semibold" onclick="aiDraftEvaluationRemarks()" title="Auto-draft scorecard summary">
                                    <i class="bi bi-stars"></i> ✨ AI Auto-Draft Scorecard
                                </button>
                            </div>
                            <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Candidate showed strong C# and SQL knowledge..."></asp:TextBox>
                        </div>

                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSaveEvaluation" runat="server" Text="Save Evaluation Result" CssClass="btn btn-primary flex-grow-1" OnClick="btnSaveEvaluation_Click" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Evaluated Candidates Grid -->
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-card-checklist text-primary me-2"></i>Evaluated Candidate Scorecards</h5>
                        <span class="text-muted small">Real-time evaluation ledger</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView  UseAccessibleHeader="True" ID="gvResults" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0"
                                DataKeyNames="Interview_Id" EmptyDataText="No evaluated interviews yet." GridLines="None" OnRowCommand="gvResults_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="Interview_Id" HeaderText="#" />
                                    <asp:TemplateField HeaderText="Candidate">
                                        <ItemTemplate>
                                            <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                            <div class="text-muted small"><%# Eval("Student_Email") %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Round_Name" HeaderText="Round" />
                                    <asp:TemplateField HeaderText="Score / Rating">
                                        <ItemTemplate>
                                            <div>Tech: <span class="fw-bold text-dark"><%# Eval("Technical_Score") %></span> | HR: <span class="fw-bold text-dark"><%# Eval("HR_Score") %></span></div>
                                            <span class="badge bg-secondary bg-opacity-10 text-dark mt-1"><%# Eval("Rating") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Result / Decision">
                                        <ItemTemplate>
                                            <span class='badge <%# Convert.ToString(Eval("Result")) == "Selected for Offer" || Convert.ToString(Eval("Result")) == "Pass" ? "bg-success" : Convert.ToString(Eval("Result")) == "Rejected" ? "bg-danger" : "bg-warning text-dark" %>'>
                                                <%# Eval("Result") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <div class="btn-group btn-group-sm">
                                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="SelectForEvaluation" CommandArgument='<%# Eval("Interview_Id") %>' CssClass="btn btn-outline-primary" title="Edit Scores">
                                                    <i class="bi bi-pencil"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="lnkOffer" runat="server" CommandName="issue_offer" CommandArgument='<%# Eval("Student_Email") %>' CssClass="btn btn-outline-success" title="Issue Offer">
                                                    <i class="bi bi-award"></i> Offer
                                                </asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center py-4 text-muted">
                                <i class="bi bi-inbox fs-2 d-block mb-1 text-secondary"></i>
                                <div class="fw-semibold">No records found</div>
                                <div class="small">There are currently no entries to display.</div>
                            </div>
                        </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function aiDraftEvaluationRemarks() {
            var rating = document.getElementById('<%= ddlRating.ClientID %>').value;
            var rec = document.getElementById('<%= ddlRecommendation.ClientID %>').value;
            var remBox = document.getElementById('<%= txtRemarks.ClientID %>');

            remBox.value = "Technical & Behavioral Assessment (" + rating + " - " + rec + "):\n" +
                           "- Candidate exhibited crisp conceptual clarity in object-oriented architecture, database normalization, and algorithm complexity.\n" +
                           "- Communication during problem-solving was structured, receptive to hints, and articulated with professional confidence.\n" +
                           "- Recommended Action: " + rec + ". Candidate aligns strongly with our engineering culture.";
        }
    </script>
</asp:Content>
