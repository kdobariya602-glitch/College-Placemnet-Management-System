<%@ Page Title="" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="interview-schedule.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.interview_schedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
<!-- ============================= BODY START (Main Page Content) ============================= -->

      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start mb-4">
          <div class="page-breadcrumb mb-0"><h4>Interview Schedule</h4><p>Schedule and track interviews for shortlisted applicants.</p></div>
          <button type="button" class="btn btn-primary-custom" onclick="Company.openInterviewModal(null)"><i class="bi bi-plus-lg me-1"></i>Schedule Interview</button>
        </div>
        <div class="filter-bar d-flex gap-2 flex-wrap mb-3">
          <select class="form-select form-select-sm" style="width:auto" id="interviewJobFilter"></select>
          <select class="form-select form-select-sm" style="width:auto" id="interviewStatusFilter">
            <option value="">All Status</option>
            <option value="Scheduled">Scheduled</option>
            <option value="Rescheduled">Rescheduled</option>
            <option value="Completed">Completed</option>
            <option value="Cancelled">Cancelled</option>
          </select>
          <input type="date" class="form-control form-control-sm" style="width:auto" id="interviewDateFilter">
        </div>
        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Student</th><th>Job</th><th>Round</th><th>Date / Time</th><th>Mode</th><th>Venue</th><th>Status</th><th>Action</th></tr></thead>
                <tbody id="interviewScheduleTableBody"></tbody>
              </table>
            </div>
          </div>
        </div>
      </div>

      <!-- Schedule / Edit Interview Modal -->
      <div class="modal fade" id="interviewModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="interviewModalTitle">Schedule Interview</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <input type="hidden" id="interviewFormId" value="">
              <div class="mb-3"><label class="form-label-custom">Candidate</label>
                <select class="form-select form-control-custom" id="interviewApplicationSelect"></select>
              </div>
              <div class="row">
                <div class="col-md-6 mb-3"><label class="form-label-custom">Round</label><input type="text" class="form-control form-control-custom" id="interviewRound" placeholder="Round 1"></div>
                <div class="col-md-6 mb-3"><label class="form-label-custom">Mode</label>
                  <select class="form-select form-control-custom" id="interviewMode">
                    <option value="Online">Online</option>
                    <option value="Offline">Offline</option>
                  </select>
                </div>
              </div>
              <div class="row">
                <div class="col-md-6 mb-3"><label class="form-label-custom">Date</label><input type="date" class="form-control form-control-custom" id="interviewDate"></div>
                <div class="col-md-6 mb-3"><label class="form-label-custom">Time</label><input type="time" class="form-control form-control-custom" id="interviewTime"></div>
              </div>
              <div class="mb-3"><label class="form-label-custom">Venue / Meeting Link</label><input type="text" class="form-control form-control-custom" id="interviewVenue" placeholder="Room 204 or meeting link"></div>
              <div class="mb-3"><label class="form-label-custom">Interviewer</label><input type="text" class="form-control form-control-custom" id="interviewInterviewer"></div>
              <div class="mb-3"><label class="form-label-custom">Remarks</label><textarea class="form-control form-control-custom" id="interviewRemarks" rows="2"></textarea></div>
              <div class="mb-3"><label class="form-label-custom">Status</label>
                <select class="form-select form-control-custom" id="interviewStatusSelect">
                  <option value="Scheduled">Scheduled</option>
                  <option value="Rescheduled">Rescheduled</option>
                  <option value="Completed">Completed</option>
                  <option value="Cancelled">Cancelled</option>
                </select>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
              <button type="button" class="btn btn-primary-custom" onclick="Company.saveInterview()">Save</button>
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
  <script src="../assets/js/company.js"></script>
  <script>
    if (App.requireAuth('company', 'login.aspx')) {
      Components.initLayout('company', 'interview-schedule.aspx', App.currentUser);
      Company.initInterviewScheduleFilters();
      Company.renderInterviewSchedule();
    }
  </script>
</asp:Content>
