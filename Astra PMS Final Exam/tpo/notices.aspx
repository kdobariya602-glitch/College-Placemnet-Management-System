<%@ Page Title="" Language="C#" MasterPageFile="~/tpo/TPO_Site.Master" AutoEventWireup="true" CodeBehind="notices.aspx.cs" Inherits="Astra_PMS_Final_Exam.tpo.notices" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">

<!-- ============================= BODY START (Main Page Content) ============================= -->
      <div class="page-content">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-4">
          <div class="page-breadcrumb mb-0">
            <nav aria-label="breadcrumb"><ol class="breadcrumb"><li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li><li class="breadcrumb-item active">Notices</li></ol></nav>
            <h4>Notices</h4>
            <p>Publish and manage notices for students and companies.</p>
          </div>
          <!-- <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#noticeModal">
            <i class="bi bi-plus-lg me-1"></i>Add Notice
          </button> -->
<asp:Button runat="server" ID="btnCtrl" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#noticeModal" OnClientClick="return false;" Text="Add Notice" />
        </div>

        <div class="content-card">
          <div class="card-body-custom p-0">
            <div class="table-responsive">
              <table class="table table-custom">
                <thead><tr><th>Title</th><th>Description</th><th>Audience</th><th>Posted On</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody id="noticesTableBody"></tbody>
              </table>
            </div>
          </div>
          <div class="card-body-custom border-top d-flex justify-content-end"><div id="noticesPagination"></div></div>
        </div>
      </div>

<!-- ============================= BODY END ============================= -->
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder3">

<!-- ============================= FOOTER START ============================= -->
<div id="footerContainer"></div>
<!-- ============================= FOOTER END ============================= -->

  <div class="modal fade" id="noticeModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
      <div class="modal-header"><h5 class="modal-title">Add Notice</h5><!-- <button type="button" class="btn-close" data-bs-dismiss="modal"></button> -->
<asp:Button runat="server" ID="btnCtrl2" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn-close" data-bs-dismiss="modal" OnClientClick="return false;" Text="" /></div>
      <div class="modal-body">
        <div class="mb-3"><label class="form-label-custom">Title</label><asp:TextBox runat="server" ID="noticeTitle" ClientIDMode="Static" TextMode="SingleLine" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
        <div class="mb-3"><label class="form-label-custom">Description</label><asp:TextBox runat="server" ID="noticeDescription" ClientIDMode="Static" TextMode="MultiLine" Rows="4" CssClass="form-control form-control-custom" required="required"></asp:TextBox></div>
        <div class="mb-3"><label class="form-label-custom">Audience</label>
          <!-- <select class="form-select form-control-custom" id="noticeAudience">
            <option value="all">All</option>
            <option value="students">Students</option>
            <option value="companies">Companies</option>
          </select> -->
<asp:DropDownList runat="server" ID="noticeAudience" ClientIDMode="Static" CssClass="form-select form-control-custom">
                    <asp:ListItem Text="All" Value="all"></asp:ListItem>
                    <asp:ListItem Text="Students" Value="students"></asp:ListItem>
                    <asp:ListItem Text="Companies" Value="companies"></asp:ListItem>
                </asp:DropDownList>
        </div>
      </div>
      <div class="modal-footer">
        <!-- <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button> -->
<asp:Button runat="server" ID="btnCtrl3" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-outline-custom" data-bs-dismiss="modal" OnClientClick="return false;" Text="Cancel" />
        <asp:Button runat="server" ID="saveNoticeBtn" ClientIDMode="Static" UseSubmitBehavior="false" CssClass="btn btn-primary-custom" OnClientClick="Tpo.saveNotice(); return false;" Text="Publish" />
      </div>
    </div></div>
  </div>
  <div id="modalContainer"></div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/data.js"></script>
  <script src="../assets/js/app.js"></script>
  <script src="../assets/js/components.js"></script>
  <script src="../assets/js/tpo.js"></script>
  <script>
      Components.initLayout('tpo', 'notices.aspx', App.currentUser);
      Tpo.renderNoticesTable();
  </script>
</asp:Content>