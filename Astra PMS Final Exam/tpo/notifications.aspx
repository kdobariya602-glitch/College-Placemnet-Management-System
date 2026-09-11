<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="notifications.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.notifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Notifications</li></ol></nav>
            <h4>Notifications</h4>
            <p>System notifications related to applications, drives and interviews.</p>
          </div>
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Title</th><th>Message</th><th>Recipient</th><th>Date</th><th>Status</th></tr></thead>
                <tbody id="notificationsTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="notificationsTableBodyPagination"></div></div>
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
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/charts.js"></script>
  <script src="../assets/js/tpo.js"></script>
  <script>
      Components.initLayout('tpo', 'notifications.aspx', App.currentUser);
      Tpo.renderNotificationsTable();
  </script>
</asp:Content>