<%@ Page Title="Recruiter Feedback" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="feedback.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.feedback" %>

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
                        <li class="breadcrumb-item"><a href="notifications.aspx">Notifications & Feedback</a></li>
                        <li class="breadcrumb-item active">Recruiter Feedback</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Campus Drive & Placement Feedback</h3>
                <p class="text-muted small mb-0">Share your recruitment experience and student readiness feedback with the Training & Placement Cell.</p>
            </div>
        </div>

        <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="notifications.aspx"><i class="bi bi-bell me-1"></i> Notifications</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="feedback.aspx"><i class="bi bi-chat-heart me-1"></i> Campus Feedback</a>
            </li>
        </ul>

        <div class="row g-4">
            <!-- Left: Feedback Form -->
            <div class="col-lg-6">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-chat-square-heart text-primary me-2"></i>Recruiter Experience Survey</h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Overall Drive Experience <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlOverall" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="5 - Excellent">5 Stars - Excellent</asp:ListItem>
                                    <asp:ListItem Value="4 - Very Good">4 Stars - Very Good</asp:ListItem>
                                    <asp:ListItem Value="3 - Good">3 Stars - Good</asp:ListItem>
                                    <asp:ListItem Value="2 - Fair">2 Stars - Fair</asp:ListItem>
                                    <asp:ListItem Value="1 - Poor">1 Star - Poor</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Student Quality & Skills <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlStudentQuality" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="5 - Exceptional">5 Stars - Exceptional</asp:ListItem>
                                    <asp:ListItem Value="4 - Very Strong">4 Stars - Very Strong</asp:ListItem>
                                    <asp:ListItem Value="3 - Meets Expectations">3 Stars - Meets Expectations</asp:ListItem>
                                    <asp:ListItem Value="2 - Needs Improvement">2 Stars - Needs Improvement</asp:ListItem>
                                    <asp:ListItem Value="1 - Below Expectations">1 Star - Below Expectations</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">TPO Cell Coordination <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlCoordination" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="5 - Flawless">5 Stars - Flawless</asp:ListItem>
                                    <asp:ListItem Value="4 - Prompt & Helpful">4 Stars - Prompt & Helpful</asp:ListItem>
                                    <asp:ListItem Value="3 - Satisfactory">3 Stars - Satisfactory</asp:ListItem>
                                    <asp:ListItem Value="2 - Disorganized">2 Stars - Disorganized</asp:ListItem>
                                    <asp:ListItem Value="1 - Poor">1 Star - Poor</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Campus Infrastructure & Labs <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlInfrastructure" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="5 - World Class">5 Stars - World Class</asp:ListItem>
                                    <asp:ListItem Value="4 - Good Equipment">4 Stars - Good Equipment</asp:ListItem>
                                    <asp:ListItem Value="3 - Adequate">3 Stars - Adequate</asp:ListItem>
                                    <asp:ListItem Value="2 - Average">2 Stars - Average</asp:ListItem>
                                    <asp:ListItem Value="1 - Inadequate">1 Star - Inadequate</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Hiring Process & Scheduling Rating</label>
                            <asp:DropDownList ID="ddlProcess" runat="server" CssClass="form-select">
                                <asp:ListItem Value="5 - Seamless">5 Stars - Seamless</asp:ListItem>
                                <asp:ListItem Value="4 - Well Managed">4 Stars - Well Managed</asp:ListItem>
                                <asp:ListItem Value="3 - Average">3 Stars - Average</asp:ListItem>
                                <asp:ListItem Value="2 - Delays Experienced">2 Stars - Delays Experienced</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label class="form-label fw-semibold small text-muted mb-0">Curriculum Recommendations & Suggestions</label>
                                <button type="button" class="btn btn-sm btn-outline-primary py-0 px-2 fw-semibold" onclick="aiDraftRecruiterFeedback()" title="Auto-draft constructive corporate review">
                                    <i class="bi bi-stars"></i> ✨ AI Auto-Draft Review
                                </button>
                            </div>
                            <asp:TextBox ID="txtSuggestions" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Suggestions regarding technical stack, communication training, or university partnership..."></asp:TextBox>
                        </div>

                        <asp:Button ID="btnSubmitFeedback" runat="server" Text="Submit Recruiter Feedback" CssClass="btn btn-primary w-100 py-2" OnClick="btnSubmitFeedback_Click" />
                    </div>
                </div>
            </div>

            <!-- Right: Past Feedback Entries -->
            <div class="col-lg-6">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-clock-history text-primary me-2"></i>Feedback History</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView  UseAccessibleHeader="True" ID="gvFeedback" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0"
                                DataKeyNames="Feedback_Id" EmptyDataText="No feedback submissions yet." GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="Feedback_Id" HeaderText="#" />
                                    <asp:BoundField DataField="Overall_Experience" HeaderText="Overall" />
                                    <asp:BoundField DataField="Student_Quality" HeaderText="Student Quality" />
                                    <asp:BoundField DataField="Feedback_Date" HeaderText="Submitted Date" />
                                    <asp:TemplateField HeaderText="Suggestions">
                                        <ItemTemplate>
                                            <div class="small text-muted text-truncate" style="max-width:180px;"><%# Eval("Suggestions") %></div>
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
        function aiDraftRecruiterFeedback() {
            var qual = document.getElementById('<%= ddlStudentQuality.ClientID %>').value;
            var box = document.getElementById('<%= txtSuggestions.ClientID %>');

            box.value = "Overall Recruitment Observations:\n" +
                        "1. Student Quality: Candidates demonstrated robust grasp of foundational data structures, OOP principles, and relational database schema design.\n" +
                        "2. Infrastructure & TPO Coordination: Campus testing labs, executive interview rooms, and student turnout were exceptionally well managed by the placement cell.\n" +
                        "3. Industry Recommendations: We recommend incorporating more hands-on cloud deployment drills (Docker, AWS) and microservices architecture into the 6th/7th semester curriculum to further elevate Day-1 project readiness.\n\n" +
                        "We look forward to returning for future campus hiring seasons!";
        }
    </script>
</asp:Content>
