<%@ Page Title="Company Directory" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="companies.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.companies" %>

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
                        <li class="breadcrumb-item active">Company Directory</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Corporate Partner Directory</h3>
            </div>
            <div class="d-flex gap-2">
                <asp:Button ID="btnExportCompaniesCsv" runat="server" Text="Export Companies (CSV)" CssClass="btn btn-outline-success fw-semibold" OnClick="btnExportCompaniesCsv_Click" />
                <button type="button" class="btn btn-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalAddCompany"><i class="bi bi-building-add me-1"></i> Add Partner Company</button>
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

        <!-- Search & Filter Card -->
        <div class="card border-0 shadow-sm p-3 mb-4">
            <div class="row g-3 align-items-center">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="bi bi-search"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by company name, location or email..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlIndustryFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Text="All Industries" Value=""></asp:ListItem>
                        <asp:ListItem Text="Technology / IT" Value="Technology / IT"></asp:ListItem>
                        <asp:ListItem Text="Software & Cloud" Value="Software & Cloud"></asp:ListItem>
                        <asp:ListItem Text="IT & Consulting" Value="IT & Consulting"></asp:ListItem>
                        <asp:ListItem Text="Core Engineering" Value="Core Engineering"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlVerificationFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Text="All Verification Statuses" Value=""></asp:ListItem>
                        <asp:ListItem Text="Verified" Value="Verified"></asp:ListItem>
                        <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                        <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100 fw-semibold" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <!-- Companies Table Card -->
        <div class="card border-0 shadow-sm">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-buildings text-primary me-2"></i>Recruiter Directory (<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>)</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvCompanies" runat="server" AutoGenerateColumns="False"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvCompanies_PageIndexChanging"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Company_Id" OnRowCommand="gvCompanies_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-buildings fs-1 text-secondary d-block mb-3"></i>
                                <h5>No Companies Found</h5>
                                <p class="mb-0">There are currently no partner companies matching the selected filter.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Company">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Company_Name") %></div>
                                    <div class="text-muted small"><i class="bi bi-tag me-1"></i><%# Eval("Industry") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Contact & Location">
                                <ItemTemplate>
                                    <div class="small"><i class="bi bi-envelope me-1 text-secondary"></i><%# Eval("Email") %></div>
                                    <div class="text-muted small"><i class="bi bi-geo-alt me-1 text-secondary"></i><%# Eval("Location") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Website">
                                <ItemTemplate>
                                    <a href='<%# Eval("Website") %>' target="_blank" class="small text-primary text-decoration-none">
                                        <i class="bi bi-link-45deg"></i> <%# Eval("Website") %>
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Verification Status">
                                <ItemTemplate>
                                    <span class='<%# Eval("Verification_Status") != null && Convert.ToString(Eval("Verification_Status")) == "Verified" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25" %>'>
                                        <%# Eval("Verification_Status") == null || Eval("Verification_Status") == DBNull.Value || string.IsNullOrEmpty(Convert.ToString(Eval("Verification_Status"))) ? "Pending" : Convert.ToString(Eval("Verification_Status")) %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <div class="btn-group btn-group-sm">
                                        <asp:LinkButton ID="btnViewCompany" runat="server" CommandName="view_company" CommandArgument='<%# Eval("Company_Id") %>' CssClass="btn btn-outline-primary fw-semibold" title="View Details"><i class="bi bi-eye"></i> View</asp:LinkButton>
                                        <asp:LinkButton ID="btnApprove" runat="server" CommandName="approve_company" CommandArgument='<%# Eval("Company_Id") %>' CssClass="btn btn-outline-success" title="Approve Verification">
                                            <i class="bi bi-check-circle"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="delete_company" CommandArgument='<%# Eval("Company_Id") %>' CssClass="btn btn-outline-danger" OnClientClick="return confirm('Remove this company?');" title="Delete">
                                            <i class="bi bi-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Add Company -->
    <div class="modal fade" id="modalAddCompany" tabindex="-1" aria-labelledby="modalAddCompanyLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddCompanyLabel"><i class="bi bi-building-add text-primary me-2"></i>Register Corporate Partner</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Company Name *</label>
                            <asp:TextBox ID="txtNewCompName" runat="server" CssClass="form-control" placeholder="e.g. Infosys Ltd"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvc1" runat="server" ControlToValidate="txtNewCompName" ValidationGroup="vgComp" ErrorMessage="Company name is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Official HR / Corporate Email *</label>
                            <asp:TextBox ID="txtNewCompEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="hr@company.com"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvc2" runat="server" ControlToValidate="txtNewCompEmail" ValidationGroup="vgComp" ErrorMessage="Email is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Account Password *</label>
                            <asp:TextBox ID="txtNewCompPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvc3" runat="server" ControlToValidate="txtNewCompPass" ValidationGroup="vgComp" ErrorMessage="Password is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Contact Number *</label>
                            <asp:TextBox ID="txtNewCompPhone" runat="server" CssClass="form-control" placeholder="Official phone number"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvc4" runat="server" ControlToValidate="txtNewCompPhone" ValidationGroup="vgComp" ErrorMessage="Phone is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Industry Domain *</label>
                            <asp:DropDownList ID="ddlNewCompIndustry" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Technology / IT Services" Value="Technology / IT"></asp:ListItem>
                                <asp:ListItem Text="Software Development & Cloud" Value="Software & Cloud"></asp:ListItem>
                                <asp:ListItem Text="Consulting & Analytics" Value="IT & Consulting"></asp:ListItem>
                                <asp:ListItem Text="Core Engineering & Manufacturing" Value="Core Engineering"></asp:ListItem>
                                <asp:ListItem Text="Banking, Financial Services & Insurance (BFSI)" Value="BFSI"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Corporate Location *</label>
                            <asp:TextBox ID="txtNewCompLoc" runat="server" CssClass="form-control" placeholder="e.g. Bangalore / Ahmedabad, India"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Company Website URL</label>
                            <asp:TextBox ID="txtNewCompWeb" runat="server" CssClass="form-control" placeholder="https://www.company.com"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">HR Contact Person Name</label>
                            <asp:TextBox ID="txtNewCompHR" runat="server" CssClass="form-control" placeholder="Lead Campus Recruiter"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Company Overview / Description</label>
                            <asp:TextBox ID="txtNewCompDesc" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="Company profile and campus recruitment focus..."></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveCompany" runat="server" Text="Register & Verify Company" CssClass="btn btn-primary fw-semibold" ValidationGroup="vgComp" OnClick="btnSaveCompany_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
