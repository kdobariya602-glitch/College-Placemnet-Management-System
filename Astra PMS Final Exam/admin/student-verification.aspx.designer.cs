namespace Astra_PMS_Final_Exam.admin
{
    public partial class student_verification
    {
        protected global::System.Web.UI.WebControls.LinkButton btnBulkVerify;
        protected global::System.Web.UI.WebControls.Panel pnlAlert;
        protected global::System.Web.UI.WebControls.Literal litAlertMsg;
        protected global::System.Web.UI.WebControls.Label lblPendingCount;
        protected global::System.Web.UI.WebControls.Label lblVerifiedCount;
        protected global::System.Web.UI.WebControls.Label lblRejectedCount;
        protected global::System.Web.UI.WebControls.Label lblTotalCount;
        protected global::System.Web.UI.WebControls.TextBox txtSearch;
        protected global::System.Web.UI.WebControls.DropDownList ddlDocTypeFilter;
        protected global::System.Web.UI.WebControls.DropDownList ddlStatusFilter;
        protected global::System.Web.UI.WebControls.Button btnFilter;
        protected global::System.Web.UI.WebControls.Button btnReset;
        protected global::System.Web.UI.WebControls.GridView gvDocVerification;
        protected global::System.Web.UI.WebControls.HiddenField hfRejectDocId;
        protected global::System.Web.UI.WebControls.TextBox txtRejectRemark;
        protected global::System.Web.UI.WebControls.Button btnConfirmReject;
    }
}
