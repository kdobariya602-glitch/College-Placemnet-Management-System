<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="placement-policy.aspx.cs" Inherits="Astra_PMS_Final_Exam.placement_policy" %>

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
                <a href="../index.aspx" class="d-block py-2 fs-5">Home</a>
                <a href="../placement-policy.aspx" class="d-block py-2 fs-5">Placement Policies</a>
                <a href="../placement-team.aspx" class="d-block py-2 fs-5">Placement Team</a>
                <a href="../placement-events.aspx" class="d-block py-2 fs-5">Placement Events</a>
                <a href="../our-recruiters.aspx" class="d-block py-2 fs-5">Our Recruiters</a>
                <a href="../contact-us.aspx" class="d-block py-2 fs-5">Contact Us</a>
            </div>
            <hr class="border-secondary my-3">
            <%--    <button class="ap-btn ap-btn-primary w-100" data-bs-toggle="modal" data-bs-target="#loginModal" data-bs-dismiss="offcanvas"><i class="bi bi-box-arrow-in-right"></i> Login</button>--%>
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/assets/images/Login1.png" CssClass="d-none d-md-inline-flex" Style="height: 38px; width: 100%; border-radius: 999px;" data-bs-toggle="modal" data-bs-target="#loginModal" OnClientClick="return false;" />

        </div>
    </div>


    <section class="ap-hero ap-page-hero has-photo">
        <div class="ap-hero-bg" style="background-image: url('../assets/images/placement-policy.jpg');"></div>
        <div class="ap-grid-dots"></div>
        <div class="container position-relative">
            <span class="ap-eyebrow"><i class="bi bi-shield-check"></i>Rules of Engagement</span>
            <h1 class="mt-3 mb-3">Placement Policies</h1>
            <p class="lead" style="max-width: 560px;">Clear, consistent rules that keep the placement process fair for every student and every recruiter.</p>
        </div>
    </section>


    <section class="ap-section">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-policy-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="ap-icon-tile mb-0"><i class="bi bi-clipboard-check"></i></div>
                            <span class="ap-policy-num">01</span>
                        </div>
                        <h5 class="fw-bold mb-2">Eligibility Criteria</h5>
                        <ul>
                            <li>Minimum 60% aggregate or 6.5 CGPA across semesters</li>
                            <li>No active academic backlog at the time of a drive</li>
                            <li>Maximum of two backlogs cleared historically per policy year</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-policy-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="ap-icon-tile mb-0"><i class="bi bi-calendar2-check"></i></div>
                            <span class="ap-policy-num">02</span>
                        </div>
                        <h5 class="fw-bold mb-2">Attendance Rules</h5>
                        <ul>
                            <li>75% minimum attendance in placement training sessions</li>
                            <li>Two consecutive unexcused absences forfeit drive eligibility for that cycle</li>
                            <li>Medical exemptions require prior written approval</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-policy-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="ap-icon-tile mb-0"><i class="bi bi-check2-circle"></i></div>
                            <span class="ap-policy-num">03</span>
                        </div>
                        <h5 class="fw-bold mb-2">Offer Acceptance Policy</h5>
                        <ul>
                            <li>One offer acceptance per student per placement cycle</li>
                            <li>Accepted offers are binding once confirmed on the portal</li>
                            <li>Withdrawal after acceptance requires TPC Director approval</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-policy-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="ap-icon-tile mb-0"><i class="bi bi-star"></i></div>
                            <span class="ap-policy-num">04</span>
                        </div>
                        <h5 class="fw-bold mb-2">Dream Company Policy</h5>
                        <ul>
                            <li>Students with a standard offer may still sit for a pre-approved 'dream' company</li>
                            <li>Dream company package threshold is revised and published every year</li>
                            <li>Only one dream company attempt permitted per student</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-policy-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="ap-icon-tile mb-0"><i class="bi bi-briefcase"></i></div>
                            <span class="ap-policy-num">05</span>
                        </div>
                        <h5 class="fw-bold mb-2">Internship Rules</h5>
                        <ul>
                            <li>Internship offers are logged separately from full-time placements</li>
                            <li>Minimum 8-week duration to count toward degree requirements</li>
                            <li>Conversion offers follow the same acceptance policy as placements</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-policy-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="ap-icon-tile mb-0"><i class="bi bi-person-plus"></i></div>
                            <span class="ap-policy-num">06</span>
                        </div>
                        <h5 class="fw-bold mb-2">Registration Guidelines</h5>
                        <ul>
                            <li>Complete profile verification is mandatory before applying to any drive</li>
                            <li>Resume must be approved by the placement coordinator</li>
                            <li>False information on the portal leads to disqualification</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-policy-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="ap-icon-tile mb-0"><i class="bi bi-bag"></i></div>
                            <span class="ap-policy-num">07</span>
                        </div>
                        <h5 class="fw-bold mb-2">Dress Code</h5>
                        <ul>
                            <li>Formal business attire is mandatory for all placement activities</li>
                            <li>Institutional ID card must be visible during every drive</li>
                            <li>Casual wear is not permitted on interview or test days</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-policy-card">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="ap-icon-tile mb-0"><i class="bi bi-award"></i></div>
                            <span class="ap-policy-num">08</span>
                        </div>
                        <h5 class="fw-bold mb-2">Code of Conduct</h5>
                        <ul>
                            <li>Punctuality and professionalism are expected at every stage</li>
                            <li>Any form of malpractice results in immediate disqualification</li>
                            <li>Respectful communication with recruiters is mandatory at all times</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="ap-section" style="background: var(--ap-surface-alt);">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-8 ap-reveal">
                    <div class="ap-card">
                        <div class="ap-card-body">
                            <div class="d-flex align-items-center gap-2 mb-3"><i class="bi bi-info-circle" style="color: var(--ap-amber); font-size: 1.3rem;"></i>
                                <h4 class="mb-0">Important Notes</h4>
                            </div>
                            <ul style="color: var(--ap-text-soft);">
                                <li>Policies are reviewed and updated at the start of every academic year by the Placement Advisory Committee.</li>
                                <li>In case of conflict, the version published on the official portal supersedes any printed copy.</li>
                                <li>Exceptions to any policy require written approval from the Placement Director.</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 ap-reveal">
                    <div class="ap-card" style="background: var(--ap-ink); border: 0;">
                        <div class="ap-card-body text-white">
                            <h5 class="text-white mb-2">Have a question about a policy?</h5>
                            <p style="color: rgba(255,255,255,.65); font-size: .9rem;">Our coordinators can clarify eligibility or exceptions specific to your programme.</p>
                            <a href="contact-us.aspx" class="ap-btn ap-btn-primary w-100">Ask the Placement Cell</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="ap-section">
        <div class="container" style="max-width: 820px;">
            <div class="text-center mb-5 ap-reveal">
                <span class="ap-eyebrow">FAQs</span>
                <h2 class="mt-3 mb-0">Policy Questions, Answered</h2>
            </div>
            <div class="accordion ap-accordion ap-reveal" id="policyFaq">
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <!-- <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#pfaq0">What happens if I miss a mandatory training session?</button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#pfaq0" OnClientClick="return false;" Text="What happens if I miss a mandatory training session?" />
                    </h2>
                    <div id="pfaq0" class="accordion-collapse collapse" data-bs-parent="#policyFaq">
                        <div class="accordion-body">Two consecutive unexcused absences make you ineligible for the next placement drive, unless a medical exemption is approved in advance.</div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <!-- <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#pfaq1">Can I reject an accepted offer?</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#pfaq1" OnClientClick="return false;" Text="Can I reject an accepted offer?" />
                    </h2>
                    <div id="pfaq1" class="accordion-collapse collapse" data-bs-parent="#policyFaq">
                        <div class="accordion-body">Only with written approval from the Placement Director, and typically only under the Dream Company Policy provisions.</div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <!-- <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#pfaq2">Are internship conversions treated as new offers?</button> -->
<asp:Button runat="server" ID="btnCtrl4" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#pfaq2" OnClientClick="return false;" Text="Are internship conversions treated as new offers?" />
                    </h2>
                    <div id="pfaq2" class="accordion-collapse collapse" data-bs-parent="#policyFaq">
                        <div class="accordion-body">Yes, but they follow the same one-offer acceptance rule as any other placement offer.</div>
                    </div>
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

