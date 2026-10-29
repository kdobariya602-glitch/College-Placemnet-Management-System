<%@ Page Title="Recruiter Dashboard" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.dashboard" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-content">

        <!-- Welcome Hero Banner -->

        <div class="content-card hero-banner-card mb-4 p-4 text-white" style="border-radius: 16px;">

            <div class="row align-items-center">

                <div class="col-lg-8">

                    <div class="d-flex align-items-center gap-2 mb-2">

                        <span class="badge bg-white text-dark px-3 py-1 fw-semibold"><i class="bi bi-building-check text-primary me-1"></i> Astra Corporate Recruiter Portal</span>

                        <asp:Label ID="lblVerificationStatusBadge" runat="server" CssClass="badge bg-success px-3 py-1 fw-semibold"></asp:Label>

                    </div>

                    <h3 class="fw-bold mb-1 text-white">Welcome, <asp:Literal ID="litCompanyName" runat="server" Text="Corporate Partner"></asp:Literal>!</h3>

                    <p class="text-white-50 mb-0">Hiring Talent for <asp:Label ID="lblIndustryHero" runat="server" CssClass="text-white fw-semibold"></asp:Label> &bull; Location: <asp:Label ID="lblLocationHero" runat="server" CssClass="text-white fw-semibold"></asp:Label></p>

                </div>

                <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">

                    <a href="post-job.aspx" class="btn btn-outline-light fw-bold px-3 py-2 text-white shadow-sm me-2">

                        <i class="bi bi-plus-circle me-1"></i> Post New Job

                    </a>

                    <a href="applicants.aspx" class="btn btn-light fw-bold px-3 py-2 text-primary shadow-sm">

                        <i class="bi bi-people me-1 text-primary"></i> View Applicants

                    </a>

                </div>

            </div>

        </div>



        <!-- KPI Metrics Row -->

        <div class="row g-3 mb-4">

            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-briefcase"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblActiveJobs" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Active Openings</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-people"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblTotalApplicants" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Candidate Applicants</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-person-video"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblShortlistedCount" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Shortlisted Candidates</div>

                    </div>

                </div>

            </div>



            <div class="col-sm-6 col-lg-3">

                <div class="content-card p-3 d-flex align-items-center gap-3">

                    <div class="stat-icon">

                        <i class="bi bi-trophy"></i>

                    </div>

                    <div>

                        <div class="stat-value fs-4 fw-bold text-dark"><asp:Label ID="lblHiredCount" runat="server" Text="0"></asp:Label></div>

                        <div class="stat-label text-muted small text-uppercase fw-semibold" style="font-size:0.75rem;">Selected & Hired</div>

                    </div>

                </div>

            </div>

        </div>



        <!-- Middle Section: Recruiter Hiring Funnel & Distribution Charts -->

        <div class="row g-4 mb-4">

            <!-- Left Chart: Recruitment Pipeline Stages (Bar Chart) -->

            <div class="col-lg-7">

                <div class="content-card h-100 p-3">

                    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">

                        <div>

                            <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-funnel-fill text-primary me-2"></i>Recruitment Pipeline Funnel</h5>

                            <small class="text-muted">Applicant conversion across screening, evaluation and offer stages</small>

                        </div>

                        <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1">Conversion Funnel</span>

                    </div>

                    <div class="text-center" style="overflow-x:auto;">

                        <asp:Chart ID="ChartHiringPipeline" runat="server" Width="480px" Height="260px" AntiAliasing="All" TextAntiAliasingQuality="High" ImageType="Png" RenderType="ImageTag" BackColor="Transparent">

                            <Series>

                                <asp:Series Name="Series1" ChartType="Column" Palette="BrightPastel" IsValueShownAsLabel="true" Font="Segoe UI, 9.5pt, style=Bold">

                                </asp:Series>

                            </Series>

                            <ChartAreas>

                                <asp:ChartArea Name="ChartArea1" BackColor="Transparent">

                                    <AxisX LineColor="#CBD5E1" Interval="1" IsLabelAutoFit="true">
                                        <LabelStyle Font="Segoe UI, 8.5pt, style=Bold" ForeColor="#1E293B" IsEndLabelVisible="true" />

                                        <MajorGrid LineColor="#F1F5F9" />

                                        
                                    </AxisX>

                                    <AxisY LineColor="#CBD5E1">

                                        <MajorGrid LineColor="#F1F5F9" />

                                        
                                    </AxisY>

                                </asp:ChartArea>

                            </ChartAreas>

                        </asp:Chart>

                    </div>

                </div>

            </div>



            <!-- Right Chart: Candidate Distribution by Hiring Stage (Doughnut Chart) -->

            <div class="col-lg-5">

                <div class="content-card h-100 p-3">

                    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">

                        <div>

                            <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-pie-chart-fill text-success me-2"></i>Applicant Status Ratio</h5>

                            <small class="text-muted">Current status breakdown of candidate pool</small>

                        </div>

                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">Pipeline Ratio</span>

                    </div>

                    <div class="text-center" style="overflow-x:auto;">

                        <asp:Chart ID="ChartCandidateStatus" runat="server" Width="320px" Height="260px" AntiAliasing="All" TextAntiAliasingQuality="High" ImageType="Png" RenderType="ImageTag" BackColor="Transparent">

                            <Series>

                                <asp:Series Name="Series1" ChartType="Doughnut" Palette="Pastel" IsValueShownAsLabel="true" Font="Segoe UI, 9.5pt, style=Bold">

                                </asp:Series>

                            </Series>

                            <ChartAreas>

                                <asp:ChartArea Name="ChartArea1" BackColor="Transparent">

                                </asp:ChartArea>

                            </ChartAreas>

                            <Legends>

                                <asp:Legend Name="Legend1" Docking="Bottom" Alignment="Center" Font="Segoe UI, 9pt, style=Bold" BackColor="Transparent" />

                            </Legends>

                        </asp:Chart>

                    </div>

                </div>

            </div>

        </div>



        <div class="row g-4">

            <!-- Left: Company's Active Job Openings & Applicants -->

            <div class="col-lg-7">

                <div class="content-card mb-4">

                    <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">

                        <h5 class="mb-0 fw-bold"><i class="bi bi-briefcase-fill text-primary me-2"></i>My Active Job Postings</h5>

                        <a href="jobs.aspx" class="btn btn-sm btn-outline-primary">Manage Jobs</a>

                    </div>

                    <div class="card-body-custom p-0">

                        <div class="table-responsive">

                            <asp:GridView ID="gvMyJobs" runat="server" AutoGenerateColumns="False"

                                CssClass="table table-hover align-middle mb-0" GridLines="None" UseAccessibleHeader="True">

                                <HeaderStyle CssClass="table-light text-muted small fw-semibold" />

                                <EmptyDataTemplate>

                                    <div class="text-center py-4 text-muted">You haven't posted any job openings yet. Click 'Post New Job' to begin hiring.</div>

                                </EmptyDataTemplate>

                                <Columns>

                                    <asp:TemplateField HeaderText="Position">

                                        <ItemTemplate>

                                            <div class="fw-bold text-dark"><%# Eval("Job_Title") %></div>

                                            <span class="text-muted small"><%# Eval("Job_Type") %> &bull; <%# Eval("Location") %></span>

                                        </ItemTemplate>

                                    </asp:TemplateField>



                                    <asp:TemplateField HeaderText="Package (LPA)">

                                        <ItemTemplate>

                                            <span class="badge bg-success-subtle text-success border border-success fw-bold">Rs. <%# Eval("Salary_CTC") %> LPA</span>

                                        </ItemTemplate>

                                    </asp:TemplateField>



                                    <asp:BoundField DataField="Vacancies" HeaderText="Openings" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />



                                    <asp:TemplateField HeaderText="Status">

                                        <ItemTemplate>

                                            <span class='<%# Convert.ToString(Eval("Status")) == "Active" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : "badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25" %>'>

                                                <%# Eval("Status") %>

                                            </span>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                </Columns>

                            </asp:GridView>

                        </div>

                    </div>

                </div>



                <!-- Recent Applicants -->

                <div class="content-card">

                    <div class="card-header-custom p-3 border-bottom d-flex justify-content-between align-items-center">

                        <h5 class="mb-0 fw-bold"><i class="bi bi-people-fill text-primary me-2"></i>Recent Candidate Submissions</h5>

                        <a href="applicants.aspx" class="btn btn-sm btn-outline-primary">View All</a>

                    </div>

                    <div class="card-body-custom p-0">

                        <div class="table-responsive">

                            <asp:GridView ID="gvRecentApplicants" runat="server" AutoGenerateColumns="False"

                                CssClass="table table-hover align-middle mb-0" GridLines="None" UseAccessibleHeader="True"

                                OnRowCommand="gvRecentApplicants_RowCommand">

                                <HeaderStyle CssClass="table-light text-muted small fw-semibold" />

                                <EmptyDataTemplate>

                                    <div class="text-center py-4 text-muted">No student applications received yet.</div>

                                </EmptyDataTemplate>

                                <Columns>

                                    <asp:TemplateField HeaderText="Student">

                                        <ItemTemplate>

                                            <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>

                                            <span class="text-muted small"><%# Eval("Department") %> &bull; CGPA: <%# Eval("CGPA", "{0:0.00}") %></span>

                                        </ItemTemplate>

                                    </asp:TemplateField>



                                    <asp:BoundField DataField="Applied_Date" HeaderText="Applied Date" DataFormatString="{0:dd MMM yyyy}" />



                                    <asp:TemplateField HeaderText="Status">

                                        <ItemTemplate>

                                            <span class='<%# Convert.ToString(Eval("Status")) == "Selected" ? "badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" : (Convert.ToString(Eval("Status")) == "Shortlisted" ? "badge bg-info bg-opacity-10 text-info border border-info border-opacity-25" : "badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25") %>'>

                                                <%# Eval("Status") %>

                                            </span>

                                        </ItemTemplate>

                                    </asp:TemplateField>



                                    <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">

                                        <ItemTemplate>

                                            <asp:LinkButton ID="lnkReview" runat="server" CommandName="review_app" CommandArgument='<%# Eval("Application_Id") %>' CssClass="btn btn-sm btn-outline-primary">Review</asp:LinkButton>

                                        </ItemTemplate>

                                    </asp:TemplateField>

                                </Columns>

                            </asp:GridView>

                        </div>

                    </div>

                </div>

            </div>



            <!-- Right: Company Overview Card -->

            <div class="col-lg-5">

                <div class="content-card p-4">

                    <div class="d-flex align-items-center gap-3 mb-3">

                        <div class="avatar-circle" style="width:55px; height:55px; border-radius:14px; background:#EFF6FF; color:#1D4ED8; display:flex; align-items:center; justify-content:center; font-size:1.6rem; font-weight:bold;">

                            <i class="bi bi-building"></i>

                        </div>

                        <div>

                            <h5 class="fw-bold text-dark mb-0"><asp:Label ID="lblCompName" runat="server"></asp:Label></h5>

                            <span class="text-muted small"><asp:Label ID="lblCompEmail" runat="server"></asp:Label></span>

                        </div>

                    </div>



                    <hr class="my-3 text-muted" />



                    <ul class="list-group list-group-flush small">

                        <li class="list-group-item d-flex justify-content-between px-0 py-2">

                            <span class="text-muted">HR Contact Person:</span>

                            <span class="fw-semibold text-dark"><asp:Label ID="lblHRName" runat="server"></asp:Label></span>

                        </li>

                        <li class="list-group-item d-flex justify-content-between px-0 py-2">

                            <span class="text-muted">HR Contact Number:</span>

                            <span class="fw-semibold text-dark"><asp:Label ID="lblHRPhone" runat="server"></asp:Label></span>

                        </li>

                        <li class="list-group-item d-flex justify-content-between px-0 py-2">

                            <span class="text-muted">Corporate Website:</span>

                            <span class="fw-semibold text-primary"><asp:Label ID="lblWebsite" runat="server"></asp:Label></span>

                        </li>

                    </ul>



                    <div class="mt-3">

                        <a href="profile.aspx" class="btn btn-sm btn-outline-secondary w-100"><i class="bi bi-pencil-square me-1"></i> Edit Company Profile</a>

                    </div>

                </div>

            </div>

        </div>

    </div>



    <!-- Chart.js Real-time Script Initialization (Library loaded via Master page) -->

    <script>

        document.addEventListener('DOMContentLoaded', function () {

            var elApps = document.getElementById('<%= lblTotalApplicants.ClientID %>');

            var elShort = document.getElementById('<%= lblShortlistedCount.ClientID %>');

            var elHired = document.getElementById('<%= lblHiredCount.ClientID %>');



            // Real data from database (code-behind)

            var chartData = <%= chartFunnel %>;

            var ratioData = <%= chartRatio %>;



            var ctx = document.getElementById('recruiterFunnelChart');

            if (ctx) {

                new Chart(ctx, {

                    type: 'bar',

                    data: {

                        labels: ['Applications', 'In Review', 'Shortlisted', 'Hired'],

                        datasets: [{

                            label: 'Candidates',

                            data: chartData,

                            backgroundColor: [

                                '#3B82F6',

                                '#38BDF8',

                                '#F59E0B',

                                '#10B981'

                            ],

                            borderRadius: 4,

                            maxBarThickness: 14

                        }]

                    },

                    options: {

                        responsive: true,

                        maintainAspectRatio: false,

                        indexAxis: 'y',

                        plugins: {

                            legend: { display: false },

                            tooltip: {

                                callbacks: {

                                    label: function(context) { return ' ' + context.raw + ' Candidates'; }

                                }

                            }

                        },

                        scales: {

                            x: {

                                beginAtZero: true,

                                grid: { color: '#F1F5F9' },

                                ticks: { font: { size: 10, family: 'Inter' }, color: '#94A3B8' }

                            },

                            y: {

                                grid: { display: false },

                                ticks: { font: { size: 10, family: 'Inter', weight: '500' }, color: '#475569' }

                            }

                        }

                    }

                });

            }



            // 2. Candidate Status Ratio (Doughnut Chart)

            var ctxRatio = document.getElementById('recruiterRatioChart');

            if (ctxRatio) {

                new Chart(ctxRatio.getContext('2d'), {

                    type: 'doughnut',

                    data: {

                        labels: ['In Review', 'Shortlisted', 'Hired'],

                        datasets: [{

                            data: ratioData,

                            backgroundColor: ['#3B82F6', '#F59E0B', '#10B981'],

                            hoverOffset: 4,

                            borderWidth: 2,

                            borderColor: '#FFFFFF'

                        }]

                    },

                    options: {

                        responsive: true,

                        maintainAspectRatio: false,

                        cutout: '72%',

                        plugins: {

                            legend: {

                                position: 'bottom',

                                labels: {

                                    boxWidth: 8,

                                    boxHeight: 8,

                                    usePointStyle: true,

                                    pointStyle: 'circle',

                                    font: { family: 'Inter', size: 10, weight: '500' },

                                    padding: 6

                                }

                            }

                        }

                    }

                });

            }

        });

    </script>

</asp:Content>

