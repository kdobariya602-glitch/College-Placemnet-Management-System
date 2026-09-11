<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="announcements.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.announcements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Announcements</h4><p>Notices published by the Placement Cell.</p></div>
        <div class="content-card">
          <div class="card-body-custom" id="announcementsList"></div>
        </div>
      </div>
<!-- ============================= BODY END ============================= -->
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">
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
  <script src="../assets/js/student.js"></script>
  <script>
    if (App.requireAuth('student', 'login.aspx')) {
      Components.initLayout('student', 'announcements.aspx', App.currentUser);
      Student.renderAnnouncements();
    }
  </script>
</asp:Content>

