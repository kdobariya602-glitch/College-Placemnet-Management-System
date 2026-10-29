<%@ Page Title="Placement Drive Details" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="drive-details.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.drive_details" %>

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
                        <li class="breadcrumb-item active">Drive Pipeline</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Placement Drive Pipeline & Command</h3>
            </div>
            <div>
                <a href="drives.aspx" class="btn btn-outline-secondary fw-semibold"><i class="bi bi-arrow-left me-1"></i> Back to Drives</a>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="drives.aspx"><i class="bi bi-calendar2-event me-1"></i> Placement Drives</a>
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
                <a class="nav-link" href="interviews.aspx"><i class="bi bi-chat-square-text me-1"></i> Interviews</a>
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

        <!-- Drive Info Card -->
        <div class="content-card p-4 mb-4">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <h4 class="fw-bold mb-0"><asp:Label ID="lblDriveName" runat="server" Text="Drive Name"></asp:Label></h4>
                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1"><asp:Label ID="lblStatus" runat="server" Text="Open"></asp:Label></span>
                    </div>
                    <div class="text-muted mb-2 d-flex flex-wrap gap-3">
                        <span><i class="bi bi-building me-1 text-primary"></i><strong>Company:</strong> <asp:Label ID="lblCompanyName" runat="server" Text="-"></asp:Label></span>
                        <span><i class="bi bi-briefcase me-1 text-primary"></i><strong>Role:</strong> <asp:Label ID="lblJobTitle" runat="server" Text="-"></asp:Label></span>
                        <span><i class="bi bi-trophy me-1 text-primary"></i><strong>Season:</strong> <asp:Label ID="lblSeason" runat="server" Text="-"></asp:Label></span>
                    </div>
                    <div class="text-secondary small d-flex flex-wrap gap-3">
                        <span><i class="bi bi-calendar-event me-1 text-primary"></i><asp:Label ID="lblDate" runat="server" Text="-"></asp:Label> at <asp:Label ID="lblTime" runat="server" Text="-"></asp:Label></span>
                        <span><i class="bi bi-geo-alt me-1 text-primary"></i><asp:Label ID="lblVenue" runat="server" Text="-"></asp:Label> (<asp:Label ID="lblMode" runat="server" Text="-"></asp:Label>)</span>
                    </div>
                </div>
                <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                    <div class="small text-muted mb-1">Application Window</div>
                    <div class="fw-bold text-dark"><asp:Label ID="lblWindow" runat="server" Text="-"></asp:Label></div>
                </div>
            </div>
        </div>

        <!-- 4 KPI Metrics -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-file-earmark-text"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblAppCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Total Applied</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-filter-circle"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblShortlistCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Shortlisted</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-person-video"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblInterviewCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Interviews</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-award"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblSelectCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Selected</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pipeline Data Tabs -->
        <div class="content-card p-4">
            <ul class="nav nav-pills mb-4 border-bottom pb-3" id="driveTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-semibold" id="apps-tab" data-bs-toggle="pill" data-bs-target="#apps" type="button" role="tab"><i class="bi bi-file-earmark-check me-1"></i> Applications (<asp:Label ID="lblTabAppCount" runat="server" Text="0"></asp:Label>)</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="shortlist-tab" data-bs-toggle="pill" data-bs-target="#shortlist" type="button" role="tab"><i class="bi bi-filter-circle me-1"></i> Shortlisted (<asp:Label ID="lblTabShortlistCount" runat="server" Text="0"></asp:Label>)</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="interviews-tab" data-bs-toggle="pill" data-bs-target="#interviews" type="button" role="tab"><i class="bi bi-person-video me-1"></i> Interviews (<asp:Label ID="lblTabInterviewCount" runat="server" Text="0"></asp:Label>)</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="selections-tab" data-bs-toggle="pill" data-bs-target="#selections" type="button" role="tab"><i class="bi bi-award me-1"></i> Final Selections (<asp:Label ID="lblTabSelectCount" runat="server" Text="0"></asp:Label>)</button>
                </li>
            </ul>

            <div class="tab-content" id="driveTabsContent">
                <!-- Tab 1: Applications -->
                <div class="tab-pane fade show active" id="apps" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvDriveApps" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            DataKeyNames="Application_Id" OnRowCommand="gvDriveApps_RowCommand"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No student applications received for this drive yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Candidate">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                        <div class="text-muted small"><i class="bi bi-card-text me-1"></i><%# Eval("Enrollment_No") %> &bull; <%# Eval("Department") %></div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CGPA">
                                    <ItemTemplate>
                                        <span class="badge bg-primary bg-opacity-10 text-primary fw-bold"><%# Eval("CGPA") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Applied Date">
                                    <ItemTemplate>
                                        <%# Eval("Applied_Date", "{0:dd MMM yyyy}") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnShortlist" runat="server" CommandName="shortlist" CommandArgument='<%# Eval("Application_Id") %>' CssClass="btn btn-sm btn-success fw-semibold me-1" title="Shortlist Candidate">
                                            <i class="bi bi-check-lg"></i> Shortlist
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnReject" runat="server" CommandName="reject" CommandArgument='<%# Eval("Application_Id") %>' CssClass="btn btn-sm btn-outline-danger" title="Reject Application">
                                            <i class="bi bi-x-lg"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 2: Shortlisted -->
                <div class="tab-pane fade" id="shortlist" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvShortlist" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No candidates shortlisted yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Candidate">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Student_Email") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CGPA">
                                    <ItemTemplate>
                                        <span class="badge bg-primary bg-opacity-10 text-primary fw-bold"><%# Eval("CGPA") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Shortlisted Date">
                                    <ItemTemplate>
                                        <%# Eval("Shortlisted_Date", "{0:dd MMM yyyy}") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 3: Interviews -->
                <div class="tab-pane fade" id="interviews" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvInterviews" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No interviews scheduled yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Candidate">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Student_Email") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Round & Time">
                                    <ItemTemplate>
                                        <div class="fw-semibold text-dark"><%# Eval("Round_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Interview_Date", "{0:dd MMM yyyy}") %> - <%# Eval("Interview_Time") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status & Result">
                                    <ItemTemplate>
                                        <span class="badge bg-secondary"><%# Eval("Status") %></span>
                                        <span class="badge bg-light text-dark border ms-1"><%# Eval("Result") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 4: Selections -->
                <div class="tab-pane fade" id="selections" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvSelections" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No final selections recorded yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Candidate">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Enrollment_No") %> &bull; <%# Eval("Department") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Offered Package">
                                    <ItemTemplate>
                                        <span class="badge bg-success bg-opacity-10 text-success fw-bold fs-6"><%# Eval("Package_CTC") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Offer & Joining">
                                    <ItemTemplate>
                                        <span class="badge bg-primary"><%# Eval("Offer_Status") %></span>
                                        <span class="badge bg-light text-dark border ms-1"><%# Eval("Joining_Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
