<%@ Page Title="Company Notifications" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="notifications.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.notifications" %>

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
                        <li class="breadcrumb-item active">Inbox</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0">Notifications & Alerts</h3>
                <p class="text-muted small mb-0">Live alerts regarding drive approvals, applications, interview updates, and university circulars.</p>
            </div>
            <div>
                <asp:Button ID="btnMarkAllRead" runat="server" Text="Mark All as Read" CssClass="btn btn-outline-primary" OnClick="btnMarkAllRead_Click" />
            </div>
        </div>

        <!-- Section Navigation Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="notifications.aspx"><i class="bi bi-bell me-1"></i> Notifications</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="feedback.aspx"><i class="bi bi-chat-heart me-1"></i> Campus Feedback</a>
            </li>
        </ul>



        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-bell-fill text-primary me-2"></i>Recruiter Inbox</h5>
                <asp:Label ID="lblUnreadCount" runat="server" CssClass="badge bg-primary px-3 py-2"></asp:Label>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView  UseAccessibleHeader="True" ID="gvNotifications" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0"
                        DataKeyNames="Notification_Id" EmptyDataText="No notifications found in your inbox." GridLines="None" OnRowCommand="gvNotifications_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Notification_Id" HeaderText="#" />
                            <asp:TemplateField HeaderText="Notification">
                                <ItemTemplate>
                                    <div class="d-flex align-items-start">
                                        <div class="me-3 mt-1">
                                            <i class='<%# Convert.ToString(Eval("Is_Read")) == "0" ? "bi bi-envelope-fill text-primary fs-5" : "bi bi-envelope-open text-muted fs-5" %>'></i>
                                        </div>
                                        <div>
                                            <div class='fw-bold <%# Convert.ToString(Eval("Is_Read")) == "0" ? "text-dark" : "text-secondary" %>'><%# Eval("Title") %></div>
                                            <div class="text-muted small mt-1"><%# Eval("Message") %></div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type">
                                <ItemTemplate>
                                    <span class="badge bg-light text-dark border"><%# Eval("Notification_Type") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Created_Date" HeaderText="Received Date" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnRead" runat="server" CommandName="MarkAsRead" CommandArgument='<%# Eval("Notification_Id") %>' 
                                        CssClass='<%# Convert.ToString(Eval("Is_Read")) == "0" ? "btn btn-sm btn-outline-primary" : "btn btn-sm btn-light disabled" %>' 
                                        Enabled='<%# Convert.ToString(Eval("Is_Read")) == "0" %>'>
                                        <i class="bi bi-check2"></i> Mark Read
                                    </asp:LinkButton>
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
</asp:Content>
