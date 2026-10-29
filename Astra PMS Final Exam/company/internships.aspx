<%@ Page Title="Internship Openings" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="internships.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.internships" %>

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
                        <li class="breadcrumb-item"><a href="employees.aspx">Post Openings</a></li>
                        <li class="breadcrumb-item active">Internship Opportunities</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Manage Internship Openings</h3>
                <p class="text-muted small mb-0">Post and manage summer, winter, and pre-placement internship opportunities for students.</p>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="post-job.aspx"><i class="bi bi-plus-circle me-1"></i> Post New Job</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="jobs.aspx"><i class="bi bi-briefcase me-1"></i> Job Openings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="internships.aspx"><i class="bi bi-mortarboard me-1"></i> Internship Postings</a>
            </li>
        </ul>



        <div class="row g-4">
            <!-- Left: Create / Edit Internship Form -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-rocket-takeoff text-primary me-2"></i>Post / Update Internship</h5>
                    </div>
                    <div class="card-body p-4">

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Internship Title <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="e.g. Software Engineering Intern (Cloud)"></asp:TextBox>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Monthly Stipend <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtStipend" runat="server" CssClass="form-control" placeholder="e.g. Rs. 25,000 / month"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Duration <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" placeholder="e.g. 6 Months"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Work Mode</label>
                                <asp:DropDownList ID="ddlWorkMode" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="Hybrid">Hybrid</asp:ListItem>
                                    <asp:ListItem Value="On-site">On-site</asp:ListItem>
                                    <asp:ListItem Value="Remote">Remote</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Location</label>
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="e.g. Bangalore / Mumbai"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Vacancies</label>
                                <asp:TextBox ID="txtVacancies" runat="server" CssClass="form-control" TextMode="Number" Text="5"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Application Deadline <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtDeadline" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Eligibility Criteria</label>
                            <asp:TextBox ID="txtEligibility" runat="server" CssClass="form-control" placeholder="e.g. B.Tech CSE/IT, Min 7.0 CGPA, No Active Backlogs"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Required Skills</label>
                            <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" placeholder="e.g. C#, ASP.NET, React, SQL Server"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label class="form-label fw-semibold small text-muted mb-0">Internship Description & Role</label>
                                <button type="button" class="btn btn-sm btn-outline-primary py-0 px-2 fw-semibold" onclick="aiDraftInternshipPosting()" title="Auto-draft role details">
                                    <i class="bi bi-stars"></i> ✨ AI Auto-Draft Role
                                </button>
                            </div>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Key responsibilities and project scope..."></asp:TextBox>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold small text-muted">Status</label>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                                <asp:ListItem Value="Active">Active / Accepting Applications</asp:ListItem>
                                <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
                                <asp:ListItem Value="Closed">Closed</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSave" runat="server" Text="Publish Internship" CssClass="btn btn-primary flex-grow-1" OnClick="btnSave_Click" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Internships Grid -->
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-list-stars text-primary me-2"></i>Active Internship Postings</h5>
                        <asp:Label ID="lblTotalInternships" runat="server" CssClass="badge bg-primary px-3 py-2"></asp:Label>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView  UseAccessibleHeader="True" ID="gvInternships" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0"
                                DataKeyNames="Internship_Id" EmptyDataText="No internship openings posted yet." GridLines="None" OnRowCommand="gvInternships_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="Internship_Id" HeaderText="#" />
                                    <asp:TemplateField HeaderText="Internship Title">
                                        <ItemTemplate>
                                            <div class="fw-bold text-dark"><%# Eval("Internship_Title") %></div>
                                            <div class="text-muted small"><i class="bi bi-geo-alt me-1"></i><%# Eval("Location") %> (<%# Eval("Work_Mode") %>)</div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Stipend & Duration">
                                        <ItemTemplate>
                                            <div class="fw-semibold text-success"><%# Eval("Stipend") %></div>
                                            <div class="text-muted small"><%# Eval("Duration") %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Deadline" HeaderText="Deadline" DataFormatString="{0:dd MMM yyyy}" />
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <span class='badge <%# Convert.ToString(Eval("Status")) == "Active" ? "bg-success" : "bg-secondary" %>'>
                                                <%# Eval("Status") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <div class="btn-group btn-group-sm">
                                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditInternship" CommandArgument='<%# Eval("Internship_Id") %>' CssClass="btn btn-outline-primary" title="Edit">
                                                    <i class="bi bi-pencil"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteInternship" CommandArgument='<%# Eval("Internship_Id") %>' CssClass="btn btn-outline-danger" OnClientClick="return confirm('Delete this internship posting?');" title="Delete">
                                                    <i class="bi bi-trash"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center py-4 text-muted">
                                <i class="bi bi-inbox fs-2 d-block mb-1 text-secondary"></i>
                                <div class="fw-semibold">No records found</div>
                                <div class="small">There are currently no entries to display.</div>
                            </div>
                        </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function aiDraftInternshipPosting() {
            var tBox = document.getElementById('<%= txtTitle.ClientID %>');
            var sBox = document.getElementById('<%= txtStipend.ClientID %>');
            var dBox = document.getElementById('<%= txtDuration.ClientID %>');
            var eBox = document.getElementById('<%= txtEligibility.ClientID %>');
            var kBox = document.getElementById('<%= txtSkills.ClientID %>');
            var descBox = document.getElementById('<%= txtDescription.ClientID %>');

            if (!tBox.value || tBox.value.trim() === '') {
                tBox.value = 'Software Engineering Intern (Full-Stack & Cloud)';
            }
            sBox.value = 'Rs. 25,000 / month';
            dBox.value = '6 Months (Pre-Placement Offer track)';
            eBox.value = 'B.Tech / M.Tech CSE, IT, ECE with minimum 6.50 CGPA';
            kBox.value = 'C#, ASP.NET Core, JavaScript/React, SQL Server, Git';
            descBox.value = 'Join our core engineering squad to develop scalable web services, optimize relational databases, and participate in daily agile sprints. Interns who demonstrate technical excellence and collaborative ownership will be considered for immediate Full-Time Pre-Placement Offers (PPO).';
        }
    </script>
</asp:Content>
