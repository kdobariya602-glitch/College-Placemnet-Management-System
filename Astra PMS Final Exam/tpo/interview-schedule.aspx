<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="interview-schedule.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.interview_schedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Interview Schedule</li></ol></nav>
            <h4>Interview Schedule</h4>
            <p>Upcoming and past interview schedules for placement drives.</p>
          </div>
          <asp:Button runat="server" ID="btnScheduleInterview" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Tpo.openScheduleInterviewModal(); return false;" Text="Schedule Interview" />
        </div>
        <div class="filter-bar"><!-- <select class="form-select form-select-sm" style="width:auto" id="interviewStatusFilter"><option value="">All Status</option><option value="scheduled">Scheduled</option><option value="completed">Completed</option></select> -->
<asp:DropDownList runat="server" ID="interviewStatusFilter" ClientIDMode="Static" CssClass="form-select form-select-sm">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Scheduled" Value="scheduled"></asp:ListItem>
                    <asp:ListItem Text="Completed" Value="completed"></asp:ListItem>
                </asp:DropDownList></div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Student</th><th>Company</th><th>Job Role</th><th>Interview Date</th><th>Time</th><th>Venue / Mode</th><th>Status</th></tr></thead>
                <tbody id="interviewTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="interviewTableBodyPagination"></div></div>
        </div>
      </div>

  <div class="modal fade" id="tpoInterviewModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Schedule Interview</h5>
        <asp:Button runat="server" ID="btnCloseTpoInterview" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" />
      </div>
      <div class="modal-body">
        <form id="tpoInterviewForm">
          <div class="mb-3">
            <label class="form-label-custom">Shortlisted Candidate</label>
            <asp:DropDownList runat="server" ID="tpoInterviewApplication" ClientIDMode="Static" CssClass="form-select form-control-custom"></asp:DropDownList>
            <small class="text-muted">Only students already shortlisted for a job can be scheduled.</small>
          </div>
          <div class="row">
            <div class="col-6 mb-3">
              <label class="form-label-custom">Interview Date</label>
              <asp:TextBox runat="server" ID="tpoInterviewDate" ClientIDMode="Static" TextMode="Date" CssClass="form-control form-control-custom" required="required"></asp:TextBox>
            </div>
            <div class="col-6 mb-3">
              <label class="form-label-custom">Time</label>
              <asp:TextBox runat="server" ID="tpoInterviewTime" ClientIDMode="Static" TextMode="Time" CssClass="form-control form-control-custom"></asp:TextBox>
            </div>
          </div>
          <div class="row">
            <div class="col-6 mb-3">
              <label class="form-label-custom">Mode</label>
              <asp:DropDownList runat="server" ID="tpoInterviewMode" ClientIDMode="Static" CssClass="form-select form-control-custom">
                <asp:ListItem Text="Offline" Value="Offline"></asp:ListItem>
                <asp:ListItem Text="Online" Value="Online"></asp:ListItem>
                <asp:ListItem Text="Hybrid" Value="Hybrid"></asp:ListItem>
              </asp:DropDownList>
            </div>
            <div class="col-6 mb-3">
              <label class="form-label-custom">Venue / Link</label>
              <asp:TextBox runat="server" ID="tpoInterviewVenue" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" placeholder="Seminar Hall A / Meet link"></asp:TextBox>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <asp:Button runat="server" ID="btnCancelTpoInterview" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <asp:Button runat="server" ID="btnSaveTpoInterview" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Tpo.scheduleInterviewTpo(); return false;" Text="Schedule" />
      </div>
    </div></div>
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
      //if (App.requireAuth('tpo', 'login.aspx')) {
      //    Components.initLayout('tpo', 'interview-schedule.aspx', App.currentUser);
      //}
      Components.initLayout('tpo', 'interview-schedule.aspx', App.currentUser);
      Tpo.renderInterviewTable();
      document.getElementById('interviewStatusFilter')?.addEventListener('change', () => Tpo.renderInterviewTable());
  </script>
</asp:Content>