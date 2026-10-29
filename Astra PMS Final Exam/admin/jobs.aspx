<%@ Page Title="Job Postings" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="jobs.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.jobs" %>

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
                        <li class="breadcrumb-item active">Job Openings</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">University Job Openings & Roles</h3>
            </div>
            <!-- Role Boundary: Companies post job openings; Admin supervises and manages listings -->
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="drives.aspx"><i class="bi bi-calendar2-event me-1"></i> Placement Drives</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="jobs.aspx"><i class="bi bi-briefcase me-1"></i> Job Postings</a>
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
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="bi bi-search"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by job title, company or location..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlCompanyFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Text="All Statuses" Value=""></asp:ListItem>
                        <asp:ListItem Text="Published" Value="Published"></asp:ListItem>
                        <asp:ListItem Text="Draft" Value="Draft"></asp:ListItem>
                        <asp:ListItem Text="Closed" Value="Closed"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100 fw-semibold" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <!-- Jobs Grid Card -->
        <div class="content-card">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-briefcase text-primary me-2"></i>Job Listings (<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>)</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvJobs" runat="server" AutoGenerateColumns="False"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvJobs_PageIndexChanging"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Job_Id" OnRowCommand="gvJobs_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-briefcase fs-1 text-secondary d-block mb-3"></i>
                                <h5>No Job Postings Found</h5>
                                <p class="mb-0">There are no job opportunities matching the selected filters.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Job & Company">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Job_Title") %></div>
                                    <div class="text-muted small"><i class="bi bi-building me-1"></i><%# Eval("Company_Name") %> &bull; <i class="bi bi-geo-alt me-1"></i><%# Eval("Location") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Package / CTC">
                                <ItemTemplate>
                                    <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 fw-bold px-2 py-1"><%# Eval("Salary_CTC") %></span>
                                    <div class="text-muted small mt-1"><%# Eval("Job_Type") %> &bull; <%# Eval("Work_Mode") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Eligibility Criteria">
                                <ItemTemplate>
                                    <div class="small fw-semibold text-dark">Min CGPA: <%# Eval("Min_CGPA") %> (Backlogs &le; <%# Eval("Max_Backlogs") %>)</div>
                                    <span class="text-muted small text-truncate d-inline-block" style="max-width:200px;"><%# Eval("Eligible_Dept") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Deadline">
                                <ItemTemplate>
                                    <div class="small text-danger fw-semibold"><i class="bi bi-hourglass me-1"></i><%# Eval("App_Deadline", "{0:dd MMM yyyy}") %></div>
                                    <span class="text-muted small"><%# Eval("Vacancies") %> Openings</span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Status")) == "Published" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnToggleStatus" runat="server" CommandName="toggle_status" CommandArgument='<%# Eval("Job_Id") %>' CssClass="btn btn-sm btn-outline-secondary me-1" title="Toggle Publish/Close">
                                        <i class="bi bi-arrow-repeat"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDeleteJob" runat="server" CommandName="delete_job" CommandArgument='<%# Eval("Job_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this job opening?');" title="Delete">
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

    <!-- Modal Create Job -->
    <div class="modal fade" id="modalCreateJob" tabindex="-1" aria-labelledby="modalCreateJobLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalCreateJobLabel"><i class="bi bi-briefcase text-primary me-2"></i>Post New Job Opportunity</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Hiring Company *</label>
                            <asp:DropDownList ID="ddlNewJobCompany" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Job Title *</label>
                            <asp:TextBox ID="txtNewJobTitle" runat="server" CssClass="form-control" placeholder="e.g. Associate Software Engineer"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvj1" runat="server" ControlToValidate="txtNewJobTitle" ValidationGroup="vgJob" ErrorMessage="Job title is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Job Type</label>
                            <asp:DropDownList ID="ddlNewJobType" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Full Time" Value="Full Time"></asp:ListItem>
                                <asp:ListItem Text="Internship" Value="Internship"></asp:ListItem>
                                <asp:ListItem Text="Internship + FTE" Value="Internship + FTE"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Work Mode</label>
                            <asp:DropDownList ID="ddlNewJobMode" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Onsite" Value="Onsite"></asp:ListItem>
                                <asp:ListItem Text="Hybrid" Value="Hybrid"></asp:ListItem>
                                <asp:ListItem Text="Remote" Value="Remote"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Location *</label>
                            <asp:TextBox ID="txtNewJobLoc" runat="server" CssClass="form-control" placeholder="e.g. Bangalore / Ahmedabad"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Annual CTC / Salary *</label>
                            <asp:TextBox ID="txtNewJobCTC" runat="server" CssClass="form-control" placeholder="e.g. Rs. 12.5 LPA"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvj2" runat="server" ControlToValidate="txtNewJobCTC" ValidationGroup="vgJob" ErrorMessage="Salary is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Minimum CGPA</label>
                            <asp:TextBox ID="txtNewJobMinCGPA" runat="server" CssClass="form-control" placeholder="e.g. 6.5"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Maximum Backlogs</label>
                            <asp:TextBox ID="txtNewJobMaxBacklogs" runat="server" CssClass="form-control" placeholder="0"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Eligible Departments</label>
                            <asp:TextBox ID="txtNewJobEligibleDept" runat="server" CssClass="form-control" placeholder="Computer Science & Engineering, Information Technology"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">Vacancies</label>
                            <asp:TextBox ID="txtNewJobVacancies" runat="server" CssClass="form-control" placeholder="10"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">Application Deadline</label>
                            <asp:TextBox ID="txtNewJobDeadline" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Required Technical Skills</label>
                            <asp:TextBox ID="txtNewJobSkills" runat="server" CssClass="form-control" placeholder="C#, ASP.NET, SQL Server, Problem Solving, Data Structures"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Job Description & Responsibilities</label>
                            <asp:TextBox ID="txtNewJobDesc" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="Brief job description and key expectations..."></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveJob" runat="server" Text="Publish Job Opportunity" CssClass="btn btn-primary fw-semibold" ValidationGroup="vgJob" OnClick="btnSaveJob_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
