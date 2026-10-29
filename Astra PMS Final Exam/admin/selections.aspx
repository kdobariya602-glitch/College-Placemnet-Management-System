<%@ Page Title="Selections & Offers" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="selections.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.selections" %>

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
                        <li class="breadcrumb-item active">Selections & Offers</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Candidate Selections, Offers & Joining Governance</h3>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalAddSelection"><i class="bi bi-award me-1"></i> Record Selection</button>
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
                <a class="nav-link" href="applications.aspx"><i class="bi bi-file-earmark-check me-1"></i> Applications</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="interviews.aspx"><i class="bi bi-chat-square-text me-1"></i> Interviews</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="selections.aspx"><i class="bi bi-award me-1"></i> Selections & Offers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="placement-history.aspx"><i class="bi bi-clock-history me-1"></i> Placement History</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- KPI Metrics -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-trophy"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalSelected" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Total Placed Candidates</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-envelope-paper"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblOffersIssued" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Offers Issued</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-check2-circle"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblCandidatesJoined" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Candidates Joined</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-cash-stack"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblAvgPackage" runat="server" Text="Rs. 14.8 LPA"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Average Package</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Selections Grid Card -->
        <div class="card border-0 shadow-sm">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-award text-success me-2"></i>Campus Placement Selections</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvSelections" runat="server" AutoGenerateColumns="False"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvSelections_PageIndexChanging"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Selection_Id" OnRowCommand="gvSelections_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-award fs-1 text-secondary d-block mb-3"></i>
                                <h5>No Selections Recorded</h5>
                                <p class="mb-0">Selections will appear here once candidates clear interview rounds.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Selected Candidate">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Student_Name") %></div>
                                    <div class="text-muted small"><i class="bi bi-card-text me-1"></i><%# Eval("Enrollment_No") %> &bull; <%# Eval("Department") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Company & Role">
                                <ItemTemplate>
                                    <div class="fw-bold text-primary"><%# Eval("Company_Name") %></div>
                                    <span class="badge bg-light text-dark border"><%# Eval("Job_Title") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Package Offered">
                                <ItemTemplate>
                                    <span class="badge bg-success bg-opacity-10 text-success fw-bold fs-6"><%# Eval("Package_CTC") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Selection Date">
                                <ItemTemplate>
                                    <%# Eval("Selection_Date", "{0:dd MMM yyyy}") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Offer & Joining Status">
                                <ItemTemplate>
                                    <div><span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25"><%# Eval("Offer_Status") %></span></div>
                                    <span class='<%# Convert.ToString(Eval("Joining_Status")) == "Joined" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 mt-1" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25 mt-1" %>'>
                                        <%# Eval("Joining_Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnMarkJoined" runat="server" CommandName="mark_joined" CommandArgument='<%# Eval("Selection_Id") %>' CssClass="btn btn-sm btn-outline-success me-1" title="Confirm Joined">
                                        <i class="bi bi-check2-all"></i> Joined
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDeleteSel" runat="server" CommandName="delete_selection" CommandArgument='<%# Eval("Selection_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Remove selection record?');" title="Delete">
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

    <!-- Modal Add Direct Selection -->
    <div class="modal fade" id="modalAddSelection" tabindex="-1" aria-labelledby="modalAddSelectionLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddSelectionLabel"><i class="bi bi-award text-success me-2"></i>Record Placement Offer / Selection</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Select Student *</label>
                            <asp:DropDownList ID="ddlSelStudent" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Recruiting Company *</label>
                            <asp:DropDownList ID="ddlSelCompany" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Job Role Title *</label>
                            <asp:TextBox ID="txtSelJobTitle" runat="server" CssClass="form-control" placeholder="e.g. Software Engineer"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Offered Package / Annual CTC *</label>
                            <asp:TextBox ID="txtSelPackage" runat="server" CssClass="form-control" placeholder="e.g. Rs. 15.0 LPA"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Offer Date</label>
                            <asp:TextBox ID="txtSelOfferDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Expected Joining Date</label>
                            <asp:TextBox ID="txtSelJoiningDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveSelection" runat="server" Text="Record Selection & Notify Student" CssClass="btn btn-success fw-semibold" OnClick="btnSaveSelection_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
