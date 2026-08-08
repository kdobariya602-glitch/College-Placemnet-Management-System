/**
 * Placement Management System - Core Application JS
 */

const App = {
  currentUser: null,

  init() {
    this.loadSession();
    this.initSidebar();
    this.initSearch();
    this.initTooltips();
  },

  loadSession() {
    const session = sessionStorage.getItem('pms_session');
    if (session) {
      this.currentUser = JSON.parse(session);
    }
  },

  setSession(user) {
    this.currentUser = user;
    sessionStorage.setItem('pms_session', JSON.stringify(user));
  },

  clearSession() {
    this.currentUser = null;
    sessionStorage.removeItem('pms_session');
  },

  requireAuth(role, redirectUrl) {
    this.loadSession();
    if (!this.currentUser || this.currentUser.role !== role) {
      window.location.href = redirectUrl;
      return false;
    }
    return true;
  },

  initSidebar() {
    const toggleBtn = document.getElementById('sidebarToggle');
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('mainContent');
    const navbar = document.getElementById('topNavbar');

    if (toggleBtn && sidebar) {
      const collapsed = localStorage.getItem('sidebar_collapsed') === 'true';
      if (collapsed) {
        sidebar.classList.add('collapsed');
        mainContent?.classList.add('sidebar-collapsed');
        navbar?.classList.add('expanded');
      }

      toggleBtn.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
        mainContent?.classList.toggle('sidebar-collapsed');
        navbar?.classList.toggle('expanded');
        localStorage.setItem('sidebar_collapsed', sidebar.classList.contains('collapsed'));
      });
    }

    const mobileToggle = document.getElementById('mobileSidebarToggle');
    if (mobileToggle && sidebar) {
      mobileToggle.addEventListener('click', () => {
        sidebar.classList.toggle('mobile-open');
      });
    }
  },

  initSearch() {
    const searchInput = document.getElementById('globalSearch');
    if (!searchInput) return;

    searchInput.addEventListener('input', (e) => {
      const query = e.target.value.toLowerCase().trim();
      const searchableRows = document.querySelectorAll('[data-searchable]');
      searchableRows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = !query || text.includes(query) ? '' : 'none';
      });

      const searchableCards = document.querySelectorAll('[data-search-card]');
      searchableCards.forEach(card => {
        const text = card.textContent.toLowerCase();
        card.closest('.col-md-6, .col-lg-4, .col-xl-3, .col-12')?.style && 
          (card.closest('.col-md-6, .col-lg-4, .col-xl-3').style.display = !query || text.includes(query) ? '' : 'none');
      });
    });
  },

  initTooltips() {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    tooltipTriggerList.forEach(el => new bootstrap.Tooltip(el));
  },

  showToast(message, type = 'success') {
    const container = document.getElementById('toastContainer') || this.createToastContainer();
    const bgClass = type === 'success' ? 'bg-success' : type === 'error' ? 'bg-danger' : type === 'warning' ? 'bg-warning' : 'bg-info';
    const icon = type === 'success' ? 'bi-check-circle' : type === 'error' ? 'bi-x-circle' : 'bi-info-circle';

    const toastEl = document.createElement('div');
    toastEl.className = 'toast align-items-center text-white border-0 ' + bgClass;
    toastEl.setAttribute('role', 'alert');
    toastEl.innerHTML = `
      <div class="d-flex">
        <div class="toast-body"><i class="bi ${icon} me-2"></i>${message}</div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
      </div>`;
    container.appendChild(toastEl);
    const toast = new bootstrap.Toast(toastEl, { delay: 3500 });
    toast.show();
    toastEl.addEventListener('hidden.bs.toast', () => toastEl.remove());
  },

  createToastContainer() {
    const container = document.createElement('div');
    container.id = 'toastContainer';
    container.className = 'toast-container-custom';
    document.body.appendChild(container);
    return container;
  },

  validateForm(form) {
    let valid = true;
    const fields = form.querySelectorAll('[required]');
    fields.forEach(field => {
      field.classList.remove('is-invalid');
      if (!field.value.trim()) {
        field.classList.add('is-invalid');
        valid = false;
      }
      if (field.type === 'email' && field.value && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(field.value)) {
        field.classList.add('is-invalid');
        valid = false;
      }
    });
    return valid;
  },

  formatDate(dateStr) {
    if (!dateStr) return '—';
    const d = new Date(dateStr);
    return d.toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' });
  },

  getInitials(name) {
    return name.split(' ').map(n => n[0]).join('').toUpperCase().slice(0, 2);
  },

  getStatusBadge(status) {
    const map = {
      pending: 'badge-pending',
      approved: 'badge-approved',
      rejected: 'badge-rejected',
      shortlisted: 'badge-shortlisted',
      selected: 'badge-selected',
      active: 'badge-active',
      closed: 'badge-closed',
      upcoming: 'badge-shortlisted',
      completed: 'badge-approved'
    };
    const cls = map[status] || 'badge-pending';
    return `<span class="badge badge-status ${cls}">${status.charAt(0).toUpperCase() + status.slice(1)}</span>`;
  },

  filterTable(selectId, tableBodyId, filterKey) {
    const select = document.getElementById(selectId);
    const tbody = document.getElementById(tableBodyId);
    if (!select || !tbody) return;

    select.addEventListener('change', () => {
      const value = select.value.toLowerCase();
      tbody.querySelectorAll('tr').forEach(row => {
        if (!value) {
          row.style.display = '';
        } else {
          const cell = row.querySelector(`[data-filter="${filterKey}"]`);
          row.style.display = cell && cell.dataset.filterValue?.toLowerCase() === value ? '' : 'none';
        }
      });
    });
  },

  paginate(items, page = 1, perPage = 10) {
    const start = (page - 1) * perPage;
    return {
      items: items.slice(start, start + perPage),
      totalPages: Math.ceil(items.length / perPage),
      currentPage: page,
      total: items.length
    };
  },

  renderPagination(containerId, totalPages, currentPage, onPageChange) {
    const container = document.getElementById(containerId);
    if (!container || totalPages <= 1) {
      if (container) container.innerHTML = '';
      return;
    }

    let html = '<nav><ul class="pagination pagination-custom mb-0">';
    html += `<li class="page-item ${currentPage === 1 ? 'disabled' : ''}"><a class="page-link" href="#" data-page="${currentPage - 1}">Prev</a></li>`;
    for (let i = 1; i <= totalPages; i++) {
      html += `<li class="page-item ${i === currentPage ? 'active' : ''}"><a class="page-link" href="#" data-page="${i}">${i}</a></li>`;
    }
    html += `<li class="page-item ${currentPage === totalPages ? 'disabled' : ''}"><a class="page-link" href="#" data-page="${currentPage + 1}">Next</a></li>`;
    html += '</ul></nav>';
    container.innerHTML = html;

    container.querySelectorAll('[data-page]').forEach(link => {
      link.addEventListener('click', (e) => {
        e.preventDefault();
        const page = parseInt(link.dataset.page);
        if (page >= 1 && page <= totalPages) onPageChange(page);
      });
    });
  },

  confirmDelete(message, onConfirm) {
    const modal = document.getElementById('confirmDeleteModal');
    if (!modal) {
      if (confirm(message)) onConfirm();
      return;
    }
    modal.querySelector('.modal-body p').textContent = message;
    const btn = modal.querySelector('#confirmDeleteBtn');
    const newBtn = btn.cloneNode(true);
    btn.parentNode.replaceChild(newBtn, btn);
    newBtn.addEventListener('click', () => {
      onConfirm();
      bootstrap.Modal.getInstance(modal)?.hide();
    });
    new bootstrap.Modal(modal).show();
  },

  login(email, password, role) {
    const data = getData();
    let user = null;

    if (role === 'admin') {
      if (data.admin.email === email && data.admin.password === password) {
        user = { ...data.admin };
      }
    } else if (role === 'student') {
      const student = data.students.find(s => s.email === email && s.password === password);
      if (student) user = { ...student, role: 'student' };
    } else if (role === 'company') {
      const company = data.companies.find(c => c.email === email && c.password === password);
      if (company) user = { ...company, role: 'company' };
    }

    if (user) {
      this.setSession(user);
      return true;
    }
    return false;
  },

  resetPassword(email, newPassword, role) {
    const data = getData();
    let updated = false;

    if (role === 'admin') {
      if (data.admin.email.toLowerCase() === email.toLowerCase()) {
        data.admin.password = newPassword;
        updated = true;
      }
    } else if (role === 'student') {
      const student = data.students.find(s => s.email.toLowerCase() === email.toLowerCase());
      if (student) {
        student.password = newPassword;
        updated = true;
      }
    } else if (role === 'company') {
      const company = data.companies.find(c => c.email.toLowerCase() === email.toLowerCase());
      if (company) {
        company.password = newPassword;
        updated = true;
      }
    }

    if (updated) saveData(data);
    return updated;
  },

  logout(redirectUrl) {
    this.clearSession();
    window.location.href = redirectUrl;
  }
};

document.addEventListener('DOMContentLoaded', () => App.init());

function getHeadLinks() {
  return `
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="../assets/css/style.css" rel="stylesheet">`;
}

function getHeadLinksRoot() {
  return `
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">`;
}

function getScripts(includeChart = false) {
  let scripts = `
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"><\/script>
    <script src="../assets/js/data.js"><\/script>
    <script src="../assets/js/app.js"><\/script>`;
  if (includeChart) {
    scripts += `<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"><\/script>
    <script src="../assets/js/charts.js"><\/script>`;
  }
  return scripts;
}

function getScriptsRoot(includeChart = false) {
  let scripts = `
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"><\/script>
    <script src="assets/js/data.js"><\/script>
    <script src="assets/js/app.js"><\/script>`;
  if (includeChart) {
    scripts += `<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"><\/script>
    <script src="assets/js/charts.js"><\/script>`;
  }
  return scripts;
}
