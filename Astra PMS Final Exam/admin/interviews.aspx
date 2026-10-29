<%@ Page Title="Interviews & Panels" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="interviews.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.interviews" %>

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
                        <li class="breadcrumb-item"><a href="drives.aspx">Placement Management</a></li>
                        <li class="breadcrumb-item active">Interviews</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Interviews & Assessment Panels</h3>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalScheduleInterview"><i class="bi bi-calendar-plus me-1"></i> Schedule Round</button>
                <button type="button" class="btn btn-outline-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalAddPanel">
                    <i class="bi bi-people me-1"></i> Add Interview Panel
                </button>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="drives.aspx"><i class="bi bi-calendar2-event me-1"></i> Placement Drives</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="jobs.aspx"><i class="bi bi-briefcase me-1"></i> Job Postings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="internships.aspx"><i class="bi bi-mortarboard me-1"></i> Internships</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="applications.aspx"><i class="bi bi-file-earmark-check me-1"></i> Applications</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="interviews.aspx"><i class="bi bi-chat-square-text me-1"></i> Interviews</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="selections.aspx"><i class="bi bi-award me-1"></i> Selections & Offers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="placement-history.aspx"><i class="bi bi-clock-history me-1"></i> Placement History</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- Tab Navigation -->
        <div class="card border-0 shadow-sm p-4">
            <ul class="nav nav-pills mb-4 border-bottom pb-3" id="interviewTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-semibold" id="scheduled-tab" data-bs-toggle="pill" data-bs-target="#scheduled" type="button" role="tab"><i class="bi bi-calendar-check me-1"></i> Scheduled Rounds</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="panels-tab" data-bs-toggle="pill" data-bs-target="#panels" type="button" role="tab"><i class="bi bi-person-lines-fill me-1"></i> Interview Panels & Evaluators</button>
                </li>
            </ul>

            <div class="tab-content" id="interviewTabsContent">
                <!-- Tab 1: Scheduled Rounds -->
                <div class="tab-pane fade show active" id="scheduled" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvInterviews" runat="server" AutoGenerateColumns="False"
                            AllowPaging="True" PageSize="10" OnPageIndexChanging="gvInterviews_PageIndexChanging"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            DataKeyNames="Interview_Id" OnRowCommand="gvInterviews_RowCommand"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-5 text-muted">
                                    <i class="bi bi-person-video fs-1 text-secondary d-block mb-3"></i>
                                    <h5>No Interviews Scheduled</h5>
                                    <p class="mb-0">There are currently no active interview rounds scheduled.</p>
                                </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Candidate">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark fs-6"><%# Eval("Student_Name") %></div>
                                        <span class="text-muted small"><i class="bi bi-envelope me-1"></i><%# Eval("Student_Email") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Company & Round">
                                    <ItemTemplate>
                                        <div class="fw-semibold text-primary"><%# Eval("Company_Name") %></div>
                                        <span class="badge bg-light text-dark border"><%# Eval("Round_Name") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Schedule & Mode">
                                    <ItemTemplate>
                                        <div class="fw-semibold text-dark"><i class="bi bi-calendar-check me-1 text-primary"></i><%# Eval("Interview_Date", "{0:dd MMM yyyy}") %> - <%# Eval("Interview_Time") %></div>
                                        <span class="text-muted small"><i class="bi bi-geo-alt me-1"></i><%# Eval("Venue") %> (<%# Eval("Mode") %>)</span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Interviewer">
                                    <ItemTemplate>
                                        <span class="small fw-semibold text-dark"><%# Eval("Interviewer_Name") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Status / Result">
                                    <ItemTemplate>
                                        <span class='<%# Convert.ToString(Eval("Result")) == "Passed" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Convert.ToString(Eval("Result")) == "Failed" ? "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25") %>'>
                                            <%# Eval("Status") %> (<%# Eval("Result") %>)
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnPass" runat="server" CommandName="pass_round" CommandArgument='<%# Eval("Interview_Id") %>' CssClass="btn btn-sm btn-outline-success me-1" title="Mark as Passed">
                                            <i class="bi bi-check-circle"></i> Pass
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnFail" runat="server" CommandName="fail_round" CommandArgument='<%# Eval("Interview_Id") %>' CssClass="btn btn-sm btn-outline-danger me-1" title="Mark as Failed">
                                            <i class="bi bi-x-circle"></i> Fail
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="delete_interview" CommandArgument='<%# Eval("Interview_Id") %>' CssClass="btn btn-sm btn-outline-secondary" OnClientClick="return confirm('Delete this interview schedule?');" title="Delete">
                                            <i class="bi bi-trash"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 2: Interview Panels -->
                <div class="tab-pane fade" id="panels" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvPanels" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            DataKeyNames="Panel_Id" OnRowCommand="gvPanels_RowCommand"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <Columns>
                                <asp:TemplateField HeaderText="Panel Name">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Panel_Name") %></div>
                                        <span class="text-muted small"><i class="bi bi-building me-1"></i><%# Eval("Company_Name") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Evaluator Details">
                                    <ItemTemplate>
                                        <div class="fw-semibold text-dark"><%# Eval("Interviewer_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Designation") %> &bull; <%# Eval("Email") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Assigned Round">
                                    <ItemTemplate>
                                        <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25"><%# Eval("Round_Assigned") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelPanel" runat="server" CommandName="delete_panel" CommandArgument='<%# Eval("Interview_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Remove panel evaluator?');"><i class="bi bi-trash"></i></asp:LinkButton>
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

    <!-- Modal Schedule Interview -->
    <div class="modal fade" id="modalScheduleInterview" tabindex="-1" aria-labelledby="modalScheduleInterviewLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalScheduleInterviewLabel"><i class="bi bi-calendar-plus text-primary me-2"></i>Schedule Candidate Interview</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Select Candidate (from Shortlisted) *</label>
                            <asp:DropDownList ID="ddlCandidate" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Interview Round *</label>
                            <asp:DropDownList ID="ddlRoundName" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Technical Round 1 (Algorithms & Systems)" Value="Technical Round 1"></asp:ListItem>
                                <asp:ListItem Text="Technical Round 2 (Design & Core)" Value="Technical Round 2"></asp:ListItem>
                                <asp:ListItem Text="Managerial / Group Discussion" Value="Managerial / GD"></asp:ListItem>
                                <asp:ListItem Text="HR & Culture Fitment Round" Value="HR Fitment Round"></asp:ListItem>
                                <asp:ListItem Text="Final Comprehensive Interview" Value="Final Round"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Interview Date *</label>
                            <asp:TextBox ID="txtIntDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Time Slot *</label>
                            <asp:TextBox ID="txtIntTime" runat="server" CssClass="form-control" placeholder="e.g. 11:00 AM"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Mode</label>
                            <asp:DropDownList ID="ddlIntMode" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Online" Value="Online"></asp:ListItem>
                                <asp:ListItem Text="On-Campus" Value="On-Campus"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Venue / Room</label>
                            <asp:TextBox ID="txtIntVenue" runat="server" CssClass="form-control" placeholder="e.g. Placement Boardroom 2 / Virtual"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Meeting Link (Google Meet / Teams)</label>
                            <asp:TextBox ID="txtIntLink" runat="server" CssClass="form-control" placeholder="https://meet.google.com/..."></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Interviewer / Panel Name</label>
                            <asp:TextBox ID="txtIntInterviewer" runat="server" CssClass="form-control" placeholder="e.g. Technical Director / Lead Architect"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Special Instructions for Candidate</label>
                            <asp:TextBox ID="txtIntInstructions" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Be ready with camera, headset and coding workspace 10 mins prior..."></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveInterview" runat="server" Text="Schedule & Send Invite" CssClass="btn btn-primary fw-semibold" OnClick="btnSaveInterview_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Add Panel -->
    <div class="modal fade" id="modalAddPanel" tabindex="-1" aria-labelledby="modalAddPanelLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddPanelLabel"><i class="bi bi-people text-primary me-2"></i>Create Interview Panel</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Panel Name *</label>
                            <asp:TextBox ID="txtPanelName" runat="server" CssClass="form-control" placeholder="e.g. Google Cloud Tech Panel Alpha"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Company *</label>
                            <asp:DropDownList ID="ddlPanelCompany" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Interviewer Full Name *</label>
                            <asp:TextBox ID="txtPanelInterviewer" runat="server" CssClass="form-control" placeholder="e.g. Senior Tech Lead"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Designation</label>
                            <asp:TextBox ID="txtPanelDesig" runat="server" CssClass="form-control" placeholder="e.g. Principal Architect"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Email Address</label>
                            <asp:TextBox ID="txtPanelEmail" runat="server" CssClass="form-control" placeholder="interviewer@company.com"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Phone Number</label>
                            <asp:TextBox ID="txtPanelPhone" runat="server" CssClass="form-control" placeholder="Phone"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSavePanel" runat="server" Text="Save Panel Evaluator" CssClass="btn btn-primary fw-semibold" OnClick="btnSavePanel_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
