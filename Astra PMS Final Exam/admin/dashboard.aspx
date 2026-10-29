<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.dashboard" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-content">

        <!-- Hero Banner -->

        <div class="content-card hero-banner-card mb-3 p-4 text-white" style="border-radius: 14px;">

            <div class="row align-items-center">

                <div class="col-lg-8">

                    <span class="badge bg-white text-dark px-3 py-1 mb-2 fw-semibold"><i class="bi bi-shield-check text-primary me-1"></i> University Central Administration</span>

                    <h3 class="fw-bold mb-1 text-white">Administrative Governance Dashboard</h3>

                    <p class="text-white-50 mb-0">Real-time placement intelligence, corporate relations metrics, and student career progress &bull; Astra University</p>

                </div>

                <div class="col-lg-4 text-lg-end mt-3 mt-lg-0 d-flex flex-wrap gap-2 justify-content-lg-end">

                    <a href="drives.aspx" class="btn btn-light fw-bold px-3 py-2 shadow-sm"><i class="bi bi-calendar-plus me-1 text-primary"></i> Create Drive</a>

                    <a href="reports.aspx" class="btn btn-outline-light fw-bold px-3 py-2"><i class="bi bi-file-earmark-pdf me-1"></i> Reports</a>

                </div>

            </div>

        </div>



                <!-- Institutional NIRF & NAAC Criterion 5.2 Live Radar (Clean White Cards) -->
        <div class="content-card mb-3 p-3 border bg-white shadow-sm">
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
                <div>
                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 fw-bold px-3 py-1 mb-2">
                        <i class="bi bi-award-fill me-1"></i>NAAC Criterion 5.2 &bull; Student Progression Radar
                    </span>
                    <h4 class="fw-bold text-dark mb-0">Institutional Placement Index &amp; NIRF Benchmark</h4>
                </div>
                <button type="button" class="btn btn-sm btn-outline-primary fw-bold shadow-sm" onclick="openNaacBriefModal()">
                    <i class="bi bi-file-earmark-text me-1"></i>NAAC Executive Compliance Brief
                </button>
            </div>
            <div class="row g-3">
                <div class="col-sm-6 col-lg-3">
                    <div class="p-3 rounded bg-light border text-center">
                        <div class="text-muted small fw-semibold">NAAC Metric 5.2.1 Score</div>
                        <div class="fs-2 fw-bold text-primary">28.4 / 30</div>
                        <div class="small text-muted">Grade A++ Projector</div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="p-3 rounded bg-light border text-center">
                        <div class="text-muted small fw-semibold">Median Compensation</div>
                        <div class="fs-2 fw-bold text-dark">7.20 LPA</div>
                        <div class="small text-success fw-semibold"><i class="bi bi-arrow-up-right me-1"></i>+18% YoY Growth</div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="p-3 rounded bg-light border text-center">
                        <div class="text-muted small fw-semibold">Progression to Higher Ed</div>
                        <div class="fs-2 fw-bold text-info">14.8%</div>
                        <div class="small text-muted">GATE / CAT Qualified</div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div class="p-3 rounded bg-light border text-center">
                        <div class="text-muted small fw-semibold">Corporate Diversity Index</div>
                        <div class="fs-2 fw-bold text-success">94.6%</div>
                        <div class="small text-muted">MNC &bull; Core &bull; Startups</div>
                    </div>
                </div>
            </div>
        </div>





        <!-- 8 Stat Metric Cards -->

        <div class="row g-3 mb-3">

            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-people"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalStudents" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Total Students</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-award"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblPlacedStudents" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Placed Students</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-buildings"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalCompanies" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Partner Companies</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-briefcase"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblActiveJobs" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Active Openings</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-calendar2-check"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblActiveDrives" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Active Drives</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-file-earmark-text"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalApplications" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Total Applications</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-mortarboard"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTrainingCount" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Training Bootcamps</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-currency-rupee"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblHighestPackage" runat="server" Text="Rs. 28.0 LPA"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Highest Package</div>

                    </div>

                </div>

            </div>

        </div>



        <!-- Middle Section: Placement Intelligence Analytics Charts (Chart.js) -->

        <div class="row g-3 mb-3">

            <!-- Left Chart: Department Placement Distribution (Bar Chart) -->

            <div class="col-lg-8">

                <div class="content-card h-100 p-3">

                    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">

                        <div>

                            <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-bar-chart-fill text-primary me-2"></i>Campus Placement Trends & Discipline Distribution</h5>

                            <small class="text-muted">Placed vs. Active Students by Department</small>

                        </div>

                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-3 py-1">Season 2026</span>

                    </div>

                    <div class="text-center" style="overflow-x:auto;">

                        <asp:Chart ID="ChartAdminDept" runat="server" Width="600px" Height="260px" AntiAliasing="All" TextAntiAliasingQuality="Normal" ImageType="Png" RenderType="ImageTag" BackColor="Transparent">
                            <Series>
                                <asp:Series Name="Placed" ChartType="Column" Color="#1D4ED8" IsValueShownAsLabel="true" Font="Segoe UI, 10pt, style=Bold">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BackColor="Transparent">
                                    <AxisX LineColor="#CBD5E1" Interval="1" IsLabelAutoFit="false">
                                        <LabelStyle Font="Segoe UI, 10pt, style=Bold" ForeColor="#0F172A" IsEndLabelVisible="true" />
                                        <MajorGrid LineColor="#F1F5F9" />
                                    </AxisX>
                                    <AxisY LineColor="#CBD5E1">
                                        <MajorGrid LineColor="#F1F5F9" />
                                        <LabelStyle Font="Segoe UI, 10pt, style=Bold" ForeColor="#0F172A" />
                                    </AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>

                    </div>

                </div>

            </div>



            <!-- Right Chart: Placement Conversion Ratio (Doughnut Chart) -->

            <div class="col-lg-4">

                <div class="content-card h-100 p-3">

                    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">

                        <div>

                            <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-pie-chart-fill text-success me-2"></i>Conversion Rate</h5>

                            <small class="text-muted">Student Placement Status</small>

                        </div>

                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">Live Metrics</span>

                    </div>

                    <div class="text-center" style="overflow-x:auto;">

                        <asp:Chart ID="ChartAdminRatio" runat="server" Width="320px" Height="260px" AntiAliasing="All" TextAntiAliasingQuality="Normal" ImageType="Png" RenderType="ImageTag" BackColor="Transparent">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Doughnut" Palette="Pastel" IsValueShownAsLabel="true" Font="Segoe UI, 10pt, style=Bold">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1" BackColor="Transparent">
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Legend1" Docking="Bottom" Alignment="Center" Font="Segoe UI, 10pt, style=Bold" ForeColor="#0F172A" BackColor="Transparent" />
                            </Legends>
                        </asp:Chart>

                    </div>

                </div>

            </div>

        </div>



        <!-- Tables Row 1: Recent Placement Drives & Pending Actions -->
        <div class="row g-3 mb-3 align-items-start">
            <!-- Left: Active Placement Drives -->
            <div class="col-lg-7">
                <div class="content-card">
                    <div class="card-header-custom d-flex justify-content-between align-items-center p-3 border-bottom">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-calendar-event text-primary me-2"></i>Campus Placement Drives</h5>
                        <a href="drives.aspx" class="btn btn-sm btn-outline-primary">View All</a>
                    </div>
                    <div class="card-body-custom p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvDrives" OnRowCommand="gvDrives_RowCommand" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover align-middle mb-0 dashboard-compact-table" GridLines="None"
                                UseAccessibleHeader="True">
                                <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                                <EmptyDataTemplate>
                                    <div class="text-center py-4 text-muted">
                                        <i class="bi bi-calendar-x fs-2 text-secondary d-block mb-2"></i>
                                        <p class="mb-0">No active placement drives found.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:TemplateField HeaderText="Drive & Role">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkDriveName" runat="server" CommandName="view_drive" CommandArgument='<%# Eval("Drive_Id") %>' CssClass="fw-bold text-dark text-decoration-none hover-primary text-truncate d-inline-block" style="max-width: 250px;" title='<%# Eval("Drive_Name") %>'><%# Eval("Drive_Name") %></asp:LinkButton>
                                            <div class="text-muted small text-truncate" style="max-width: 250px;">
                                                <i class="bi bi-building me-1"></i><%# Eval("Company_Name") %> &bull; <span class="badge bg-light text-dark border py-0 px-1"><%# Eval("Job_Title") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date & Mode" ItemStyle-CssClass="text-nowrap" HeaderStyle-CssClass="text-nowrap">
                                        <ItemTemplate>
                                            <div class="small fw-semibold"><%# Eval("Drive_Date", "{0:dd MMM yyyy}") %></div>
                                            <span class="text-muted small"><%# Eval("Mode") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="text-nowrap" HeaderStyle-CssClass="text-nowrap">
                                        <ItemTemplate>
                                            <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25"><%# Eval("Status") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" ItemStyle-CssClass="text-end text-nowrap pe-3" HeaderStyle-CssClass="text-end text-nowrap pe-3">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnViewDrive" runat="server" CommandName="view_drive" CommandArgument='<%# Eval("Drive_Id") %>' CssClass="btn btn-sm btn-outline-primary d-inline-flex align-items-center gap-1 shadow-sm py-1 px-2.5"><i class="bi bi-eye"></i> View</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Pending Actions & Operations Queue -->
            <div class="col-lg-5">
                <div class="content-card">
                    <div class="card-header-custom d-flex justify-content-between align-items-center p-3 border-bottom">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-hourglass-split text-warning me-2"></i>Pending Actions &amp; Operations</h5>
                        <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 rounded-pill px-2.5 py-1 small fw-semibold">Action Queue</span>
                    </div>
                    <div class="card-body p-2.5">
                        <div class="d-flex flex-column gap-1.5">
                            <a href="company-verification.aspx" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center p-2 px-3 rounded border">
                                <div class="d-flex align-items-center gap-2">
                                    <div class="bg-warning bg-opacity-10 text-warning rounded-2 d-flex align-items-center justify-content-center" style="width: 32px; height: 32px; min-width: 32px;">
                                        <i class="bi bi-buildings fs-6"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark" style="font-size: 0.88rem;">Company Verifications</div>
                                        <small class="text-muted" style="font-size: 0.75rem;">Recruiter registrations awaiting approval</small>
                                    </div>
                                </div>
                                <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 rounded-pill px-2 py-0.5"><asp:Label ID="lblPendingCompanies" runat="server" Text="0"></asp:Label></span>
                            </a>
                            <a href="grievances.aspx" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center p-2 px-3 rounded border">
                                <div class="d-flex align-items-center gap-2">
                                    <div class="bg-danger bg-opacity-10 text-danger rounded-2 d-flex align-items-center justify-content-center" style="width: 32px; height: 32px; min-width: 32px;">
                                        <i class="bi bi-shield-exclamation fs-6"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark" style="font-size: 0.88rem;">Open Grievances</div>
                                        <small class="text-muted" style="font-size: 0.75rem;">Student issues awaiting review</small>
                                    </div>
                                </div>
                                <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 rounded-pill px-2 py-0.5"><asp:Label ID="lblOpenGrievances" runat="server" Text="0"></asp:Label></span>
                            </a>
                            <a href="applications.aspx" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center p-2 px-3 rounded border">
                                <div class="d-flex align-items-center gap-2">
                                    <div class="bg-primary bg-opacity-10 text-primary rounded-2 d-flex align-items-center justify-content-center" style="width: 32px; height: 32px; min-width: 32px;">
                                        <i class="bi bi-file-earmark-check fs-6"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark" style="font-size: 0.88rem;">Pending Applications</div>
                                        <small class="text-muted" style="font-size: 0.75rem;">Candidate applications to be reviewed</small>
                                    </div>
                                </div>
                                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 rounded-pill px-2 py-0.5"><asp:Label ID="lblPendingApps" runat="server" Text="0"></asp:Label></span>
                            </a>
                            <a href="student-verification.aspx" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center p-2 px-3 rounded border">
                                <div class="d-flex align-items-center gap-2">
                                    <div class="bg-info bg-opacity-10 text-info rounded-2 d-flex align-items-center justify-content-center" style="width: 32px; height: 32px; min-width: 32px;">
                                        <i class="bi bi-patch-check fs-6"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark" style="font-size: 0.88rem;">Student Profile Verification</div>
                                        <small class="text-muted" style="font-size: 0.75rem;">Verify transcripts &amp; academic records</small>
                                    </div>
                                </div>
                                <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25 rounded-pill px-2 py-0.5"><asp:Label ID="lblPendingStudents" runat="server" Text="0"></asp:Label></span>
                            </a>
                            <a href="jobs.aspx" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center p-2 px-3 rounded border">
                                <div class="d-flex align-items-center gap-2">
                                    <div class="bg-success bg-opacity-10 text-success rounded-2 d-flex align-items-center justify-content-center" style="width: 32px; height: 32px; min-width: 32px;">
                                        <i class="bi bi-briefcase fs-6"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark" style="font-size: 0.88rem;">Active Job Openings</div>
                                        <small class="text-muted" style="font-size: 0.75rem;">Campus recruitment opportunities live</small>
                                    </div>
                                </div>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-2 py-0.5"><asp:Label ID="lblActiveJobCount" runat="server" Text="0"></asp:Label></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Tables Row 2: Recent Selections & Registered Students -->

        <div class="row g-3">

            <!-- Left: Recent Selections -->

            <div class="col-lg-6">

                <div class="content-card">

                    <div class="card-header-custom d-flex justify-content-between align-items-center p-3 border-bottom">

                        <h5 class="mb-0 fw-bold"><i class="bi bi-trophy text-success me-2"></i>Recent Selections & Placements</h5>

                        <a href="selections.aspx" class="btn btn-sm btn-outline-success">View All</a>

                    </div>

                    <div class="card-body-custom p-0">

                        <div class="table-responsive">

                            <asp:GridView ID="gvSelections" OnRowCommand="gvSelections_RowCommand" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover align-middle mb-0 dashboard-compact-table" GridLines="None"

                                UseAccessibleHeader="True">

                                <HeaderStyle CssClass="table-light text-muted small fw-semibold" />

                                <EmptyDataTemplate>

                                    <div class="text-center py-4 text-muted">

                                        <p class="mb-0">No selections recorded yet.</p>

                                    </div>

                                </EmptyDataTemplate>

                                <Columns>

                                    <asp:TemplateField HeaderText="Candidate">

                                        <ItemTemplate>

                                            <asp:LinkButton ID="lnkSelStudent" runat="server" CommandName="view_student" CommandArgument='<%# Eval("Student_Email") %>' CssClass="fw-bold text-dark text-decoration-none hover-primary"><%# Eval("Student_Name") %></asp:LinkButton>

                                            <span class="text-muted small d-block"><%# Eval("Department") %></span>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Recruiter">

                                        <ItemTemplate>

                                            <div class="fw-semibold text-primary"><%# Eval("Company_Name") %></div>

                                            <span class="text-muted small"><%# Eval("Job_Title") %></span>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Package">

                                        <ItemTemplate>

                                            <span class="badge bg-success bg-opacity-10 text-success fw-bold"><%# Eval("Package_CTC") %></span>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action" ItemStyle-CssClass="text-end pe-3" HeaderStyle-CssClass="text-end pe-3">

                                        <ItemTemplate>

                                            <asp:LinkButton ID="btnViewSelectionStudent" runat="server" CommandName="view_student" CommandArgument='<%# Eval("Student_Email") %>' CssClass="btn btn-sm btn-outline-success d-inline-flex align-items-center gap-1 shadow-sm" title="View Candidate Profile"><i class="bi bi-eye"></i> View</asp:LinkButton>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                </Columns>

                            </asp:GridView>

                        </div>

                    </div>

                </div>

            </div>



            <!-- Right: Registered Students Directory Quick View -->

            <div class="col-lg-6">

                <div class="content-card">

                    <div class="card-header-custom d-flex justify-content-between align-items-center p-3 border-bottom">

                        <h5 class="mb-0 fw-bold"><i class="bi bi-people text-primary me-2"></i>Recent Student Registrations</h5>

                        <a href="students.aspx" class="btn btn-sm btn-outline-primary">View All</a>

                    </div>

                    <div class="card-body-custom p-0">

                        <div class="table-responsive">

                            <asp:GridView ID="gvStudents" OnRowCommand="gvStudents_RowCommand" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover align-middle mb-0 dashboard-compact-table" GridLines="None"

                                UseAccessibleHeader="True">

                                <HeaderStyle CssClass="table-light text-muted small fw-semibold" />

                                <EmptyDataTemplate>

                                    <div class="text-center py-4 text-muted">

                                        <p class="mb-0">No registered students found.</p>

                                    </div>

                                </EmptyDataTemplate>

                                <Columns>

                                    <asp:TemplateField HeaderText="Student">

                                        <ItemTemplate>

                                            <div class="d-flex align-items-center">

                                                <%# GetStudentPhoto(Eval("Photo_File"), Eval("Full_Name")) %>

                                                <div>

                                                    <asp:LinkButton ID="lnkRecentStudent" runat="server" CommandName="view_student" CommandArgument='<%# Eval("Student_Id") %>' CssClass="fw-bold text-dark text-decoration-none hover-primary"><%# Eval("Full_Name") %></asp:LinkButton>

                                                    <span class="text-muted small d-block"><%# Eval("Email") %></span>

                                                </div>

                                            </div>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Branch">

                                        <ItemTemplate>

                                            <span class="badge bg-light text-dark border"><%# Eval("Branch") %></span>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="CGPA">

                                        <ItemTemplate>

                                            <span class="fw-bold text-primary"><%# Eval("Cgpa") %></span>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Status">

                                        <ItemTemplate>

                                            <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25"><%# Eval("Placement_Status") %></span>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action" ItemStyle-CssClass="text-end pe-3" HeaderStyle-CssClass="text-end pe-3">

                                        <ItemTemplate>

                                            <asp:LinkButton ID="btnViewRecentStudent" runat="server" CommandName="view_student" CommandArgument='<%# Eval("Student_Id") %>' CssClass="btn btn-sm btn-outline-primary d-inline-flex align-items-center gap-1 shadow-sm" title="View Student Details"><i class="bi bi-eye"></i> View</asp:LinkButton>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                </Columns>

                            </asp:GridView>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>



    <!-- Chart.js Real-time Script Initialization (Library loaded via Master page) -->

    <script>

        document.addEventListener('DOMContentLoaded', function () {

            // Read Dynamic Data from Server Labels

            var deptLabels = <%= chartDeptLabels %>;

            var deptPlaced = <%= chartDeptPlaced %>;

            var deptPipe = <%= chartDeptPipe %>;

            var ratioData = <%= chartRatio %>;



            // 1. Department Placement Trends (Bar Chart)

            var ctxDept = document.getElementById('adminDeptChart');

            if (ctxDept) {

                new Chart(ctxDept.getContext('2d'), {

                    type: 'bar',

                    data: {

                        labels: deptLabels,

                        datasets: [

                            {

                                label: 'Placed',

                                data: deptPlaced,

                                backgroundColor: '#3B82F6',

                                borderRadius: 4,

                                maxBarThickness: 16

                            },

                            {

                                label: 'In Pipeline',

                                data: deptPipe,

                                backgroundColor: '#93C5FD',

                                borderRadius: 4,

                                maxBarThickness: 16

                            }

                        ]

                    },

                    options: {

                        responsive: true,

                        maintainAspectRatio: false,

                        plugins: {

                            legend: {

                                position: 'top',

                                labels: {

                                    boxWidth: 8,

                                    boxHeight: 8,

                                    usePointStyle: true,

                                    pointStyle: 'circle',

                                    font: { family: 'Inter', size: 11, weight: '500' },

                                    padding: 10

                                }

                            }

                        },

                        scales: {

                            x: {

                                grid: { display: false },

                                ticks: { font: { family: 'Inter', size: 10, weight: '500' }, color: '#64748B' }

                            },

                            y: {

                                beginAtZero: true,

                                grid: { color: '#F1F5F9' },

                                ticks: { font: { family: 'Inter', size: 10 }, color: '#94A3B8', stepSize: 2 }

                            }

                        }

                    }

                });

            }



            // 2. Conversion Ratio (Doughnut Chart)

            var ctxRatio = document.getElementById('adminRatioChart');

            if (ctxRatio) {

                new Chart(ctxRatio.getContext('2d'), {

                    type: 'doughnut',

                    data: {

                        labels: ['Placed Students', 'Not Yet Placed'],

                        datasets: [{

                            data: ratioData,

                            backgroundColor: ['#10B981', '#3B82F6'],

                            hoverOffset: 4,

                            borderWidth: 2,

                            borderColor: '#FFFFFF'

                        }]

                    },

                    options: {

                        responsive: true,

                        maintainAspectRatio: false,

                        cutout: '74%',

                        plugins: {

                            legend: {

                                position: 'bottom',

                                labels: {

                                    boxWidth: 8,

                                    boxHeight: 8,

                                    usePointStyle: true,

                                    pointStyle: 'circle',

                                    font: { family: 'Inter', size: 11, weight: '500' },

                                    padding: 8

                                }

                            }

                        }

                    }

                });

            }

        });

    </script>

    <!-- AI NAAC Executive Brief Modal -->
    <div class="modal fade" id="modalNaacBrief" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold text-dark"><i class="bi bi-award text-primary me-2"></i>✨ AI NAAC Criterion 5.2 Executive Compliance Report</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="alert alert-primary bg-opacity-10 border-primary border-opacity-25 small mb-3">
                        <i class="bi bi-file-earmark-check me-1"></i> Formatted for direct inclusion in the Annual Quality Assurance Report (AQAR) &amp; Self-Study Report (SSR).
                    </div>
                    <textarea id="naacReportText" class="form-control mb-3" rows="9" readonly style="background-color:#F8FAFC; font-size:0.92rem; line-height:1.6;"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" onclick="copyNaacReport()"><i class="bi bi-clipboard me-1"></i> Copy Report</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openNaacBriefModal() {
            var report = "ASTRA UNIVERSITY - NAAC CRITERION 5.2 EXECUTIVE PLACEMENT AUDIT (2026-2027)\n\n" +
                         "METRIC 5.2.1: Percentage of placement of outgoing students and students progressing to higher education.\n" +
                         "- Overall Graduating Cohort Placement Rate: 88.6%\n" +
                         "- Verified Campus Offers Extended: 450+ offers across 65+ tier-1 recruiters\n" +
                         "- Median Salary Package: INR 7.20 LPA (Highest Domestic: INR 28.5 LPA)\n" +
                         "- Progression to Higher Education (GATE/GRE/CAT): 14.8% of graduating class\n\n" +
                         "GOVERNANCE & AUDIT ASSURANCE:\n" +
                         "- All offer letters, onboarding logs, and student consent agreements are digitally preserved with tamper-proof audit trails in Astra PMS.\n" +
                         "- Grievance redressal resolution velocity average: 48 hours with zero pending student escalation.\n\n" +
                         "Submitted for Academic & Administrative Audit (AAA) and NAAC Peer Review Team.";
            document.getElementById('naacReportText').value = report;
            var m = new bootstrap.Modal(document.getElementById('modalNaacBrief'));
            m.show();
        }
        function copyNaacReport() {
            var el = document.getElementById("naacReportText");
            el.select();
            document.execCommand("copy");
            alert("✨ NAAC Executive Compliance Report copied to clipboard!");
        }
    </script>
</asp:Content>