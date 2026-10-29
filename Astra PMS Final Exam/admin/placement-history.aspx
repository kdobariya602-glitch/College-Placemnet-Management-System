<%@ Page Title="Placement History & Archives" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="placement-history.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.placement_history" %>

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
                        <li class="breadcrumb-item active">Placement History</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">University Placement Archives & Records</h3>
            </div>
            <div class="mt-2 mt-md-0 d-flex gap-2">
                <button type="button" class="btn btn-outline-secondary" onclick="window.print();">
                    <i class="bi bi-printer me-1"></i> Print / Export
                </button>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAddHistory">
                    <i class="bi bi-plus-circle-fill me-1"></i> Add Archive Record
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
                <a class="nav-link" href="interviews.aspx"><i class="bi bi-chat-square-text me-1"></i> Interviews</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="selections.aspx"><i class="bi bi-award me-1"></i> Selections & Offers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="placement-history.aspx"><i class="bi bi-clock-history me-1"></i> Placement History</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- KPI Cards -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-primary bg-opacity-10 text-primary me-3">
                        <i class="bi bi-trophy fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Total Offers Archived</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litTotalHistory" runat="server">0</asp:Literal></h4>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-success bg-opacity-10 text-success me-3">
                        <i class="bi bi-cash-stack fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Highest Package</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litHighestCTC" runat="server">Rs. 0 LPA</asp:Literal></h4>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-warning bg-opacity-10 text-warning me-3">
                        <i class="bi bi-graph-up fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Average Package</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litAverageCTC" runat="server">Rs. 0 LPA</asp:Literal></h4>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-info bg-opacity-10 text-info me-3">
                        <i class="bi bi-building fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Hiring Partners</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litUniqueCompanies" runat="server">0</asp:Literal></h4>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter & Search Card -->
        <div class="content-card p-3 mb-4">
            <div class="row g-2 align-items-center">
                <div class="col-md-3">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search student, enrollment, company..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlFilterDept" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlFilterBatch" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Value="">All Joining Status</asp:ListItem>
                        <asp:ListItem Value="Joined">Joined</asp:ListItem>
                        <asp:ListItem Value="Offer Accepted">Offer Accepted</asp:ListItem>
                        <asp:ListItem Value="Pending Joining">Pending Joining</asp:ListItem>
                        <asp:ListItem Value="Declined">Declined</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3 d-flex gap-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Filter Records" CssClass="btn btn-sm btn-primary flex-grow-1" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <!-- History Records Table -->
        <div class="content-card p-4">
            <div class="table-responsive">
                <asp:GridView  UseAccessibleHeader="True" ID="gvHistory" runat="server" AutoGenerateColumns="false" CssClass="table table-hover align-middle mb-0"
                    DataKeyNames="History_Id" OnRowCommand="gvHistory_RowCommand" EmptyDataText="No placement history records found.">
                    <EmptyDataTemplate>
                        <div class="text-center py-5">
                            <i class="bi bi-archive text-muted display-4 d-block mb-3"></i>
                            <h5 class="text-secondary fw-semibold">No Placement Archives Found</h5>
                            <p class="text-muted small">Add previous academic year and batch placement records to build the historical repository.</p>
                        </div>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="History_Id" HeaderText="#" ItemStyle-CssClass="fw-bold text-muted small" />
                        
                        <asp:TemplateField HeaderText="Candidate">
                            <ItemTemplate>
                                <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                <div class="text-muted small"><i class="bi bi-person-badge me-1"></i><%# Eval("Enrollment_No") %> | <%# Eval("Student_Email") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Department & Batch">
                            <ItemTemplate>
                                <div class="fw-semibold text-secondary"><%# Eval("Department") %></div>
                                <div class="small text-muted"><%# Eval("Course") %> (Batch: <%# Eval("Batch") %>)</div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Hiring Company & Role">
                            <ItemTemplate>
                                <div class="fw-bold text-primary"><%# Eval("Company_Name") %></div>
                                <div class="small text-muted"><%# Eval("Job_Title") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Package (CTC)">
                            <ItemTemplate>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success fw-bold px-2 py-1">
                                    <i class="bi bi-currency-rupee me-1"></i><%# Eval("Package_CTC") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Selection & Joining">
                            <ItemTemplate>
                                <div class="small">Selected: <strong><%# FormatDate(Eval("Selection_Date")) %></strong></div>
                                <div class="small text-muted">Joining: <%# FormatDate(Eval("Joining_Date")) %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success px-2 py-1">
                                    <%# Eval("Joining_Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Academic Season">
                            <ItemTemplate>
                                <span class="badge bg-light text-dark border"><%# Eval("Academic_Year") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                            <ItemTemplate>
                                <div class="btn-group btn-group-sm">
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteRecord" CommandArgument='<%# Eval("History_Id") %>'
                                        CssClass="btn btn-outline-danger btn-icon" ToolTip="Delete Record"
                                        OnClientClick="return confirm('Are you sure you want to delete this historical record?');">
                                        <i class="bi bi-trash-fill"></i>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- Modal: Add Historical Placement Record -->
    <div class="modal fade" id="modalAddHistory" tabindex="-1" aria-labelledby="modalAddHistoryLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddHistoryLabel"><i class="bi bi-archive-fill text-primary me-2"></i> Archive New Placement Record</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Student Full Name *</label>
                            <asp:TextBox ID="txtAddStudentName" runat="server" CssClass="form-control" placeholder="e.g. Aarav Sharma"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Student Email Address</label>
                            <asp:TextBox ID="txtAddStudentEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="aarav.sharma@astra.edu"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Enrollment / Roll No *</label>
                            <asp:TextBox ID="txtAddEnrollment" runat="server" CssClass="form-control" placeholder="ASTRA2023CS042"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Department *</label>
                            <asp:DropDownList ID="ddlAddDept" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Course / Degree</label>
                            <asp:TextBox ID="txtAddCourse" runat="server" CssClass="form-control" placeholder="B.Tech Computer Science"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Graduation Batch *</label>
                            <asp:DropDownList ID="ddlAddBatch" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Hiring Company Name *</label>
                            <asp:TextBox ID="txtAddCompany" runat="server" CssClass="form-control" placeholder="Google / Microsoft / TCS"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Job Title / Designation *</label>
                            <asp:TextBox ID="txtAddJobTitle" runat="server" CssClass="form-control" placeholder="Software Development Engineer"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Package CTC (e.g. 14.5 LPA) *</label>
                            <asp:TextBox ID="txtAddPackage" runat="server" CssClass="form-control" placeholder="12.00 LPA"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Joining Status</label>
                            <asp:DropDownList ID="ddlAddJoiningStatus" runat="server" CssClass="form-select">
                                <asp:ListItem Value="Joined">Joined</asp:ListItem>
                                <asp:ListItem Value="Offer Accepted">Offer Accepted</asp:ListItem>
                                <asp:ListItem Value="Pending Joining">Pending Joining</asp:ListItem>
                                <asp:ListItem Value="Declined">Declined</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Academic Year</label>
                            <asp:TextBox ID="txtAddAcademicYear" runat="server" CssClass="form-control" placeholder="2025-2026"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Placement Season</label>
                            <asp:TextBox ID="txtAddSeason" runat="server" CssClass="form-control" placeholder="2025-26 Campus Drive"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnSaveHistory" runat="server" Text="Save Archive Record" CssClass="btn btn-primary" OnClick="btnSaveHistory_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
