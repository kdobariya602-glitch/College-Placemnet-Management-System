<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="our-recruiters.aspx.cs" Inherits="Astra_PMS_Final_Exam.our_recruiters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->

    <div class="offcanvas offcanvas-end ap-offcanvas" tabindex="-1" id="apMobileNav">
        <div class="offcanvas-header">
            <span class="fw-bold">Menu</span>
            <!-- <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close btn-close-white" data-bs-dismiss="offcanvas" OnClientClick="return false;" Text="" />
        </div>
        <div class="offcanvas-body">
            <div class="ap-links">
                <a href="index.aspx" class="d-block py-2 fs-5">Home</a>
                <a href="placement-policy.aspx" class="d-block py-2 fs-5">Placement Policies</a>
                <a href="placement-team.aspx" class="d-block py-2 fs-5">Placement Team</a>
                <a href="placement-events.aspx" class="d-block py-2 fs-5">Placement Events</a>
                <a href="our-recruiters.aspx" class="d-block py-2 fs-5">Our Recruiters</a>
                <a href="contact-us.aspx" class="d-block py-2 fs-5">Contact Us</a>
            </div>
            <hr class="border-secondary my-3">
            <%--    <button class="ap-btn ap-btn-primary w-100" data-bs-toggle="modal" data-bs-target="#loginModal" data-bs-dismiss="offcanvas"><i class="bi bi-box-arrow-in-right"></i> Login</button>--%>
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/assets/images/Login1.png" CssClass="d-none d-md-inline-flex" Style="height: 38px; width: 100%; border-radius: 999px;" data-bs-toggle="modal" data-bs-target="#loginModal" OnClientClick="return false;" />

        </div>
    </div>

    <section class="ap-hero ap-page-hero has-photo">
        <div class="ap-hero-bg" style="background-image: url('../assets/images/our-recruiters.jpg');"></div>
        <div class="ap-grid-dots"></div>
        <div class="container position-relative">
            <span class="ap-eyebrow"><i class="bi bi-building"></i>Trusted Partners</span>
            <h1 class="mt-3 mb-3">Our Recruiters</h1>
            <p class="lead" style="max-width: 560px;">260+ organisations across IT, core engineering, BFSI, consulting and manufacturing recruit from Astra University every year.</p>
        </div>
    </section>

    <div class="ap-stats-band">
        <div class="container">
            <div class="row g-0">
                <div class="col-6 col-md-3 ap-stat">
                    <div class="num" data-count="260">0</div>
                    <div class="label">Recruiting Companies</div>
                </div>
                <div class="col-6 col-md-3 ap-stat">
                    <div class="num" data-count="42" data-suffix=" LPA">0</div>
                    <div class="label">Highest Package</div>
                </div>
                <div class="col-6 col-md-3 ap-stat">
                    <div class="num" data-count="7.8" data-decimals="1" data-suffix=" LPA">0</div>
                    <div class="label">Average Package</div>
                </div>
                <div class="col-6 col-md-3 ap-stat">
                    <div class="num" data-count="38">0</div>
                    <div class="label">New Recruiters This Year</div>
                </div>
            </div>
        </div>
    </div>

    <section class="ap-section">
        <div class="container">
            <div class="d-flex flex-wrap justify-content-between align-items-end gap-3 mb-4">
                <div>
                    <span class="ap-eyebrow">Filter</span>
                    <h2 class="mt-3 mb-0">Featured Companies</h2>
                </div>
                <div class="ap-filter-bar" data-filter-group="recruiters">
                    <!-- <button class="ap-filter-btn active" data-filter-value="all">All Companies</button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="ap-filter-btn active" data-filter-value="all" OnClientClick="return false;" Text="All Companies" />
                    <!-- <button class="ap-filter-btn" data-filter-value="it">IT &amp; Software</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="ap-filter-btn" data-filter-value="it" OnClientClick="return false;" Text="IT &amp; Software" />
                </div>
            </div>

            <div class="row g-3">
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/microsoft.jpg" alt="Microsoft logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/Google.jpg" alt="Google logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/amazon.jpg" alt="Amazon logo" loading="lazy"></div>
                </div>

                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/meta.jpg" alt="Meta logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/ibm.jpg" alt="IBM logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/oracle.jpg" alt="Oracle logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/sap.jpg" alt="SAP logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/adobe.jpg" alt="Adobe logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/salesforce.jpg" alt="Salesforce logo" loading="lazy"></div>
                </div>

                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/infosys.jpg" alt="Infosys logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/wipro.jpg" alt="Wipro logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/Hcl tech.jpg" alt="HCLTech logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/Tech mahindra.jpg" alt="Tech Mahindra logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/cognizant.jpg" alt="Cognizant logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/capgemini.jpg" alt="Capgemini logo" loading="lazy"></div>
                </div>

                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/deloitte.jpg" alt="Deloitte logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/ey.jpg" alt="EY logo" loading="lazy"></div>
                </div>

                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/tata.jpg" alt="Tata Motors logo" loading="lazy"></div>
                </div>

                <div class="col-6 col-md-3 col-lg-2 ap-reveal" data-filter-item="recruiters" data-cats="it">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/tata.jpg" alt="Tata Steel logo" loading="lazy"></div>
                </div>

            </div>
        </div>
    </section>

    <section class="ap-section" style="background: var(--ap-surface-alt);">
        <div class="container">
            <div class="mb-4 ap-reveal">
                <span class="ap-eyebrow">New This Season</span>
                <h2 class="mt-3 mb-0">Recent Recruiters</h2>
            </div>
            <div class="row g-3 mb-5">
                <div class="col-6 col-md-2 ap-reveal">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/servicenow.jpg" alt="ServiceNow logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-2 ap-reveal">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/zoho.jpg" alt="Zoho logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-2 ap-reveal">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/cisco.jpg" alt="Cisco logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-2 ap-reveal">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/intel.jpg" alt="Intel logo" loading="lazy"></div>
                </div>
                <div class="col-6 col-md-2 ap-reveal">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/nvidia.jpg" alt="Nvidia logo" loading="lazy"></div>
                </div>
            </div>

            <div class="mb-4 ap-reveal">
                <span class="ap-eyebrow">Product &amp; Global Tech</span>
                <h2 class="mt-3 mb-0">More Leading IT Recruiters</h2>
            </div>
            <div class="row g-3 mb-5">
                <div class="col-6 col-md-2 ap-reveal">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/dell.jpg" alt="Dell logo" loading="lazy"></div>
                </div>

                <div class="col-6 col-md-2 ap-reveal">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/linkedin.jpg" alt="LinkedIn logo" loading="lazy"></div>
                </div>

                <div class="col-6 col-md-2 ap-reveal">
                    <div class="ap-logo-tile">
                        <img src="assets/images/Companies/filpcart.jpg" alt="Flipkart logo" loading="lazy"></div>
                </div>

            </div>
            <div class="mb-4 ap-reveal">
                <span class="ap-eyebrow">Compensation</span>
                <h2 class="mt-3 mb-0">Placement Packages by Sector</h2>
            </div>
            <div class="row g-3">
                <div class="col-md-3 ap-reveal">
                    <div class="ap-card">
                        <div class="ap-card-body text-center">
                            <div class="fw-semibold mb-1">Product-Based IT</div>
                            <div class="ap-mono" style="color: var(--ap-blue); font-weight: 600;">5.5 &ndash; 42 LPA</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 ap-reveal">
                    <div class="ap-card">
                        <div class="ap-card-body text-center">
                            <div class="fw-semibold mb-1">Core Engineering</div>
                            <div class="ap-mono" style="color: var(--ap-blue); font-weight: 600;">4.5 &ndash; 12 LPA</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 ap-reveal">
                    <div class="ap-card">
                        <div class="ap-card-body text-center">
                            <div class="fw-semibold mb-1">BFSI & Consulting</div>
                            <div class="ap-mono" style="color: var(--ap-blue); font-weight: 600;">6 &ndash; 18 LPA</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 ap-reveal">
                    <div class="ap-card">
                        <div class="ap-card-body text-center">
                            <div class="fw-semibold mb-1">Manufacturing</div>
                            <div class="ap-mono" style="color: var(--ap-blue); font-weight: 600;">4 &ndash; 9 LPA</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="ap-section">
        <div class="container">
            <div class="ap-card ap-reveal" style="background: var(--ap-ink); border: 0;">
                <div class="ap-card-body text-white text-center py-5">
                    <h3 class="text-white mb-2">Want to recruit from Astra University?</h3>
                    <p style="color: rgba(255,255,255,.7); max-width: 520px; margin: 0 auto 1.5rem;">Partner with our Corporate Relations team to schedule a campus drive or pre-placement talk.</p>
                    <a href="contact-us.aspx" class="ap-btn ap-btn-primary">Schedule a Drive <i class="bi bi-arrow-right"></i></a>
                </div>
            </div>
        </div>
    </section>

              <div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered modal-lg">
                  <div class="modal-content" style="border-radius: 20px; border: 0;">
                      <div class="modal-body p-4 p-md-5">
                          <div class="text-center mb-3">
                              <svg width="52" height="52" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                                  <rect x="1" y="1" width="46" height="46" rx="14" fill="#0d1b3e" />
                                  <path d="M24 9L34.5 31.5H30L28 27H20L18 31.5H13.5L24 9Z" fill="#ffffff" />
                                  <rect x="20.8" y="22.5" width="6.4" height="2.6" fill="#0d1b3e" />
                                  <circle cx="34" cy="13.5" r="3.2" fill="#f5a524" />
                              </svg>
                          </div>
                          <h5 class="ap-display mb-1 text-center">Login to your portal</h5>
                          <p class="text-center mb-4" style="color: var(--ap-text-soft); font-size: .88rem;">Choose your role to continue</p>
                          <div class="row g-3">
                              <div class="col-md-4">
                                  <div class="ap-contact-card text-center h-100 d-flex flex-column">
                                      <div class="ap-role-icon student mx-auto"><i class="bi bi-mortarboard"></i></div>
                                      <div class="fw-bold mb-3">Student</div>
                                      <div class="d-flex gap-2 mt-auto">
                                          <%--<a href="student/login.aspx" class="ap-btn ap-btn-primary ap-btn-sm flex-fill">Login</a>--%>
                                          <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/assets/images/Login2.png" CssClass="flex-fill" Style="height: 38px; width: 50%; border-radius: 999px; object-fit: contain;" PostBackUrl="/student/login.aspx" OnClientClick="window.location.href='/student/login.aspx'; return false;" />
                                          <%--<a href="student/register.aspx" class="ap-btn ap-btn-primary ap-btn-sm flex-fill">Register</a>--%>
                                          <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/assets/images/Register1.png" CssClass="flex-fill" Style="height: 38px; width: 50%; border-radius: 999px; object-fit: contain;" PostBackUrl="/student/register.aspx" OnClientClick="window.location.href='/student/register.aspx'; return false;" />
                                      </div>
                                  </div>
                              </div>
                              <div class="col-md-4">
                                  <div class="ap-contact-card text-center h-100 d-flex flex-column">
                                      <div class="ap-role-icon admin mx-auto"><i class="bi bi-shield-lock"></i></div>
                                      <div class="fw-bold mb-3">Admin</div>
                                      <div class="d-grid gap-2 mt-auto">
                                          <%--<a href="admin/login.aspx" class="ap-btn ap-btn-primary ap-btn-sm">Login</a>--%>
                                          <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/assets/images/Login3.png" CssClass="w-100" Style="height: 38px; width: 60%; border-radius: 999px; object-fit: contain;" PostBackUrl="/admin/login.aspx" OnClientClick="window.location.href='/admin/login.aspx'; return false;" />
                                      </div>
                                  </div>
                              </div>
                              <div class="col-md-4">
                                  <div class="ap-contact-card text-center h-100 d-flex flex-column">
                                      <div class="ap-role-icon company mx-auto"><i class="bi bi-building"></i></div>
                                      <div class="fw-bold mb-3">Company</div>
                                      <div class="d-flex gap-2 mt-auto">
                                          <%--<a href="company/login.aspx" class="ap-btn ap-btn-primary ap-btn-sm flex-fill">Login</a>--%>
                                          <asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/assets/images/Login2.png" CssClass="flex-fill" Style="height: 38px; width: 50%; border-radius: 999px; object-fit: contain;" PostBackUrl="/company/login.aspx" OnClientClick="window.location.href='/company/login.aspx'; return false;" />
                                          <%--<a href="company/register.aspx" class="ap-btn ap-btn-primary ap-btn-sm flex-fill">Register</a>--%>
                                          <asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/assets/images/Register1.png" CssClass="flex-fill" Style="height: 38px; width: 50%; border-radius: 999px; object-fit: contain;" PostBackUrl="/company/register.aspx" OnClientClick="window.location.href='/company/register.aspx'; return false;" />
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
          </div>

    <!-- ============================= BODY END ============================= -->
</asp:Content>

