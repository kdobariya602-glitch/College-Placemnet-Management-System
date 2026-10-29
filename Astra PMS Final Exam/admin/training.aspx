<%@ Page Title="Training & Bootcamps" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="training.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.training" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <!-- Breadcrumb & Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item active">Training</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Training Bootcamps & Attendance Command</h3>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalAddProgram"><i class="bi bi-plus-lg me-1"></i> New Program</button>
                <button type="button" class="btn btn-outline-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalAddSession"><i class="bi bi-calendar-plus me-1"></i> Add Session</button>
            </div>
        </div>

        <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="training.aspx"><i class="bi bi-mortarboard me-1"></i> Training Programs</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="ai-assistant.aspx"><i class="bi bi-robot me-1"></i> AI Admin Assistant</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="ai-grievance-triage.aspx"><i class="bi bi-life-preserver me-1"></i> AI Grievance Triage</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- Tab Navigation -->
        <div class="card border-0 shadow-sm p-4">
            <ul class="nav nav-pills mb-4 border-bottom pb-3" id="trainingTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-semibold" id="programs-tab" data-bs-toggle="pill" data-bs-target="#programs" type="button" role="tab"><i class="bi bi-mortarboard me-1"></i> Training Bootcamps</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="sessions-tab" data-bs-toggle="pill" data-bs-target="#sessions" type="button" role="tab"><i class="bi bi-clock-history me-1"></i> Sessions Schedule</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="participants-tab" data-bs-toggle="pill" data-bs-target="#participants" type="button" role="tab"><i class="bi bi-people me-1"></i> Enrolled Students & Attendance</button>
                </li>
            </ul>

            <div class="tab-content" id="trainingTabsContent">
                <!-- Tab 1: Training Programs -->
                <div class="tab-pane fade show active" id="programs" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvPrograms" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            DataKeyNames="Program_Id" OnRowCommand="gvPrograms_RowCommand"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <Columns>
                                <asp:TemplateField HeaderText="Bootcamp Program">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark fs-6"><%# Eval("Program_Name") %></div>
                                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25"><%# Eval("Category") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Trainer & Org">
                                    <ItemTemplate>
                                        <div class="fw-semibold text-dark"><%# Eval("Trainer_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Organization") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Timeline & Mode">
                                    <ItemTemplate>
                                        <div class="small fw-semibold"><%# Eval("Start_Date", "{0:dd MMM}") %> - <%# Eval("End_Date", "{0:dd MMM yyyy}") %></div>
                                        <span class="text-muted small"><%# Eval("Duration") %> &bull; <%# Eval("Mode") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='<%# Convert.ToString(Eval("Status")) == "Active" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25" %>'>
                                            <%# Eval("Status") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelProg" runat="server" CommandName="delete_program" CommandArgument='<%# Eval("Program_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this training program?');"><i class="bi bi-trash"></i></asp:LinkButton>
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

                <!-- Tab 2: Sessions -->
                <div class="tab-pane fade" id="sessions" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvSessions" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            DataKeyNames="Session_Id" OnRowCommand="gvSessions_RowCommand"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <Columns>
                                <asp:TemplateField HeaderText="Session Title">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Session_Title") %></div>
                                        <span class="text-muted small"><%# Eval("Topic") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date & Time">
                                    <ItemTemplate>
                                        <div class="fw-semibold"><%# Eval("Session_Date", "{0:dd MMM yyyy}") %></div>
                                        <span class="text-muted small"><%# Eval("Start_Time") %> - <%# Eval("End_Time") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Venue / Mode">
                                    <ItemTemplate>
                                        <span class="small text-dark"><%# Eval("Venue") %> (<%# Eval("Mode") %>)</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelSess" runat="server" CommandName="delete_session" CommandArgument='<%# Eval("Session_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete session?');"><i class="bi bi-trash"></i></asp:LinkButton>
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

                <!-- Tab 3: Enrolled Participants & Attendance -->
                <div class="tab-pane fade" id="participants" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvParticipants" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            DataKeyNames="Participant_Id" OnRowCommand="gvParticipants_RowCommand"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <Columns>
                                <asp:TemplateField HeaderText="Student">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Enrollment_No") %> &bull; <%# Eval("Department") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bootcamp Program">
                                    <ItemTemplate>
                                        <div class="fw-semibold text-primary"><%# Eval("Program_Name") %></div>
                                        <span class="text-muted small">Enrolled: <%# Eval("Reg_Date", "{0:dd MMM yyyy}") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Attendance %">
                                    <ItemTemplate>
                                        <span class="badge bg-success bg-opacity-10 text-success fw-bold fs-6"><%# Eval("Attendance_Pct") %>%</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25"><%# Eval("Completion_Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnMark100" runat="server" CommandName="mark_full" CommandArgument='<%# Eval("Participant_Id") %>' CssClass="btn btn-sm btn-outline-success" title="Mark 100% Attendance">
                                            <i class="bi bi-check2-circle"></i> 100%
                                        </asp:LinkButton>
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

    <!-- Modal Add Training Program -->
    <div class="modal fade" id="modalAddProgram" tabindex="-1" aria-labelledby="modalAddProgramLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddProgramLabel"><i class="bi bi-mortarboard text-primary me-2"></i>Create Training Bootcamp</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label class="form-label fw-semibold">Program Title *</label>
                            <asp:TextBox ID="txtNewProgName" runat="server" CssClass="form-control" placeholder="e.g. Full Stack Cloud Development Bootcamp"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Category</label>
                            <asp:DropDownList ID="ddlNewProgCategory" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Technical" Value="Technical"></asp:ListItem>
                                <asp:ListItem Text="Aptitude" Value="Aptitude"></asp:ListItem>
                                <asp:ListItem Text="Soft Skills" Value="Soft Skills"></asp:ListItem>
                                <asp:ListItem Text="Coding & DSA" Value="Coding"></asp:ListItem>
                                <asp:ListItem Text="Cybersecurity" Value="Cybersecurity"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Trainer / Instructor Name</label>
                            <asp:TextBox ID="txtNewProgTrainer" runat="server" CssClass="form-control" placeholder="Prof. / Industry Expert"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Training Organization</label>
                            <asp:TextBox ID="txtNewProgOrg" runat="server" CssClass="form-control" placeholder="Astra Tech Excellence Cell"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Start Date</label>
                            <asp:TextBox ID="txtNewProgStart" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">End Date</label>
                            <asp:TextBox ID="txtNewProgEnd" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Total Duration</label>
                            <asp:TextBox ID="txtNewProgDuration" runat="server" CssClass="form-control" placeholder="e.g. 40 Hours"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Description & Syllabus</label>
                            <asp:TextBox ID="txtNewProgDesc" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Bootcamp objectives..."></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveProgram" runat="server" Text="Create Bootcamp" CssClass="btn btn-primary fw-semibold" OnClick="btnSaveProgram_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Add Session -->
    <div class="modal fade" id="modalAddSession" tabindex="-1" aria-labelledby="modalAddSessionLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddSessionLabel"><i class="bi bi-calendar-plus text-primary me-2"></i>Add Training Session</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Bootcamp Program *</label>
                            <asp:DropDownList ID="ddlSessionProgram" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Session Title *</label>
                            <asp:TextBox ID="txtNewSessTitle" runat="server" CssClass="form-control" placeholder="e.g. Session 4: State Management & Views"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Session Date</label>
                            <asp:TextBox ID="txtNewSessDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Start Time</label>
                            <asp:TextBox ID="txtNewSessStart" runat="server" CssClass="form-control" placeholder="10:00 AM"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">End Time</label>
                            <asp:TextBox ID="txtNewSessEnd" runat="server" CssClass="form-control" placeholder="12:00 PM"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Topic Covered</label>
                            <asp:TextBox ID="txtNewSessTopic" runat="server" CssClass="form-control" placeholder="Key learning outcomes..."></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveSession" runat="server" Text="Save Session" CssClass="btn btn-primary fw-semibold" OnClick="btnSaveSession_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
