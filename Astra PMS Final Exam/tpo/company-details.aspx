<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="company-details.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.company_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4">
          <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item"><a href="companies.aspx">Company Management</a></li><li class="breadcrumb-item active">Company Details</li></ol></nav>
          <h4>Company Details</h4>
          <p>Detailed profile information of all registered recruiting companies.</p>
        </div>

        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" HorizontalAlign="Center" Width="100%" GridLines="None" BorderWidth="0px" UseAccessibleHeader="True" HeaderStyle-CssClass="table-custom-head" CssClass="table table-custom" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
    <Columns>
        <asp:TemplateField HeaderText="Company Name">
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Company_Name") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Email">
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Industry">
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Industry") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Location">
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Contact Number">
            <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Contact_Number") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Website">
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Website") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Description">
            <ItemTemplate>
                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Company_Description") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
            </div>
          </div>
        </div>
      </div>

<!-- ============================= BODY END ============================= -->
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">

<!-- ============================= FOOTER START ============================= -->
<div id="footerContainer"></div>
<!-- ============================= FOOTER END ============================= -->
  <div id="modalContainer"></div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/tpo.js"></script>
  <script>
      Components.initLayout('tpo', 'company-details.aspx', App.currentUser);
  </script>
</asp:Content>