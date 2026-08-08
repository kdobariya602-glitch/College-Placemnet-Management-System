<%@ Page Title="" Language="C#" MasterPageFile="~/Public_Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.register" %>

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
        <div class="auth-card" style="max-width: 960px">
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
                        <p class="opacity-75 mb-4">Create your account to explore placement drives, apply to top companies, and track your journey at Parul University.</p>
                    </div>
                </div>
                <div class="col-lg-7 auth-form">
                    <div class="text-center mb-4">
                        <div class="auth-logo mx-auto">
                            <svg width="32" height="32" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                                <rect x="1" y="1" width="46" height="46" rx="14" fill="#0d1b3e" />
                                <path d="M24 9L34.5 31.5H30L28 27H20L18 31.5H13.5L24 9Z" fill="#ffffff" />
                                <rect x="20.8" y="22.5" width="6.4" height="2.6" fill="#0d1b3e" />
                                <circle cx="34" cy="13.5" r="3.2" fill="#f5a524" />
                            </svg>
                        </div>
                        <h4 class="fw-bold">Student Registration</h4>
                        <p class="text-muted">Create your account to access placement opportunities</p>
                    </div>
                    <div id="registerForm">
                        <div class="row">
                            <!-- <div class="col-md-6 mb-3"><label class="form-label-custom">Full Name</label><input type="text" class="form-control form-control-custom" id="fullName" required></div> -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label-custom">Full Name</label><asp:TextBox runat="server" ID="fullName" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
                            <!-- <div class="col-md-6 mb-3"><label class="form-label-custom">Email</label><input type="email" class="form-control form-control-custom" id="email" required></div> -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label-custom">Email</label><asp:TextBox runat="server" ID="email" ClientIDMode="Static" TextMode="Email" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
                        </div>
                        <div class="row">
                            <!-- <div class="col-md-6 mb-3"><label class="form-label-custom">Password</label><input type="password" class="form-control form-control-custom" id="password" required minlength="6"></div> -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label-custom">Password</label><asp:TextBox runat="server" ID="password" ClientIDMode="Static" TextMode="Password" CssClass="form-control form-control-custom" required="required" minlength="6"></asp:TextBox></div>
                            <!-- <div class="col-md-6 mb-3"><label class="form-label-custom">Phone</label><input type="tel" class="form-control form-control-custom" id="phone" required></div> -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label-custom">Phone</label><asp:TextBox runat="server" ID="phone" ClientIDMode="Static" TextMode="Phone" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label-custom">Branch</label>
                                <!-- <select class="form-select form-control-custom" id="branch" required>
                <option value="Computer Science">Computer Science</option>
                <option value="Information Technology">Information Technology</option>
                <option value="Electronics">Electronics</option>
                <option value="Mechanical">Mechanical</option>
              </select> -->
                                <asp:DropDownList runat="server" ID="branch" ClientIDMode="Static" CssClass="form-select form-control-custom" required="required">
                                    <asp:ListItem Text="Computer Science" Value="Computer Science"></asp:ListItem>
                                    <asp:ListItem Text="Information Technology" Value="Information Technology"></asp:ListItem>
                                    <asp:ListItem Text="Electronics" Value="Electronics"></asp:ListItem>
                                    <asp:ListItem Text="Mechanical" Value="Mechanical"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <!-- <div class="col-md-4 mb-3"><label class="form-label-custom">CGPA</label><input type="number" step="0.1" min="0" max="10" class="form-control form-control-custom" id="cgpa" required></div> -->
                            <div class="col-md-4 mb-3">
                                <label class="form-label-custom">CGPA</label><asp:TextBox runat="server" ID="cgpa" ClientIDMode="Static" TextMode="Number" step="0.1" min="0" max="10" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
                            <!-- <div class="col-md-4 mb-3"><label class="form-label-custom">Graduation Year</label><input type="text" class="form-control form-control-custom" id="year" value="2026" required></div> -->
                            <div class="col-md-4 mb-3">
                                <label class="form-label-custom">Graduation Year</label><asp:TextBox runat="server" ID="year" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" Text="2026" required="required"></asp:TextBox></div>
                        </div>
                        <!-- <div class="mb-3"><label class="form-label-custom">Skills (comma separated)</label><input type="text" class="form-control form-control-custom" id="skills" placeholder="JavaScript, Python, React"></div> -->
                        <div class="mb-3">
                            <label class="form-label-custom">Skills (comma separated)</label><asp:TextBox runat="server" ID="skills" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" placeholder="JavaScript, Python, React"></asp:TextBox></div>
                        <%--          <button type="button" id="registerBtn" class="btn btn-primary-custom w-100 py-2 mb-3">Register</button>--%>
                        <asp:ImageButton ID="registerBtn" runat="server" ClientIDMode="Static" ImageUrl="~/assets/images/Register2.png" CssClass="w-100" Style="height: 35px; border-radius: 99px;" OnClick="registerBtn_Click" />
                    </div>
                    <p class="text-center text-muted small">Already have an account? <a href="login.aspx" class="text-danger">Login here</a></p>
                    <p class="text-center text-muted small mb-0"><a href="../index.aspx"><i class="bi bi-arrow-left me-1"></i>Back to Home</a></p>
                    <p class="text-center text-muted small mb-0">&nbsp;</p>
                    <p class="text-center text-muted small mb-0">
                    </p>
                </div>
            </div>
        </div>
    </div>
    <div style="width:90%; margin:30px auto; overflow-x:auto;">

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" HorizontalAlign="Center" Width="1127px">
    <Columns>
        <asp:TemplateField HeaderText="Full_Name">
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Full_Name") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Email">
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Phone">
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Branch">
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Branch") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Cgpa">
            <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Cgpa") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Graduation_Year">
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Graduation_Year") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Skills">
            <ItemTemplate>
                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Skills") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
        </div>
                   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                   <script src="../assets/js/data.js"></script>
                   <script src="../assets/js/app.js"></script>
                   <%--<script src="../assets/js/student.js"></script>--%>

                   <!-- ============================= BODY END ============================= -->

               </div>
    </div>
</asp:Content>

