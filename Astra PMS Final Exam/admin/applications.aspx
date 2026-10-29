<%@ Page Title="Applications Pipeline" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="applications.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.applications" %>



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

                        <li class="breadcrumb-item active">Applications</li>

                    </ol>

                </nav>

                <h3 class="fw-bold mb-0">Campus Applications Master Pipeline</h3>

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

                <a class="nav-link active" href="applications.aspx"><i class="bi bi-file-earmark-check me-1"></i> Applications</a>

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

        <div class="card border-0 shadow-sm p-3 mb-4">

            <div class="row g-3 align-items-center">

                <div class="col-md-4">

                    <div class="input-group">

                        <span class="input-group-text bg-light"><i class="bi bi-search"></i></span>

                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search student, enrollment or role..."></asp:TextBox>

                    </div>

                </div>

                <div class="col-md-3">

                    <asp:DropDownList ID="ddlCompanyFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"></asp:DropDownList>

                </div>

                <div class="col-md-3">

                    <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">

                        <asp:ListItem Text="All Pipeline Statuses" Value=""></asp:ListItem>

                        <asp:ListItem Text="Applied" Value="Applied"></asp:ListItem>

                        <asp:ListItem Text="Shortlisted" Value="Shortlisted"></asp:ListItem>

                        <asp:ListItem Text="Interview Scheduled" Value="Interview Scheduled"></asp:ListItem>

                        <asp:ListItem Text="Selected" Value="Selected"></asp:ListItem>

                        <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>

                    </asp:DropDownList>

                </div>

                <div class="col-md-2 d-flex gap-2">

                    <asp:Button ID="btnSearch" runat="server" Text="Filter" CssClass="btn btn-primary w-100 fw-semibold" OnClick="btnSearch_Click" />

                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />

                </div>

            </div>

        </div>



        <!-- Applications Grid Card -->

        <div class="card border-0 shadow-sm">

            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">

                <h5 class="mb-0 fw-bold"><i class="bi bi-file-earmark-check text-primary me-2"></i>Applications Received (<asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>)</h5>

            </div>

            <div class="card-body-custom p-0">

                <div class="table-responsive">

                    <asp:GridView ID="gvApplications" runat="server" AutoGenerateColumns="False"

                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvApplications_PageIndexChanging"

                        CssClass="table table-hover align-middle mb-0" GridLines="None"

                        DataKeyNames="Application_Id" OnRowCommand="gvApplications_RowCommand"

                        UseAccessibleHeader="True">

                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />

                        <EmptyDataTemplate>

                            <div class="text-center py-5 text-muted">

                                <i class="bi bi-folder-x fs-1 text-secondary d-block mb-3"></i>

                                <h5>No Applications Found</h5>

                                <p class="mb-0">There are no applications matching the selected criteria.</p>

                            </div>

                        </EmptyDataTemplate>

                        <Columns>

                            <asp:TemplateField HeaderText="Candidate">

                                <ItemTemplate>

                                    <div class="fw-bold text-dark fs-6"><asp:LinkButton ID="lnkStudentName" runat="server" CommandName="view_student" CommandArgument='<%# Eval("Student_Email") %>' CssClass="text-dark text-decoration-none hover-primary"><%# Eval("Student_Name") %></asp:LinkButton></div>

                                    <div class="text-muted small"><i class="bi bi-card-text me-1"></i><%# Eval("Enrollment_No") %> &bull; <%# Eval("Department") %></div>

                                    <div class="text-muted small"><i class="bi bi-envelope me-1"></i><%# Eval("Student_Email") %></div>

                                </ItemTemplate>

                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Job Role & Company">

                                <ItemTemplate>

                                    <div class="fw-bold text-primary"><%# Eval("Job_Title") %></div>

                                    <span class="badge bg-light text-dark border"><i class="bi bi-building me-1"></i><%# Eval("Company_Name") %></span>

                                </ItemTemplate>

                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="CGPA">

                                <ItemTemplate>

                                    <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-2 py-1"><%# Eval("CGPA") %></span>

                                </ItemTemplate>

                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Applied Date">

                                <ItemTemplate>

                                    <%# Eval("Applied_Date", "{0:dd MMM yyyy}") %>

                                </ItemTemplate>

                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Status">

                                <ItemTemplate>

                                    <span class='<%# Convert.ToString(Eval("Status")) == "Selected" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Convert.ToString(Eval("Status")) == "Shortlisted" ? "badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25" : (Convert.ToString(Eval("Status")) == "Interview Scheduled" ? "badge bg-info bg-opacity-10 text-info border border-info border-opacity-25" : (Convert.ToString(Eval("Status")) == "Rejected" ? "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25"))) %>'>

                                        <%# Eval("Status") %>

                                    </span>

                                </ItemTemplate>

                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">

                                <ItemTemplate>

                                    <div class="btn-group btn-group-sm">

                                        <asp:LinkButton ID="btnViewStudent" runat="server" CommandName="view_student" CommandArgument='<%# Eval("Student_Email") %>' CssClass="btn btn-outline-info fw-semibold" title="View Student Profile"><i class="bi bi-eye"></i> View</asp:LinkButton>

                                        <asp:LinkButton ID="btnShortlist" runat="server" CommandName="shortlist_app" CommandArgument='<%# Eval("Application_Id") %>' CssClass="btn btn-outline-primary fw-semibold" title="Shortlist Candidate">

                                            <i class="bi bi-check2"></i> Shortlist

                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnSelect" runat="server" CommandName="select_app" CommandArgument='<%# Eval("Application_Id") %>' CssClass="btn btn-outline-success fw-semibold" title="Select Candidate">

                                            <i class="bi bi-award"></i> Select

                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnReject" runat="server" CommandName="reject_app" CommandArgument='<%# Eval("Application_Id") %>' CssClass="btn btn-outline-danger" title="Reject Application">

                                            <i class="bi bi-x-lg"></i>

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

