<%@ Page Title="Selections & Offers" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="selections.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.selections" %>

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
                        <li class="breadcrumb-item"><a href="selections.aspx">Candidate Management</a></li>
                        <li class="breadcrumb-item active">Selections & Offers</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Hiring Selections & Offer Letters</h3>
                <p class="text-muted small mb-0">Extend formal placement offers, set compensation packages, and monitor student acceptances.</p>
            </div>
            <div class="d-flex gap-2">
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
                <a class="nav-link" href="interviews.aspx"><i class="bi bi-calendar-event me-1"></i> Interview Schedules</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="interview-results.aspx"><i class="bi bi-clipboard-check me-1"></i> Assessment Results</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="selections.aspx"><i class="bi bi-award me-1"></i> Selections & Offers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="placement-history.aspx"><i class="bi bi-clock-history me-1"></i> Hiring History</a>
            </li>
        </ul>

        <!-- KPI Summary Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-xl-3">
                <div class="card stat-card p-3 border-0 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted small fw-semibold">Total Offers Issued</span>
                            <h3 class="fw-bold mb-0 mt-1"><asp:Label ID="lblTotalOffers" runat="server" Text="0"></asp:Label></h3>
                        </div>
                        <div class="stat-icon bg-primary bg-opacity-10 text-primary p-3 rounded-circle">
                            <i class="bi bi-award fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="card stat-card p-3 border-0 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted small fw-semibold">Accepted by Student</span>
                            <h3 class="fw-bold mb-0 mt-1"><asp:Label ID="lblAcceptedOffers" runat="server" Text="0"></asp:Label></h3>
                        </div>
                        <div class="stat-icon bg-success bg-opacity-10 text-success p-3 rounded-circle">
                            <i class="bi bi-check2-circle fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="card stat-card p-3 border-0 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted small fw-semibold">Pending Response</span>
                            <h3 class="fw-bold mb-0 mt-1"><asp:Label ID="lblPendingOffers" runat="server" Text="0"></asp:Label></h3>
                        </div>
                        <div class="stat-icon bg-warning bg-opacity-10 text-warning p-3 rounded-circle">
                            <i class="bi bi-hourglass-split fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="card stat-card p-3 border-0 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted small fw-semibold">Confirmed Joined</span>
                            <h3 class="fw-bold mb-0 mt-1"><asp:Label ID="lblJoinedOffers" runat="server" Text="0"></asp:Label></h3>
                        </div>
                        <div class="stat-icon bg-info bg-opacity-10 text-info p-3 rounded-circle">
                            <i class="bi bi-person-check fs-4"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left: Issue Offer Form -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-patch-plus text-primary me-2"></i>Issue Formal Job Offer</h5>
                    </div>
                    <div class="card-body p-4">
                        <asp:HiddenField ID="hfSelectionId" runat="server" Value="0" />

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Select Candidate <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlCandidate" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold small text-muted">Job Position <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlJob" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Annual CTC (LPA) <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtPackage" runat="server" CssClass="form-control" placeholder="e.g. 7.5 LPA"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Designation</label>
                                <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control" placeholder="e.g. Associate Software Engineer"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Offer Date <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtOfferDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold small text-muted">Expected Joining Date</label>
                                <asp:TextBox ID="txtJoiningDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label class="form-label fw-semibold small text-muted mb-0">Special Remarks / Terms</label>
                                <button type="button" class="btn btn-sm btn-outline-primary py-0 px-2 fw-semibold" onclick="aiDraftOfferTerms()" title="Draft official offer conditions">
                                    <i class="bi bi-stars"></i> ✨ AI Auto-Draft Terms
                                </button>
                            </div>
                            <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="e.g. Subject to passing final semester with min 6.5 CGPA."></asp:TextBox>
                        </div>

                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSaveOffer" runat="server" Text="Issue Offer" CssClass="btn btn-primary flex-grow-1" OnClick="btnSaveOffer_Click" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Selections & Offers Table -->
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-trophy text-primary me-2"></i>Offers Issued by Your Company</h5>
                        <span class="text-muted small">Real-time status</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView  UseAccessibleHeader="True" ID="gvSelections" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0"
                                DataKeyNames="Selection_Id" EmptyDataText="No formal offers issued yet." GridLines="None" OnRowCommand="gvSelections_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="Selection_Id" HeaderText="#" />
                                    <asp:TemplateField HeaderText="Selected Candidate">
                                        <ItemTemplate>
                                            <div class="fw-bold text-dark"><%# Eval("Student_Name") %></div>
                                            <div class="text-muted small"><%# Eval("Student_Email") %> | <%# Eval("Enrollment_No") %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Job_Title" HeaderText="Job Title" />
                                    <asp:TemplateField HeaderText="CTC Package">
                                        <ItemTemplate>
                                            <span class="fw-bold text-success"><%# Eval("Package_CTC") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Offer Status">
                                        <ItemTemplate>
                                            <span class='badge <%# Convert.ToString(Eval("Offer_Status")) == "Accepted" || Convert.ToString(Eval("Offer_Status")) == "Joined" ? "bg-success" : Convert.ToString(Eval("Offer_Status")) == "Declined" ? "bg-danger" : "bg-warning text-dark" %>'>
                                                <%# Eval("Offer_Status") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Joining Date">
                                        <ItemTemplate>
                                            <div class="small text-muted"><%# Eval("Joining_Date", "{0:dd MMM yyyy}") %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <div class="btn-group btn-group-sm">
                                                <asp:LinkButton ID="btnJoin" runat="server" CommandName="MarkJoined" CommandArgument='<%# Eval("Selection_Id") %>' CssClass="btn btn-outline-success" title="Mark as Joined" Visible='<%# Convert.ToString(Eval("Offer_Status")) == "Accepted" %>'>
                                                    <i class="bi bi-person-check-fill me-1"></i> Joined
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditOffer" CommandArgument='<%# Eval("Selection_Id") %>' CssClass="btn btn-outline-primary" title="Edit Offer">
                                                    <i class="bi bi-pencil"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRevoke" runat="server" CommandName="RevokeOffer" CommandArgument='<%# Eval("Selection_Id") %>' CssClass="btn btn-outline-danger" OnClientClick="return confirm('Revoke this job offer?');" title="Revoke">
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

    <script type="text/javascript">
        function aiDraftOfferTerms() {
            var pkgBox = document.getElementById('<%= txtPackage.ClientID %>');
            var desBox = document.getElementById('<%= txtDesignation.ClientID %>');
            var remBox = document.getElementById('<%= txtRemarks.ClientID %>');

            if (!pkgBox.value || pkgBox.value.trim() === '') {
                pkgBox.value = '7.50 LPA';
            }
            if (!desBox.value || desBox.value.trim() === '') {
                desBox.value = 'Associate Software Engineer';
            }

            remBox.value = "Offer Contingencies & Terms: 1. Subject to successful completion of undergraduate degree with no active backlogs and minimum 6.50 cumulative CGPA. 2. Pre-joining verification of identity and academic certificates. 3. Standard probationary period of 6 months from official reporting date.";
        }
    </script>
</asp:Content>
