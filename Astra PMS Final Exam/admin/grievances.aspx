<%@ Page Title="Student Grievances" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="grievances.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.grievances" %>

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
                        <li class="breadcrumb-item active">Grievances</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Student Grievance & Redressal Desk</h3>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="notices.aspx"><i class="bi bi-megaphone me-1"></i> Notices</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="grievances.aspx"><i class="bi bi-exclamation-circle me-1"></i> Grievances</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="reports.aspx"><i class="bi bi-bar-chart me-1"></i> Placement Reports</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- KPI Row -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-4">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-shield-exclamation"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblOpenCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Open Grievances</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-4">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblReviewCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Under Investigation</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-4">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblResolvedCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Resolved Tickets</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Grievances Table Card -->
        <div class="card border-0 shadow-sm">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-list-check text-primary me-2"></i>Student Redressal Tickets</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvGrievances" runat="server" AutoGenerateColumns="False"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvGrievances_PageIndexChanging"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Grievance_Id" OnRowCommand="gvGrievances_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-shield-check fs-1 text-success d-block mb-3"></i>
                                <h5>No Grievances Submitted</h5>
                                <p class="mb-0">There are no pending tickets requiring administration resolution.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Ticket & Issue">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center gap-2 mb-1">
                                        <span class='<%# Convert.ToString(Eval("Priority")) == "Urgent" ? "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25" : (Convert.ToString(Eval("Priority")) == "High" ? "badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25") %>'>
                                            <%# Eval("Priority") %>
                                        </span>
                                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25"><%# Eval("Category") %></span>
                                    </div>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Subject") %></div>
                                    <p class="text-muted small mb-0"><%# Eval("Description") %></p>
                                    <%# Eval("Response") != null && !string.IsNullOrEmpty(Convert.ToString(Eval("Response"))) ? "<div class='mt-2 p-2 bg-light border rounded small text-dark'><strong>Admin Response:</strong> " + Eval("Response") + "</div>" : "" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Submitted By">
                                <ItemTemplate>
                                    <div class="fw-semibold text-dark"><%# Eval("Student_Name") %></div>
                                    <span class="text-muted small"><i class="bi bi-envelope me-1"></i><%# Eval("Student_Email") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <span class="small text-muted"><%# Eval("Submitted_Date", "{0:dd MMM yyyy}") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Status")) == "Resolved" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Convert.ToString(Eval("Status")) == "In Review" ? "badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25" : "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25") %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnOpenResolve" runat="server" CommandName="open_respond" CommandArgument='<%# Eval("Grievance_Id") %>' CssClass="btn btn-sm btn-outline-primary me-1" title="Respond & Resolve">
                                        <i class="bi bi-reply-fill"></i> Respond
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelGrievance" runat="server" CommandName="delete_grievance" CommandArgument='<%# Eval("Grievance_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this grievance?');" title="Delete">
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

    <!-- Modal Respond Grievance -->
    <div class="modal fade" id="modalRespond" tabindex="-1" aria-labelledby="modalRespondLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalRespondLabel"><i class="bi bi-reply-fill text-primary me-2"></i>Respond to Student Grievance</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <asp:HiddenField ID="hfGrievanceId" runat="server" />
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Subject / Issue</label>
                        <asp:Label ID="lblModalSubject" runat="server" CssClass="d-block p-2 bg-light rounded text-dark fw-bold"></asp:Label>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Resolution Status</label>
                        <asp:DropDownList ID="ddlModalStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Resolved" Value="Resolved"></asp:ListItem>
                            <asp:ListItem Text="In Review" Value="In Review"></asp:ListItem>
                            <asp:ListItem Text="Closed" Value="Closed"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    
                    <!-- Dual Mode: AI Redressal Resolution Drafter -->
                    <div class="mb-3 p-3 rounded" style="background: linear-gradient(135deg, #EFF6FF 0%, #F5F3FF 100%); border: 1px solid #BFDBFE;">
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <span class="fw-bold text-dark small"><i class="bi bi-stars text-primary me-1"></i>AI Redressal Drafter (Dual Mode: Auto-Draft OR Manual)</span>
                            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 small">Gemini AI</span>
                        </div>
                        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2">
                            <span class="text-muted small">Auto-generate an empathetic, official administrative redressal:</span>
                            <asp:Button ID="btnAiDraftResolution" runat="server" Text="✨ AI Auto-Draft Resolution" CssClass="btn btn-sm btn-primary fw-bold" OnClick="btnAiDraftResolution_Click" />
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Administrative Response & Action Taken *</label>
                        <asp:TextBox ID="txtModalResponse" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Explain the resolution or next steps for the candidate..."></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSubmitResponse" runat="server" Text="Submit Official Response" CssClass="btn btn-primary fw-semibold" OnClick="btnSubmitResponse_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
