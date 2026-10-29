<%@ Page Title="Recruiter Team" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="employees.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.employees" %>

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
                        <li class="breadcrumb-item active">Recruiter Team</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Authorized Hiring Managers & HR Team</h3>
            </div>
            <div>
                <button type="button" class="btn btn-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#modalAddMember"><i class="bi bi-person-plus me-1"></i> Add Team Member</button>
            </div>
        </div>

                <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link" href="verification.aspx"><i class="bi bi-patch-check me-1"></i> Verification & Documents</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="employees.aspx"><i class="bi bi-person-badge me-1"></i> HR Team & Contacts</a>
            </li>
        </ul>
        <!-- Team Table Card -->
        <div class="content-card">
            <div class="card-header-custom p-3 border-bottom">
                <h5 class="mb-0 fw-bold"><i class="bi bi-people-fill text-primary me-2"></i>Recruiter Team Directory</h5>
            </div>
            <div class="card-body-custom p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvTeam" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle mb-0" GridLines="None"
                        DataKeyNames="Emp_Id" OnRowCommand="gvTeam_RowCommand"
                        UseAccessibleHeader="True">
                        <HeaderStyle CssClass="table-light text-muted small fw-semibold" />
                        <EmptyDataTemplate>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-people fs-1 text-muted d-block mb-3"></i>
                                <h5>No Additional Team Members Added</h5>
                                <p class="mb-0">Add your recruitment panelists or hiring managers who participate in student interviews.</p>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Name & Role">
                                <ItemTemplate>
                                    <div class="fw-bold text-dark fs-6"><%# Eval("Contact_Name") %></div>
                                    <span class="text-muted small"><%# Eval("Designation") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" />

                            <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="text-end text-nowrap" ItemStyle-CssClass="text-end text-nowrap">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDel" runat="server" CommandName="delete_member" CommandArgument='<%# Eval("Emp_Id") %>'
                                        CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Remove this team member?');" title="Remove">
                                        <i class="bi bi-trash"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Add Member -->
    <div class="modal fade" id="modalAddMember" tabindex="-1" aria-labelledby="modalAddMemberLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="modalAddMemberLabel"><i class="bi bi-person-plus-fill text-primary me-2"></i>Add Recruiter Team Member</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Member Name *</label>
                        <asp:TextBox ID="txtNewName" runat="server" CssClass="form-control" placeholder="e.g. Rahul Sharma"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Designation / Role *</label>
                        <asp:TextBox ID="txtNewDesig" runat="server" CssClass="form-control" placeholder="e.g. Lead Technical Interviewer"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email Address *</label>
                        <asp:TextBox ID="txtNewEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="panelist@company.com"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Contact Phone</label>
                        <asp:TextBox ID="txtNewPhone" runat="server" CssClass="form-control" placeholder="Phone number"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnSaveMember" runat="server" Text="Add Member" CssClass="btn btn-primary fw-semibold" OnClick="btnSaveMember_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
