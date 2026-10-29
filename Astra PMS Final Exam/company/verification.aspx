<%@ Page Title="Corporate Verification" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="verification.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.verification" %>

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
                        <li class="breadcrumb-item">Company Profile & Settings</li>
                        <li class="breadcrumb-item active">Verification & Docs</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Corporate Verification & Authorization Status</h3>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="verification.aspx"><i class="bi bi-patch-check me-1"></i> Verification & Documents</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="employees.aspx"><i class="bi bi-person-badge me-1"></i> HR Team & Contacts</a>
            </li>
        </ul>

        <!-- Status Card -->
        <div class="content-card mb-4 p-4">
            <div class="d-flex align-items-center justify-content-between">
                <div>
                    <h5 class="fw-bold text-dark mb-1">Authorization Status: <asp:Label ID="lblStatusText" runat="server"></asp:Label></h5>
                    <p class="text-muted small mb-0"><asp:Label ID="lblStatusDesc" runat="server"></asp:Label></p>
                </div>
                <div>
                    <asp:Label ID="lblStatusBadge" runat="server" CssClass="badge fs-6 px-3 py-2"></asp:Label>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left: Legal Registration Details -->
            <div class="col-lg-5">
                <div class="content-card h-100">
                    <div class="card-header-custom p-3 border-bottom">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-shield-check text-primary me-2"></i>Corporate Identification</h5>
                    </div>
                    <div class="card-body-custom p-4">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Corporate Registration / CIN Number</label>
                            <asp:TextBox ID="txtCIN" runat="server" CssClass="form-control" placeholder="e.g. L72200KA1981PLC013115"></asp:TextBox>
                            <span class="text-muted small">Official Government Registration or MCA CIN</span>
                        </div>

                        <div class="p-3 border rounded bg-light mb-4">
                            <h6 class="fw-bold text-dark mb-2"><i class="bi bi-patch-check text-success me-2"></i>Why Verification?</h6>
                            <p class="text-muted small mb-0">
                                Astra University Placement Cell verifies all corporate recruiters to ensure legitimate employment offers for students. Once verified, your job postings will instantly reach eligible candidates.
                            </p>
                        </div>

                        <div>
                            <asp:Button ID="btnSubmitVerification" runat="server" Text="Update Registration No." CssClass="btn btn-primary fw-semibold px-4 w-100" OnClick="btnSubmitVerification_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Upload Official Verification Documents -->
            <div class="col-lg-7">
                <div class="content-card mb-4">
                    <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-file-earmark-arrow-up text-primary me-2"></i>Upload Verification Proof</h5>
                    </div>
                    <div class="card-body-custom p-4">
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Document Type</label>
                                <asp:DropDownList ID="ddlDocType" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="Certificate of Incorporation">Certificate of Incorporation</asp:ListItem>
                                    <asp:ListItem Value="GST Registration Certificate">GST Registration Certificate</asp:ListItem>
                                    <asp:ListItem Value="Company PAN Card">Company PAN Card</asp:ListItem>
                                    <asp:ListItem Value="Authorization Letter">Authorization Letter</asp:ListItem>
                                    <asp:ListItem Value="Other Legal Proof">Other Legal Proof</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Document Title / Note</label>
                                <asp:TextBox ID="txtDocTitle" runat="server" CssClass="form-control" placeholder="e.g. MCA Incorporation Cert"></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Select File (PDF, PNG, JPG - max 5MB)</label>
                                <asp:FileUpload ID="fuCompanyDoc" runat="server" CssClass="form-control" />
                            </div>
                        </div>
                        <asp:Button ID="btnUploadDoc" runat="server" Text="Upload Document for Verification" CssClass="btn btn-outline-primary fw-semibold" OnClick="btnUploadDoc_Click" />
                    </div>
                </div>

                <!-- Uploaded Documents List -->
                <div class="content-card">
                    <div class="card-header-custom p-3 border-bottom">
                        <h6 class="mb-0 fw-bold text-dark"><i class="bi bi-folder2-open text-primary me-2"></i>Submitted Documents</h6>
                    </div>
                    <div class="card-body-custom p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvCompanyDocs" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover align-middle mb-0" GridLines="None"
                                DataKeyNames="Company_Doc_Id" OnRowCommand="gvCompanyDocs_RowCommand"
                                UseAccessibleHeader="True">
                                <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                                <EmptyDataTemplate>
                                    <div class="text-center py-4 text-muted">
                                        No verification documents uploaded yet.
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:TemplateField HeaderText="Document">
                                        <ItemTemplate>
                                            <div class="fw-bold text-dark"><%# Eval("Document_Name") %></div>
                                            <span class="text-muted small"><%# Eval("Document_Type") %> &bull; <%# Eval("Upload_Date", "{0:dd MMM yyyy}") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <span class='<%# Convert.ToString(Eval("Verification_Status")) == "Verified" ? "badge bg-success" : "badge bg-warning text-dark" %>'>
                                                <%# Eval("Verification_Status") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                        <ItemTemplate>
                                            <a href='<%# ResolveUrl("~/" + Convert.ToString(Eval("File_Path")).TrimStart('~', '/')) %>' target="_blank" class="btn btn-sm btn-outline-primary me-1" title="View Document"><i class="bi bi-eye"></i></a>
                                            <a href='<%# ResolveUrl("~/" + Convert.ToString(Eval("File_Path")).TrimStart('~', '/')) %>' download class="btn btn-sm btn-outline-secondary me-1" title="Download Document"><i class="bi bi-download"></i></a>
                                            <asp:LinkButton ID="btnDelDoc" runat="server" CommandName="delete_doc" CommandArgument='<%# Eval("Company_Id") %>' CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete this document?');"><i class="bi bi-trash"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
