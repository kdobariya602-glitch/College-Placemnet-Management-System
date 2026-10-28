<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="placement-team.aspx.cs" Inherits="Astra_PMS_Final_Exam.placement_team" %>

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
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/assets/images/Login1.png" CssClass="d-none d-md-inline-flex" Style="height: 38px; width: 100%; border-radius: 999px;" data-bs-toggle="modal" data-bs-target="#loginModal" />

        </div>
    </div>


    <section class="ap-hero ap-page-hero has-photo">
        <div class="ap-hero-bg" style="background-image: url('../assets/images/placement-team.jpg');"></div>
        <div class="ap-grid-dots"></div>
        <div class="container position-relative">
            <span class="ap-eyebrow"><i class="bi bi-people"></i>The People Behind It</span>
            <h1 class="mt-3 mb-3">Meet the Placement Team</h1>
            <p class="lead">A dedicated team of faculty, corporate relations professionals and student coordinators working together to place every eligible student.</p>
        </div>
    </section>


    <section class="ap-section ">
        <div class="container">
            <div class="mb-4 ap-reveal">
                <span class="ap-eyebrow">Leadership</span>
                <h2 class="mt-3 mb-0">Placement Director</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team1.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Dr. Rakesh Malhotra</div>
                            <div class="role">Placement Director</div>
                            <div class="dept">Training & Placement Cell</div>
                            <div class="ap-team-contact">
                                <a href="mailto:rakesh.malhotra@astrauniversity.edu.in" title="rakesh.malhotra@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98250 11234" title="+91 98250 11234"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="ap-divider container"></div>

    <section class="ap-section">
        <div class="container">
            <div class="mb-4 ap-reveal">
                <span class="ap-eyebrow">Training</span>
                <h2 class="mt-3 mb-0">Training Officer</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team2.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Ms. Priya Nair</div>
                            <div class="role">Chief Training Officer</div>
                            <div class="dept">Skill Development Wing</div>
                            <div class="ap-team-contact">
                                <a href="mailto:priya.nair@astrauniversity.edu.in" title="priya.nair@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98250 22456" title="+91 98250 22456"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team3.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Mr. Aditya Kulkarni</div>
                            <div class="role">Assistant Training Officer</div>
                            <div class="dept">Technical Training</div>
                            <div class="ap-team-contact">
                                <a href="mailto:aditya.kulkarni@astrauniversity.edu.in" title="aditya.kulkarni@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98250 33678" title="+91 98250 33678"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="ap-divider container" style="background: var(--ap-surface-alt); border: 0;"></div>

    <section class="ap-section">
        <div class="container">
            <div class="mb-4 ap-reveal">
                <span class="ap-eyebrow">Industry Liaison</span>
                <h2 class="mt-3 mb-0">Corporate Relations</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team4.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Mr. Vikram Sethi</div>
                            <div class="role">Head, Corporate Relations</div>
                            <div class="dept">Industry Partnerships</div>
                            <div class="ap-team-contact">
                                <a href="mailto:vikram.sethi@astrauniversity.edu.in" title="vikram.sethi@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98250 44890" title="+91 98250 44890"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team5.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Ms. Neha Bhatt</div>
                            <div class="role">Corporate Relations Manager</div>
                            <div class="dept">Recruiter Onboarding</div>
                            <div class="ap-team-contact">
                                <a href="mailto:neha.bhatt@astrauniversity.edu.in" title="neha.bhatt@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98250 55012" title="+91 98250 55012"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team6.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Mr. Farhan Ansari</div>
                            <div class="role">Corporate Relations Executive</div>
                            <div class="dept">MoUs & Compliance</div>
                            <div class="ap-team-contact">
                                <a href="mailto:farhan.ansari@astrauniversity.edu.in" title="farhan.ansari@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98250 66234" title="+91 98250 66234"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="ap-section">
        <div class="container">
            <div class="mb-4 ap-reveal">
                <span class="ap-eyebrow">Department Liaison</span>
                <h2 class="mt-3 mb-0">Placement Coordinators</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team7.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Dr. Meenal Deshpande</div>
                            <div class="role">Placement Coordinator</div>
                            <div class="dept">School of Engineering</div>
                            <div class="ap-team-contact">
                                <a href="mailto:meenal.deshpande@astrauniversity.edu.in" title="meenal.deshpande@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98250 77456" title="+91 98250 77456"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team8.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Dr. Sameer Joshi</div>
                            <div class="role">Placement Coordinator</div>
                            <div class="dept">School of Management</div>
                            <div class="ap-team-contact">
                                <a href="mailto:sameer.joshi@astrauniversity.edu.in" title="sameer.joshi@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98250 88678" title="+91 98250 88678"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team9.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Dr. Kavita Rao</div>
                            <div class="role">Placement Coordinator</div>
                            <div class="dept">School of Computer Applications</div>
                            <div class="ap-team-contact">
                                <a href="mailto:kavita.rao@astrauniversity.edu.in" title="kavita.rao@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98250 99890" title="+91 98250 99890"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="ap-section">
        <div class="container">
            <div class="mb-4 ap-reveal">
                <span class="ap-eyebrow">Academic Support</span>
                <h2 class="mt-3 mb-0">Faculty Coordinators</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team10.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Prof. Ramesh Iyer</div>
                            <div class="role">Faculty Coordinator</div>
                            <div class="dept">Department of CSE</div>
                            <div class="ap-team-contact">
                                <a href="mailto:ramesh.iyer@astrauniversity.edu.in" title="ramesh.iyer@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98251 11123" title="+91 98251 11123"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team11.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Prof. Divya Menon</div>
                            <div class="role">Faculty Coordinator</div>
                            <div class="dept">Department of ECE</div>
                            <div class="ap-team-contact">
                                <a href="mailto:divya.menon@astrauniversity.edu.in" title="divya.menon@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98251 22345" title="+91 98251 22345"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team12.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Prof. Anil Chandra</div>
                            <div class="role">Faculty Coordinator</div>
                            <div class="dept">Department of Mechanical</div>
                            <div class="ap-team-contact">
                                <a href="mailto:anil.chandra@astrauniversity.edu.in" title="anil.chandra@astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98251 33567" title="+91 98251 33567"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="ap-section">
        <div class="container">
            <div class="mb-4 ap-reveal">
                <span class="ap-eyebrow">Peer Support</span>
                <h2 class="mt-3 mb-0">Student Coordinators</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team13.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Ishaan Kapoor</div>
                            <div class="role">Student Coordinator</div>
                            <div class="dept">Final Year, CSE</div>
                            <div class="ap-team-contact">
                                <a href="mailto:ishaan.kapoor@students.astrauniversity.edu.in" title="ishaan.kapoor@students.astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98251 44789" title="+91 98251 44789"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team14.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Radhika Pillai</div>
                            <div class="role">Student Coordinator</div>
                            <div class="dept">Final Year, MBA</div>
                            <div class="ap-team-contact">
                                <a href="mailto:radhika.pillai@students.astrauniversity.edu.in" title="radhika.pillai@students.astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98251 55901" title="+91 98251 55901"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4 ap-reveal">
                    <div class="ap-team-card">
                        <div class="ap-team-photo has-img">
                            <img src="../assets/images/team15.jpg" alt="Team member photo" loading="lazy">
                        </div>
                        <div class="ap-team-body">
                            <div class="fw-bold fs-6">Yash Trivedi</div>
                            <div class="role">Student Coordinator</div>
                            <div class="dept">Final Year, IT</div>
                            <div class="ap-team-contact">
                                <a href="mailto:yash.trivedi@students.astrauniversity.edu.in" title="yash.trivedi@students.astrauniversity.edu.in"><i class="bi bi-envelope"></i></a>
                                <a href="tel:+91 98251 66123" title="+91 98251 66123"><i class="bi bi-telephone"></i></a>
                                <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="ap-section" style="background: var(--ap-surface-alt);">
        <div class="container">
            <div class="ap-card ap-reveal">
                <div class="ap-card-body d-flex flex-wrap align-items-center justify-content-between gap-3">
                    <div>
                        <h4 class="mb-1">Need to reach the Placement Cell directly?</h4>
                        <p class="mb-0 ap-kicker">Our team typically responds within one working day.</p>
                    </div>
                    <a href="contact-us.aspx" class="ap-btn ap-btn-primary">Contact Us <i class="bi bi-arrow-right"></i></a>
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

