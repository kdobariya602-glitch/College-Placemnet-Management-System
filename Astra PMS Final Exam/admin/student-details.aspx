<%@ Page Title="Student 360 Profile" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="student-details.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.student_details" %>

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
                        <li class="breadcrumb-item"><a href="students.aspx">People Management</a></li>
                        <li class="breadcrumb-item active">Student Profile</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Student 360&deg; Comprehensive Profile</h3>
            </div>
            <div>
                <a href="students.aspx" class="btn btn-outline-secondary fw-semibold"><i class="bi bi-arrow-left me-1"></i> Back to Roster</a>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="students.aspx"><i class="bi bi-person-lines-fill me-1"></i> Students Directory</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="student-verification.aspx"><i class="bi bi-patch-check me-1"></i> Student Verification</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-tpo.aspx"><i class="bi bi-person-badge me-1"></i> TPO Management</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- Top Overview Card -->
        <div class="content-card p-4 mb-4">
            <div class="row align-items-center">
                <div class="col-auto">
                    <div class="rounded-circle overflow-hidden border shadow-sm d-flex align-items-center justify-content-center bg-primary text-white" style="width: 84px; height: 84px; min-width: 84px;">
                        <asp:Literal ID="litStudentInitials" runat="server" Text="ST"></asp:Literal>
                    </div>
                </div>
                <div class="col">
                    <h4 class="fw-bold mb-1"><asp:Label ID="lblFullName" runat="server" Text="Student Name"></asp:Label></h4>
                    <div class="text-muted mb-2 d-flex flex-wrap gap-3">
                        <span><i class="bi bi-card-text me-1 text-primary"></i><strong>Enrollment:</strong> <asp:Label ID="lblEnrollment" runat="server" Text="-"></asp:Label></span>
                        <span><i class="bi bi-envelope me-1 text-primary"></i><asp:Label ID="lblEmail" runat="server" Text="-"></asp:Label></span>
                        <span><i class="bi bi-telephone me-1 text-primary"></i><asp:Label ID="lblPhone" runat="server" Text="-"></asp:Label></span>
                    </div>
                    <div class="d-flex flex-wrap gap-2">
                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1"><asp:Label ID="lblBranch" runat="server" Text="-"></asp:Label></span>
                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">CGPA: <asp:Label ID="lblCgpa" runat="server" Text="-"></asp:Label></span>
                        <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25 px-2 py-1">Batch: <asp:Label ID="lblGradYear" runat="server" Text="-"></asp:Label></span>
                        <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-2 py-1"><asp:Label ID="lblPlacementStatus" runat="server" Text="-"></asp:Label></span>
                    </div>
                    <div class="mt-3">
                        <asp:HyperLink ID="lnkResumeDownload" runat="server" Target="_blank" CssClass="btn btn-sm btn-outline-primary fw-semibold"><i class="bi bi-file-earmark-pdf me-1"></i> View / Download ATS Resume</asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tabbed Information Sections -->
        <div class="content-card p-4">
            <ul class="nav nav-pills mb-4 border-bottom pb-3" id="profileTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-semibold" id="personal-tab" data-bs-toggle="pill" data-bs-target="#personal" type="button" role="tab"><i class="bi bi-person me-1"></i> Personal & Academics</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="apps-tab" data-bs-toggle="pill" data-bs-target="#apps" type="button" role="tab"><i class="bi bi-file-earmark-check me-1"></i> Applications (<asp:Label ID="lblAppCount" runat="server" Text="0"></asp:Label>)</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="interviews-tab" data-bs-toggle="pill" data-bs-target="#interviews" type="button" role="tab"><i class="bi bi-person-video me-1"></i> Interviews (<asp:Label ID="lblInterviewCount" runat="server" Text="0"></asp:Label>)</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="training-tab" data-bs-toggle="pill" data-bs-target="#training" type="button" role="tab"><i class="bi bi-mortarboard me-1"></i> Training & Attendance</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="docs-tab" data-bs-toggle="pill" data-bs-target="#docs" type="button" role="tab"><i class="bi bi-patch-check me-1"></i> Verified Documents (<asp:Label ID="lblDocsCount" runat="server" Text="0"></asp:Label>)</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold text-danger" id="admin-tab" data-bs-toggle="pill" data-bs-target="#adminActions" type="button" role="tab"><i class="bi bi-shield-lock me-1"></i> Admin Controls</button>
                </li>
            </ul>

            <div class="tab-content" id="profileTabsContent">
                <!-- Tab 1: Personal & Academics -->
                <div class="tab-pane fade show active" id="personal" role="tabpanel">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded-3 h-100">
                                <h6 class="fw-bold text-dark border-bottom pb-2 mb-3"><i class="bi bi-mortarboard text-primary me-2"></i>Academic Metrics</h6>
                                <div class="row g-2">
                                    <div class="col-6 text-muted">Current CGPA:</div>
                                    <div class="col-6 fw-bold text-primary"><asp:Label ID="lblCgpaDetail" runat="server" Text="-"></asp:Label></div>
                                    <div class="col-6 text-muted">10th Standard %:</div>
                                    <div class="col-6 fw-semibold"><asp:Label ID="lblTenth" runat="server" Text="-"></asp:Label>%</div>
                                    <div class="col-6 text-muted">12th Standard %:</div>
                                    <div class="col-6 fw-semibold"><asp:Label ID="lblTwelfth" runat="server" Text="-"></asp:Label>%</div>
                                    <div class="col-6 text-muted">Diploma %:</div>
                                    <div class="col-6 fw-semibold"><asp:Label ID="lblDiploma" runat="server" Text="N/A"></asp:Label></div>
                                    <div class="col-6 text-muted">Active Backlogs:</div>
                                    <div class="col-6 fw-semibold text-danger"><asp:Label ID="lblActiveBacklogs" runat="server" Text="0"></asp:Label></div>
                                    <div class="col-6 text-muted">Total History Backlogs:</div>
                                    <div class="col-6 fw-semibold"><asp:Label ID="lblTotalBacklogs" runat="server" Text="0"></asp:Label></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded-3 h-100">
                                <h6 class="fw-bold text-dark border-bottom pb-2 mb-3"><i class="bi bi-geo-alt text-primary me-2"></i>Personal & Contact Details</h6>
                                <div class="row g-2">
                                    <div class="col-4 text-muted">Gender:</div>
                                    <div class="col-8 fw-semibold"><asp:Label ID="lblGender" runat="server" Text="-"></asp:Label></div>
                                    <div class="col-4 text-muted">Date of Birth:</div>
                                    <div class="col-8 fw-semibold"><asp:Label ID="lblDob" runat="server" Text="-"></asp:Label></div>
                                    <div class="col-4 text-muted">Address:</div>
                                    <div class="col-8 fw-semibold"><asp:Label ID="lblAddress" runat="server" Text="-"></asp:Label></div>
                                    <div class="col-4 text-muted">City / State:</div>
                                    <div class="col-8 fw-semibold"><asp:Label ID="lblCityState" runat="server" Text="-"></asp:Label></div>
                                    <div class="col-4 text-muted">Pincode:</div>
                                    <div class="col-8 fw-semibold"><asp:Label ID="lblPincode" runat="server" Text="-"></asp:Label></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="p-3 bg-light rounded-3">
                                <h6 class="fw-bold text-dark border-bottom pb-2 mb-3"><i class="bi bi-stars text-warning me-2"></i>Technical Skills & Domain Expertise</h6>
                                <p class="mb-0"><asp:Label ID="lblSkills" runat="server" Text="No skills listed yet." CssClass="fw-semibold text-dark"></asp:Label></p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tab 2: Applications Pipeline -->
                <div class="tab-pane fade" id="apps" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvStudentApps" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No applications submitted by this student yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Job / Company">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Job_Title") %></div>
                                        <span class="text-muted small"><i class="bi bi-building me-1"></i><%# Eval("Company_Name") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Applied Date">
                                    <ItemTemplate>
                                        <%# Eval("Applied_Date", "{0:dd MMM yyyy}") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <span class="small text-muted"><%# Eval("Remarks") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 3: Interviews Scheduled -->
                <div class="tab-pane fade" id="interviews" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvStudentInterviews" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No interview rounds scheduled yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Company & Round">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Company_Name") %></div>
                                        <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25"><%# Eval("Round_Name") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Schedule & Mode">
                                    <ItemTemplate>
                                        <div class="fw-semibold"><%# Eval("Interview_Date", "{0:dd MMM yyyy}") %> - <%# Eval("Interview_Time") %></div>
                                        <span class="text-muted small"><%# Eval("Mode") %> (<%# Eval("Venue") %>)</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Result / Status">
                                    <ItemTemplate>
                                        <span class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 4: Training & Attendance -->
                <div class="tab-pane fade" id="training" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvStudentTraining" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No training program enrollments found.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Training Program">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Program_Name") %></div>
                                        <span class="text-muted small">Registered: <%# Eval("Reg_Date", "{0:dd MMM yyyy}") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Attendance %">
                                    <ItemTemplate>
                                        <span class="fw-bold text-success"><%# Eval("Attendance_Pct") %>%</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Completion Status">
                                    <ItemTemplate>
                                        <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25"><%# Eval("Completion_Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab: Verified Credentials & Documents -->
                <div class="tab-pane fade" id="docs" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold mb-0 text-dark"><i class="bi bi-shield-check text-primary me-2"></i>Institutional Credential Verification</h6>
                        <a href="student-verification.aspx" class="btn btn-sm btn-outline-primary"><i class="bi bi-patch-check me-1"></i>Open Central Verification Desk</a>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvStudentDocs" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None" UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No academic documents or certificates submitted by this student yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:BoundField DataField="Document_Type" HeaderText="Type" ItemStyle-CssClass="fw-semibold text-dark" />
                                <asp:BoundField DataField="Document_Name" HeaderText="Document Name" />
                                <asp:BoundField DataField="Upload_Date" HeaderText="Submitted" DataFormatString="{0:dd MMM yyyy}" />
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='<%# Eval("Verification_Status") != null && Convert.ToString(Eval("Verification_Status")) == "Verified" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Eval("Verification_Status") != null && Convert.ToString(Eval("Verification_Status")) == "Rejected" ? "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25" : "badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25") %>'>
                                            <%# Eval("Verification_Status") ?? "Pending" %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Verified_By" HeaderText="Verified By" ItemStyle-CssClass="small text-muted" />
                                <asp:TemplateField HeaderText="Action" ItemStyle-CssClass="text-end pe-3">
                                    <ItemTemplate>
                                        <a href='<%# GetSafeResumeUrl(Eval("File_Path") != null ? Convert.ToString(Eval("File_Path")) : "") %>' target="_blank" class="btn btn-sm btn-outline-primary" title="View Document">
                                            <i class="bi bi-eye"></i> View
                                        </a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 5: Admin Controls -->
                <div class="tab-pane fade" id="adminActions" role="tabpanel">
                    <div class="row g-3 max-w-lg">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Update Placement Status</label>
                            <asp:DropDownList ID="ddlUpdatePlacementStatus" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Seeking Placement" Value="Seeking Placement"></asp:ListItem>
                                <asp:ListItem Text="Placed" Value="Placed"></asp:ListItem>
                                <asp:ListItem Text="Higher Studies" Value="Higher Studies"></asp:ListItem>
                                <asp:ListItem Text="Opted Out" Value="Opted Out"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Account Status</label>
                            <asp:DropDownList ID="ddlUpdateAccountStatus" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12 mt-3">
                            <asp:Button ID="btnUpdateStudentStatus" runat="server" Text="Save Status Changes" CssClass="btn btn-primary fw-semibold" OnClick="btnUpdateStudentStatus_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
