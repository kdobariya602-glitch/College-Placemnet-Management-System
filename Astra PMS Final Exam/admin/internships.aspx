<%@ Page Title="Internships Management" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="internships.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.internships" %>

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
                        <li class="breadcrumb-item active">Internships</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Internship Programs & Applications</h3>
            </div>
            <!-- Role Boundary: Companies post internships; Admin supervises applications and listings -->
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
                <a class="nav-link active" href="internships.aspx"><i class="bi bi-mortarboard me-1"></i> Internships</a>
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

        <!-- Tab Navigation -->
        <div class="card border-0 shadow-sm p-4">
            <ul class="nav nav-pills mb-4 border-bottom pb-3" id="internshipTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-semibold" id="openings-tab" data-bs-toggle="pill" data-bs-target="#openings" type="button" role="tab"><i class="bi bi-briefcase me-1"></i> Internship Openings</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-semibold" id="intern-apps-tab" data-bs-toggle="pill" data-bs-target="#internApps" type="button" role="tab"><i class="bi bi-file-earmark-check me-1"></i> Student Applications</button>
                </li>
            </ul>

            <div class="tab-content" id="internshipTabsContent">
                <!-- Tab 1: Openings -->
                <div class="tab-pane fade show active" id="openings" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvInternships" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            DataKeyNames="Internship_Id" OnRowCommand="gvInternships_RowCommand"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-5 text-muted">
                                    <i class="bi bi-rocket-takeoff fs-1 text-secondary d-block mb-3"></i>
                                    <h5>No Internships Listed</h5>
                                    <p class="mb-0">Create new corporate internship opportunities above.</p>
                                </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Internship & Company">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark fs-6"><%# Eval("Internship_Title") %></div>
                                        <span class="text-muted small"><i class="bi bi-building me-1"></i><%# Eval("Company_Name") %> &bull; <%# Eval("Location") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Stipend & Duration">
                                    <ItemTemplate>
                                        <span class="badge bg-success bg-opacity-10 text-success fw-bold"><%# Eval("Stipend") %></span>
                                        <div class="text-muted small mt-1"><%# Eval("Duration") %> &bull; <%# Eval("Work_Mode") %></div>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Deadline">
                                    <ItemTemplate>
                                        <span class="small text-danger fw-semibold"><%# Eval("Deadline", "{0:dd MMM yyyy}") %></span>
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
                                        <asp:LinkButton ID="btnToggle" runat="server" CommandName="toggle_status" CommandArgument='<%# Eval("Internship_Id") %>' CssClass="btn btn-sm btn-outline-secondary me-1" title="Toggle Status">
                                            <i class="bi bi-arrow-repeat"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelIntern" runat="server" CommandName="delete_internship" CommandArgument='<%# Eval("Internship_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this internship?');" title="Delete">
                                            <i class="bi bi-trash"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- Tab 2: Applications -->
                <div class="tab-pane fade" id="internApps" role="tabpanel">
                    <div class="table-responsive">
                        <asp:GridView ID="gvInternApps" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle mb-0" GridLines="None"
                            DataKeyNames="Internship_App_Id" OnRowCommand="gvInternApps_RowCommand"
                            UseAccessibleHeader="True">
                            <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                            <EmptyDataTemplate>
                                <div class="text-center py-4 text-muted">No student applications submitted for internships yet.</div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Applicant">
                                    <ItemTemplate>
                                        <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                        <span class="text-muted small"><%# Eval("Enrollment_No") %> &bull; <%# Eval("Department") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Internship Role">
                                    <ItemTemplate>
                                        <div class="fw-semibold text-primary"><%# Eval("Internship_Title") %></div>
                                        <span class="text-muted small"><%# Eval("Company_Name") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="CGPA & Date">
                                    <ItemTemplate>
                                        <div class="fw-bold"><%# Eval("CGPA") %></div>
                                        <span class="text-muted small"><%# Eval("Applied_Date", "{0:dd MMM yyyy}") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='<%# Convert.ToString(Eval("Status")) == "Selected" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Convert.ToString(Eval("Status")) == "Rejected" ? "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25" : "badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25") %>'>
                                            <%# Eval("Status") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnApproveApp" runat="server" CommandName="select_app" CommandArgument='<%# Eval("Internship_Id") %>' CssClass="btn btn-sm btn-outline-success me-1" title="Select for Internship">
                                            <i class="bi bi-check-lg"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnRejectApp" runat="server" CommandName="reject_app" CommandArgument='<%# Eval("Internship_Id") %>' CssClass="btn btn-sm btn-outline-danger" title="Reject">
                                            <i class="bi bi-x-lg"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Add Internship -->
    <div class="modal fade" id="modalAddInternship" tabindex="-1" aria-labelledby="modalAddInternshipLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddInternshipLabel"><i class="bi bi-rocket-takeoff text-primary me-2"></i>Post New Internship Opportunity</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Internship Title *</label>
                            <asp:TextBox ID="txtNewIntTitle" runat="server" CssClass="form-control" placeholder="e.g. Software Development Engineering Intern"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Company *</label>
                            <asp:DropDownList ID="ddlIntCompany" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Monthly Stipend *</label>
                            <asp:TextBox ID="txtNewIntStipend" runat="server" CssClass="form-control" placeholder="e.g. Rs. 35,000 / Month"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Duration</label>
                            <asp:TextBox ID="txtNewIntDuration" runat="server" CssClass="form-control" placeholder="e.g. 6 Months"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Work Mode</label>
                            <asp:DropDownList ID="ddlNewIntMode" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Hybrid" Value="Hybrid"></asp:ListItem>
                                <asp:ListItem Text="Onsite" Value="Onsite"></asp:ListItem>
                                <asp:ListItem Text="Remote" Value="Remote"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Location</label>
                            <asp:TextBox ID="txtNewIntLoc" runat="server" CssClass="form-control" placeholder="Bangalore / Ahmedabad"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Application Deadline</label>
                            <asp:TextBox ID="txtNewIntDeadline" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Required Skills</label>
                            <asp:TextBox ID="txtNewIntSkills" runat="server" CssClass="form-control" placeholder="Python, C#, Data Structures, Cloud"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Description</label>
                            <asp:TextBox ID="txtNewIntDesc" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Internship overview and learning scope..."></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveInternship" runat="server" Text="Publish Internship" CssClass="btn btn-primary fw-semibold" OnClick="btnSaveInternship_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
