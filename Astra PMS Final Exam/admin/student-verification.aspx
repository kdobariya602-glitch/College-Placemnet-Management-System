<%@ Page Title="Student Document Verification" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="student-verification.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.student_verification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .stat-card-custom {
            border-radius: 14px;
            padding: 1.25rem;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .stat-card-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
        }
        .stat-icon-wrapper {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <!-- Breadcrumb & Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-2">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="students.aspx">People Management</a></li>
                        <li class="breadcrumb-item active">Verification Desk</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Central Student Credential Verification</h3>
                <p class="text-muted small mb-0">Institutional compliance oversight for candidate mark sheets, degree certificates, and identity documents.</p>
            </div>
            <div class="d-flex gap-2">
                <asp:LinkButton ID="btnBulkVerify" runat="server" CssClass="btn btn-outline-success fw-semibold" OnClick="btnBulkVerify_Click" OnClientClick="return confirm('Verify and approve all pending documents currently shown in the queue?');">
                    <i class="bi bi-check-all me-1"></i> Verify All Pending
                </asp:LinkButton>
            </div>
        </div>

        <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="students.aspx"><i class="bi bi-person-lines-fill me-1"></i> Students Directory</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="student-verification.aspx"><i class="bi bi-patch-check me-1"></i> Student Verification</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-tpo.aspx"><i class="bi bi-person-badge me-1"></i> TPO Management</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <!-- KPI Row -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="card stat-card-custom border-0 shadow-sm d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon-wrapper bg-warning bg-opacity-10 text-warning">
                        <i class="bi bi-clock-history"></i>
                    </div>
                    <div>
                        <div class="fs-4 fw-bold text-dark"><asp:Label ID="lblPendingCount" runat="server" Text="0"></asp:Label></div>
                        <div class="text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Pending Audit</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="card stat-card-custom border-0 shadow-sm d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon-wrapper bg-success bg-opacity-10 text-success">
                        <i class="bi bi-patch-check-fill"></i>
                    </div>
                    <div>
                        <div class="fs-4 fw-bold text-dark"><asp:Label ID="lblVerifiedCount" runat="server" Text="0"></asp:Label></div>
                        <div class="text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Verified Records</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="card stat-card-custom border-0 shadow-sm d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon-wrapper bg-danger bg-opacity-10 text-danger">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                    </div>
                    <div>
                        <div class="fs-4 fw-bold text-dark"><asp:Label ID="lblRejectedCount" runat="server" Text="0"></asp:Label></div>
                        <div class="text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Rejected / Resubmit</div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="card stat-card-custom border-0 shadow-sm d-flex flex-row align-items-center gap-3">
                    <div class="stat-icon-wrapper bg-primary bg-opacity-10 text-primary">
                        <i class="bi bi-folder-check"></i>
                    </div>
                    <div>
                        <div class="fs-4 fw-bold text-dark"><asp:Label ID="lblTotalCount" runat="server" Text="0"></asp:Label></div>
                        <div class="text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Total Documents</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter & Search Card -->
        <div class="content-card mb-4 p-3">
            <div class="row g-2 align-items-center">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text bg-transparent"><i class="bi bi-search"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by student name, enrollment, or email..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlDocTypeFilter" runat="server" CssClass="form-select">
                        <asp:ListItem Text="All Document Types" Value="All"></asp:ListItem>
                        <asp:ListItem Text="10th Class Marksheet" Value="10th Class Marksheet"></asp:ListItem>
                        <asp:ListItem Text="12th Class Marksheet" Value="12th Class Marksheet"></asp:ListItem>
                        <asp:ListItem Text="Graduation Transcript" Value="Graduation Transcript"></asp:ListItem>
                        <asp:ListItem Text="Government ID" Value="Government ID"></asp:ListItem>
                        <asp:ListItem Text="Resume" Value="Resume"></asp:ListItem>
                        <asp:ListItem Text="Experience Certificate" Value="Experience Certificate"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select">
                        <asp:ListItem Text="All Statuses" Value="All"></asp:ListItem>
                        <asp:ListItem Text="Pending Verification" Value="Pending" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Verified" Value="Verified"></asp:ListItem>
                        <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-primary w-100 fw-semibold" OnClick="btnFilter_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <!-- Verification Queue Table -->
        <div class="content-card">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-list-check text-primary me-2"></i>Institutional Document Verification Queue</h5>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25">Admin Central Desk</span>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvDocVerification" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Document_Id" OnRowCommand="gvDocVerification_RowCommand"
                        AllowPaging="True" PageSize="12" OnPageIndexChanging="gvDocVerification_PageIndexChanging"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-patch-check-fill fs-1 text-success d-block mb-3"></i>
                                <h5>Verification Queue All Clear!</h5>
                                <p class="mb-0">There are no pending documents matching your filter criteria.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Candidate Details">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Student_Name") != null && Eval("Student_Name") != DBNull.Value ? Eval("Student_Name") : Eval("Student_Email") %></div>
                                    <div class="small text-muted"><i class="bi bi-person-vcard me-1"></i>Enroll: <%# Eval("Enrollment_No") != null && Eval("Enrollment_No") != DBNull.Value ? Eval("Enrollment_No") : "N/A" %> &bull; <%# Eval("Branch") != null && Eval("Branch") != DBNull.Value ? Eval("Branch") : "Student" %></div>
                                    <div class="small text-primary"><i class="bi bi-envelope me-1"></i><%# Eval("Student_Email") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Document Info">
                                <ItemTemplate>
                                    <div class="fw-semibold text-dark"><%# Eval("Document_Type") %></div>
                                    <div class="small text-muted"><i class="bi bi-file-earmark-text me-1"></i><%# Eval("Document_Name") %></div>
                                    <div class="small text-secondary"><i class="bi bi-calendar3 me-1"></i>Uploaded: <%# Eval("Upload_Date", "{0:dd MMM yyyy, hh:mm tt}") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Current Status">
                                <ItemTemplate>
                                    <span class='<%# Eval("Verification_Status") != null && Convert.ToString(Eval("Verification_Status")) == "Verified" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Eval("Verification_Status") != null && Convert.ToString(Eval("Verification_Status")) == "Rejected" ? "badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25" : "badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25") %>'>
                                        <%# Eval("Verification_Status") != null && Eval("Verification_Status") != DBNull.Value ? Eval("Verification_Status") : "Pending" %>
                                    </span>
                                    <div class="small text-muted mt-1" style="max-width:220px; font-size:0.75rem;"><%# Eval("Remarks") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Auditor">
                                <ItemTemplate>
                                    <span class="small fw-semibold text-secondary">
                                        <%# Eval("Verified_By") != null && Eval("Verified_By") != DBNull.Value && !string.IsNullOrEmpty(Convert.ToString(Eval("Verified_By"))) ? Convert.ToString(Eval("Verified_By")) : "Pending" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-end">
                                <ItemTemplate>
                                    <div class="btn-group btn-group-sm">
                                        <a href='<%# GetDocumentUrl(Eval("File_Path")) %>' class="btn btn-outline-primary fw-semibold" target="_blank" title="Inspect Document">
                                            <i class="bi bi-eye"></i> View
                                        </a>
                                        <a href='<%# GetDocumentUrl(Eval("File_Path")) %>' class="btn btn-outline-secondary" download title="Download">
                                            <i class="bi bi-download"></i>
                                        </a>
                                        <asp:LinkButton ID="btnApprove" runat="server" CommandName="approve_doc" CommandArgument='<%# Eval("Student_Id") %>' CssClass="btn btn-outline-success fw-semibold" title="Approve & Verify">
                                            <i class="bi bi-check-lg"></i> Approve
                                        </asp:LinkButton>
                                        <button type="button" class="btn btn-outline-danger fw-semibold" data-bs-toggle="modal" data-bs-target="#rejectModal" onclick="prepareReject('<%# Eval("Document_Id") %>', '<%# Eval("Document_Type") %>');" title="Reject / Ask Fix">
                                            <i class="bi bi-x-lg"></i> Reject
                                        </button>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Reject Remarks Modal -->
    <div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="rejectModalLabel"><i class="bi bi-exclamation-octagon text-danger me-2"></i>Reject / Request Correction</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <asp:HiddenField ID="hfRejectDocId" runat="server" ClientIDMode="Static" />
                    <p class="small text-muted mb-3">Provide feedback to the candidate detailing why this document cannot be verified, so they can re-upload a compliant file.</p>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Reason / Audit Remark <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtRejectRemark" runat="server" ClientIDMode="Static" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="e.g. Scanned copy is illegible/blurry. Please upload a clear color PDF with all 4 corners visible."></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnConfirmReject" runat="server" Text="Confirm Rejection & Notify Student" CssClass="btn btn-danger fw-semibold" OnClick="btnConfirmReject_Click" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function prepareReject(id, docType) {
            document.getElementById('hfRejectDocId').value = id;
            var txt = document.getElementById('txtRejectRemark');
            if (txt) {
                txt.value = 'Clear copy required for ' + docType + '. Please re-upload verified document.';
            }
        }
    </script>
</asp:Content>
