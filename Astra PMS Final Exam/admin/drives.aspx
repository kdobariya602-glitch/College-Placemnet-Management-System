<%@ Page Title="Placement Drives" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="drives.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.drives" %>

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
                        <li class="breadcrumb-item active">Placement Drives</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Campus Placement Drives & Schedules</h3>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalCreateDrive"><i class="bi bi-calendar-plus me-1"></i> Schedule Placement Drive</button>
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

        <!-- Search & Filter Card -->
        <div class="content-card p-3 mb-4">
            <div class="row g-3 align-items-center">
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="bi bi-search"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by drive name, company or venue..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Text="All Drive Statuses" Value=""></asp:ListItem>
                        <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                        <asp:ListItem Text="Closed" Value="Closed"></asp:ListItem>
                        <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4 d-flex gap-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100 fw-semibold" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <!-- Drives Table Card -->
        <div class="content-card">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-calendar2-event text-primary me-2"></i>Scheduled Drives (<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>)</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvDrives" runat="server" AutoGenerateColumns="False"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvDrives_PageIndexChanging"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Drive_Id" OnRowCommand="gvDrives_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-calendar-x fs-1 text-secondary d-block mb-3"></i>
                                <h5>No Placement Drives Found</h5>
                                <p class="mb-0">There are no scheduled drives matching the selected criteria.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Drive & Company">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Drive_Name") %></div>
                                    <div class="text-muted small"><i class="bi bi-building me-1"></i><%# Eval("Company_Name") %> &bull; <%# Eval("Job_Title") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Date, Time & Venue">
                                <ItemTemplate>
                                    <div class="fw-semibold text-dark"><i class="bi bi-calendar-check me-1 text-primary"></i><%# FormatDriveDate(Eval("Drive_Date")) %> - <%# !string.IsNullOrEmpty(Eval("Drive_Time") as string) ? Eval("Drive_Time") : "10:00 AM" %></div>
                                    <div class="text-muted small"><i class="bi bi-geo-alt me-1"></i><%# Eval("Venue") %> (<%# Eval("Mode") %>)</div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Application Window">
                                <ItemTemplate>
                                    <span class="small text-muted"><i class="bi bi-calendar-range me-1 text-secondary"></i><%# FormatAppWindow(Eval("App_Opening"), Eval("App_Closing")) %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Status")) == "Open" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Convert.ToString(Eval("Status")) == "Completed" ? "badge bg-info bg-opacity-10 text-info border border-info border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25") %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnViewDrive" runat="server" CommandName="view_drive" CommandArgument='<%# Eval("Drive_Id") %>' CssClass="btn btn-sm btn-outline-primary" title="View Drive Pipeline"><i class="bi bi-eye"></i> Details</asp:LinkButton>
                                    <asp:LinkButton ID="btnToggleStatus" runat="server" CommandName="toggle_status" CommandArgument='<%# Eval("Drive_Id") %>' CssClass="btn btn-sm btn-outline-secondary" title="Toggle Open/Closed">
                                        <i class="bi bi-arrow-repeat"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDeleteDrive" runat="server" CommandName="delete_drive" CommandArgument='<%# Eval("Drive_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this placement drive?');" title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Create Drive -->
    <div class="modal fade" id="modalCreateDrive" tabindex="-1" aria-labelledby="modalCreateDriveLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalCreateDriveLabel"><i class="bi bi-calendar-plus text-primary me-2"></i>Schedule Campus Drive</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    
                    <!-- Dual Mode: AI Drive Drafter -->
                    <div class="p-3 mb-3 rounded" style="background: linear-gradient(135deg, #EFF6FF 0%, #F5F3FF 100%); border: 1px solid #BFDBFE;">
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <span class="fw-bold text-dark small"><i class="bi bi-stars text-primary me-1"></i>AI Drive Configuration & Instructions (Dual Mode)</span>
                            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 small">Gemini AI</span>
                        </div>
                        <div class="row g-2 align-items-center">
                            <div class="col-md-9">
                                <asp:TextBox ID="txtAdminAiDrivePrompt" runat="server" CssClass="form-control form-control-sm bg-white" placeholder="Enter Company/Drive Target (e.g. Microsoft India, Google Cloud, TCS Digital)..."></asp:TextBox>
                            </div>
                            <div class="col-md-3">
                                <asp:Button ID="btnAdminAiDraftDrive" runat="server" Text="? AI Auto-Draft" CssClass="btn btn-sm btn-primary w-100 fw-bold" OnClick="btnAdminAiDraftDrive_Click" CausesValidation="false" />
                            </div>
                        </div>
                        <div class="d-flex flex-wrap gap-2 mt-2">
                            <span class="text-muted" style="font-size:0.75rem;">Presets:</span>
                            <button type="button" class="btn btn-xs btn-white border px-2 py-0 text-dark" style="font-size:0.75rem;" onclick="setAdminDrivePrompt('Microsoft India University Campus Recruitment 2026');">Microsoft</button>
                            <button type="button" class="btn btn-xs btn-white border px-2 py-0 text-dark" style="font-size:0.75rem;" onclick="setAdminDrivePrompt('Google Cloud Associate Engineer & Solutions');">Google Cloud</button>
                            <button type="button" class="btn btn-xs btn-white border px-2 py-0 text-dark" style="font-size:0.75rem;" onclick="setAdminDrivePrompt('TCS National Qualifier Test (NQT) & Digital Engineering');">TCS NQT</button>
                            <button type="button" class="btn btn-xs btn-white border px-2 py-0 text-dark" style="font-size:0.75rem;" onclick="setAdminDrivePrompt('Accenture Advanced Technology Centers India');">Accenture ATCI</button>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Drive Title / Name *</label>
                            <asp:TextBox ID="txtNewDriveName" runat="server" CssClass="form-control" placeholder="e.g. Google India Campus Hiring 2026"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvd1" runat="server" ControlToValidate="txtNewDriveName" ValidationGroup="vgDrive" ErrorMessage="Drive name is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Company *</label>
                            <asp:DropDownList ID="ddlNewDriveCompany" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Role / Job Title *</label>
                            <asp:TextBox ID="txtNewDriveJobTitle" runat="server" CssClass="form-control" placeholder="e.g. Associate Software Engineer"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Placement Season</label>
                            <asp:DropDownList ID="ddlNewDriveSeason" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Drive Date *</label>
                            <asp:TextBox ID="txtNewDriveDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvd2" runat="server" ControlToValidate="txtNewDriveDate" ValidationGroup="vgDrive" ErrorMessage="Date is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Reporting Time</label>
                            <asp:TextBox ID="txtNewDriveTime" runat="server" CssClass="form-control" placeholder="e.g. 09:30 AM"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Mode</label>
                            <asp:DropDownList ID="ddlNewDriveMode" runat="server" CssClass="form-select">
                                <asp:ListItem Text="On-Campus" Value="On-Campus"></asp:ListItem>
                                <asp:ListItem Text="Online" Value="Online"></asp:ListItem>
                                <asp:ListItem Text="Hybrid" Value="Hybrid"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Campus Venue</label>
                            <asp:TextBox ID="txtNewDriveVenue" runat="server" CssClass="form-control" placeholder="e.g. Central Auditorium & Computer Labs"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Online Meeting Link (If any)</label>
                            <asp:TextBox ID="txtNewDriveLink" runat="server" CssClass="form-control" placeholder="https://meet.google.com/..."></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Application Opening Date</label>
                            <asp:TextBox ID="txtNewDriveOpenDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Application Closing Date</label>
                            <asp:TextBox ID="txtNewDriveCloseDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Special Instructions for Candidates</label>
                            <asp:TextBox ID="txtNewDriveInstructions" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Carry 2 printed copies of resume, College ID card, Formal attire mandatory..."></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveDrive" runat="server" Text="Schedule Placement Drive" CssClass="btn btn-primary fw-semibold" ValidationGroup="vgDrive" OnClick="btnSaveDrive_Click" />
                </div>
            </div>
        </div>
    </div>


    
    <script>
        function setAdminDrivePrompt(val) {
            var el = document.getElementById('<%= txtAdminAiDrivePrompt.ClientID %>');
            if (el) { el.value = val; el.focus(); }
        }
    </script>

</asp:Content>
