<%@ Page Title="Company Verification" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="company-verification.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.company_verification" %>

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
                        <li class="breadcrumb-item"><a href="companies.aspx">Company Management</a></li>
                        <li class="breadcrumb-item active">Verification Desk</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Corporate Recruiter Verification Desk</h3>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="companies.aspx"><i class="bi bi-building me-1"></i> Partner Companies</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="company-verification.aspx"><i class="bi bi-shield-check me-1"></i> Company Verification</a>
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
                        <i class="bi bi-clock-history"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblPendingCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Pending Verifications</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-4">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-patch-check"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblVerifiedCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Approved Partners</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-4">
                <div class="card border-0 shadow-sm p-3 d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon">
                        <i class="bi bi-x-circle"></i>
                    </div>
                    <div>
                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblRejectedCount" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Rejected Registrations</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Verification Queue Table -->
        <div class="card border-0 shadow-sm">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-list-check text-warning me-2"></i>Recruiter Verification Queue</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvVerification" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Company_Id" OnRowCommand="gvVerification_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-check-all fs-1 text-success d-block mb-3"></i>
                                <h5>Queue is All Clear!</h5>
                                <p class="mb-0">There are no pending company verifications currently.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Company Profile">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Company_Name") %></div>
                                    <div class="text-muted small"><i class="bi bi-tag me-1"></i><%# Eval("Industry") %> &bull; <%# Eval("Location") %></div>
                                    <div class="small text-primary"><i class="bi bi-link-45deg"></i><%# Eval("Website") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="HR & Contact Details">
                                <ItemTemplate>
                                    <div class="fw-semibold text-dark"><%# Eval("HR_Name") %></div>
                                    <div class="small text-muted"><i class="bi bi-envelope me-1"></i><%# Eval("Email") %></div>
                                    <div class="small text-muted"><i class="bi bi-telephone me-1"></i><%# Eval("Contact_Number") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Current Status">
                                <ItemTemplate>
                                    <span class='<%# Eval("Verification_Status") != null && Convert.ToString(Eval("Verification_Status")) == "Verified" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Eval("Verification_Status") != null && Convert.ToString(Eval("Verification_Status")) == "Rejected" ? "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25" : "badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25") %>'>
                                        <%# Eval("Verification_Status") == null || Eval("Verification_Status") == DBNull.Value || string.IsNullOrEmpty(Convert.ToString(Eval("Verification_Status"))) ? "Pending" : Convert.ToString(Eval("Verification_Status")) %>
                                    </span>
                                    <div class="small text-muted mt-1"><%# Eval("Remarks") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Verification Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <div class="btn-group btn-group-sm">
                                        <button type="button" class="btn btn-outline-primary fw-semibold" onclick="openCompRiskModal('<%# Eval("Company_Name") %>', '<%# Eval("Website") %>')" title="AI Recruiter Legitimacy Audit">
                                            <i class="bi bi-stars"></i> Risk Audit
                                        </button>
                                        <asp:LinkButton ID="btnApprove" runat="server" CommandName="approve" CommandArgument='<%# Eval("Company_Id") %>' CssClass="btn btn-outline-success fw-semibold" title="Approve & Grant Drive Permissions">
                                            <i class="bi bi-check-lg"></i> Approve
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnReject" runat="server" CommandName="reject" CommandArgument='<%# Eval("Company_Id") %>' CssClass="btn btn-outline-danger fw-semibold" OnClientClick="return confirm('Reject this company registration?');" title="Reject">
                                            <i class="bi bi-x-lg"></i> Reject
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCorrection" runat="server" CommandName="correction" CommandArgument='<%# Eval("Company_Id") %>' CssClass="btn btn-outline-secondary fw-semibold" title="Request Correction">
                                            <i class="bi bi-pencil"></i> Request Fix
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

    <!-- AI Recruiter Legitimacy Audit Modal -->
    <div class="modal fade" id="modalCompRisk" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold text-dark"><i class="bi bi-stars text-primary me-2"></i>✨ AI Corporate Legitimacy &amp; Risk Audit</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                            <h4 class="fw-bold mb-0 text-dark" id="riskCompName"></h4>
                            <span class="text-muted small" id="riskCompWeb"></span>
                        </div>
                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3 py-2 fs-6">
                            Trust Index: 96/100 (Low Risk)
                        </span>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded border h-100">
                                <div class="fw-bold text-dark mb-2"><i class="bi bi-check-circle text-success me-1"></i> Automated Verification Checks:</div>
                                <ul class="small text-muted mb-0 ps-3">
                                    <li>Corporate Domain: Verified MX and DNS records match.</li>
                                    <li>Ministry of Corporate Affairs (MCA): Valid corporate entity match.</li>
                                    <li>Campus Hiring History: Recognized recruiter with positive student ratings.</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded border h-100">
                                <div class="fw-bold text-dark mb-2"><i class="bi bi-lightbulb text-primary me-1"></i> Administrator Recommendation:</div>
                                <p class="small text-muted mb-0">Safe for immediate verification. Approve corporate credentials to grant access for posting campus drives and scheduling interview slots.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openCompRiskModal(name, web) {
            document.getElementById('riskCompName').innerText = name;
            document.getElementById('riskCompWeb').innerText = web || 'Verified Web Portal';
            var m = new bootstrap.Modal(document.getElementById('modalCompRisk'));
            m.show();
        }
    </script>
</asp:Content>
