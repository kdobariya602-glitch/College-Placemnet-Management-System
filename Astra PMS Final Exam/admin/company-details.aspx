<%@ Page Title="Company Details" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="company-details.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.company_details" %>

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
                        <li class="breadcrumb-item"><a href="companies.aspx">Company Management</a></li>
                        <li class="breadcrumb-item active">Company Profile</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Corporate Recruiter 360&deg; View</h3>
            </div>
            <div>
                <a href="companies.aspx" class="btn btn-outline-secondary fw-semibold"><i class="bi bi-arrow-left me-1"></i> Back to Directory</a>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="companies.aspx"><i class="bi bi-building me-1"></i> Partner Companies</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="company-verification.aspx"><i class="bi bi-shield-check me-1"></i> Company Verification</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- Company Overview Header Card -->
        <div class="content-card p-4 mb-4">
            <div class="row align-items-center">
                <div class="col-auto">
                    <div class="rounded-3 bg-light border p-3 text-center" style="width: 80px; height: 80px; display:flex; align-items:center; justify-content:center;">
                        <i class="bi bi-buildings fs-1 text-primary"></i>
                    </div>
                </div>
                <div class="col">
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <h4 class="fw-bold mb-0"><asp:Label ID="lblCompanyName" runat="server" Text="Company Name"></asp:Label></h4>
                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1"><asp:Label ID="lblVerificationStatus" runat="server" Text="Verified"></asp:Label></span>
                    </div>
                    <div class="text-muted mb-2 d-flex flex-wrap gap-3">
                        <span><i class="bi bi-tag me-1 text-primary"></i><asp:Label ID="lblIndustry" runat="server" Text="-"></asp:Label></span>
                        <span><i class="bi bi-geo-alt me-1 text-primary"></i><asp:Label ID="lblLocation" runat="server" Text="-"></asp:Label></span>
                        <span><i class="bi bi-envelope me-1 text-primary"></i><asp:Label ID="lblEmail" runat="server" Text="-"></asp:Label></span>
                        <span><i class="bi bi-telephone me-1 text-primary"></i><asp:Label ID="lblPhone" runat="server" Text="-"></asp:Label></span>
                    </div>
                    <div>
                        <a href="#" id="lnkWebsite" runat="server" target="_blank" class="small text-primary text-decoration-none fw-semibold"><i class="bi bi-link-45deg"></i> <asp:Literal ID="litWebsite" runat="server"></asp:Literal></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tabbed Information Sections -->
        <div class="content-card p-4">
            <ul class="nav nav-pills mb-4 border-bottom pb-3" id="companyTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-semibold" id="about-tab" data-bs-toggle="pill" data-bs-target="#about" type="button" role="tab"><i class="bi bi-info-circle me-1"></i> Corporate Details</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="jobs-tab" data-bs-toggle="pill" data-bs-target="#jobs" type="button" role="tab"><i class="bi bi-briefcase me-1"></i> Jobs Posted (<asp:Label ID="lblJobCount" runat="server" Text="0"></asp:Label>)</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="drives-tab" data-bs-toggle="pill" data-bs-target="#drives" type="button" role="tab"><i class="bi bi-calendar-event me-1"></i> Drives Conducted (<asp:Label ID="lblDriveCount" runat="server" Text="0"></asp:Label>)</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="selections-tab" data-bs-toggle="pill" data-bs-target="#selections" type="button" role="tab"><i class="bi bi-award me-1"></i> Selected Candidates</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold text-danger" id="admin-tab" data-bs-toggle="pill" data-bs-target="#adminControls" type="button" role="tab"><i class="bi bi-shield-lock me-1"></i> Verification & Status</button>
                </li>
            </ul>

            <div class="tab-content" id="companyTabsContent">
                <!-- Tab 1: About & Details -->
                <div class="tab-pane fade show active" id="about" role="tabpanel">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded-3 h-100">
                                <h6 class="fw-bold text-dark border-bottom pb-2 mb-3"><i class="bi bi-building text-primary me-2"></i>Corporate Profile</h6>
                                <div class="row g-2">
                                    <div class="col-5 text-muted">Company Type:</div>
                                    <div class="col-7 fw-semibold"><asp:Label ID="lblCompType" runat="server" Text="MNC / IT Services"></asp:Label></div>
                                    <div class="col-5 text-muted">Employee Strength:</div>
                                    <div class="col-7 fw-semibold"><asp:Label ID="lblEmpCount" runat="server" Text="10,000+"></asp:Label></div>
                                    <div class="col-5 text-muted">Partner Rating:</div>
                                    <div class="col-7 fw-semibold text-warning"><i class="bi bi-star-fill"></i> <asp:Label ID="lblRating" runat="server" Text="4.8"></asp:Label> / 5.0</div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded-3 h-100">
                                <h6 class="fw-bold text-dark border-bottom pb-2 mb-3"><i class="bi bi-person-badge text-primary me-2"></i>HR & Recruiter Contact</h6>
                                <div class="row g-2">
                                    <div class="col-4 text-muted">HR Lead:</div>
                                    <div class="col-8 fw-semibold"><asp:Label ID="lblHRName" runat="server" Text="-"></asp:Label></div>
                                    <div class="col-4 text-muted">Official Email:</div>
                                    <div class="col-8 fw-semibold"><asp:Label ID="lblHREmail" runat="server" Text="-"></asp:Label></div>
                                    <div class="col-4 text-muted">Official Phone:</div>
                                    <div class="col-8 fw-semibold"><asp:Label ID="lblHRPhone" runat="server" Text="-"></asp:Label></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="p-3 bg-light rounded-3">
                                <h6 class="fw-bold text-dark border-bottom pb-2 mb-3"><i class="bi bi-card-text text-primary me-2"></i>About Company & Recruitment History</h6>
                                <p class="mb-0 text-secondary"><asp:Label ID="lblDescription" runat="server" Text="No description provided."></asp:Label></p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tab 2: Jobs Posted -->
                <div class="tab-pane fade" id="jobs" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvJobs" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No jobs posted by this company yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Job Title">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Job_Title") %></div>
                                        <span class="text-muted small"><%# Eval("Job_Type") %> &bull; <%# Eval("Work_Mode") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Salary / CTC">
                                    <ItemTemplate>
                                        <span class="badge bg-success bg-opacity-10 text-success fw-bold"><%# Eval("Salary_CTC") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Eligibility">
                                    <ItemTemplate>
                                        <span class="small text-muted">Min CGPA: <%# Eval("Min_CGPA") %>, Backlogs: <%# Eval("Max_Backlogs") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-primary bg-opacity-10 text-primary"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 3: Drives Conducted -->
                <div class="tab-pane fade" id="drives" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvDrives" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No placement drives conducted yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Drive Name">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Drive_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Job_Title") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date & Venue">
                                    <ItemTemplate>
                                        <div class="small fw-semibold"><%# Eval("Drive_Date", "{0:dd MMM yyyy}") %></div>
                                        <span class="text-muted small"><%# Eval("Venue") %> (<%# Eval("Mode") %>)</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25"><%# Eval("Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 4: Selections Made -->
                <div class="tab-pane fade" id="selections" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvSelections" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No candidates selected yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Candidate">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Department") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Job & Package">
                                    <ItemTemplate>
                                        <div class="small fw-semibold"><%# Eval("Job_Title") %></div>
                                        <span class="badge bg-success bg-opacity-10 text-success fw-bold"><%# Eval("Package_CTC") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Offer & Joining">
                                    <ItemTemplate>
                                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25"><%# Eval("Offer_Status") %></span>
                                        <span class="badge bg-light text-dark border ms-1"><%# Eval("Joining_Status") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 5: Verification & Status Admin Actions -->
                <div class="tab-pane fade" id="adminControls" role="tabpanel">
                    <div class="row g-3 max-w-lg">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Verification Status</label>
                            <asp:DropDownList ID="ddlUpdateVerification" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Verified" Value="Verified"></asp:ListItem>
                                <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                <asp:ListItem Text="Correction Required" Value="Correction Required"></asp:ListItem>
                                <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Admin Remarks</label>
                            <asp:TextBox ID="txtAdminRemarks" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Remarks for this corporate partner..."></asp:TextBox>
                        </div>
                        <div class="col-12 mt-3">
                            <asp:Button ID="btnUpdateVerification" runat="server" Text="Save Verification Changes" CssClass="btn btn-primary fw-semibold" OnClick="btnUpdateVerification_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
