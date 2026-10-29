<%@ Page Title="Schedule Interviews" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="interviews.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.interviews" %>

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
                        <li class="breadcrumb-item"><a href="interviews.aspx">Candidate Management</a></li>
                        <li class="breadcrumb-item active">Schedule Interviews</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Interview Scheduling & Management</h3>
                <p class="text-muted small mb-0">Coordinate technical and HR evaluation rounds for shortlisted applicants.</p>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="applicants.aspx"><i class="bi bi-people me-1"></i> Applicants</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="shortlisted.aspx"><i class="bi bi-person-check me-1"></i> Shortlisted Students</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="interviews.aspx"><i class="bi bi-calendar-event me-1"></i> Interview Schedules</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="interview-results.aspx"><i class="bi bi-clipboard-check me-1"></i> Assessment Results</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="selections.aspx"><i class="bi bi-award me-1"></i> Selections & Offers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="placement-history.aspx"><i class="bi bi-clock-history me-1"></i> Hiring History</a>
            </li>
        </ul>

        <div class="row g-4">
            <!-- Left: Schedule New Interview Form -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-calendar-plus text-primary me-2"></i>Schedule Interview Round</h5>
                    </div>
                    <div class="card-body p-4">

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Select Shortlisted Candidate <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlCandidate" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Interview Round <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlRound" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="Technical Round 1">Technical Round 1</asp:ListItem>
                                    <asp:ListItem Value="Technical Round 2">Technical Round 2</asp:ListItem>
                                    <asp:ListItem Value="Managerial Round">Managerial Round</asp:ListItem>
                                    <asp:ListItem Value="Group Discussion">Group Discussion</asp:ListItem>
                                    <asp:ListItem Value="HR & Culture Fit">HR & Culture Fit</asp:ListItem>
                                    <asp:ListItem Value="Final Round">Final Round</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Interview Mode <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlMode" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="Online / Video Call">Online / Video Call</asp:ListItem>
                                    <asp:ListItem Value="Offline (Campus Venue)">Offline (Campus Venue)</asp:ListItem>
                                    <asp:ListItem Value="Hybrid">Hybrid</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Date <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Time Slot <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" placeholder="e.g. 10:30 AM"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Meeting Link / Campus Venue <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtVenue" runat="server" CssClass="form-control" placeholder="https://meet.google.com/xyz or Seminar Hall B"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Interviewer / Panel Name</label>
                            <asp:TextBox ID="txtInterviewer" runat="server" CssClass="form-control" placeholder="e.g. Mr. Rajesh Kumar (Tech Lead)"></asp:TextBox>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold small text-muted">Instructions for Candidate</label>
                            <asp:TextBox ID="txtInstructions" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="e.g. Keep resume, project code demo, and ID card ready."></asp:TextBox>
                        </div>

                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSave" runat="server" Text="Schedule Interview" CssClass="btn btn-primary flex-grow-1" OnClick="btnSave_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnCancel_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Scheduled Interviews List -->
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-clock-history text-primary me-2"></i>Upcoming & Scheduled Interviews</h5>
                        <asp:Label ID="lblTotalCount" runat="server" CssClass="badge bg-primary px-3 py-2"></asp:Label>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView  UseAccessibleHeader="True" ID="gvInterviews" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0"
                                DataKeyNames="Interview_Id" EmptyDataText="No interview sessions scheduled yet." OnRowCommand="gvInterviews_RowCommand" GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="Interview_Id" HeaderText="#" />
                                    <asp:TemplateField HeaderText="Candidate">
                                        <ItemTemplate>
                                            <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                            <div class="text-muted small"><%# Eval("Student_Email") %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Round & Mode">
                                        <ItemTemplate>
                                            <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25 fw-semibold"><%# Eval("Round_Name") %></span>
                                            <div class="text-muted small mt-1"><i class="bi bi-geo-alt me-1"></i><%# Eval("Mode") %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date & Time">
                                        <ItemTemplate>
                                            <div class="fw-semibold text-dark"><i class="bi bi-calendar3 me-1 text-primary"></i><%# Eval("Interview_Date", "{0:dd MMM yyyy}") %></div>
                                            <div class="text-muted small"><i class="bi bi-clock me-1"></i><%# Eval("Interview_Time") %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <span class='badge <%# Convert.ToString(Eval("Status")) == "Completed" ? "bg-success" : Convert.ToString(Eval("Status")) == "Cancelled" ? "bg-danger" : "bg-warning text-dark" %>'>
                                                <%# Eval("Status") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <div class="btn-group btn-group-sm">
                                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditInterview" CommandArgument='<%# Eval("Interview_Id") %>' CssClass="btn btn-outline-primary" title="Edit Session">
                                                    <i class="bi bi-pencil"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="lnkEvaluate" runat="server" CommandName="evaluate_interview" CommandArgument='<%# Eval("Interview_Id") %>' CssClass="btn btn-outline-success" title="Evaluate">
                                                    <i class="bi bi-check-circle"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="CancelInterview" CommandArgument='<%# Eval("Interview_Id") %>' CssClass="btn btn-outline-danger" OnClientClick="return confirm('Cancel this interview?');" title="Cancel">
                                                    <i class="bi bi-x-circle"></i>
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
</asp:Content>
