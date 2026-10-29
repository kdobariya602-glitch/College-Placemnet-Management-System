<%@ Page Title="Academic Master Data" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="academic-masters.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.academic_masters" %>

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
                        <li class="breadcrumb-item active">Academic Masters</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">University Academic Masters & Governance</h3>
            </div>
            <div>
                
            </div>
        </div>

        <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="academic-masters.aspx"><i class="bi bi-diagram-3 me-1"></i> Academic Masters</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Placement_Configuration.aspx"><i class="bi bi-sliders2 me-1"></i> Placement Configuration</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="System_Settings.aspx"><i class="bi bi-sliders me-1"></i> System Settings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="User_Management.aspx"><i class="bi bi-person-lock me-1"></i> User Management</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="audit-logs.aspx"><i class="bi bi-journal-text me-1"></i> Audit Logs</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- Tabbed Master Categories -->
        <div class="card border-0 shadow-sm p-4">
            <ul class="nav nav-pills mb-4 border-bottom pb-3" id="masterTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-semibold" id="depts-tab" data-bs-toggle="pill" data-bs-target="#depts" type="button" role="tab"><i class="bi bi-diagram-3 me-1"></i> Departments</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="courses-tab" data-bs-toggle="pill" data-bs-target="#courses" type="button" role="tab"><i class="bi bi-journal-bookmark me-1"></i> Courses</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="batches-tab" data-bs-toggle="pill" data-bs-target="#batches" type="button" role="tab"><i class="bi bi-people me-1"></i> Batches</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="years-tab" data-bs-toggle="pill" data-bs-target="#years" type="button" role="tab"><i class="bi bi-calendar3 me-1"></i> Academic Years</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="seasons-tab" data-bs-toggle="pill" data-bs-target="#seasons" type="button" role="tab"><i class="bi bi-trophy me-1"></i> Placement Seasons</button>
                </li>
            </ul>

            <div class="tab-content" id="masterTabsContent">
                <!-- Tab 1: Departments -->
                <div class="tab-pane fade show active" id="depts" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-dark mb-0">Academic Departments</h5>
                        <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="collapse" data-bs-target="#collapseAddDept"><i class="bi bi-plus-circle me-1"></i> Add Department</button>
                    </div>

                    <div class="collapse mb-4" id="collapseAddDept">
                        <div class="p-3 bg-light rounded-3 border">
                            <h6 class="fw-bold text-primary mb-3">Create New Department</h6>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Department Name *</label>
                                    <asp:TextBox ID="txtDeptName" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. Artificial Intelligence & Data Science"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Department Code *</label>
                                    <asp:TextBox ID="txtDeptCode" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. AIDS"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">HOD Name</label>
                                    <asp:TextBox ID="txtDeptHOD" runat="server" CssClass="form-control form-control-sm" placeholder="Dr. Name"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">HOD Email</label>
                                    <asp:TextBox ID="txtDeptEmail" runat="server" CssClass="form-control form-control-sm" placeholder="hod@astra.edu.in"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">HOD Phone</label>
                                    <asp:TextBox ID="txtDeptPhone" runat="server" CssClass="form-control form-control-sm" placeholder="Mobile Number"></asp:TextBox>
                                </div>
                                <div class="col-12 text-end">
                                    <asp:Button ID="btnAddDept" runat="server" Text="Save Department" CssClass="btn btn-sm btn-primary fw-semibold" OnClick="btnAddDept_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <asp:GridView ID="gvDepts" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None" DataKeyNames="Dept_Id" OnRowCommand="gvDepts_RowCommand" UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <Columns>
                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Dept_Name") %></div>
                                        <span class="badge bg-light text-dark border">Code: <%# Eval("Dept_Code") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="HOD Details">
                                    <ItemTemplate>
                                        <div class="small fw-semibold"><%# Eval("HOD_Name") %></div>
                                        <span class="text-muted small"><%# Eval("HOD_Email") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelDept" runat="server" CommandName="delete_dept" CommandArgument='<%# Eval("Dept_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this department?');"><i class="bi bi-trash"></i></asp:LinkButton>
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

                <!-- Tab 2: Courses -->
                <div class="tab-pane fade" id="courses" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-dark mb-0">Academic Courses & Degrees</h5>
                        <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="collapse" data-bs-target="#collapseAddCourse"><i class="bi bi-plus-circle me-1"></i> Add Course</button>
                    </div>

                    <div class="collapse mb-4" id="collapseAddCourse">
                        <div class="p-3 bg-light rounded-3 border">
                            <h6 class="fw-bold text-primary mb-3">Create New Course</h6>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Course Title *</label>
                                    <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. B.Tech in Artificial Intelligence"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Course Code *</label>
                                    <asp:TextBox ID="txtCourseCode" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. BTECH-AI"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Department *</label>
                                    <asp:DropDownList ID="ddlCourseDept" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Degree Level</label>
                                    <asp:DropDownList ID="ddlDegreeLevel" runat="server" CssClass="form-select form-select-sm">
                                        <asp:ListItem Text="Undergraduate (UG)" Value="Undergraduate"></asp:ListItem>
                                        <asp:ListItem Text="Postgraduate (PG)" Value="Postgraduate"></asp:ListItem>
                                        <asp:ListItem Text="Doctorate (PhD)" Value="Doctorate"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Duration</label>
                                    <asp:TextBox ID="txtCourseDuration" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. 4 Years"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small fw-semibold">Total Semesters</label>
                                    <asp:TextBox ID="txtCourseSemCount" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. 8"></asp:TextBox>
                                </div>
                                <div class="col-12 text-end">
                                    <asp:Button ID="btnAddCourse" runat="server" Text="Save Course" CssClass="btn btn-sm btn-primary fw-semibold" OnClick="btnAddCourse_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None" DataKeyNames="Course_Id" OnRowCommand="gvCourses_RowCommand" UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <Columns>
                                <asp:TemplateField HeaderText="Course">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Course_Name") %></div>
                                        <span class="badge bg-light text-dark border">Code: <%# Eval("Course_Code") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Department & Degree">
                                    <ItemTemplate>
                                        <div class="small fw-semibold"><%# Eval("Dept_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Degree_Level") %> (<%# Eval("Duration_Years") %>)</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelCourse" runat="server" CommandName="delete_course" CommandArgument='<%# Eval("Course_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this course?');"><i class="bi bi-trash"></i></asp:LinkButton>
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

                <!-- Tab 3: Batches -->
                <div class="tab-pane fade" id="batches" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-dark mb-0">Graduating & Active Batches</h5>
                        <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="collapse" data-bs-target="#collapseAddBatch"><i class="bi bi-plus-circle me-1"></i> Add Batch</button>
                    </div>

                    <div class="collapse mb-4" id="collapseAddBatch">
                        <div class="p-3 bg-light rounded-3 border">
                            <h6 class="fw-bold text-primary mb-3">Create New Batch</h6>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Batch Name *</label>
                                    <asp:TextBox ID="txtBatchName" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. 2023-2027 CSE Batch"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Start Year</label>
                                    <asp:TextBox ID="txtBatchStartYear" runat="server" CssClass="form-control form-control-sm" placeholder="2023"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Graduation Year</label>
                                    <asp:TextBox ID="txtBatchEndYear" runat="server" CssClass="form-control form-control-sm" placeholder="2027"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Coordinator Name</label>
                                    <asp:TextBox ID="txtBatchCoord" runat="server" CssClass="form-control form-control-sm" placeholder="Prof. Name"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Intake Capacity</label>
                                    <asp:TextBox ID="txtBatchIntake" runat="server" CssClass="form-control form-control-sm" placeholder="120"></asp:TextBox>
                                </div>
                                <div class="col-12 text-end">
                                    <asp:Button ID="btnAddBatch" runat="server" Text="Save Batch" CssClass="btn btn-sm btn-primary fw-semibold" OnClick="btnAddBatch_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <asp:GridView ID="gvBatches" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None" DataKeyNames="Batch_Id" OnRowCommand="gvBatches_RowCommand" UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <Columns>
                                <asp:TemplateField HeaderText="Batch Name">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Batch_Name") %></div>
                                        <span class="text-muted small">Years: <%# Eval("Start_Year") %> - <%# Eval("End_Year") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Coordinator & Intake">
                                    <ItemTemplate>
                                        <div class="small fw-semibold"><%# Eval("Coordinator_Name") %></div>
                                        <span class="text-muted small">Intake: <%# Eval("Intake") %> Seats</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelBatch" runat="server" CommandName="delete_batch" CommandArgument='<%# Eval("Batch_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this batch?');"><i class="bi bi-trash"></i></asp:LinkButton>
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

                <!-- Tab 4: Academic Years -->
                <div class="tab-pane fade" id="years" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-dark mb-0">Academic Years</h5>
                        <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="collapse" data-bs-target="#collapseAddYear"><i class="bi bi-plus-circle me-1"></i> Add Academic Year</button>
                    </div>

                    <div class="collapse mb-4" id="collapseAddYear">
                        <div class="p-3 bg-light rounded-3 border">
                            <h6 class="fw-bold text-primary mb-3">Create Academic Year</h6>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Year Label *</label>
                                    <asp:TextBox ID="txtYearName" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. 2027-28"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Start Date</label>
                                    <asp:TextBox ID="txtYearStart" runat="server" TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">End Date</label>
                                    <asp:TextBox ID="txtYearEnd" runat="server" TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-12 text-end">
                                    <asp:Button ID="btnAddYear" runat="server" Text="Save Academic Year" CssClass="btn btn-sm btn-primary fw-semibold" OnClick="btnAddYear_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <asp:GridView ID="gvYears" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None" DataKeyNames="Year_Id" OnRowCommand="gvYears_RowCommand" UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <Columns>
                                <asp:TemplateField HeaderText="Academic Year">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Year_Name") %></div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Period">
                                    <ItemTemplate>
                                        <span class="text-muted small"><%# Eval("Start_Date", "{0:dd MMM yyyy}") %> to <%# Eval("End_Date", "{0:dd MMM yyyy}") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Current Status">
                                    <ItemTemplate>
                                        <span class='<%# Convert.ToInt32(Eval("Is_Current")) == 1 ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25" %>'>
                                            <%# Convert.ToInt32(Eval("Is_Current")) == 1 ? "Active Current Year" : "Archived" %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSetCurrent" runat="server" CommandName="set_current" CommandArgument='<%# Eval("Year_Id") %>' CssClass="btn btn-sm btn-outline-primary" title="Set as Current Active Year"><i class="bi bi-check-circle"></i> Set Current</asp:LinkButton>
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

                <!-- Tab 5: Placement Seasons -->
                <div class="tab-pane fade" id="seasons" role="tabpanel">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold text-dark mb-0">Placement Seasons</h5>
                        <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="collapse" data-bs-target="#collapseAddSeason"><i class="bi bi-plus-circle me-1"></i> Add Season</button>
                    </div>

                    <div class="collapse mb-4" id="collapseAddSeason">
                        <div class="p-3 bg-light rounded-3 border">
                            <h6 class="fw-bold text-primary mb-3">Create Placement Season</h6>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-semibold">Season Name *</label>
                                    <asp:TextBox ID="txtSeasonName" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. 2027-28 Placement Season"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">Start Date</label>
                                    <asp:TextBox ID="txtSeasonStart" runat="server" TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-semibold">End Date</label>
                                    <asp:TextBox ID="txtSeasonEnd" runat="server" TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-12">
                                    <label class="form-label small fw-semibold">Description</label>
                                    <asp:TextBox ID="txtSeasonDesc" runat="server" CssClass="form-control form-control-sm" placeholder="Season objectives and scope"></asp:TextBox>
                                </div>
                                <div class="col-12 text-end">
                                    <asp:Button ID="btnAddSeason" runat="server" Text="Save Placement Season" CssClass="btn btn-sm btn-primary fw-semibold" OnClick="btnAddSeason_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <asp:GridView ID="gvSeasons" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None" DataKeyNames="Season_Id" OnRowCommand="gvSeasons_RowCommand" UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <Columns>
                                <asp:TemplateField HeaderText="Season Name">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Season_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Description") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Dates">
                                    <ItemTemplate>
                                        <span class="small text-muted"><%# Eval("Start_Date", "{0:dd MMM yyyy}") %> - <%# Eval("End_Date", "{0:dd MMM yyyy}") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='<%# Convert.ToString(Eval("Status")) == "Active" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25" %>'><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelSeason" runat="server" CommandName="delete_season" CommandArgument='<%# Eval("Season_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this placement season?');"><i class="bi bi-trash"></i></asp:LinkButton>
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

    <!-- AI Academic Skill Matrix Modal -->
    <div style="display:none;" id="modalAiMatrix" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold text-dark"><i class="bi bi-stars text-primary me-2"></i>✨ AI Departmental Skill Matrix Standardizer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="alert alert-primary bg-opacity-10 border-primary border-opacity-25 small mb-3">
                        <i class="bi bi-diagram-3 me-1"></i> Industry-aligned competency mappings calibrated for NAAC Criterion 5 and NBA Accreditation.
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded border">
                                <span class="badge bg-primary mb-2">Computer Science &amp; IT</span>
                                <div class="fw-semibold text-dark">Enterprise Core Competencies</div>
                                <div class="small text-muted">Data Structures, Relational Schema, Cloud Architecture (AWS/Azure), REST APIs, Git &amp; CI/CD Pipelines.</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded border">
                                <span class="badge bg-success mb-2">Electronics &amp; Communication</span>
                                <div class="fw-semibold text-dark">Hardware &amp; Embedded Systems</div>
                                <div class="small text-muted">Embedded C, Microcontrollers (ARM/ESP32), IoT Protocols (MQTT), Signal Processing, VLSI design fundamentals.</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openAiSkillMatrixModal() {
            var m = new bootstrap.Modal(document.getElementById('modalAiMatrix'));
            m.show();
        }
    </script>
</asp:Content>
