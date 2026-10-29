<%@ Page Title="Manage TPO Officers" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="manage-tpo.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.manage_tpo" %>

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
                        <li class="breadcrumb-item active">TPO Management</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Manage TPO Officers & Coordinators</h3>
            </div>
            <div class="mt-2 mt-md-0">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAddTpo">
                    <i class="bi bi-person-plus-fill me-1"></i> Add New TPO Officer
                </button>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="students.aspx"><i class="bi bi-person-lines-fill me-1"></i> Students Directory</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="student-verification.aspx"><i class="bi bi-patch-check me-1"></i> Student Verification</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="manage-tpo.aspx"><i class="bi bi-person-badge me-1"></i> TPO Management</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- KPI Summary Cards -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-primary bg-opacity-10 text-primary me-3">
                        <i class="bi bi-person-badge fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Total Officers</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litTotalTpo" runat="server">0</asp:Literal></h4>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-success bg-opacity-10 text-success me-3">
                        <i class="bi bi-person-check fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Active Officers</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litActiveTpo" runat="server">0</asp:Literal></h4>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-warning bg-opacity-10 text-warning me-3">
                        <i class="bi bi-diagram-3 fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Depts Covered</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litDeptsCovered" runat="server">0</asp:Literal></h4>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-info bg-opacity-10 text-info me-3">
                        <i class="bi bi-shield-check fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Inactive Officers</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litHeadTpo" runat="server">0</asp:Literal></h4>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter & Search Card -->
        <div class="content-card p-3 mb-4">
            <div class="row g-2 align-items-center">
                <div class="col-md-5">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name, email, designation..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlFilterDept" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Value="">All Departments</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Value="">All Statuses</asp:ListItem>
                        <asp:ListItem Value="Active">Active</asp:ListItem>
                        <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-sm btn-primary flex-grow-1" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <!-- TPO GridView Table -->
        <div class="content-card p-4">
            <div class="table-responsive">
                <asp:GridView  UseAccessibleHeader="True" ID="gvTpo" runat="server" AutoGenerateColumns="false" CssClass="table table-hover align-middle mb-0"
                    DataKeyNames="Tpo_Id" OnRowCommand="gvTpo_RowCommand" EmptyDataText="No TPO officers found matching the criteria.">
                    <EmptyDataTemplate>
                        <div class="text-center py-5">
                            <i class="bi bi-people text-muted display-4 d-block mb-3"></i>
                            <h5 class="text-secondary fw-semibold">No TPO Officers Found</h5>
                            <p class="text-muted small">Click "Add New TPO Officer" above to register coordinators for campus placement governance.</p>
                        </div>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="Tpo_Id" HeaderText="#" ItemStyle-CssClass="fw-bold text-muted small" />
                        
                        <asp:TemplateField HeaderText="Officer Name">
                            <ItemTemplate>
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm rounded-circle bg-primary bg-opacity-10 text-primary fw-bold d-flex align-items-center justify-content-center me-2" style="width: 36px; height: 36px;">
                                        <i class="bi bi-person-fill"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark"><%# Eval("Full_Name") %></div>
                                        <div class="text-muted small"><i class="bi bi-envelope me-1"></i><%# Eval("Email") %></div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Designation" HeaderText="Designation" ItemStyle-CssClass="fw-semibold text-secondary" />
                        <asp:BoundField DataField="Department" HeaderText="Department Assigned" ItemStyle-CssClass="small" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" ItemStyle-CssClass="small text-muted" />

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# Convert.ToString(Eval("Status")) == "Active" ? "badge bg-success bg-opacity-10 text-success border border-success" : "badge bg-danger bg-opacity-10 text-danger border border-danger" %> px-2 py-1'>
                                    <i class='<%# Convert.ToString(Eval("Status")) == "Active" ? "bi bi-check-circle-fill me-1" : "bi bi-x-circle-fill me-1" %>'></i>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Last Login">
                            <ItemTemplate>
                                <span class="small text-muted">
                                    <%# Eval("Last_Login") != DBNull.Value ? Convert.ToDateTime(Eval("Last_Login")).ToString("dd MMM yyyy, hh:mm tt") : "Never Logged In" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                            <ItemTemplate>
                                <div class="btn-group btn-group-sm">
                                    <asp:LinkButton ID="btnToggleStatus" runat="server" CommandName="ToggleStatus" CommandArgument='<%# Eval("Tpo_Id") %>'
                                        CssClass='<%# Convert.ToString(Eval("Status")) == "Active" ? "btn btn-outline-warning btn-icon" : "btn btn-outline-success btn-icon" %>'
                                        ToolTip='<%# Convert.ToString(Eval("Status")) == "Active" ? "Deactivate Officer" : "Activate Officer" %>'>
                                        <i class='<%# Convert.ToString(Eval("Status")) == "Active" ? "bi bi-pause-fill" : "bi bi-play-fill" %>'></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnResetPass" runat="server" CommandName="ResetPassword" CommandArgument='<%# Eval("Tpo_Id") %>'
                                        CssClass="btn btn-outline-info btn-icon" ToolTip="Reset Password to Default (Astra@123)">
                                        <i class="bi bi-key-fill"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteTpo" CommandArgument='<%# Eval("Tpo_Id") %>'
                                        CssClass="btn btn-outline-danger btn-icon" ToolTip="Delete Officer"
                                        OnClientClick="return confirm('Are you sure you want to delete this TPO officer account?');">
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

    <!-- Modal: Add New TPO Officer -->
    <div class="modal fade" id="modalAddTpo" tabindex="-1" aria-labelledby="modalAddTpoLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddTpoLabel"><i class="bi bi-person-plus-fill text-primary me-2"></i> Register New TPO Officer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Full Name *</label>
                            <asp:TextBox ID="txtAddFullName" runat="server" CssClass="form-control" placeholder="Prof. Rajesh Kumar"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Official Email Address *</label>
                            <asp:TextBox ID="txtAddEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="rajesh.tpo@university.edu"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Password *</label>
                            <asp:TextBox ID="txtAddPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Minimum 6 characters"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Mobile / Phone Number *</label>
                            <asp:TextBox ID="txtAddPhone" runat="server" CssClass="form-control" placeholder="+91 98765 43210"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Designation *</label>
                            <asp:DropDownList ID="ddlAddDesignation" runat="server" CssClass="form-select">
                                <asp:ListItem Value="Head - Training & Placement">Head - Training & Placement</asp:ListItem>
                                <asp:ListItem Value="Training & Placement Officer">Training & Placement Officer</asp:ListItem>
                                <asp:ListItem Value="Assistant Placement Officer">Assistant Placement Officer</asp:ListItem>
                                <asp:ListItem Value="Departmental Placement Coordinator">Departmental Placement Coordinator</asp:ListItem>
                                <asp:ListItem Value="Corporate Relations Manager">Corporate Relations Manager</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold">Assigned Department</label>
                            <asp:DropDownList ID="ddlAddDepartment" runat="server" CssClass="form-select">
                                <asp:ListItem Value="All Departments">All Departments (Central)</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12">
                            <div class="form-check form-switch mt-2">
                                <asp:CheckBox ID="chkAddActive" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label small fw-semibold" for="<%= chkAddActive.ClientID %>">Activate officer account immediately</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnSaveTpo" runat="server" Text="Create Officer Account" CssClass="btn btn-primary" OnClick="btnSaveTpo_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
