<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.register" %>

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
<asp:Content ID="ContentFooterEmpty" ContentPlaceHolderID="ContentPlaceHolder3" runat="server"></asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
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
    <linearGradient id="crestCmpRegGrad" x1="0" y1="0" x2="48" y2="48" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#1E3A8A"/>
      <stop offset="50%" stop-color="#0F2756"/>
      <stop offset="100%" stop-color="#0B1528"/>
    </linearGradient>
    <!-- Royal Blue 3D Cap -->
    <linearGradient id="crestCmpRegCapGrad" x1="7" y1="7" x2="41" y2="21" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#3B82F6"/>
      <stop offset="50%" stop-color="#2563EB"/>
      <stop offset="100%" stop-color="#1D4ED8"/>
    </linearGradient>
    <!-- Soft Ice-Blue Diploma Paper -->
    <linearGradient id="crestCmpRegPaperGrad" x1="5" y1="28" x2="43" y2="36" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#FFFFFF"/>
      <stop offset="40%" stop-color="#E0F2FE"/>
      <stop offset="100%" stop-color="#BAE6FD"/>
    </linearGradient>
    <!-- Metallic Academic Gold -->
    <linearGradient id="crestCmpRegGoldGrad" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#FDE047"/>
      <stop offset="50%" stop-color="#F59E0B"/>
      <stop offset="100%" stop-color="#D97706"/>
    </linearGradient>
    <filter id="crestCmpRegGlow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="1.5" stdDeviation="1.2" flood-color="#000000" flood-opacity="0.45"/>
    </filter>
  </defs>

  <!-- Luxury Squircle Badge with Gold Rim -->
  <rect x="1.5" y="1.5" width="45" height="45" rx="12" fill="url(#crestCmpRegGrad)" stroke="url(#crestCmpRegGoldGrad)" stroke-width="1.2"/>
  <rect x="3" y="3" width="42" height="42" rx="10.5" fill="none" stroke="rgba(255,255,255,0.12)" stroke-width="0.8"/>

  <!-- 1. DIPLOMA SCROLL (Pepear) - Diagonal in lower section with ice-blue depth -->
  <g transform="rotate(-18 24 32)" filter="url(#crestCmpRegGlow)">
    <!-- Rolled Certificate Body -->
    <rect x="5" y="28.5" width="38" height="7" rx="3.5" fill="url(#crestCmpRegPaperGrad)" stroke="#38BDF8" stroke-width="0.75"/>
    <!-- Rolled Curls at both ends -->
    <ellipse cx="6.5" cy="32" rx="1.6" ry="3.5" fill="#7DD3FC" stroke="#0284C7" stroke-width="0.5"/>
    <ellipse cx="41.5" cy="32" rx="1.6" ry="3.5" fill="#E0F2FE" stroke="#38BDF8" stroke-width="0.5"/>
    <!-- Center Ribbon Band in Royal Blue & Gold -->
    <rect x="21" y="27.5" width="6" height="9" rx="1" fill="#1D4ED8" stroke="url(#crestCmpRegGoldGrad)" stroke-width="0.75"/>
    <!-- Flowing Ribbon Tails -->
    <path d="M21.5 36.5 L18 42.5 L21.5 41 L23.8 42.5 L23.2 36.5 Z" fill="#2563EB"/>
    <path d="M24.5 36.5 L24 42.5 L26.2 41 L29.5 42.5 L26.2 36.5 Z" fill="#1D4ED8"/>
    <!-- Golden Wax Seal Medallion -->
    <circle cx="24" cy="32" r="2.2" fill="url(#crestCmpRegGoldGrad)" stroke="#78350F" stroke-width="0.4"/>
  </g>

  <!-- 2. GRADUATION CAP (Topi) - Royal Blue & Gold 3D Mortarboard -->
  <g filter="url(#crestCmpRegGlow)">
    <!-- Skull Cap Base in deep midnight blue -->
    <path d="M16 17.5 V21.5 C16 24.5 19.5 26.5 24 26.5 C28.5 26.5 32 24.5 32 21.5 V17.5 Z" fill="#0B1528" stroke="#3B82F6" stroke-width="0.6"/>
    <!-- 3D Bevel Facets under diamond -->
    <polygon points="7,13.5 24,20.5 24,22 7,15" fill="#0F172A"/>
    <polygon points="24,20.5 41,13.5 41,15 24,22" fill="#1E293B"/>
    <!-- Diamond Top Face: Rich Royal Blue with gleaming Gold Border -->
    <polygon points="24,6.5 41,13.5 24,20.5 7,13.5" fill="url(#crestCmpRegCapGrad)" stroke="url(#crestCmpRegGoldGrad)" stroke-width="1.2"/>
    <!-- 3D Faceted Lighting on Top Face -->
    <polygon points="24,6.5 41,13.5 24,20.5" fill="#60A5FA" fill-opacity="0.25"/>

    <!-- Center Gold Button -->
    <circle cx="24" cy="13.5" r="2" fill="url(#crestCmpRegGoldGrad)" stroke="#78350F" stroke-width="0.4"/>

    <!-- Flowing Gold Tassel -->
    <path d="M24 13.5 Q34 15 36.5 19.5" fill="none" stroke="url(#crestCmpRegGoldGrad)" stroke-width="1.8" stroke-linecap="round"/>
    <rect x="35.2" y="19.5" width="2.4" height="6.5" rx="1.2" fill="url(#crestCmpRegGoldGrad)" stroke="#78350F" stroke-width="0.3"/>
    <circle cx="36.4" cy="19.5" r="1.1" fill="#92400E"/>
  </g>
</svg>
                        <div class="ms-3">
                            <div class="text-white fw-bold fs-5" style="letter-spacing: -0.01em; line-height: 1.1;">Astra University</div>
                            <small class="text-white-50" style="font-size: 0.72rem; letter-spacing: 0.05em; text-transform: uppercase;">Corporate Recruiter Gateway</small>
                        </div>
                    </div>

                    <!-- Middle Content -->
                    <div style="margin: auto 0; padding: 1.5rem 0;">
                        <span class="badge bg-white bg-opacity-10 text-white border border-white border-opacity-20 px-3 py-2 rounded-pill fw-semibold mb-3">
                            <i class="bi bi-building-fill me-1 text-warning"></i> CORPORATE RECRUITER PARTNERSHIP
                        </span>
                        <h1 class="text-white fw-bolder mb-3" style="font-size: 2.35rem; line-height: 1.15; letter-spacing: -0.03em;">
                            Hire Elite Talent,<br><span style="color: #93C5FD;">Build Tomorrow.</span>
                        </h1>
                        <p style="color: #94a3b8; font-size: 0.95rem; line-height: 1.55; max-width: 380px; margin-bottom: 1.25rem;">
                            Register your organisation to post placement drives, access pre-screened engineering candidates, and manage campus interview schedules.
                        </p>

                        <div class="d-flex flex-column gap-2 mb-2">
                            <div class="auth-feature-pill">
                                <i class="bi bi-briefcase-fill"></i>
                                <span>Publish Placement Drives &amp; Eligibility Criteria</span>
                            </div>
                            <div class="auth-feature-pill">
                                <i class="bi bi-funnel-fill"></i>
                                <span>Multi-Criteria Candidate Filtering &amp; Screening</span>
                            </div>
                            <div class="auth-feature-pill">
                                <i class="bi bi-clipboard2-check-fill"></i>
                                <span>Multi-Round Assessment &amp; Final Selection Desk</span>
                            </div>
                        </div>
                    </div>

                    <!-- Bottom Footer -->
                    <div>
                        <div class="d-flex align-items-center gap-3 text-white-50" style="font-size: 0.82rem;">
                            <span>&copy; 2026 Astra University</span>
                            <span>&bull;</span>
                            <span>Corporate Relations Wing</span>
                        </div>
                    </div>
                </div>
            `;
            document.body.appendChild(leftPanel);
        }
    });
    </script>

    <!-- ============================= BODY START (Main Page Content) ============================= -->
    <div class="company-register-page">

    <section class="ap-hero ap-page-hero ap-auth-hero">
        <div class="ap-grid-dots"></div>
        <div class="container position-relative">
            <div class="ap-auth-shell is-wide">
                <div class="ap-auth-card shadow-sm">
                    <div class="text-center mb-3">
                        <div class="ap-role-icon mx-auto"><i class="bi bi-building-add"></i></div>
                        <h2>Company Registration</h2>
                        <p class="ap-auth-sub">Register your organisation to announce hiring drives and recruit university talent.</p>
                    </div>

                    <div id="registerForm">
                        <div class="row g-2">
                            <!-- Company Name -->
                            <div class="col-6 ap-auth-field">
                                <asp:Label ID="lblAuto1" runat="server" AssociatedControlID="companyName" CssClass="ap-form-label" Text="Company Name"></asp:Label>
                                <span class="ap-auth-input">
                                    <i class="bi bi-building ic"></i>
                                    <asp:TextBox runat="server" ID="companyName" ClientIDMode="Static" TextMode="SingleLine" CssClass="ap-form-control" placeholder="Company name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvcompanyName" runat="server" ControlToValidate="companyName" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="RegGrp"></asp:RequiredFieldValidator>
                                </span>
                            </div>

                            <!-- Industry -->
                            <div class="col-6 ap-auth-field">
                                <asp:Label ID="lblAuto5" runat="server" AssociatedControlID="industry" CssClass="ap-form-label" Text="Industry"></asp:Label>
                                <span class="ap-auth-input">
                                    <i class="bi bi-briefcase ic"></i>
                                    <asp:TextBox runat="server" ID="industry" ClientIDMode="Static" TextMode="SingleLine" CssClass="ap-form-control" placeholder="IT, Manufacturing, Finance..."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvindustry" runat="server" ControlToValidate="industry" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="RegGrp"></asp:RequiredFieldValidator>
                                </span>
                            </div>

                            <!-- Location -->
                            <div class="col-6 ap-auth-field">
                                <asp:Label ID="lblAuto6" runat="server" AssociatedControlID="location" CssClass="ap-form-label" Text="Location / City"></asp:Label>
                                <span class="ap-auth-input">
                                    <i class="bi bi-geo-alt ic"></i>
                                    <asp:TextBox runat="server" ID="location" ClientIDMode="Static" TextMode="SingleLine" CssClass="ap-form-control" placeholder="City, State"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvlocation" runat="server" ControlToValidate="location" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="RegGrp"></asp:RequiredFieldValidator>
                                </span>
                            </div>

                            <!-- Website -->
                            <div class="col-6 ap-auth-field">
                                <asp:Label ID="lblAuto7" runat="server" AssociatedControlID="website" CssClass="ap-form-label" Text="Corporate Website"></asp:Label>
                                <span class="ap-auth-input">
                                    <i class="bi bi-globe2 ic"></i>
                                    <asp:TextBox runat="server" ID="website" ClientIDMode="Static" TextMode="Url" CssClass="ap-form-control" placeholder="https://example.com"></asp:TextBox>
                                </span>
                            </div>

                            <!-- Contact Number -->
                            <div class="col-6 ap-auth-field">
                                <asp:Label ID="lblAuto4" runat="server" AssociatedControlID="contact" CssClass="ap-form-label" Text="Contact Number"></asp:Label>
                                <span class="ap-auth-input">
                                    <i class="bi bi-telephone ic"></i>
                                    <asp:TextBox runat="server" ID="contact" ClientIDMode="Static" TextMode="Phone" CssClass="ap-form-control" placeholder="Primary contact number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvcontact" runat="server" ControlToValidate="contact" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="RegGrp"></asp:RequiredFieldValidator>
                                </span>
                            </div>

                            <!-- Official Email -->
                            <div class="col-6 ap-auth-field">
                                <asp:Label ID="lblAuto2" runat="server" AssociatedControlID="email" CssClass="ap-form-label" Text="Corporate Email"></asp:Label>
                                <span class="ap-auth-input">
                                    <i class="bi bi-envelope ic"></i>
                                    <asp:TextBox runat="server" ID="email" ClientIDMode="Static" TextMode="Email" CssClass="ap-form-control" placeholder="hr@company.com"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvemail" runat="server" ControlToValidate="email" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="RegGrp"></asp:RequiredFieldValidator>
                                </span>
                            </div>

                            <!-- Password -->
                            <div class="col-6 ap-auth-field">
                                <asp:Label ID="lblAuto3" runat="server" AssociatedControlID="password" CssClass="ap-form-label" Text="Password"></asp:Label>
                                <span class="ap-auth-input has-eye">
                                    <i class="bi bi-lock ic"></i>
                                    <asp:TextBox runat="server" ID="password" ClientIDMode="Static" TextMode="Password" CssClass="ap-form-control" placeholder="Min 6 characters"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvpassword" runat="server" ControlToValidate="password" ErrorMessage="*" ForeColor="Red" Display="Dynamic" ValidationGroup="RegGrp"></asp:RequiredFieldValidator>
                                    <button type="button" class="ap-auth-eye" data-target="password" aria-label="Show password" tabindex="-1"><i class="bi bi-eye"></i></button>
                                </span>
                            </div>

                            <!-- Company Description -->
                            <div class="col-6 ap-auth-field">
                                <asp:Label ID="lblAuto8" runat="server" AssociatedControlID="description" CssClass="ap-form-label" Text="Brief Description"></asp:Label>
                                <span class="ap-auth-input">
                                    <i class="bi bi-card-text ic"></i>
                                    <asp:TextBox runat="server" ID="description" ClientIDMode="Static" TextMode="SingleLine" CssClass="ap-form-control" placeholder="Company profile summary"></asp:TextBox>
                                </span>
                            </div>

                            <!-- Submit Button -->
                            <div class="col-12 mt-1">
                                <asp:LinkButton ID="btnRegisterSubmit" runat="server" CssClass="ap-auth-modal-btn" OnClick="registerBtn_Click" ValidationGroup="RegGrp"><i class="bi bi-building-add me-2"></i>Register Corporate Account</asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <div class="ap-auth-foot">
                        <p>Already have an account? <a href="login.aspx">Login here</a></p>
                        <p class="mb-0"><a href="../index.aspx" class="back"><i class="bi bi-arrow-left"></i> Back to Home</a></p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Public records grid removed for company privacy and security -->
    <div class="table-responsive" style="display:none;"><asp:GridView UseAccessibleHeader="True" ID="GridView1" runat="server" Visible="false">
                        <EmptyDataTemplate>
                            <div class="text-center py-4 text-muted">
                                <i class="bi bi-inbox fs-2 d-block mb-1 text-secondary"></i>
                                <div class="fw-semibold">No records found</div>
                                <div class="small">There are currently no entries to display.</div>
                            </div>
                        </EmptyDataTemplate>
</asp:GridView></div>
    </div>

    <div id="astraAuthMeta" data-aa-title="Company Registration" data-aa-sub="Register your organisation" data-aa-wide="1" hidden="hidden"></div>
    <script>
        /* Reports this form's height and heading to the popup so the modal can
           size itself. Purely visual - no data leaves the page. */
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
