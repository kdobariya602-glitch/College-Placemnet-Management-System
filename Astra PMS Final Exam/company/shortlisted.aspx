<%@ Page Title="Shortlisted Candidates" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="shortlisted.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.shortlisted" %>

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
                        <li class="breadcrumb-item"><a href="applicants.aspx">Candidate Management</a></li>
                        <li class="breadcrumb-item active">Shortlisted Candidates</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Shortlisted Candidate Pool</h3>
                <p class="text-muted small mb-0">Manage candidates qualified for subsequent interview rounds and evaluations.</p>
            </div>
            <div class="d-flex gap-2">
                <a href="interviews.aspx" class="btn btn-primary"><i class="bi bi-person-video me-1"></i> View Interview Schedule</a>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="applicants.aspx"><i class="bi bi-people me-1"></i> Applicants</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="shortlisted.aspx"><i class="bi bi-person-check me-1"></i> Shortlisted Students</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="interviews.aspx"><i class="bi bi-calendar-event me-1"></i> Interview Schedules</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="interview-results.aspx"><i class="bi bi-clipboard-check me-1"></i> Assessment Results</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="selections.aspx"><i class="bi bi-award me-1"></i> Selections & Offers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="placement-history.aspx"><i class="bi bi-clock-history me-1"></i> Hiring History</a>
            </li>
        </ul>

        <!-- KPI Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-xl-4">
                <div class="card stat-card p-3 border-0 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted small fw-semibold">Total Shortlisted</span>
                            <h3 class="fw-bold mb-0 mt-1"><asp:Label ID="lblTotalShortlisted" runat="server" Text="0"></asp:Label></h3>
                        </div>
                        <div class="stat-icon bg-info bg-opacity-10 text-info p-3 rounded-circle">
                            <i class="bi bi-filter-circle fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-4">
                <div class="card stat-card p-3 border-0 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted small fw-semibold">Interviews Scheduled</span>
                            <h3 class="fw-bold mb-0 mt-1"><asp:Label ID="lblInterviewsScheduled" runat="server" Text="0"></asp:Label></h3>
                        </div>
                        <div class="stat-icon bg-warning bg-opacity-10 text-warning p-3 rounded-circle">
                            <i class="bi bi-calendar-event fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-4">
                <div class="card stat-card p-3 border-0 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted small fw-semibold">Selected & Offered</span>
                            <h3 class="fw-bold mb-0 mt-1"><asp:Label ID="lblTotalSelected" runat="server" Text="0"></asp:Label></h3>
                        </div>
                        <div class="stat-icon bg-success bg-opacity-10 text-success p-3 rounded-circle">
                            <i class="bi bi-award fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filters & Search -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body p-3">
                <div class="row g-3 align-items-end">
                    <div class="col-md-5">
                        <label class="form-label small fw-semibold text-muted">Filter by Job Posting</label>
                        <asp:DropDownList ID="ddlJobFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlJobFilter_SelectedIndexChanged">
                            <asp:ListItem Value="">-- All Job Postings --</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label small fw-semibold text-muted">Search Student</label>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by student name or email..."></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary w-100" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Shortlist Table -->
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-people-fill text-primary me-2"></i>Candidates in Pipeline</h5>
                <span class="text-muted small">Showing verified shortlisted profiles</span>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView  UseAccessibleHeader="True" ID="gvShortlist" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvShortlist_PageIndexChanging"
                        DataKeyNames="Application_Id" EmptyDataText="No shortlisted candidates found for your postings." OnRowCommand="gvShortlist_RowCommand" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="Shortlist_Id" HeaderText="#" />
                            <asp:TemplateField HeaderText="Candidate Details">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-circle me-2" style="width:36px; height:36px; border-radius:50%; background:#EFF6FF; color:#1D4ED8; display:flex; align-items:center; justify-content:center; font-weight:bold;">
                                            <%# Convert.ToString(Eval("Student_Name")).Length > 0 ? Convert.ToString(Eval("Student_Name")).Substring(0, 1) : "S" %>
                                        </div>
                                        <div>
                                            <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                            <div class="text-muted small"><%# Eval("Student_Email") %></div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Job_Title" HeaderText="Job Position" />
                            <asp:BoundField DataField="CGPA" HeaderText="CGPA" />
                            <asp:TemplateField HeaderText="Resume">
                                <ItemTemplate>
                                    <%# !string.IsNullOrEmpty(Eval("Resume_File") as string) ? 
                                        "<a href='../uploads/resumes/" + Eval("Resume_File") + "' target='_blank' class='btn btn-sm btn-outline-primary py-0 px-2' title='View Resume'><i class='bi bi-file-earmark-pdf me-1'></i>PDF</a>" : 
                                        "<span class='text-muted small'>None</span>" %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Shortlisted_Date" HeaderText="Shortlisted Date" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='badge <%# Convert.ToString(Eval("Status")) == "Selected" ? "bg-success" : Convert.ToString(Eval("Status")) == "Rejected" ? "bg-danger" : "bg-primary" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="btn-group btn-group-sm">
                                        <asp:LinkButton ID="btnView" runat="server" CommandName="ViewApp" CommandArgument='<%# Eval("Application_Id") %>' CssClass="btn btn-outline-secondary" title="View Profile">
                                            <i class="bi bi-eye"></i>
                                        </asp:LinkButton>
                                        <a href="interviews.aspx" class="btn btn-outline-primary" title="Schedule Interview">
                                            <i class="bi bi-calendar-plus"></i> Schedule
                                        </a>
                                        <asp:LinkButton ID="btnRemove" runat="server" CommandName="RemoveCandidate" CommandArgument='<%# Eval("Application_Id") %>' CssClass="btn btn-outline-danger" OnClientClick="return confirm('Are you sure you want to remove this candidate from shortlist?');" title="Remove">
                                            <i class="bi bi-x-circle"></i>
                                        </asp:LinkButton>
                                    </div>
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
</asp:Content>
