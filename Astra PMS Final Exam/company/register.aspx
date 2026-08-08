<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link href="../assets/css/style.css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->

  <div class="auth-wrapper" style="background:linear-gradient(135deg, rgba(13,27,62,.45), rgba(21,68,173,.45)), url('../assets/images/company-login.jpg') center/cover no-repeat;">
    <div class="auth-card" style="max-width:960px">
      <div class="row g-0">
        <div class="col-lg-5 auth-brand d-none d-lg-flex" style="background:linear-gradient(135deg, rgba(21,68,173,.55), rgba(13,27,62,.65)), url('../assets/images/company-login.jpg') center/cover no-repeat;">
          <div>
            <div class="auth-logo"><svg width="32" height="32" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
              <rect x="1" y="1" width="46" height="46" rx="14" fill="#0d1b3e"/>
              <path d="M24 9L34.5 31.5H30L28 27H20L18 31.5H13.5L24 9Z" fill="#ffffff"/>
              <rect x="20.8" y="22.5" width="6.4" height="2.6" fill="#0d1b3e"/>
              <circle cx="34" cy="13.5" r="3.2" fill="#f5a524"/>
            </svg></div>
            <h1>Company Portal</h1>
            <p class="opacity-75 mb-4">Register your company to post jobs, review applications, and hire talent from Parul University.</p>
          </div>
        </div>
        <div class="col-lg-7 auth-form">
        <div class="text-center mb-4">
          <div class="auth-logo mx-auto"><svg width="32" height="32" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
              <rect x="1" y="1" width="46" height="46" rx="14" fill="#0d1b3e"/>
              <path d="M24 9L34.5 31.5H30L28 27H20L18 31.5H13.5L24 9Z" fill="#ffffff"/>
              <rect x="20.8" y="22.5" width="6.4" height="2.6" fill="#0d1b3e"/>
              <circle cx="34" cy="13.5" r="3.2" fill="#f5a524"/>
            </svg></div>
          <h4 class="fw-bold">Company Registration</h4>
          <p class="text-muted">Create your account to start hiring on campus</p>
        </div>
        <div id="registerForm">
          <div class="row">
            <div class="col-md-6 mb-3"><label class="form-label-custom">Company Name</label><asp:TextBox runat="server" ID="companyName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
            <div class="col-md-6 mb-3"><label class="form-label-custom">Email</label><asp:TextBox runat="server" ID="email" ClientIDMode="Static" TextMode="Email" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3"><label class="form-label-custom">Password</label><asp:TextBox runat="server" ID="password" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" required="required" minlength="6"></asp:TextBox></div>
            <div class="col-md-6 mb-3"><label class="form-label-custom">Contact Number</label><asp:TextBox runat="server" ID="contact" ClientIDMode="Static" TextMode="Phone" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3"><label class="form-label-custom">Industry</label><asp:TextBox runat="server" ID="industry" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" placeholder="IT Services, Manufacturing..." required="required"></asp:TextBox></div>
            <div class="col-md-6 mb-3"><label class="form-label-custom">Location</label><asp:TextBox runat="server" ID="location" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
          </div>
          <div class="mb-3"><label class="form-label-custom">Website</label><asp:TextBox runat="server" ID="website" ClientIDMode="Static" TextMode="Url" CssClass="form-control form-control-custom" placeholder="https://example.com"></asp:TextBox></div>
          <div class="mb-3"><label class="form-label-custom">Company Description</label><asp:TextBox runat="server" ID="description" ClientIDMode="Static" TextMode="MultiLine" Rows="3" CssClass="form-control form-control-custom" placeholder="Brief description about the company"></asp:TextBox></div>
<%--          <button type="button" id="registerBtn" class="btn btn-primary-custom w-100 py-2 mb-3">Register</button>--%>
            <asp:ImageButton ID="registerBtn" runat="server" ClientIDMode="Static" ImageUrl="~/assets/images/Register2.png" CssClass="w-100" Style="height: 35px; border-radius: 99px;" OnClientClick="Company.register(); return false;"/>
        </div>
        <p class="text-center text-muted small">Already have an account? <a href="login.aspx" class="text-danger">Login here</a></p>
        <p class="text-center text-muted small mb-0"><a href="../index.aspx"><i class="bi bi-arrow-left me-1"></i>Back to Home</a></p>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/company.js"></script>

<!-- ============================= BODY END ============================= -->

</asp:Content>