<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Astra_PMS_Final_Exam.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="../assets/css/style.css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->
    <div class="auth-wrapper" style="background: linear-gradient(135deg, rgba(13,27,62,.45), rgba(21,68,173,.45)), url('../assets/images/student-login-register.png') center/cover no-repeat;">
        <div class="auth-card">
            <div class="row g-0">
                <div class="col-lg-5 auth-brand d-none d-lg-flex" style="background: linear-gradient(135deg, rgba(21,68,173,.55), rgba(13,27,62,.65)), url('../assets/images/student-login-register.png') center/cover no-repeat;">
                    <div>
                        <div class="auth-logo">
                            <svg width="32" height="32" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                                <rect x="1" y="1" width="46" height="46" rx="14" fill="#0d1b3e" />
                                <path d="M24 9L34.5 31.5H30L28 27H20L18 31.5H13.5L24 9Z" fill="#ffffff" />
                                <rect x="20.8" y="22.5" width="6.4" height="2.6" fill="#0d1b3e" />
                                <circle cx="34" cy="13.5" r="3.2" fill="#f5a524" />
                            </svg>
                        </div>
                        <h1>Student Portal</h1>
                        <p class="opacity-75 mb-4">Browse jobs, apply to companies, track applications, and monitor your placement status.</p>
                    </div>
                </div>
                <div class="col-lg-7 auth-form">
                    <h4 class="fw-bold mb-1">Student Login</h4>
                    <p class="text-muted mb-4">Sign in to your student account</p>
                    <div id="loginForm">
                        <!-- <div class="mb-3"><label class="form-label-custom">Email</label><input type="email" class="form-control form-control-custom" id="email" value="aarav@student.edu" required></div> -->
                        <div class="mb-3">
                            <label class="form-label-custom">Email</label><asp:TextBox runat="server" ID="email" ClientIDMode="Static" TextMode="Email" CssClass="form-control form-control-custom" Text="aarav@student.edu" required="required"></asp:TextBox></div>
                        <!-- <div class="mb-3"><label class="form-label-custom">Password</label><input type="password" class="form-control form-control-custom" id="password" value="student123" required></div> -->
                        <div class="mb-3">
                            <label class="form-label-custom">Password</label><asp:TextBox runat="server" ID="password" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" Text="student123" required="required"></asp:TextBox></div>
                        <div class="text-end mb-3"><a href="#" class="small text-danger" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">Forgot password?</a></div>      
                        <%-- <button type="button" id="signInBtn" class="btn btn-primary-custom w-100 py-2 mb-3">Sign In</button> --%>
                        <asp:ImageButton ID="signInBtn" runat="server" ClientIDMode="Static" ImageUrl="~/assets/images/signin.jpeg" CssClass="w-100 mb-3" Style="height: 40px; border-radius: 12px;" OnClientClick="return false;" />
                    </div>
                    <p class="text-center text-muted small">Don't have an account? <a href="register.aspx" class="text-danger">Register</a></p>
                    <p class="text-center text-muted small mb-0"><a href="../index.aspx"><i class="bi bi-arrow-left me-1"></i>Back to Home</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Forgot Password Modal -->
    <div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-key me-2"></i>Reset Password</h5>
                    <button type="button" id="closeModalBtn" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="text-muted small">Enter your registered email and a new password.</p>
                    <div id="forgotPasswordForm">
                        <div class="mb-3">
                            <label class="form-label-custom">Registered Email</label>
                            <!-- <input type="email" class="form-control form-control-custom" id="resetEmail" placeholder="Enter your registered email" required> -->
                            <asp:TextBox runat="server" ID="resetEmail" ClientIDMode="Static" TextMode="Email" CssClass="form-control form-control-custom" placeholder="Enter your registered email" required="required"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label-custom">New Password</label>
                            <!-- <input type="password" class="form-control form-control-custom" id="resetNewPassword" placeholder="Enter new password" minlength="6" required> -->
                            <asp:TextBox runat="server" ID="resetNewPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" placeholder="Enter new password" minlength="6" required="required"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label-custom">Confirm New Password</label>
                            <!-- <input type="password" class="form-control form-control-custom" id="resetConfirmPassword" placeholder="Confirm new password" minlength="6" required> -->
                            <asp:TextBox runat="server" ID="resetConfirmPassword" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" placeholder="Confirm new password" minlength="6" required="required"></asp:TextBox>
                        </div>
<%--                        <button type="button" id="resetBtn" class="btn btn-primary-custom w-100 py-2">Reset Password</button>--%>
                        <asp:ImageButton ID="resetBtn" runat="server" ClientIDMode="Static" ImageUrl="~/assets/images/Sign in.png" CssClass="w-100" Style="height: 45px; border-radius: 99px;" OnClientClick="handleResetPassword(); return false;" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../assets/js/data.js"></script>
    <script src="../assets/js/app.js"></script>
    <script>
        const signInBtn = document.getElementById('signInBtn');
        if (signInBtn) {
            signInBtn.addEventListener('click', () => {
                if (App.login(document.getElementById('email').value, document.getElementById('password').value, 'student')) {
                    App.showToast('Welcome back!');
                    setTimeout(() => window.location.href = 'dashboard.aspx', 800);
                } else App.showToast('Invalid credentials', 'error');
            });
        }

        function handleResetPassword() {
            const email = document.getElementById('resetEmail').value.trim();
            const newPassword = document.getElementById('resetNewPassword').value;
            const confirmPassword = document.getElementById('resetConfirmPassword').value;

            if (newPassword !== confirmPassword) {
                App.showToast('Passwords do not match', 'error');
                return;
            }

            if (App.resetPassword(email, newPassword, 'student')) {
                App.showToast('Password reset successful! Please sign in.');
                bootstrap.Modal.getInstance(document.getElementById('forgotPasswordModal')).hide();
                document.getElementById('resetEmail').value = '';
                document.getElementById('resetNewPassword').value = '';
                document.getElementById('resetConfirmPassword').value = '';
                document.getElementById('email').value = email;
                document.getElementById('password').value = '';
            } else {
                App.showToast('No account found with this email', 'error');
            }
        }
    </script>

    <!-- ============================= BODY END ============================= -->
</asp:Content>
