<%@ Page Title="Campus Hiring History" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="placement-history.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.placement_history" %>

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
                        <li class="breadcrumb-item"><a href="selections.aspx">Candidate Management</a></li>
                        <li class="breadcrumb-item active">Placement History</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Campus Hiring History & Alumni Track Record</h3>
            </div>
            <div class="mt-2 mt-md-0 d-flex gap-2">
                <button type="button" class="btn btn-outline-secondary" onclick="window.print();">
                    <i class="bi bi-printer me-1"></i> Print / Export Report
                </button>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="applicants.aspx"><i class="bi bi-people me-1"></i> Applicants</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="shortlisted.aspx"><i class="bi bi-person-check me-1"></i> Shortlisted Students</a>
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
                <a class="nav-link active" href="placement-history.aspx"><i class="bi bi-clock-history me-1"></i> Hiring History</a>
            </li>
        </ul>

        <!-- KPI Cards -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-primary bg-opacity-10 text-primary me-3">
                        <i class="bi bi-people-fill fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Total Campus Hires</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litTotalHires" runat="server">0</asp:Literal></h4>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-success bg-opacity-10 text-success me-3">
                        <i class="bi bi-check-circle-fill fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Successfully Joined</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litTotalJoined" runat="server">0</asp:Literal></h4>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="content-card p-3 d-flex align-items-center">
                    <div class="rounded-3 p-3 bg-warning bg-opacity-10 text-warning me-3">
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
                    <div class="rounded-3 p-3 bg-info bg-opacity-10 text-info me-3">
                        <i class="bi bi-graph-up fs-3"></i>
                    </div>
                    <div>
                        <div class="text-muted small fw-semibold">Average Package</div>
                        <h4 class="fw-bold mb-0"><asp:Literal ID="litAverageCTC" runat="server">Rs. 0 LPA</asp:Literal></h4>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter Card -->
        <div class="content-card p-3 mb-4">
            <div class="row g-2 align-items-center">
                <div class="col-md-5">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search candidate name, role, email..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlFilterDept" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                        <asp:ListItem Value="">All Statuses</asp:ListItem>
                        <asp:ListItem Value="Joined">Joined</asp:ListItem>
                        <asp:ListItem Value="Offer Accepted">Offer Accepted</asp:ListItem>
                        <asp:ListItem Value="Pending Joining">Pending Joining</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-sm btn-primary flex-grow-1" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <!-- Table Card -->
        <div class="content-card p-4">
            <div class="table-responsive">
                <asp:GridView  UseAccessibleHeader="True" ID="gvHistory" runat="server" AutoGenerateColumns="false" CssClass="table table-hover align-middle mb-0"
                    EmptyDataText="No campus hiring records found for your organization.">
                    <EmptyDataTemplate>
                        <div class="text-center py-5">
                            <i class="bi bi-person-check text-muted display-4 d-block mb-3"></i>
                            <h5 class="text-secondary fw-semibold">No Campus Hires Recorded Yet</h5>
                            <p class="text-muted small">As candidates are selected and accept offers during campus recruitment drives, records will be compiled here.</p>
                        </div>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="History_Id" HeaderText="#" ItemStyle-CssClass="fw-bold text-muted small" />
                        
                        <asp:TemplateField HeaderText="Selected Candidate">
                            <ItemTemplate>
                                <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                <div class="text-muted small"><i class="bi bi-envelope me-1"></i><%# Eval("Student_Email") %> | <%# Eval("Enrollment_No") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Department & Batch">
                            <ItemTemplate>
                                <div class="fw-semibold text-secondary"><%# Eval("Department") %></div>
                                <div class="small text-muted"><%# Eval("Course") %> (Batch: <%# Eval("Batch") %>)</div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Job_Title" HeaderText="Designation Offered" ItemStyle-CssClass="fw-bold text-primary" />

                        <asp:TemplateField HeaderText="Package (CTC)">
                            <ItemTemplate>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success fw-bold px-2 py-1">
                                    <i class="bi bi-currency-rupee me-1"></i><%# Eval("Package_CTC") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Selection & Joining Dates">
                            <ItemTemplate>
                                <div class="small">Selected: <strong><%# FormatDate(Eval("Selection_Date")) %></strong></div>
                                <div class="small text-muted">Joining: <%# FormatDate(Eval("Joining_Date")) %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Joining Status">
                            <ItemTemplate>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success px-2 py-1"><%# SafeStatus(Eval("Joining_Status")) %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Academic_Year" HeaderText="Season" ItemStyle-CssClass="small text-muted" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
