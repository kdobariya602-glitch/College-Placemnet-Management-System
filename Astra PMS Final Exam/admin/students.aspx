<%@ Page Title="Student Directory" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="students.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.students" %>

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
                        <li class="breadcrumb-item active">Students</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Student Directory & Academic Roster</h3>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalAddStudent"><i class="bi bi-person-plus me-1"></i> Register Student</button>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="students.aspx"><i class="bi bi-person-lines-fill me-1"></i> Students Directory</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="student-verification.aspx"><i class="bi bi-patch-check me-1"></i> Student Verification</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-tpo.aspx"><i class="bi bi-person-badge me-1"></i> TPO Management</a>
            </li>
        </ul>

        <!-- Feedback Alert -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- Search & Filter Card -->
        <div class="content-card p-3 mb-4">
            <div class="row g-3 align-items-center">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="bi bi-search"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name, enrollment or email..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlBranchFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Text="All Departments" Value=""></asp:ListItem>
                        <asp:ListItem Text="Computer Science & Engineering" Value="Computer Science & Engineering"></asp:ListItem>
                        <asp:ListItem Text="Information Technology" Value="Information Technology"></asp:ListItem>
                        <asp:ListItem Text="Electronics & Communication" Value="Electronics & Communication"></asp:ListItem>
                        <asp:ListItem Text="Mechanical Engineering" Value="Mechanical Engineering"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Text="All Placement Statuses" Value=""></asp:ListItem>
                        <asp:ListItem Text="Seeking Placement" Value="Seeking Placement"></asp:ListItem>
                        <asp:ListItem Text="Placed" Value="Placed"></asp:ListItem>
                        <asp:ListItem Text="Higher Studies" Value="Higher Studies"></asp:ListItem>
                        <asp:ListItem Text="Opted Out" Value="Opted Out"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100 fw-semibold" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <!-- Student Data Table Card -->
        <div class="content-card">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-people text-primary me-2"></i>Students Roster (<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>)</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvStudents_PageIndexChanging"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Student_Id" OnRowCommand="gvStudents_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-people fs-1 text-secondary d-block mb-3"></i>
                                <h5>No Students Found</h5>
                                <p class="mb-0">There are currently no students matching the filter criteria.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Student Info">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark"><%# Eval("Full_Name") %></div>
                                    <div class="text-muted small"><i class="bi bi-card-text me-1"></i><%# Eval("Enrollment_No") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Contact">
                                <ItemTemplate>
                                    <div class="small"><i class="bi bi-envelope me-1 text-secondary"></i><%# Eval("Email") %></div>
                                    <div class="text-muted small"><i class="bi bi-telephone me-1 text-secondary"></i><%# Eval("Phone") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Branch & Batch">
                                <ItemTemplate>
                                    <div class="fw-semibold text-dark"><%# Eval("Branch") %></div>
                                    <div class="text-muted small">Batch: <%# Eval("Graduation_Year") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="CGPA">
                                <ItemTemplate>
                                    <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 fw-bold px-2 py-1"><%# Eval("Cgpa") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Placement Status">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Placement_Status")) == "Placed" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25" %>'>
                                        <%# Eval("Placement_Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Account">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Account_Status")) == "Active" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25" %>'>
                                        <%# Eval("Account_Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <div class="btn-group btn-group-sm">
                                        <asp:LinkButton ID="btnViewStudent" runat="server" CommandName="view_student" CommandArgument='<%# Eval("Student_Id") %>' CssClass="btn btn-outline-primary fw-semibold" title="View 360 Profile"><i class="bi bi-eye"></i> View</asp:LinkButton>
                                        <asp:LinkButton ID="btnToggle" runat="server" CommandName="toggle_status" CommandArgument='<%# Eval("Student_Id") %>' CssClass="btn btn-outline-secondary" title="Toggle Active/Inactive">
                                            <i class="bi bi-arrow-repeat"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="delete_student" CommandArgument='<%# Eval("Student_Id") %>' CssClass="btn btn-outline-danger" OnClientClick="return confirm('Are you sure you want to remove this student record?');" title="Delete">
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

    <!-- Modal Add Student -->
    <div class="modal fade" id="modalAddStudent" tabindex="-1" aria-labelledby="modalAddStudentLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddStudentLabel"><i class="bi bi-person-plus text-primary me-2"></i>Register New Student</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Full Name *</label>
                            <asp:TextBox ID="txtNewName" runat="server" CssClass="form-control" placeholder="e.g. Rahul Sharma"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="txtNewName" ValidationGroup="vgAdd" ErrorMessage="Full name is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Enrollment Number *</label>
                            <asp:TextBox ID="txtNewEnroll" runat="server" CssClass="form-control" placeholder="e.g. ASTRA2022CSE099"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="txtNewEnroll" ValidationGroup="vgAdd" ErrorMessage="Enrollment number is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Email Address *</label>
                            <asp:TextBox ID="txtNewEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="student@rku.ac.in"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv3" runat="server" ControlToValidate="txtNewEmail" ValidationGroup="vgAdd" ErrorMessage="Email is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Password *</label>
                            <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv4" runat="server" ControlToValidate="txtNewPass" ValidationGroup="vgAdd" ErrorMessage="Password is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Phone Number *</label>
                            <asp:TextBox ID="txtNewPhone" runat="server" CssClass="form-control" placeholder="10-digit mobile"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv5" runat="server" ControlToValidate="txtNewPhone" ValidationGroup="vgAdd" ErrorMessage="Phone is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Department / Branch *</label>
                            <asp:DropDownList ID="ddlNewBranch" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Computer Science & Engineering" Value="Computer Science & Engineering"></asp:ListItem>
                                <asp:ListItem Text="Information Technology" Value="Information Technology"></asp:ListItem>
                                <asp:ListItem Text="Electronics & Communication" Value="Electronics & Communication"></asp:ListItem>
                                <asp:ListItem Text="Mechanical Engineering" Value="Mechanical Engineering"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Current CGPA *</label>
                            <asp:TextBox ID="txtNewCgpa" runat="server" CssClass="form-control" placeholder="e.g. 8.5"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv6" runat="server" ControlToValidate="txtNewCgpa" ValidationGroup="vgAdd" ErrorMessage="CGPA is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Graduation Year *</label>
                            <asp:TextBox ID="txtNewGradYear" runat="server" CssClass="form-control" placeholder="e.g. 2026"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Semester</label>
                            <asp:TextBox ID="txtNewSem" runat="server" CssClass="form-control" placeholder="e.g. 7"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Key Skills (Comma separated)</label>
                            <asp:TextBox ID="txtNewSkills" runat="server" CssClass="form-control" placeholder="C#, ASP.NET, Java, Python, SQL Server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveStudent" runat="server" Text="Register Student" CssClass="btn btn-primary fw-semibold" ValidationGroup="vgAdd" OnClick="btnSaveStudent_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
