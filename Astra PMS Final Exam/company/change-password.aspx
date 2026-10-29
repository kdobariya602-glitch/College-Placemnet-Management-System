<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="change-password.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.change_password" %>

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
                        <li class="breadcrumb-item active">Change Password</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Change Password</h3>
                <p class="text-muted small mb-0">Update your recruiter account credentials to keep your corporate portal secure.</p>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="profile.aspx"><i class="bi bi-building me-1"></i> Company Profile</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="change-password.aspx"><i class="bi bi-key me-1"></i> Change Password</a>
            </li>
        </ul>

        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-shield-lock text-primary me-2"></i>Update Password</h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Current Password <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter current password"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">New Password <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter new password (min 6 characters)"></asp:TextBox>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold small text-muted">Confirm New Password <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm new password"></asp:TextBox>
                        </div>

                        <div class="p-3 bg-light rounded small text-muted mb-4">
                            <div class="fw-semibold text-dark mb-1"><i class="bi bi-info-circle me-1 text-primary"></i>Password Guidelines:</div>
                            <ul class="mb-0 ps-3">
                                <li>Minimum 6 characters in length</li>
                                <li>Include numbers and special symbols for stronger security</li>
                                <li>Do not share recruiter account credentials with unauthorized staff</li>
                            </ul>
                        </div>

                        <asp:Button ID="btnUpdatePassword" runat="server" Text="Update Security Password" CssClass="btn btn-primary w-100 py-2 fw-semibold" OnClick="btnUpdatePassword_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
