<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../assets/js/astra-auth.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <%-- The master links assets/css/astra-public.css with a root-relative path,
         which does not resolve from a sub-folder page. Re-linked here so the
         authentication screens inherit the exact public-site design system. --%>
    <link href="../assets/css/astra-public.css" rel="stylesheet" />

    <link href="../assets/css/astra-auth.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="ContentHeaderEmpty" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <link href="../assets/css/astra-auth-redesign.css" rel="stylesheet" />
    <link href="../assets/css/astra-buttons.css" rel="stylesheet" />
    
    
    
        <script>
    document.addEventListener("DOMContentLoaded", function() {
        if (!document.querySelector(".auth-left-panel")) {
            let leftPanel = document.createElement("div");
            leftPanel.className = "auth-left-panel d-none d-lg-flex";
            leftPanel.innerHTML = `
                <div class="auth-left-content w-100">
                    <!-- Top Logo -->
                    <div class="d-flex align-items-center">
                        <svg width="42" height="42" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <!-- Deep Oxford Blue squircle background -->
    <linearGradient id="crestAdmLogGrad" x1="0" y1="0" x2="48" y2="48" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#1E3A8A"/>
      <stop offset="50%" stop-color="#0F2756"/>
      <stop offset="100%" stop-color="#0B1528"/>
    </linearGradient>
    <!-- Royal Blue 3D Cap -->
    <linearGradient id="crestAdmLogCapGrad" x1="7" y1="7" x2="41" y2="21" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#3B82F6"/>
      <stop offset="50%" stop-color="#2563EB"/>
      <stop offset="100%" stop-color="#1D4ED8"/>
    </linearGradient>
    <!-- Soft Ice-Blue Diploma Paper -->
    <linearGradient id="crestAdmLogPaperGrad" x1="5" y1="28" x2="43" y2="36" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#FFFFFF"/>
      <stop offset="40%" stop-color="#E0F2FE"/>
      <stop offset="100%" stop-color="#BAE6FD"/>
    </linearGradient>
    <!-- Metallic Academic Gold -->
    <linearGradient id="crestAdmLogGoldGrad" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#FDE047"/>
      <stop offset="50%" stop-color="#F59E0B"/>
      <stop offset="100%" stop-color="#D97706"/>
    </linearGradient>
    <filter id="crestAdmLogGlow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="1.5" stdDeviation="1.2" flood-color="#000000" flood-opacity="0.45"/>
    </filter>
  </defs>

  <!-- Luxury Squircle Badge with Gold Rim -->
  <rect x="1.5" y="1.5" width="45" height="45" rx="12" fill="url(#crestAdmLogGrad)" stroke="url(#crestAdmLogGoldGrad)" stroke-width="1.2"/>
  <rect x="3" y="3" width="42" height="42" rx="10.5" fill="none" stroke="rgba(255,255,255,0.12)" stroke-width="0.8"/>

  <!-- 1. DIPLOMA SCROLL (Pepear) - Diagonal in lower section with ice-blue depth -->
  <g transform="rotate(-18 24 32)" filter="url(#crestAdmLogGlow)">
    <!-- Rolled Certificate Body -->
    <rect x="5" y="28.5" width="38" height="7" rx="3.5" fill="url(#crestAdmLogPaperGrad)" stroke="#38BDF8" stroke-width="0.75"/>
    <!-- Rolled Curls at both ends -->
    <ellipse cx="6.5" cy="32" rx="1.6" ry="3.5" fill="#7DD3FC" stroke="#0284C7" stroke-width="0.5"/>
    <ellipse cx="41.5" cy="32" rx="1.6" ry="3.5" fill="#E0F2FE" stroke="#38BDF8" stroke-width="0.5"/>
    <!-- Center Ribbon Band in Royal Blue & Gold -->
    <rect x="21" y="27.5" width="6" height="9" rx="1" fill="#1D4ED8" stroke="url(#crestAdmLogGoldGrad)" stroke-width="0.75"/>
    <!-- Flowing Ribbon Tails -->
    <path d="M21.5 36.5 L18 42.5 L21.5 41 L23.8 42.5 L23.2 36.5 Z" fill="#2563EB"/>
    <path d="M24.5 36.5 L24 42.5 L26.2 41 L29.5 42.5 L26.2 36.5 Z" fill="#1D4ED8"/>
    <!-- Golden Wax Seal Medallion -->
    <circle cx="24" cy="32" r="2.2" fill="url(#crestAdmLogGoldGrad)" stroke="#78350F" stroke-width="0.4"/>
  </g>

  <!-- 2. GRADUATION CAP (Topi) - Royal Blue & Gold 3D Mortarboard -->
  <g filter="url(#crestAdmLogGlow)">
    <!-- Skull Cap Base in deep midnight blue -->
    <path d="M16 17.5 V21.5 C16 24.5 19.5 26.5 24 26.5 C28.5 26.5 32 24.5 32 21.5 V17.5 Z" fill="#0B1528" stroke="#3B82F6" stroke-width="0.6"/>
    <!-- 3D Bevel Facets under diamond -->
    <polygon points="7,13.5 24,20.5 24,22 7,15" fill="#0F172A"/>
    <polygon points="24,20.5 41,13.5 41,15 24,22" fill="#1E293B"/>
    <!-- Diamond Top Face: Rich Royal Blue with gleaming Gold Border -->
    <polygon points="24,6.5 41,13.5 24,20.5 7,13.5" fill="url(#crestAdmLogCapGrad)" stroke="url(#crestAdmLogGoldGrad)" stroke-width="1.2"/>
    <!-- 3D Faceted Lighting on Top Face -->
    <polygon points="24,6.5 41,13.5 24,20.5" fill="#60A5FA" fill-opacity="0.25"/>

    <!-- Center Gold Button -->
    <circle cx="24" cy="13.5" r="2" fill="url(#crestAdmLogGoldGrad)" stroke="#78350F" stroke-width="0.4"/>

    <!-- Flowing Gold Tassel -->
    <path d="M24 13.5 Q34 15 36.5 19.5" fill="none" stroke="url(#crestAdmLogGoldGrad)" stroke-width="1.8" stroke-linecap="round"/>
    <rect x="35.2" y="19.5" width="2.4" height="6.5" rx="1.2" fill="url(#crestAdmLogGoldGrad)" stroke="#78350F" stroke-width="0.3"/>
    <circle cx="36.4" cy="19.5" r="1.1" fill="#92400E"/>
  </g>
</svg>
                        <div class="ms-3">
                            <div class="text-white fw-bold fs-5" style="letter-spacing: -0.01em; line-height: 1.1;">Astra University</div>
                            <small class="text-white-50" style="font-size: 0.72rem; letter-spacing: 0.05em; text-transform: uppercase;">Central System Administration</small>
                        </div>
                    </div>

                    <!-- Middle Content -->
                    <div style="margin: auto 0; padding: 2rem 0;">
                        <span class="badge bg-white bg-opacity-10 text-white border border-white border-opacity-20 px-3 py-2 rounded-pill fw-semibold mb-3">
                            <i class="bi bi-shield-lock-fill me-1 text-warning"></i> ADMINISTRATIVE CONSOLE
                        </span>
                        <h1 class="text-white fw-bolder mb-3" style="font-size: 2.5rem; line-height: 1.15; letter-spacing: -0.03em;">
                            Central Governance,<br><span style="color: #93C5FD;">Complete Control.</span>
                        </h1>
                        <p style="color: #94a3b8; font-size: 1rem; line-height: 1.6; max-width: 380px; margin-bottom: 1.5rem;">
                            Enterprise-grade administration governing master catalogs, user roles, security audits, and university-wide placement compliance.
                        </p>

                        <div class="d-flex flex-column gap-2 mb-2">
                            <div class="auth-feature-pill">
                                <i class="bi bi-shield-lock-fill"></i>
                                <span>Multi-Role Access &amp; Audit Logging</span>
                            </div>
                            <div class="auth-feature-pill">
                                <i class="bi bi-diagram-3-fill"></i>
                                <span>Department, Course &amp; Batch Master Catalogs</span>
                            </div>
                            <div class="auth-feature-pill">
                                <i class="bi bi-graph-up-arrow"></i>
                                <span>Institutional Placement Season Analytics</span>
                            </div>
                        </div>
                    </div>

                    <!-- Bottom Footer -->
                    <div>
                        <div class="d-flex align-items-center gap-3 text-white-50" style="font-size: 0.82rem;">
                            <span>&copy; 2026 Astra University</span>
                            <span>&bull;</span>
                            <span>Enterprise Admin Portal</span>
                        </div>
                    </div>
                </div>
            `;
            document.body.appendChild(leftPanel);
        }
    });
    </script>





    

    <!-- ============================= BODY START (Main Page Content) ============================= -->
    <div class="admin-login-page">

    <section class="ap-hero ap-page-hero ap-auth-hero">
        <div class="ap-grid-dots"></div>
        <div class="container position-relative">
            <div class="ap-auth-shell">
                <div class="text-center mb-4">
                    <span class="ap-eyebrow"><i class="bi bi-shield-lock"></i>Administrator Access</span>
                </div>
                <div class="ap-auth-card shadow-sm">
                    <div class="text-center">
                        <div class="ap-role-icon mx-auto"><i class="bi bi-shield-lock"></i></div>
                        <h2>Admin Login</h2>
                        <p class="ap-auth-sub">Sign in to manage the Astra Placement Management System.</p>
                    </div>
                    <hr class="ap-auth-divider" />

                    <div id="loginForm">
                        <div class="ap-auth-field mb-3">
                            <!--<label class="form-label-custom">Email Address</label>-->
                            <asp:Label ID="lblAuto1" runat="server" AssociatedControlID="email" CssClass="ap-form-label" Text="Email Address"></asp:Label>
                            <span class="ap-auth-input">
                                <i class="bi bi-envelope ic"></i>
                            <!-- <input type="email" class="form-control form-control-custom border-start-0" id="email" placeholder="admin@university.edu" value="admin@university.edu" required> -->
                                <asp:TextBox runat="server" ID="email" ClientIDMode="Static" TextMode="Email" CssClass="ap-form-control" placeholder="admin@astra.edu" Text="admin@astra.edu" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="email" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="LoginGrp"></asp:RequiredFieldValidator>
                            </span>
                        </div>

                        <div class="ap-auth-field mb-3">
                            <!--<label class="form-label-custom">Password</label>-->
                            <asp:Label ID="lblAuto2" runat="server" AssociatedControlID="password" CssClass="ap-form-label" Text="Password"></asp:Label>
                            <span class="ap-auth-input has-eye">
                                <i class="bi bi-lock ic"></i>
                                <asp:TextBox runat="server" ID="password" ClientIDMode="Static" TextMode="Password" CssClass="ap-form-control" placeholder="Enter password" Text="admin" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="password" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="LoginGrp"></asp:RequiredFieldValidator>
                                <button type="button" class="ap-auth-eye" data-target="password" aria-label="Show password" tabindex="-1"><i class="bi bi-eye"></i></button>
                            </span>
                        </div>

                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-4">
                        <span class="ap-auth-check">
                            <!-- <input class="form-check-input" type="checkbox" id="remember"> -->
                            <asp:CheckBox runat="server" ID="remember" ClientIDMode="Static" CssClass="ap-auth-check-input" />
                            <!--<label class="form-check-label small" for="remember">Remember me</label>-->
                            <asp:Label ID="lblAuto3" runat="server" AssociatedControlID="remember" CssClass="ap-auth-check-label" Text="Remember me"></asp:Label>
                        </span>
                        <a href="#" class="ap-auth-forgot" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal" style="font-size: .86rem; font-weight: 600; color: var(--ap-blue);">Forgot password?</a>
                    </div>

<%--            <button type="button" ID="btnLoginSubmit" class="btn btn-primary-custom w-100 py-2 mb-3">Sign In</button>--%>
                    <asp:LinkButton ID="btnLoginSubmit" runat="server" CssClass="ap-auth-modal-btn d-flex align-items-center justify-content-center" OnClick="signInBtn_Click" ValidationGroup="LoginGrp"><i class="bi bi-box-arrow-in-right me-2"></i>Sign In</asp:LinkButton>
                    </div>

                    <div class="ap-auth-foot">
                        <p class="mb-0"><a href="../index.aspx" class="back"><i class="bi bi-arrow-left"></i>&nbsp;Back to Home</a></p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Forgot Password Modal -->
    <div class="modal fade ap-auth-modal" id="forgotPasswordModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-key"></i>Reset Password</h5>
                    <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
                    <asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="ap-auth-close" data-bs-dismiss="modal" aria-label="Close" OnClientClick="return false;" Text="&#215;" />
                </div>
                <div class="modal-body">
                    <p class="lead-text">Enter your registered email and a new password.</p>
                    <div id="forgotPasswordForm">
                        <div class="ap-auth-field mb-3">
                            <!--<label class="form-label-custom">Registered Email</label>-->
                            <asp:Label ID="lblAuto4" runat="server" AssociatedControlID="resetEmail" CssClass="ap-form-label" Text="Registered Email"></asp:Label>
                            <span class="ap-auth-input">
                                <i class="bi bi-envelope ic"></i>
                                <!-- <input type="email" class="form-control form-control-custom" id="resetEmail" placeholder="Enter your registered email" required> -->
                                <asp:TextBox runat="server" ID="resetEmail" ClientIDMode="Static" TextMode="Email" CssClass="ap-form-control" placeholder="Enter your registered email"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvResetEmail" runat="server" ControlToValidate="resetEmail" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="ResetGrp"></asp:RequiredFieldValidator>
                            </span>
                        </div>
                        <div class="ap-auth-field mb-3">
                            <!--<label class="form-label-custom">New Password</label>-->
                            <asp:Label ID="lblAuto5" runat="server" AssociatedControlID="resetNewPassword" CssClass="ap-form-label" Text="New Password"></asp:Label>
                            <span class="ap-auth-input has-eye">
                                <i class="bi bi-lock ic"></i>
                                <!-- <input type="password" class="form-control form-control-custom" id="resetNewPassword" placeholder="Enter new password" minlength="6" required> -->
                                <asp:TextBox runat="server" ID="resetNewPassword" ClientIDMode="Static" TextMode="Password" CssClass="ap-form-control" placeholder="Enter new password" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvResetNew" runat="server" ControlToValidate="resetNewPassword" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="ResetGrp"></asp:RequiredFieldValidator>
                                <button type="button" class="ap-auth-eye" data-target="resetNewPassword" aria-label="Show password" tabindex="-1"><i class="bi bi-eye"></i></button>
                            </span>
                        </div>
                        <div class="ap-auth-field mb-4">
                            <!--<label class="form-label-custom">Confirm New Password</label>-->
                            <asp:Label ID="lblAuto6" runat="server" AssociatedControlID="resetConfirmPassword" CssClass="ap-form-label" Text="Confirm New Password"></asp:Label>
                            <span class="ap-auth-input has-eye">
                                <i class="bi bi-shield-check ic"></i>
                                <!-- <input type="password" class="form-control form-control-custom" id="resetConfirmPassword" placeholder="Confirm new password" minlength="6" required> -->
                                <asp:TextBox runat="server" ID="resetConfirmPassword" ClientIDMode="Static" TextMode="Password" CssClass="ap-form-control" placeholder="Confirm new password" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvResetConfirm" runat="server" ControlToValidate="resetConfirmPassword" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="ResetGrp"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvResetPassword" runat="server" ControlToValidate="resetConfirmPassword" ControlToCompare="resetNewPassword" ErrorMessage="Passwords do not match" ForeColor="Red" Display="Dynamic" ValidationGroup="ResetGrp"></asp:CompareValidator>
                                <button type="button" class="ap-auth-eye" data-target="resetConfirmPassword" aria-label="Show password" tabindex="-1"><i class="bi bi-eye"></i></button>
                            </span>
                        </div>
                        <asp:Button runat="server" ID="resetBtn" ClientIDMode="Static" CssClass="ap-auth-modal-btn" Text="Reset Password" OnClick="resetBtn_Click" ValidationGroup="ResetGrp" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>

    <div id="astraAuthMeta" data-aa-title="Admin Login" data-aa-sub="Administration &amp; system management" data-aa-wide="0" hidden="hidden"></div>
    <script>
        /* Reports this form's height and heading to the popup so the modal can
           size itself. Purely visual — no data leaves the page. */
        (function () {
            if (!/(^|\s)astra-embed(\s|$)/.test(document.documentElement.className)) { return; }
            var meta = document.getElementById('astraAuthMeta');
            var last = 0;
            function report() {
                var card = document.querySelector('.ap-auth-card');
                if (!card) { return; }
                var h = Math.ceil(card.getBoundingClientRect().height) + 34;
                if (Math.abs(h - last) < 3) { return; }
                last = h;
                try {
                    window.parent.postMessage({
                        astraAuth: 'view',
                        h: h,
                        title: meta ? meta.getAttribute('data-aa-title') : '',
                        sub: meta ? meta.getAttribute('data-aa-sub') : '',
                        wide: meta ? meta.getAttribute('data-aa-wide') === '1' : false,
                        path: window.location.pathname
                    }, '*');
                } catch (e) { }
            }
            document.addEventListener('DOMContentLoaded', report);
            window.addEventListener('load', report);
            window.addEventListener('resize', report);
            setInterval(report, 300);
        })();
    </script>
    <!-- ============================= BODY END ============================= -->
</asp:Content>
<asp:Content ID="ContentFooterEmpty" ContentPlaceHolderID="ContentPlaceHolder3" runat="server"></asp:Content>