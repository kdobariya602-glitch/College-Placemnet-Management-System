<%@ Page Title="Manage Jobs" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="jobs.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.jobs" %>

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
                        <li class="breadcrumb-item">Post Openings</li>
                        <li class="breadcrumb-item active">Job Openings</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">My Company Job Openings</h3>
            </div>
            <div>
                <a href="post-job.aspx" class="btn btn-primary fw-semibold"><i class="bi bi-plus-lg me-1"></i> Post New Job</a>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="post-job.aspx"><i class="bi bi-plus-circle me-1"></i> Post New Job</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="jobs.aspx"><i class="bi bi-briefcase me-1"></i> Job Openings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="internships.aspx"><i class="bi bi-mortarboard me-1"></i> Internship Postings</a>
            </li>
        </ul>

        <!-- KPI Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-xl-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon"><i class="bi bi-briefcase"></i></div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalJobs" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Total Postings</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon"><i class="bi bi-check2-circle"></i></div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblActiveJobs" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Active Openings</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon"><i class="bi bi-people"></i></div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalApplications" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Total Applications</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="content-card p-3 d-flex align-items-center gap-3">
                    <div class="stat-icon"><i class="bi bi-trophy"></i></div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalHired" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Selected / Hired</div>
                    </div>
                </div>
            </div>
        </div>

                <!-- Filter Card -->
        <div class="content-card mb-4">
            <div class="card-body-custom p-3">
                <div class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-muted">Status</label>
                        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                            <asp:ListItem Text="All Statuses" Value="All"></asp:ListItem>
                            <asp:ListItem Text="Published / Active" Value="Published"></asp:ListItem>
                            <asp:ListItem Text="Closed" Value="Closed"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label small fw-semibold text-muted">Search Job Title / Location</label>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm" placeholder="Title, location, type..."></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-sm btn-primary w-100" OnClick="Filter_Changed" />
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-outline-secondary w-100" OnClick="btnReset_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Jobs Grid Card -->
        <div class="content-card">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-briefcase-fill text-primary me-2"></i>Active & Concluded Campus Job Listings</h5>
                <div>
                    <asp:Button ID="btnExportJobsCsv" runat="server" Text="Export Jobs (CSV)" CssClass="btn btn-sm btn-outline-success fw-semibold me-2" OnClick="btnExportJobsCsv_Click" />
                    <a href="post-job.aspx" class="btn btn-sm btn-primary fw-semibold"><i class="bi bi-plus-lg me-1"></i> Post New Job</a>
                </div>
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
                                <i class="bi bi-briefcase fs-1 text-muted d-block mb-3"></i>
                                <h5>No Job Openings Created</h5>
                                <p class="mb-0">Click 'Post New Job' to publish your company hiring requirements.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Position & Type">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Job_Title") %></div>
                                    <span class="text-muted small"><%# Eval("Job_Type") %> &bull; <%# Eval("Location") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Package (LPA)">
                                <ItemTemplate>
                                    <span class="badge bg-success-subtle text-success border border-success fw-bold">Rs. <%# Eval("Salary_CTC") %> LPA</span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Vacancies" HeaderText="Openings" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                            <asp:TemplateField HeaderText="Date Posted">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark"><%# Eval("Created_Date", "{0:dd-MMM-yyyy}") %></div>
                                    <small class="text-muted"><%# Eval("Created_Date", "{0:hh:mm tt}") %></small>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Deadline">
                                <ItemTemplate>
                                    <span class="badge bg-warning bg-opacity-10 text-dark border border-warning border-opacity-25"><%# Eval("App_Deadline", "{0:dd-MMM-yyyy}") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Applicants" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnApplicants" runat="server" CommandName="view_applicants" CommandArgument='<%# Eval("Job_Id") %>' CssClass="btn btn-sm btn-outline-primary fw-semibold" title="View Applied Candidates"><i class="bi bi-people me-1"></i> <%# Eval("Applicant_Count") %> Candidates</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Status")) == "Active" || Convert.ToString(Eval("Status")) == "Published" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <div class="btn-group btn-group-sm">
                                        <asp:LinkButton ID="btnJobDetails" runat="server" CommandName="view_job" CommandArgument='<%# Eval("Job_Id") %>' CssClass="btn btn-outline-primary" title="View In-Depth Job Details"><i class="bi bi-eye"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnClone" runat="server" CommandName="clone_job" CommandArgument='<%# Eval("Job_Id") %>'
                                            CssClass="btn btn-outline-primary" title="Duplicate Job Opening">
                                            <i class="bi bi-copy"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnToggle" runat="server" CommandName="toggle_status" CommandArgument='<%# Eval("Job_Id") %>'
                                            CssClass='<%# Convert.ToString(Eval("Status")) == "Active" || Convert.ToString(Eval("Status")) == "Published" ? "btn btn-outline-secondary" : "btn btn-outline-success" %>'
                                            title="Toggle Active Status">
                                            <i class='<%# Convert.ToString(Eval("Status")) == "Active" || Convert.ToString(Eval("Status")) == "Published" ? "bi bi-pause-circle" : "bi bi-play-circle" %>'></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDel" runat="server" CommandName="delete_job" CommandArgument='<%# Eval("Job_Id") %>'
                                            CssClass="btn btn-outline-danger" OnClientClick="return confirm('Delete this job opening?');" title="Delete">
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

        </asp:Content>