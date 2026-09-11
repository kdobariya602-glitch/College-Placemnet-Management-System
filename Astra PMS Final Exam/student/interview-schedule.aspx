<%@ Page Title="" Language="C#" MasterPageFile="~/student/Student_Site2.Master" AutoEventWireup="true" CodeBehind="interview-schedule.aspx.cs" Inherits="Astra_PMS_Final_Exam.student.interview_schedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="page-breadcrumb mb-4"><h4>Interview Schedule</h4><p>Upcoming and past interviews for your applications.</p></div>
        <ul class="nav nav-tabs mb-3" role="tablist">
          <li class="nav-item"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tabUpcoming" type="button">Upcoming</button></li>
          <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tabToday" type="button">Today</button></li>
          <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tabCompleted" type="button">Completed</button></li>
          <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tabCancelled" type="button">Cancelled</button></li>
        </ul>
        <div class="tab-content">
          <div class="tab-pane fade show active" id="tabUpcoming">
            <div class="content-card"><div class="card-body-custom p-0"><div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Job Title</th><th>Company</th><th>Round</th><th>Date</th><th>Time</th><th>Mode</th><th>Venue / Link</th><th>Interviewer</th><th>Remarks</th><th>Status</th></tr></thead>
                <tbody id="upcomingInterviewsBody"></tbody>
              </table>
            </div></div></div>
          </div>
          <div class="tab-pane fade" id="tabToday">
            <div class="content-card"><div class="card-body-custom p-0"><div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Job Title</th><th>Company</th><th>Round</th><th>Date</th><th>Time</th><th>Mode</th><th>Venue / Link</th><th>Interviewer</th><th>Remarks</th><th>Status</th></tr></thead>
                <tbody id="todayInterviewsBody"></tbody>
              </table>
            </div></div></div>
          </div>
          <div class="tab-pane fade" id="tabCompleted">
            <div class="content-card"><div class="card-body-custom p-0"><div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Job Title</th><th>Company</th><th>Round</th><th>Date</th><th>Time</th><th>Mode</th><th>Venue / Link</th><th>Interviewer</th><th>Remarks</th><th>Status</th></tr></thead>
                <tbody id="completedInterviewsBody"></tbody>
              </table>
            </div></div></div>
          </div>
          <div class="tab-pane fade" id="tabCancelled">
            <div class="content-card"><div class="card-body-custom p-0"><div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Job Title</th><th>Company</th><th>Round</th><th>Date</th><th>Time</th><th>Mode</th><th>Venue / Link</th><th>Interviewer</th><th>Remarks</th><th>Status</th></tr></thead>
                <tbody id="cancelledInterviewsBody"></tbody>
              </table>
            </div></div></div>
          </div>
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
      Components.initLayout('student', 'interview-schedule.aspx', App.currentUser);
      Student.renderInterviewSchedule();
    }
  </script>
</asp:Content>

