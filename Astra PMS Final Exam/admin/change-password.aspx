<%@ Page Title="Change Admin Password" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="change-password.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.change_password" %>

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
                        <li class="breadcrumb-item active">Change Password</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Change Administrator Password</h3>
                <p class="text-muted small mb-0">Update your central administrator portal password to maintain institutional system security.</p>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="profile.aspx"><i class="bi bi-person-gear me-1"></i> Profile Details</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="change-password.aspx"><i class="bi bi-key me-1"></i> Change Password</a>
            </li>
        </ul>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </asp:Panel>

        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-6">
                <div class="card border-0 shadow-sm p-4">
                    <div class="d-flex align-items-center mb-4 pb-3 border-bottom">
                        <div class="rounded-3 p-3 bg-primary bg-opacity-10 text-primary me-3">
                            <i class="bi bi-shield-lock-fill fs-3"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-1">Update Security Password</h5>
                            <div class="text-muted small">Enter your current password and set a secure administrator password.</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small text-muted">Current Password <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter current password"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small text-muted">New Password <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter new password (min 6 chars)"></asp:TextBox>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold small text-muted">Confirm New Password <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Re-enter new password"></asp:TextBox>
                    </div>

                    <div class="p-3 bg-light rounded-3 small text-muted mb-4 border">
                        <div class="fw-semibold text-dark mb-1"><i class="bi bi-info-circle me-1 text-primary"></i>Security Guidelines:</div>
                        <ul class="mb-0 ps-3">
                            <li>Choose a strong password with letters, digits, and special characters.</li>
                            <li>Password will be immediately updated for your central administrator login session.</li>
                        </ul>
                    </div>

                    <asp:Button ID="btnChangePassword" runat="server" Text="Update Security Password" CssClass="btn btn-primary w-100 py-2 fw-semibold" OnClick="btnChangePassword_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
