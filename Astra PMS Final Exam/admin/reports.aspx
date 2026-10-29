<%@ Page Title="Placement Reports & Analytics" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="reports.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @media print {
            .sidebar, .top-header, .btn-no-print, .breadcrumb, .filter-card {
                display: none !important;
            }
            .main-content {
                margin: 0 !important;
                padding: 0 !important;
            }
            .content-card {
                box-shadow: none !important;
                border: 1px solid #ccc !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <!-- Breadcrumb & Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="notices.aspx">Communication & Reports</a></li>
                        <li class="breadcrumb-item active">Reports & Analytics</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">University Placement Analytics & Reports</h3>
            </div>
            <div class="btn-no-print d-flex gap-2">
                <asp:Button ID="btnExportReportCsv" runat="server" Text="Export CSV" CssClass="btn btn-outline-primary" OnClick="btnExportReportCsv_Click" />
                <button type="button" class="btn btn-outline-secondary" onclick="window.print();"><i class="bi bi-printer me-1"></i> Print / Export PDF</button>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="notices.aspx"><i class="bi bi-megaphone me-1"></i> Notices</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="grievances.aspx"><i class="bi bi-exclamation-circle me-1"></i> Grievances</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="reports.aspx"><i class="bi bi-bar-chart me-1"></i> Placement Reports</a>
            </li>
        </ul>

        <!-- Filter Card -->
        <div class="card border-0 shadow-sm mb-4 filter-card">
            <div class="card-body-custom p-3">
                <div class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-muted">Department</label>
                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-muted">Batch / Year</label>
                        <asp:DropDownList ID="ddlBatch" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-muted">Placement Season</label>
                        <asp:DropDownList ID="ddlSeason" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <asp:Button ID="btnResetFilter" runat="server" Text="Reset Filters" CssClass="btn btn-sm btn-outline-secondary w-100" OnClick="btnResetFilter_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- KPI Metrics Header -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-mortarboard"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalStudents" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Total Registered</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-patch-check"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblPlacedStudents" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Placed Candidates (<asp:Label ID="lblPlacementPct" runat="server" Text="0%"></asp:Label>)</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-cash-stack"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblHighestPkg" runat="server" Text="0.00 LPA"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Highest Package</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-graph-up-arrow"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblAvgPkg" runat="server" Text="0.00 LPA"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Average Package</div>
                    </div>
                </div>
            </div>
        </div>

        
        <!-- Dual Mode: AI Institutional Placement Performance Audit & NAAC Criterion 5 -->
        <div class="content-card mb-4 p-4 border-0 shadow-sm" style="background: linear-gradient(135deg, #EFF6FF 0%, #F5F3FF 100%); border: 1.5px solid #BFDBFE !important;">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-3">
                <div class="d-flex align-items-center gap-2">
                    <span class="badge bg-primary px-2 py-1"><i class="bi bi-stars"></i> Gemini AI</span>
                    <h5 class="fw-bold mb-0 text-dark">AI Institutional Placement Audit & NAAC Criterion 5 Drafter</h5>
                </div>
                <div class="d-flex gap-2">
                    <asp:Button ID="btnGenerateAdminAiAudit" runat="server" Text="✨ Generate NAAC Placement Audit" CssClass="btn btn-primary fw-bold shadow-sm" OnClick="btnGenerateAdminAiAudit_Click" />
                </div>
            </div>
            <div id="divAdminAiAudit" runat="server" visible="false">
                <div class="p-3 bg-white rounded border mb-2">
                    <div class="d-flex justify-content-between align-items-center mb-2 pb-2 border-bottom">
                        <span class="fw-bold text-dark"><i class="bi bi-award text-primary me-2"></i>Astra University NAAC Criterion 5.2.1 Institutional Compliance Audit</span>
                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25">Accreditation Ready</span>
                    </div>
                    <div class="text-dark small" style="line-height:1.7;">
                        <asp:Literal ID="litAdminAiAuditContent" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
            <div id="divAdminAiAuditPlaceholder" runat="server" class="text-muted small">
                <i class="bi bi-info-circle me-1"></i> Generate a formal university-level accreditation audit narrative assessing student career progression, median packages, and industry MoUs powered by Gemini AI.
            </div>
        </div>

        <!-- Department Breakdown & Top Recruiters -->
        <div class="row g-4 mb-4">
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header-custom p-3 border-bottom">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-diagram-3 text-primary me-2"></i>Department-Wise Placement Performance</h5>
                    </div>
                    <div class="card-body-custom p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvDeptStats" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover align-middle mb-0" GridLines="None" UseAccessibleHeader="True">
                                <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                                <Columns>
                                    <asp:BoundField DataField="Department" HeaderText="Department" />
                                    <asp:BoundField DataField="Total" HeaderText="Total Enrolled" ItemStyle-CssClass="fw-semibold text-center" HeaderStyle-CssClass="text-center" />
                                    <asp:BoundField DataField="Placed" HeaderText="Placed" ItemStyle-CssClass="text-success fw-bold text-center" HeaderStyle-CssClass="text-center" />
                                    <asp:BoundField DataField="Unplaced" HeaderText="Unplaced" ItemStyle-CssClass="text-muted text-center" HeaderStyle-CssClass="text-center" />
                                    <asp:TemplateField HeaderText="Placement %" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                                        <ItemTemplate>
                                            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 fs-6"><%# Eval("Percentage") %>%</span>
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

            <div class="col-lg-5">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header-custom p-3 border-bottom">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-buildings text-primary me-2"></i>Top Hiring Partners</h5>
                    </div>
                    <div class="card-body-custom p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvTopCompanies" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover align-middle mb-0" GridLines="None" UseAccessibleHeader="True">
                                <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                                <Columns>
                                    <asp:BoundField DataField="Company_Name" HeaderText="Recruiter" />
                                    <asp:BoundField DataField="Selections" HeaderText="Total Hires" ItemStyle-CssClass="text-primary fw-bold text-center" HeaderStyle-CssClass="text-center" />
                                    <asp:TemplateField HeaderText="Top Package" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                                        <ItemTemplate>
                                            <span class="text-success fw-bold">â‚&#8377; <%# Eval("MaxPackage") %> LPA</span>
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

        <!-- Detailed Placement Register -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-journal-bookmark text-primary me-2"></i>Official University Placement Register</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvPlacements" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle mb-0" GridLines="None" UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-info-circle fs-1 text-primary d-block mb-3"></i>
                                <h5>No Placement Records Matched</h5>
                                <p class="mb-0">Try changing the filters above to view student placement records.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="Enrollment_No" HeaderText="Enrollment No" />
                            <asp:BoundField DataField="Student_Name" HeaderText="Candidate Name" ItemStyle-CssClass="fw-bold text-dark" />
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:BoundField DataField="Course" HeaderText="Course" />
                            <asp:BoundField DataField="Company_Name" HeaderText="Hiring Company" ItemStyle-CssClass="fw-semibold text-primary" />
                            <asp:BoundField DataField="Designation" HeaderText="Designation" />
                            <asp:TemplateField HeaderText="Package (LPA)">
                                <ItemTemplate>
                                    <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 fw-bold">â‚&#8377; <%# Eval("Package_LPA") %> LPA</span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Offer_Date" HeaderText="Offer Date" DataFormatString="{0:dd MMM yyyy}" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Status")) == "Joined" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

