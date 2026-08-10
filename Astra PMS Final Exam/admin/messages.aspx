<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin_Site3.Master" AutoEventWireup="true" CodeBehind="messages.aspx.cs" Inherits="Astra_PMS_Final_Exam.admin.messages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Contact Messages</li></ol></nav>
          <h4>Contact Messages</h4>
          <p>Inquiries submitted by visitors through the public Contact Us page.</p>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Full Name</th><th>Email</th><th>Phone</th><th>City</th><th>Message</th><th>Submitted On</th></tr></thead>
                <tbody>
                  <asp:Repeater ID="rptMessages" runat="server">
                    <ItemTemplate>
                      <tr>
                        <td><%# Eval("FullName") %></td>
                        <td><%# Eval("Email") %></td>
                        <td><%# Eval("Phone") %></td>
                        <td><%# Eval("City") %></td>
                        <td><%# Eval("Message") %></td>
                        <td><%# Eval("SubmittedOn", "{0:dd MMM yyyy, hh:mm tt}") %></td>
                      </tr>
                    </ItemTemplate>
                  </asp:Repeater>
                </tbody>
              </table>
              <asp:Label ID="lblNoMessages" runat="server" CssClass="d-block text-center text-muted p-4" Text="No contact messages yet." Visible="false"></asp:Label>
            </div>
          </div>
        </div>
      </div>

<!-- ============================= BODY END ============================= -->
</asp:Content>
<asp:Content ID="Content4" runat="server" contentplaceholderid="ContentPlaceHolder3">
<!-- ============================= FOOTER START ============================= -->
<div id="footerContainer"></div>
<!-- ============================= FOOTER END ============================= -->
    </div>
  </div>
  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/admin.js"></script>
  <script>
      //if (App.requireAuth('admin', 'login.aspx')) {
      //    Components.initLayout('admin', 'messages.aspx', App.currentUser);
      //}
      Components.initLayout('admin', 'dashboard.aspx', App.currentUser);
      Admin.initDashboard();
  </script>
</asp:Content>
