<%@ Page Title="User Management" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="User_Management.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.User_Management" %>

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
                        <li class="breadcrumb-item active">User Management</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">System User Accounts & Access Control</h3>
            </div>
            <div>
                <span class="badge bg-primary px-3 py-2 fs-6">
                    Total System Accounts: <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                </span>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="academic-masters.aspx"><i class="bi bi-diagram-3 me-1"></i> Academic Masters</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Placement_Configuration.aspx"><i class="bi bi-sliders2 me-1"></i> Placement Configuration</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="System_Settings.aspx"><i class="bi bi-sliders me-1"></i> System Settings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="User_Management.aspx"><i class="bi bi-person-lock me-1"></i> User Management</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="audit-logs.aspx"><i class="bi bi-journal-text me-1"></i> Audit Logs</a>
            </li>
        </ul>

        <!-- Role Filter Tabs -->
        <div class="mb-4">
            <div class="btn-group" role="group">
                <asp:Button ID="btnTabAll" runat="server" Text="All Accounts" CssClass="btn btn-primary fw-semibold" OnClick="btnTabAll_Click" />
                <asp:Button ID="btnTabStudents" runat="server" Text="Students" CssClass="btn btn-outline-primary fw-semibold" OnClick="btnTabStudents_Click" />
                <asp:Button ID="btnTabCompanies" runat="server" Text="Recruiters" CssClass="btn btn-outline-primary fw-semibold" OnClick="btnTabCompanies_Click" />
                <asp:Button ID="btnTabTpo" runat="server" Text="TPO Officers" CssClass="btn btn-outline-primary fw-semibold" OnClick="btnTabTpo_Click" />
                <asp:Button ID="btnTabAdmin" runat="server" Text="Administrators" CssClass="btn btn-outline-primary fw-semibold" OnClick="btnTabAdmin_Click" />
            </div>
        </div>

        <!-- Search Bar Card -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body p-3">
                <div class="row g-2 align-items-center">
                    <div class="col-md-6">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by Name or Email..."></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <asp:Button ID="btnSearch" runat="server" Text="Search Users" CssClass="btn btn-primary w-100 fw-semibold" OnClick="btnSearch_Click" />
                    </div>
                    <div class="col-md-3">
                        <asp:Button ID="btnReset" runat="server" Text="Reset Filters" CssClass="btn btn-outline-secondary w-100 fw-semibold" OnClick="btnReset_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Users GridView Card -->
        <div class="content-card">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-people-fill text-primary me-2"></i>Registered User Directory</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Email" OnRowCommand="gvUsers_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-people fs-1 text-muted d-block mb-3"></i>
                                <h5>No User Accounts Found</h5>
                                <p class="mb-0">No records match the selected filter criteria.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="User_Id" HeaderText="User ID" />

                            <asp:TemplateField HeaderText="Full Name & Email">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("User_Name") %></div>
                                    <span class="text-muted small"><i class="bi bi-envelope me-1"></i><%# Eval("Email") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Role" HeaderText="Role" />
                            <asp:BoundField DataField="Phone" HeaderText="Contact" />

                            <asp:TemplateField HeaderText="Account Status">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Status")) == "Active" || Convert.ToString(Eval("Status")) == "Verified" ? "badge bg-success" : "badge bg-warning text-dark" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnToggle" runat="server" Text='<%# Convert.ToString(Eval("Status")) == "Active" ? "Deactivate" : "Activate" %>' CommandName="toggle_status" CommandArgument='<%# Eval("Email") %>' CssClass='<%# Convert.ToString(Eval("Status")) == "Active" ? "btn btn-sm btn-outline-warning" : "btn btn-sm btn-outline-success" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
