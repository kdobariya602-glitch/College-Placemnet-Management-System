<%@ Page Title="Admin Profile" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.profile" %>

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
                        <li class="breadcrumb-item"><a href="profile.aspx">Profile & Account</a></li>
                        <li class="breadcrumb-item active">Profile</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">System Administrator Account</h3>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="profile.aspx"><i class="bi bi-person-gear me-1"></i> Profile Details</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="change-password.aspx"><i class="bi bi-key me-1"></i> Change Password</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <div class="row g-4">
            <!-- Left Info Card -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm p-4 text-center mb-4">
                    <div class="text-center mb-3">
                        <div class="position-relative d-inline-block mb-2">
                            <asp:Image ID="imgProfile" runat="server" CssClass="rounded-circle shadow border border-3 border-primary" style="width:110px; height:110px; object-fit:cover;" ImageUrl="../assets/images/default-avatar.svg" />
                        </div>
                        <div class="mt-2 text-center" style="max-width:260px; margin:0 auto;">
                            <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control form-control-sm mb-2" accept=".jpg,.jpeg,.png,.gif" />
                            <div class="d-flex justify-content-center gap-2">
                                <asp:Button ID="btnUploadPhoto" runat="server" Text="Upload Photo" CssClass="btn btn-sm btn-primary fw-semibold" OnClick="btnUploadPhoto_Click" />
                                <asp:Button ID="btnDeletePhoto" runat="server" Text="Delete Photo" CssClass="btn btn-sm btn-outline-danger fw-semibold" OnClick="btnDeletePhoto_Click" OnClientClick="return confirm('Are you sure you want to delete your profile photo?');" />
                            </div>
                            <asp:Label ID="lblPhotoMsg" runat="server" CssClass="d-block mt-2 small fw-semibold"></asp:Label>
                        </div>
                    </div>
                    <h5 class="fw-bold text-dark mb-1"><asp:Label ID="lblAdminName" runat="server" Text="Administrator"></asp:Label></h5>
                    <p class="text-muted small mb-2"><i class="bi bi-shield-check me-1"></i><asp:Label ID="lblAdminRole" runat="server" Text="Super Administrator"></asp:Label></p>
                    <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-3 py-2 rounded-pill">
                        <i class="bi bi-check-circle-fill me-1"></i> Root Access Active
                    </span>

                    <hr class="my-4 text-muted" />

                    <div class="text-start small">
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                            <span class="text-muted"><i class="bi bi-person me-1"></i> Username:</span>
                            <span class="fw-bold text-dark"><asp:Label ID="lblUsername" runat="server"></asp:Label></span>
                        </div>
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                            <span class="text-muted"><i class="bi bi-envelope me-1"></i> Contact Email:</span>
                            <span class="fw-bold text-dark text-truncate ms-2"><asp:Label ID="lblEmail" runat="server"></asp:Label></span>
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm p-4 bg-light bg-opacity-50">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-shield-lock-fill text-primary me-2"></i>Institutional Governance</h6>
                    <p class="text-muted small mb-0">System Administrators have full authority over university placement batches, departments, company approvals, and audit trail logs.</p>
                </div>
            </div>

            <!-- Right Edit Forms -->
            <div class="col-lg-8">
                <!-- Profile Information Form -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header-custom p-4 border-bottom bg-white d-flex align-items-center justify-content-between">
                        <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-person-gear text-primary me-2"></i>Administrator Account Information</h5>
                        <span class="badge bg-dark bg-opacity-10 text-dark border border-dark border-opacity-25 small fw-semibold">System Root</span>
                    </div>
                    <div class="card-body-custom p-4">
                        <h6 class="text-muted fw-bold text-uppercase small mb-3" style="letter-spacing:0.5px;">Admin Details</h6>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Full Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Administrator legal name"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Email Address <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Official admin email"></asp:TextBox>
                            </div>
                        </div>
                        <div class="pt-3 border-top d-flex justify-content-end">
                            <asp:Button ID="btnSaveProfile" runat="server" Text="Update Profile" CssClass="btn btn-primary fw-semibold px-4 py-2" OnClick="btnSaveProfile_Click" />
                        </div>
                    </div>
                </div>

                <!-- Change Password Form -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header-custom p-4 border-bottom bg-white">
                        <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-key-fill text-primary me-2"></i>Security Password Credentials</h5>
                    </div>
                    <div class="card-body-custom p-4">
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">New Password <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter new password"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Confirm Password <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Re-enter new password"></asp:TextBox>
                            </div>
                        </div>
                        <div class="pt-3 border-top d-flex justify-content-end">
                            <asp:Button ID="btnChangePassword" runat="server" Text="Update Security Password" CssClass="btn btn-primary fw-semibold px-4 py-2" OnClick="btnChangePassword_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
