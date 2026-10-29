<%@ Page Title="Placement Configuration" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="Placement_Configuration.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.Placement_Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <!-- Breadcrumb & Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item active">Placement Configuration</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Placement Cell Policy & Academic Years</h3>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="academic-masters.aspx"><i class="bi bi-diagram-3 me-1"></i> Academic Masters</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="Placement_Configuration.aspx"><i class="bi bi-sliders2 me-1"></i> Placement Configuration</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="System_Settings.aspx"><i class="bi bi-sliders me-1"></i> System Settings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="User_Management.aspx"><i class="bi bi-person-lock me-1"></i> User Management</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="audit-logs.aspx"><i class="bi bi-journal-text me-1"></i> Audit Logs</a>
            </li>
        </ul>

        <!-- Add Academic Year Form Card -->
        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-header bg-white p-3 border-bottom">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-calendar-plus text-primary me-2"></i>Configure Academic Year</h5>
                    
                </div>
            </div>
            <div class="card-body p-4">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-semibold text-muted">Academic Year (e.g., 2026-2027)</label>
                        <asp:TextBox ID="txtYearName" runat="server" CssClass="form-control" placeholder="2026-2027"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-muted">Start Date</label>
                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-muted">End Date</label>
                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <asp:Button ID="btnSaveYear" runat="server" Text="Save Year" CssClass="btn btn-primary w-100 fw-semibold" OnClick="btnSaveYear_Click" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Academic Years GridView Card -->
        <div class="content-card">
            <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold"><i class="bi bi-calendar-range text-primary me-2"></i>Academic Years Configuration</h5>
                <span class="text-muted small">Academic cohorts mapped to placement sessions</span>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvAcademicYears" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Year_Id" OnRowCommand="gvAcademicYears_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-calendar-x fs-1 text-muted d-block mb-3"></i>
                                <h5>No Academic Years Configured</h5>
                                <p class="mb-0">Add an academic year to initiate the placement season.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="Year_Name" HeaderText="Academic Year" />
                            <asp:BoundField DataField="Start_Date" HeaderText="Start Date" DataFormatString="{0:dd MMM yyyy}" />
                            <asp:BoundField DataField="End_Date" HeaderText="End Date" DataFormatString="{0:dd MMM yyyy}" />

                            <asp:TemplateField HeaderText="Current Season">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("Is_Current")) == "1" ? "badge bg-success" : "badge bg-secondary" %>'>
                                        <%# Convert.ToString(Eval("Is_Current")) == "1" ? "Active Season" : "Archived" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Status" HeaderText="Status" />

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnSetCurrent" runat="server" Text="Set Current" CommandName="set_current" CommandArgument='<%# Eval("Year_Id") %>' CssClass="btn btn-sm btn-outline-primary me-1" />
                                    <asp:Button ID="btnToggle" runat="server" Text="Toggle Status" CommandName="toggle_status" CommandArgument='<%# Eval("Year_Id") %>' CssClass="btn btn-sm btn-outline-secondary" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- AI Placement Policy Drafter Modal -->
    <div style="display:none;" id="modalAiPolicy" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold text-dark"><i class="bi bi-stars text-primary me-2"></i>✨ AI University Placement Policy &amp; Code of Conduct</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="alert alert-primary bg-opacity-10 border-primary border-opacity-25 small mb-3">
                        <i class="bi bi-shield-check me-1"></i> Institutional Code of Conduct, One-Student-One-Offer rules, and Dream Job criteria generated for Astra University.
                    </div>
                    <div class="mb-3">
                        <textarea id="aiPolicyText" class="form-control" rows="9" readonly style="background-color:#F8FAFC; font-size:0.92rem; line-height:1.6;"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" onclick="copyAiPolicy()"><i class="bi bi-clipboard me-1"></i> Copy Policy</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function openAiPolicyModal() {
            var policy = "ASTRA UNIVERSITY - INSTITUTIONAL PLACEMENT POLICY & CODE OF CONDUCT (2026-2027)\n\n" +
                         "1. REGISTRATION & ELIGIBILITY MANDATE:\n" +
                         "- Mandatory registration on Astra PMS with verified CGPA (minimum 6.00 with no active backlogs for general campus drives).\n" +
                         "- Minimum 75% verified attendance in all pre-placement training modules, mock interviews, and soft-skill bootcamps.\n\n" +
                         "2. ONE-STUDENT-ONE-OFFER (OSOO) GOVERNANCE:\n" +
                         "- Once a candidate accepts an employment offer, they are marked 'Placed' and withdrawn from equivalent category drives.\n" +
                         "- Exception: Candidates with an offer under 6.00 LPA are eligible to compete in designated 'Dream / Super Dream' drives (>10.00 LPA).\n\n" +
                         "3. DISCIPLINARY & PROFESSIONAL ETIQUETTE:\n" +
                         "- Failure to attend an accepted interview round without 24 hours prior written notice will lead to automatic placement de-registration.\n" +
                         "- Professional formal dress code and valid university ID card are mandatory across on-campus and virtual hiring rounds.";
            document.getElementById('aiPolicyText').value = policy;
            var m = new bootstrap.Modal(document.getElementById('modalAiPolicy'));
            m.show();
        }
        function copyAiPolicy() {
            var el = document.getElementById("aiPolicyText");
            el.select();
            document.execCommand("copy");
            alert("✨ Placement Policy copied to clipboard!");
        }
    </script>
</asp:Content>
