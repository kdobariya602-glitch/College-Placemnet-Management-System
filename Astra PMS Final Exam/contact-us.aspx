<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="contact-us.aspx.cs" Inherits="Astra_PMS_Final_Exam.contact_us" %>

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
        <div class="ap-hero-bg" style="background-image: url('../assets/images/contact-us.jpg'); background-position: center 75%;"></div>
        <div class="ap-grid-dots"></div>
        <div class="container position-relative">
            <span class="ap-eyebrow"><i class="bi bi-chat-dots"></i>We're Here to Help</span>
            <h1 class="mt-3 mb-3">Contact Us</h1>
            <p class="lead" style="max-width: 560px;">Questions about eligibility, a drive, or partnering with us &mdash; the Placement Cell usually replies within one working day.</p>
        </div>
    </section>


    <section class="ap-section-tight">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-6 col-lg-3 ap-reveal">
                    <div class="ap-contact-card text-center">
                        <div class="ap-icon-tile mx-auto"><i class="bi bi-geo-alt"></i></div>
                        <div class="fw-bold mb-1">Placement Office</div>
                        <div style="color: var(--ap-text-soft); font-size: .88rem;">TPC Block, 2nd Floor, Astra University Campus, Sector 26, Gujarat</div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 ap-reveal">
                    <div class="ap-contact-card text-center">
                        <div class="ap-icon-tile mx-auto"><i class="bi bi-envelope"></i></div>
                        <div class="fw-bold mb-1">Email</div>
                        <div style="color: var(--ap-text-soft); font-size: .88rem;">tpc@astrauniversity.edu.in</div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 ap-reveal">
                    <div class="ap-contact-card text-center">
                        <div class="ap-icon-tile mx-auto"><i class="bi bi-telephone"></i></div>
                        <div class="fw-bold mb-1">Phone</div>
                        <div style="color: var(--ap-text-soft); font-size: .88rem;">1800-123-1104</div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 ap-reveal">
                    <div class="ap-contact-card text-center">
                        <div class="ap-icon-tile mx-auto"><i class="bi bi-clock"></i></div>
                        <div class="fw-bold mb-1">Office Hours</div>
                        <div style="color: var(--ap-text-soft); font-size: .88rem;">Mon &ndash; Sat, 9:00 AM &ndash; 5:30 PM</div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="ap-section">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-7 ap-reveal">
                    <div class="ap-contact-card h-100 d-flex flex-column">
                        <h4 class="mb-1">Send an Inquiry</h4>
                        <p class="ap-kicker mb-4" style="font-size: .9rem;">For recruiters, students and parents &mdash; tell us what you need.</p>
                        <div data-ap-form="Message sent — our team will reach out shortly." onsubmit="return false;" class="d-flex flex-column flex-grow-1">
                            <div class="row g-3 flex-grow-1">
                                <div class="col-md-6">
                                    <label class="ap-form-label">Full Name</label>
                                    <!-- <input type="text" class="ap-form-control" required> -->
                                    <asp:TextBox ID="txtFullName" runat="server" CssClass="ap-form-control"></asp:TextBox>
                                    <asp:Label ID="lblFullName" runat="server" CssClass="ap-form-label" ForeColor="#0d1b3e"></asp:Label>
                                </div>
                                <div class="col-md-6">
                                    <label class="ap-form-label">Email Address</label>
                                    <!-- <input type="email" class="ap-form-control" required> -->
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="ap-form-control" TextMode="Email"></asp:TextBox>
                                    <asp:Label ID="lblEmail" runat="server" CssClass="ap-form-label" ForeColor="#0d1b3e"></asp:Label>
                                </div>
                                <div class="col-md-6">
                                    <label class="ap-form-label">Phone Number</label>
                                    <!-- <input type="tel" class="ap-form-control"> -->
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="ap-form-control" TextMode="Phone"></asp:TextBox>
                                    <asp:Label ID="lblPhone" runat="server" CssClass="ap-form-label" ForeColor="#0d1b3e"></asp:Label>
                                </div>
                                <div class="col-md-6">
                                    <label class="ap-form-label">City</label>
                                    <!-- <input type="text" class="ap-form-control" required> -->
                                    <asp:TextBox ID="txtCity" runat="server" CssClass="ap-form-control"></asp:TextBox>
                                    <asp:Label ID="lblCity" runat="server" CssClass="ap-form-label" ForeColor="#0d1b3e"></asp:Label>
                                </div>
                                <div class="col-12 flex-grow-1 d-flex flex-column">
                                    <label class="ap-form-label">Message</label>
                                    <!-- <textarea class="ap-form-control flex-grow-1" rows="4" required style="min-height:110px;"></textarea> -->
                                    <asp:TextBox ID="txtMessage" runat="server" CssClass="ap-form-control flex-grow-1" TextMode="MultiLine" Rows="4" Style="min-height: 110px;"></asp:TextBox>
                                    <asp:Label ID="lblMessage" runat="server" CssClass="ap-form-label" ForeColor="#0d1b3e"></asp:Label>
                                </div>
                                <div class="col-12">
                                    <!-- <button class="ap-btn ap-btn-primary w-100">Send Message <i class="bi bi-send"></i></button> -->
                                    <asp:Button ID="btnSend" runat="server" Text="Send Message" CssClass="ap-btn ap-btn-primary w-100" OnClick="btnSend_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 ap-reveal">
                    <div class="ap-contact-card p-0 overflow-hidden h-100" style="min-height: 420px;">
                        <iframe src="https://maps.google.com/maps?q=university&t=&z=13&ie=UTF8&iwloc=&output=embed" width="100%" height="100%" style="border: 0;" loading="lazy" title="Astra University location map"></iframe>
                    </div>
                </div>
            </div>
    </section>


    <section class="ap-section" style="background: var(--ap-surface-alt);">
        <div class="container" style="max-width: 820px;">
            <div class="text-center mb-5 ap-reveal">
                <span class="ap-eyebrow">FAQs</span>
                <h2 class="mt-3 mb-0">Common Questions</h2>
            </div>
            <div class="accordion ap-accordion ap-reveal" id="contactFaq">
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <!-- <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#cfaq0">How quickly will I get a response?</button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cfaq0" OnClientClick="return false;" Text="How quickly will I get a response?" />
                    </h2>
                    <div id="cfaq0" class="accordion-collapse collapse" data-bs-parent="#contactFaq">
                        <div class="accordion-body">Our team responds to portal and email inquiries within one working day.</div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <!-- <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#cfaq1">Can recruiters schedule a drive through this form?</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cfaq1" OnClientClick="return false;" Text="Can recruiters schedule a drive through this form?" />
                    </h2>
                    <div id="cfaq1" class="accordion-collapse collapse" data-bs-parent="#contactFaq">
                        <div class="accordion-body">Yes — select 'Recruiter' and share your requirements; Corporate Relations will follow up to finalise the schedule.</div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <!-- <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#cfaq2">Where exactly is the Placement Office located?</button> -->
<asp:Button runat="server" ID="btnCtrl4" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#cfaq2" OnClientClick="return false;" Text="Where exactly is the Placement Office located?" />
                    </h2>
                    <div id="cfaq2" class="accordion-collapse collapse" data-bs-parent="#contactFaq">
                        <div class="accordion-body">
                            Second floor of the TPC Block, opposite the Central Library on the main campus.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div style="width: 90%; margin: 30px auto; overflow-x: auto;">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" HorizontalAlign="Center" Width="967px">
            <Columns>
                <asp:TemplateField HeaderText="Full_Name">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Full_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email_Address">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Email_Address") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Phone_Number">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("Phone_Number") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="City">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Message">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("Message") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

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

