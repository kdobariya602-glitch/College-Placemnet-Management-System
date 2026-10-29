<%@ Page Title="Placement Notices" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="notices.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.notices" %>

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
                        <li class="breadcrumb-item"><a href="notices.aspx">Communication & Reports</a></li>
                        <li class="breadcrumb-item active">Notice Board</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Placement & Training Circulars / Notices</h3>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalAddNotice"><i class="bi bi-megaphone me-1"></i> Publish Notice</button>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="notices.aspx"><i class="bi bi-megaphone me-1"></i> Notices</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="grievances.aspx"><i class="bi bi-exclamation-circle me-1"></i> Grievances</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="reports.aspx"><i class="bi bi-bar-chart me-1"></i> Placement Reports</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- Notices Grid Card -->
        <div class="card border-0 shadow-sm">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-megaphone text-primary me-2"></i>Active Circulars & Announcements</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvNotices" runat="server" AutoGenerateColumns="False"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvNotices_PageIndexChanging"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Notice_Id" OnRowCommand="gvNotices_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-megaphone fs-1 text-secondary d-block mb-3"></i>
                                <h5>No Circulars Published</h5>
                                <p class="mb-0">Publish official announcements for students and recruiters above.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Circular Details">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center gap-2 mb-1">
                                        <span class='<%# Convert.ToString(Eval("Priority")) == "Urgent" ? "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25" : (Convert.ToString(Eval("Priority")) == "High" ? "badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25") %>'>
                                            <%# Eval("Priority") %>
                                        </span>
                                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25"><%# Eval("Category") %></span>
                                    </div>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Title") %></div>
                                    <p class="text-muted small mb-0"><%# Eval("Description") %></p>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Target Audience">
                                <ItemTemplate>
                                    <div class="small fw-semibold text-dark"><%# Eval("Target_Audience") %></div>
                                    <span class="text-muted small">Dept: <%# Eval("Department") %> &bull; Batch: <%# Eval("Batch") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Publish Date">
                                <ItemTemplate>
                                    <div class="small text-muted"><i class="bi bi-calendar-check me-1"></i><%# Eval("Publish_Date", "{0:dd MMM yyyy}") %></div>
                                    <span class="text-muted small">By <%# Eval("Created_By") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Status")) == "Active" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnToggle" runat="server" CommandName="toggle_status" CommandArgument='<%# Eval("Notice_Id") %>' CssClass="btn btn-sm btn-outline-secondary me-1" title="Toggle Status">
                                        <i class="bi bi-arrow-repeat"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelNotice" runat="server" CommandName="delete_notice" CommandArgument='<%# Eval("Notice_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this announcement?');" title="Delete">
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

    <!-- Modal Add Notice -->
    <div class="modal fade" id="modalAddNotice" tabindex="-1" aria-labelledby="modalAddNoticeLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddNoticeLabel"><i class="bi bi-megaphone text-primary me-2"></i>Publish Notice / Circular</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label fw-semibold">Notice Title *</label>
                            <asp:TextBox ID="txtNewNoticeTitle" runat="server" CssClass="form-control" placeholder="e.g. Schedule for Technical Assessments 2026-27"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvn1" runat="server" ControlToValidate="txtNewNoticeTitle" ValidationGroup="vgNotice" ErrorMessage="Title is required" CssClass="text-danger small"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Category</label>
                            <asp:DropDownList ID="ddlNoticeCategory" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Placement" Value="Placement"></asp:ListItem>
                                <asp:ListItem Text="Training" Value="Training"></asp:ListItem>
                                <asp:ListItem Text="Interview" Value="Interview"></asp:ListItem>
                                <asp:ListItem Text="Internship" Value="Internship"></asp:ListItem>
                                <asp:ListItem Text="General" Value="General"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Priority Level</label>
                            <asp:DropDownList ID="ddlNoticePriority" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Standard" Value="Standard"></asp:ListItem>
                                <asp:ListItem Text="High" Value="High"></asp:ListItem>
                                <asp:ListItem Text="Urgent" Value="Urgent"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Target Audience</label>
                            <asp:DropDownList ID="ddlNoticeAudience" runat="server" CssClass="form-select">
                                <asp:ListItem Text="All Students" Value="All Students"></asp:ListItem>
                                <asp:ListItem Text="Final Year Candidates" Value="Final Year Candidates"></asp:ListItem>
                                <asp:ListItem Text="Companies & Recruiters" Value="Companies & Recruiters"></asp:ListItem>
                                <asp:ListItem Text="Department Coordinators" Value="Department Coordinators"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Department Filter</label>
                            <asp:TextBox ID="txtNoticeDept" runat="server" CssClass="form-control" placeholder="All / Computer Science & Engineering"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Batch</label>
                            <asp:TextBox ID="txtNoticeBatch" runat="server" CssClass="form-control" placeholder="2026 / All"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Full Notice Content *</label>
                            <asp:TextBox ID="txtNoticeDesc" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Write full text of the circular..."></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveNotice" runat="server" Text="Publish Circular" CssClass="btn btn-primary fw-semibold" ValidationGroup="vgNotice" OnClick="btnSaveNotice_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
