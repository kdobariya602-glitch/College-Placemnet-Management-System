<%@ Page Title="Company Profile" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.profile" %>

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
                        <li class="breadcrumb-item active">Company Details</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Corporate Recruiter Profile & Settings</h3>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="profile.aspx"><i class="bi bi-building me-1"></i> Company Profile</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="change-password.aspx"><i class="bi bi-key me-1"></i> Change Password</a>
            </li>
        </ul>

        <div class="row g-4">
            <!-- Left Info Card -->
            <div class="col-lg-4">
                <div class="content-card p-4 text-center mb-4 border-0 shadow-sm">
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
                    <h5 class="fw-bold text-dark mb-1"><asp:Label ID="lblCompanyName" runat="server"></asp:Label></h5>
                    <p class="text-muted small mb-2"><i class="bi bi-briefcase me-1"></i><asp:Label ID="lblIndustry" runat="server"></asp:Label></p>
                    <asp:Label ID="lblVerificationBadge" runat="server" CssClass="badge bg-success px-3 py-2 rounded-pill"></asp:Label>

                    <hr class="my-4 text-muted" />

                    <div class="text-start small">
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                            <span class="text-muted"><i class="bi bi-envelope me-1"></i> Corporate Email:</span>
                            <span class="fw-semibold text-dark text-truncate ms-2"><asp:Label ID="lblEmail" runat="server"></asp:Label></span>
                        </div>
                    </div>
                </div>

                <!-- Recruiter Verification Notice -->
                <div class="content-card p-4 border-0 shadow-sm bg-light">
                    <h6 class="fw-bold text-dark mb-2"><i class="bi bi-patch-check-fill text-success me-2"></i>Official Partner Status</h6>
                    <p class="text-muted small mb-0">Your profile details are shown to registered students when they apply to your campus placement drives and internships.</p>
                </div>
            </div>

            <!-- Right Edit Form -->
            <div class="col-lg-8">
                <div class="content-card border-0 shadow-sm">
                    <div class="card-header-custom p-4 border-bottom bg-white d-flex align-items-center justify-content-between">
                        <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-building-gear text-primary me-2"></i>Corporate Profile & Recruitment Details</h5>
                        <span class="badge bg-primary bg-opacity-10 text-primary border small">Corporate Account</span>
                    </div>
                    <div class="card-body-custom p-4">
                        <h6 class="text-muted fw-bold text-uppercase small mb-3" style="letter-spacing:0.5px;">Company Overview</h6>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Company Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtCompName" runat="server" CssClass="form-control" placeholder="Official Registered Name"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Corporate Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control bg-light" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Industry Sector</label>
                                <asp:DropDownList ID="ddlIndustry" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Information Technology" Value="Information Technology"></asp:ListItem>
                                    <asp:ListItem Text="Financial Services / Fintech" Value="Financial Services / Fintech"></asp:ListItem>
                                    <asp:ListItem Text="Automotive & Mobility" Value="Automotive & Mobility"></asp:ListItem>
                                    <asp:ListItem Text="HealthTech & Pharmaceuticals" Value="HealthTech & Pharmaceuticals"></asp:ListItem>
                                    <asp:ListItem Text="Consulting & Advisory" Value="Consulting & Advisory"></asp:ListItem>
                                    <asp:ListItem Text="Manufacturing & Core" Value="Manufacturing & Core"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted"><i class="bi bi-globe me-1 text-primary"></i>Official Website</label>
                                <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control" placeholder="https://www.company.com"></asp:TextBox>
                            </div>
                        </div>

                        <h6 class="text-muted fw-bold text-uppercase small mb-3 border-top pt-3" style="letter-spacing:0.5px;">HR & Campus Point of Contact</h6>
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Lead HR Contact Person <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtHRName" runat="server" CssClass="form-control" placeholder="Full name of Lead HR"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">HR Contact Phone <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Direct contact number"></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold small text-muted">Headquarters / Office Location</label>
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="City, State, Country"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mt-4 pt-3 border-top d-flex justify-content-end">
                            <asp:Button ID="btnSaveProfile" runat="server" Text="Save Company Profile" CssClass="btn btn-primary fw-semibold px-4 py-2" OnClick="btnSaveProfile_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
