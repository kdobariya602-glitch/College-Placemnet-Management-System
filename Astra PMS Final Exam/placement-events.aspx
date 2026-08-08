<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="placement-events.aspx.cs" Inherits="Astra_PMS_Final_Exam.placement_events" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->


    <div class="offcanvas offcanvas-end ap-offcanvas" tabindex="-1" id="apMobileNav">
        <div class="offcanvas-header">
            <span class="fw-bold">Menu</span>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
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
        <div class="ap-hero-bg" style="background-image: url('../assets/images/placement-event.jpg');"></div>
        <div class="ap-grid-dots"></div>
        <div class="container position-relative">
            <span class="ap-eyebrow"><i class="bi bi-calendar3"></i>Placement Calendar</span>
            <h1 class="mt-3 mb-3">Placement Events</h1>
            <p class="lead" style="max-width: 560px;">Every drive, workshop, hackathon and industrial visit &mdash; in one place.</p>
        </div>
    </section>


    <section class="ap-section" style="background: var(--ap-surface-alt);">
        <div class="container">
            <div class="mb-5 ap-reveal">
                <span class="ap-eyebrow">Archive</span>
                <h2 class="mt-3 mb-0">Past Events Gallery</h2>
            </div>
            <div class="row g-3">
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event1.jpeg" data-caption="Placement Event 1">
                        <img src="../assets/images/events/event1.jpeg" alt="Placement Event 1"><div class="cap">Placement Event 1</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event2.jpeg" data-caption="Placement Event 2">
                        <img src="../assets/images/events/event2.jpeg" alt="Placement Event 2"><div class="cap">Placement Event 2</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event3.jpeg" data-caption="Placement Event 3">
                        <img src="../assets/images/events/event3.jpeg" alt="Placement Event 3"><div class="cap">Placement Event 3</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event4.jpeg" data-caption="Placement Event 4">
                        <img src="../assets/images/events/event4.jpeg" alt="Placement Event 4"><div class="cap">Placement Event 4</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event5.jpeg" data-caption="Placement Event 5">
                        <img src="../assets/images/events/event5.jpeg" alt="Placement Event 5"><div class="cap">Placement Event 5</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event6.jpeg" data-caption="Placement Event 6">
                        <img src="../assets/images/events/event6.jpeg" alt="Placement Event 6"><div class="cap">Placement Event 6</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event7.jpg" data-caption="Placement Event 7">
                        <img src="../assets/images/events/event7.jpg" alt="Placement Event 7"><div class="cap">Placement Event 7</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event8.jpg" data-caption="Placement Event 8">
                        <img src="../assets/images/events/event8.jpg" alt="Placement Event 8"><div class="cap">Placement Event 8</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event9.jpg" data-caption="Placement Event 9">
                        <img src="../assets/images/events/event9.jpg" alt="Placement Event 9"><div class="cap">Placement Event 9</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event10.jpg" data-caption="Placement Event 10">
                        <img src="../assets/images/events/event10.jpg" alt="Placement Event 10"><div class="cap">Placement Event 10</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event11.jpg" data-caption="Placement Event 11">
                        <img src="../assets/images/events/event11.jpg" alt="Placement Event 11"><div class="cap">Placement Event 11</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event12.jpg" data-caption="Placement Event 12">
                        <img src="../assets/images/events/event12.jpg" alt="Placement Event 12"><div class="cap">Placement Event 12</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event13.jpg" data-caption="Placement Event 13">
                        <img src="../assets/images/events/event13.jpg" alt="Placement Event 13"><div class="cap">Placement Event 13</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event14.jpg" data-caption="Placement Event 14">
                        <img src="../assets/images/events/event14.jpg" alt="Placement Event 14"><div class="cap">Placement Event 14</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event15.jpg" data-caption="Placement Event 15">
                        <img src="../assets/images/events/event15.jpg" alt="Placement Event 15"><div class="cap">Placement Event 15</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event16.jpg" data-caption="Placement Event 16">
                        <img src="../assets/images/events/event16.jpg" alt="Placement Event 16"><div class="cap">Placement Event 16</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event17.jpg" data-caption="Placement Event 17">
                        <img src="../assets/images/events/event17.jpg" alt="Placement Event 17"><div class="cap">Placement Event 17</div>
                    </div>
                </div>
                <div class="col-6 col-md-3 ap-reveal">
                    <div class="ap-gallery-item" data-lightbox="assets/images/events/event18.jpg" data-caption="Placement Event 18">
                        <img src="../assets/images/events/event18.jpg" alt="Placement Event 18"><div class="cap">Placement Event 18</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="ap-lightbox" id="apLightbox" style="position: fixed; inset: 0; background: rgba(11,18,32,.92); z-index: 3000; display: none; align-items: center; justify-content: center; padding: 2rem;">
        <button data-lightbox-close="true" style="position: absolute; top: 1.5rem; right: 1.5rem; background: none; border: 0; color: #fff; font-size: 1.8rem;">&times;</button>
        <div style="max-width: 900px; width: 100%;">
            <img src="" alt="" style="width: 100%; border-radius: 14px;">
            <p class="ap-lightbox-cap text-center text-white mt-3"></p>
        </div>
    </div>
    <style>
        .ap-lightbox.show {
            display: flex !important;
        }
    </style>

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

