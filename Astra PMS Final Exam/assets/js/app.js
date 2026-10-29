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

  // Shared "no data" row for table bodies (spec: never leave a blank white
  // area — every table across every panel shows a proper empty state
  // instead of an empty <tbody>). colspan must match the table's column
  // count so the message stays centered across the full row.
  emptyStateRow(colspan, icon, message) {
    return `<tr><td colspan="${colspan}">
      <div class="empty-state">
        <i class="bi ${icon}"></i>
        <p>${message}</p>
      </div>
    </td></tr>`;
  },

  getStatusBadge(status) {
    const map = {
      // 🟢 Green: Active / Open / Selected / Completed / Placed
      active: 'badge-success status-active',
      open: 'badge-success status-open',
      selected: 'badge-success status-selected',
      completed: 'badge-success status-completed',
      placed: 'badge-success status-placed',
      approved: 'badge-success status-active',
      joined: 'badge-success status-completed',

      // 🔵 Blue: Applied / Info / Enrolled / Eligible
      applied: 'badge-info status-applied',
      enrolled: 'badge-info status-enrolled',
      info: 'badge-info status-info',
      eligible: 'badge-info status-eligible',

      // 🟡 Amber: Shortlisted / Interview / Ongoing / Upcoming
      shortlisted: 'badge-warning status-shortlisted',
      interview: 'badge-warning status-interview',
      'interview scheduled': 'badge-warning status-interview',
      scheduled: 'badge-warning status-interview',
      ongoing: 'badge-warning status-ongoing',
      upcoming: 'badge-warning status-upcoming',
      pending: 'badge-warning status-pending',
      'under review': 'badge-warning status-pending',
      'offer received': 'badge-warning status-shortlisted',
      draft: 'badge-warning status-pending',
      rescheduled: 'badge-warning status-pending',

      // 🔴 Red: Blocked / Rejected / Closed / Cancelled / Dropped / Withdrawn
      blocked: 'badge-danger status-blocked',
      rejected: 'badge-danger status-rejected',
      closed: 'badge-danger status-closed',
      cancelled: 'badge-danger status-cancelled',
      dropped: 'badge-danger status-dropped',
      withdrawn: 'badge-danger status-rejected',
      inactive: 'badge-danger status-blocked',
      'below criteria': 'badge-danger status-rejected'
    };
    const key = String(status || '').trim().toLowerCase();
    const cls = map[key] || 'badge-info status-info';
    const label = String(status || '').replace(/(^|\s)\S/g, c => c.toUpperCase());
    return `<span class="badge badge-status ${cls}">${label}</span>`;
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

  //login(email, password, role) {
  //  const data = getData();
  //  let user = null;

  //  if (role === 'admin') {
  //    if (data.admin.email === email && data.admin.password === password) {
  //      user = { ...data.admin };
  //    }
  //  } else if (role === 'student') {
  //    const student = data.students.find(s => s.email === email && s.password === password);
  //    if (student) user = { ...student, role: 'student' };
  //  } else if (role === 'company') {
  //    const company = data.companies.find(c => c.email === email && c.password === password);
  //    if (company) user = { ...company, role: 'company' };
  //  }

  //  if (user) {
  //    this.setSession(user);
  //    return true;
  //  }
  //  return false;
  //},

  //resetPassword(email, newPassword, role) {
  //  const data = getData();
  //  let updated = false;

  //  if (role === 'admin') {
  //    if (data.admin.email.toLowerCase() === email.toLowerCase()) {
  //      data.admin.password = newPassword;
  //      updated = true;
  //    }
  //  } else if (role === 'student') {
  //    const student = data.students.find(s => s.email.toLowerCase() === email.toLowerCase());
  //    if (student) {
  //      student.password = newPassword;
  //      updated = true;
  //    }
  //  } else if (role === 'company') {
  //    const company = data.companies.find(c => c.email.toLowerCase() === email.toLowerCase());
  //    if (company) {
  //      company.password = newPassword;
  //      updated = true;
  //    }
  //  }

  //  if (updated) saveData(data);
  //  return updated;
  //},

  logout(redirectUrl) {
    this.clearSession();
    window.location.href = redirectUrl;
  },

  /**
   * Bridges a DB-authenticated student (from Student_reg_tbl via login.aspx.cs /
   * change-password.aspx.cs) into the JS/localStorage layer used by every other
   * student page (applications, interviews, notifications, eligibility, etc).
   *
   * Student_reg_tbl (SQL Server) stays the single source of truth for identity +
   * credentials. This only upserts the *extended* profile fields the JS layer
   * needs (branch/cgpa/skills/etc) into localStorage, keyed by email since the
   * DB table has no separate numeric id. DB-backed fields are always refreshed
   * from the server payload; JS-only extended fields (course, semester, gender,
   * dob, address, photoUrl) already saved locally are preserved so edit-profile
   * changes aren't clobbered on every login.
   *
   * Kept centralized here (not duplicated per-page) so the future page-by-page
   * SQL migration only needs to change this one bridge function.
   */
  syncStudentSession(dbUser) {
    const data = getData();
    const email = (dbUser.email || '').trim();
    let student = data.students.find(s => (s.email || '').toLowerCase() === email.toLowerCase());

    if (!student) {
      student = {
        id: email,
        name: dbUser.name,
        email: email,
        password: dbUser.password || '',
        phone: dbUser.phone || '',
        gender: '',
        dob: '',
        address: '',
        branch: dbUser.branch || '',
        course: dbUser.branch || '',
        semester: '',
        cgpa: dbUser.cgpa || 0,
        year: dbUser.year || '',
        skills: dbUser.skills || [],
        status: 'active',
        placed: false,
        company: null,
        photoUrl: '',
        registeredAt: new Date().toISOString().split('T')[0]
      };
      data.students.push(student);
    } else {
      // Refresh DB-owned fields only; leave JS-only extended fields untouched.
      student.id = email; // normalize legacy sample-data ids (e.g. STU001) to email
      student.name = dbUser.name;
      student.email = email;
      if (dbUser.password) student.password = dbUser.password;
      student.phone = dbUser.phone || student.phone;
      student.branch = dbUser.branch || student.branch;
      student.cgpa = (typeof dbUser.cgpa === 'number') ? dbUser.cgpa : student.cgpa;
      student.year = dbUser.year || student.year;
      if (Array.isArray(dbUser.skills) && dbUser.skills.length) student.skills = dbUser.skills;
    }

    saveData(data);
    const sessionUser = { ...student, role: 'student' };
    this.setSession(sessionUser);
    return sessionUser;
  },

  /**
   * Centralized eligibility engine (spec section 24).
   * Same logic must be reused everywhere eligibility is checked:
   * Jobs, Job Details, Eligible Drives, Apply.
   * Returns { eligible, reasons[], deadlinePassed, alreadyApplied }.
   */
  checkJobEligibility(user, job, data) {
    data = data || getData();
    const reasons = [];
    const today = new Date(); today.setHours(0, 0, 0, 0);
    const deadline = job.deadline ? new Date(job.deadline) : null;
    const deadlinePassed = !!deadline && deadline < today;
    const jobActive = job.status === 'active';
    const alreadyApplied = data.applications.some(a => a.studentId === user.id && a.jobId === job.id);

    if (!jobActive) reasons.push('This job is no longer active.');
    if (deadlinePassed) reasons.push('The application deadline has passed.');
    if (typeof job.cgpaMin === 'number' && user.cgpa < job.cgpaMin) {
      reasons.push(`Minimum CGPA required is ${job.cgpaMin} (yours: ${user.cgpa}).`);
    }
    if (Array.isArray(job.branches) && job.branches.length && !job.branches.includes(user.branch)) {
      reasons.push(`Open to ${job.branches.join(', ')} only.`);
    }
    if (job.course && user.course && job.course !== user.course) {
      reasons.push(`Open to ${job.course} students only.`);
    }
    if (job.batch && user.year && job.batch !== user.year) {
      reasons.push(`Open to ${job.batch} batch only.`);
    }
    if (typeof job.maxBacklogs === 'number' && typeof user.backlogs === 'number' && user.backlogs > job.maxBacklogs) {
      reasons.push(`Maximum ${job.maxBacklogs} backlog(s) allowed (yours: ${user.backlogs}).`);
    }
    if (Array.isArray(job.skills) && job.skills.length) {
      const userSkills = (user.skills || []).map(s => String(s).toLowerCase());
      const hasMatchingSkill = job.skills.some(sk => userSkills.includes(String(sk).toLowerCase()));
      if (!hasMatchingSkill) {
        reasons.push(`Requires at least one of these skills: ${job.skills.join(', ')}.`);
      }
    }

    return {
      eligible: reasons.length === 0,
      reasons,
      deadlinePassed,
      jobActive,
      alreadyApplied
    };
  },

  /** Centralized drive eligibility, reused by drives.aspx / eligible-drives.aspx / apply flow. */
  checkDriveEligibility(user, drive, data) {
    data = data || getData();
    const relatedJobs = data.jobs.filter(j => j.companyId === drive.companyId);
    const today = new Date(); today.setHours(0, 0, 0, 0);
    const regDeadline = drive.registrationDeadline ? new Date(drive.registrationDeadline) : null;
    const regDeadlinePassed = !!regDeadline && regDeadline < today;
    const driveActive = drive.status === 'upcoming';

    let eligible;
    if (relatedJobs.length) {
      eligible = relatedJobs.some(j => this.checkJobEligibility(user, j, data).eligible);
    } else {
      const cgpaMatch = (drive.eligibility || '').match(/([\d.]+)/);
      const minCgpa = cgpaMatch ? parseFloat(cgpaMatch[1]) : 0;
      const branchOk = (drive.eligibility || '').includes('All Branches') ||
        (drive.eligibility || '').toLowerCase().includes(String(user.branch).toLowerCase());
      eligible = user.cgpa >= minCgpa && branchOk;
    }

    return {
      eligible: eligible && driveActive && !regDeadlinePassed,
      driveActive,
      regDeadlinePassed
    };
  }
};

document.addEventListener('DOMContentLoaded', () => {
  try {
    if (typeof App !== 'undefined' && App.init) {
      App.init();
    }
  } catch (e) {
    console.warn('App.init skipped:', e);
  }
});

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

// Global toggle for sidebar collapse / expand (desktop)
window.toggleAstraSidebar = function () {
  var sidebar = document.getElementById('sidebar');
  var mainContent = document.getElementById('mainContent');
  var topNavbar = document.getElementById('topNavbar');
  if (sidebar) {
    var isCollapsed = sidebar.classList.toggle('collapsed');
    if (mainContent) mainContent.classList.toggle('sidebar-collapsed', isCollapsed);
    if (topNavbar) topNavbar.classList.toggle('expanded', isCollapsed);
    try {
      localStorage.setItem('sidebar_collapsed', isCollapsed ? 'true' : 'false');
    } catch (e) { }
  }
};

/**
 * Hierarchical Sidebar & Table Consistency Controller
 */
function initHierarchicalSidebar() {
  try {
    // Restore collapsed state from localStorage if previously collapsed on desktop
    try {
      if (localStorage.getItem('sidebar_collapsed') === 'true' && window.innerWidth >= 992) {
        var sb = document.getElementById('sidebar');
        var mc = document.getElementById('mainContent');
        var tn = document.getElementById('topNavbar');
        if (sb) sb.classList.add('collapsed');
        if (mc) mc.classList.add('sidebar-collapsed');
        if (tn) tn.classList.add('expanded');
      }
    } catch (e) { }

    var rawPath = (window.location.pathname || '').toLowerCase();
    var pageName = rawPath.substring(rawPath.lastIndexOf('/') + 1);
    if (!pageName || pageName === '' || pageName === 'index.aspx') {
      pageName = 'dashboard.aspx';
    }
    var currentKey = pageName.replace('.aspx', '').trim();

    var containers = document.querySelectorAll('.sidebar, .offcanvas');
    containers.forEach(function (container) {
      // 1. Reset all links and submenus inside this container first
      var allSubmenuItems = container.querySelectorAll('.has-submenu');
      allSubmenuItems.forEach(function (item) {
        item.classList.remove('open', 'active-parent');
        var sub = item.querySelector('.sidebar-submenu');
        if (sub) sub.style.display = 'none';
      });

      var allLinks = container.querySelectorAll('.nav-link, .submenu-link');
      allLinks.forEach(function (link) {
        link.classList.remove('active');
      });

      // 2. Identify and highlight active link and expand ONLY its parent submenu (single active parent)
      var matchedParentItem = null;
      allLinks.forEach(function (link) {
        var href = link.getAttribute('href');
        if (!href || href === 'javascript:void(0);' || href.startsWith('#')) return;

        var linkTarget = href.split('?')[0].split('#')[0].split('/').pop().toLowerCase();
        var hasDataPages = link.hasAttribute('data-pages') && link.getAttribute('data-pages').trim() !== '';
        var groupPages = hasDataPages ? link.getAttribute('data-pages').toLowerCase().split(',').map(function (s) { return s.trim(); }).filter(Boolean) : [];

        var isMatch = (linkTarget === pageName) || (currentKey !== '' && groupPages.indexOf(currentKey) !== -1);
        if (isMatch) {
          link.classList.add('active');

          var parentSubmenu = link.closest('.sidebar-submenu');
          if (parentSubmenu && !matchedParentItem) {
            var parentItem = link.closest('.has-submenu');
            if (parentItem) {
              matchedParentItem = parentItem;
              parentItem.classList.add('open', 'active-parent');
              parentSubmenu.style.display = 'block';
            }
          }
        }
      });

      // 3. Attach ACCORDION dropdown toggle listeners
      var toggles = container.querySelectorAll('.sidebar-dropdown-toggle');
      toggles.forEach(function (toggle) {
        var newToggle = toggle.cloneNode(true);
        toggle.parentNode.replaceChild(newToggle, toggle);

        newToggle.addEventListener('click', function (e) {
          e.preventDefault();
          e.stopPropagation();

          // If desktop sidebar was collapsed, auto-expand it on dropdown click so options are visible
          var sidebar = document.getElementById('sidebar');
          if (sidebar && sidebar.classList.contains('collapsed')) {
            sidebar.classList.remove('collapsed');
            var mc = document.getElementById('mainContent');
            var tn = document.getElementById('topNavbar');
            if (mc) mc.classList.remove('sidebar-collapsed');
            if (tn) tn.classList.remove('expanded');
            try { localStorage.setItem('sidebar_collapsed', 'false'); } catch (err) { }
          }

          var parentItem = newToggle.closest('.has-submenu');
          if (!parentItem) return;

          var submenu = parentItem.querySelector('.sidebar-submenu');
          if (!submenu) return;

          var isOpen = parentItem.classList.contains('open');

          // Close all sibling submenus in this container (accordion behavior)
          allSubmenuItems.forEach(function (sibling) {
            if (sibling !== parentItem) {
              sibling.classList.remove('open');
              var sibSub = sibling.querySelector('.sidebar-submenu');
              if (sibSub) sibSub.style.display = 'none';
            }
          });

          // Toggle current submenu
          if (isOpen) {
            parentItem.classList.remove('open');
            submenu.style.display = 'none';
          } else {
            parentItem.classList.add('open');
            submenu.style.display = 'block';
          }
        });
      });
    });

    // 3. Ensure all GridView tables are wrapped in .table-responsive for horizontal scrolling
    var gvTables = document.querySelectorAll('table[id*="gv"], table[id*="Grid"], table[id*="grid"], .gridview');
    gvTables.forEach(function (tbl) {
      if (!tbl.parentElement || !tbl.parentElement.classList.contains('table-responsive')) {
        var wrapper = document.createElement('div');
        wrapper.className = 'table-responsive';
        tbl.parentNode.insertBefore(wrapper, tbl);
        wrapper.appendChild(tbl);
      }
    });

    // 4. Ensure Bootstrap Modals are never blocked by backdrop in ASP.NET Web Forms
    var form = document.getElementById('form1') || document.forms[0];
    var allModals = document.querySelectorAll('.modal');
    allModals.forEach(function (m) {
      if (form && m.parentElement !== form) {
        form.appendChild(m);
      }
      m.addEventListener('show.bs.modal', function () {
        if (form && m.parentElement !== form) {
          form.appendChild(m);
        }
        setTimeout(function () {
          var backdrops = document.querySelectorAll('.modal-backdrop');
          backdrops.forEach(function (bd) {
            if (form && bd.parentElement !== form) {
              form.insertBefore(bd, m);
            }
          });
        }, 10);
      });
      m.addEventListener('shown.bs.modal', function () {
        var firstInput = m.querySelector('input:not([type="hidden"]), select, textarea');
        if (firstInput) {
          firstInput.focus();
        }
      });
    });
  } catch (err) {
    console.error('Sidebar/Table init error:', err);
  }
}

// Auto-run on load and on ASP.NET AJAX PostBacks
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initHierarchicalSidebar);
} else {
  initHierarchicalSidebar();
}

if (typeof Sys !== 'undefined' && Sys.WebForms && Sys.WebForms.PageRequestManager) {
  Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
    initHierarchicalSidebar();
  });
}

// ========================================================
// Universal Toast Interceptor for Modern Non-blocking Alerts
// ========================================================
(function () {
  var alertQueue = [];
  var toastContainer = null;

  function getContainer() {
    if (!toastContainer) {
      toastContainer = document.getElementById('astra-toast-container');
      if (!toastContainer) {
        toastContainer = document.createElement('div');
        toastContainer.id = 'astra-toast-container';
        toastContainer.className = 'toast-container position-fixed top-0 end-0 p-3';
        toastContainer.style.zIndex = '999999';
        if (document.body) {
          document.body.appendChild(toastContainer);
        }
      }
    }
    return toastContainer;
  }

  function showAstraToast(msg) {
    if (!document.body) {
      alertQueue.push(msg);
      return;
    }

    var text = String(msg || '');
    var isSuccess = /success|registered|created|updated|joined|confirmed|approved|sent|verified|completed|saved/i.test(text);
    var isError = /error|invalid|fail|blocked|deactivated|not found|suspended|denied/i.test(text);

    var bgClass = isSuccess ? 'bg-success' : (isError ? 'bg-danger' : 'bg-primary');
    var iconClass = isSuccess ? 'bi-check-circle-fill' : (isError ? 'bi-exclamation-triangle-fill' : 'bi-info-circle-fill');
    var title = isSuccess ? 'Success' : (isError ? 'Alert' : 'Notice');

    var container = getContainer();
    if (!container) return;

    var toastEl = document.createElement('div');
    toastEl.className = 'toast align-items-center text-white border-0 shadow-lg mb-2 show ' + bgClass;
    toastEl.setAttribute('role', 'alert');
    toastEl.style.minWidth = '320px';
    toastEl.style.borderRadius = '10px';
    toastEl.style.opacity = '1';
    toastEl.style.transition = 'all 0.3s ease';

    toastEl.innerHTML =
      '<div class="d-flex align-items-center p-2">' +
        '<div class="toast-body d-flex align-items-center gap-2 flex-grow-1 text-white">' +
          '<i class="bi ' + iconClass + ' fs-5"></i>' +
          '<div><strong>' + title + ':</strong> ' + text + '</div>' +
        '</div>' +
        '<button type="button" class="btn-close btn-close-white me-2 m-auto" aria-label="Close"></button>' +
      '</div>';

    container.appendChild(toastEl);

    var closeBtn = toastEl.querySelector('.btn-close');
    if (closeBtn) {
      closeBtn.onclick = function () {
        toastEl.remove();
      };
    }

    setTimeout(function () {
      toastEl.style.opacity = '0';
      setTimeout(function () {
        if (toastEl.parentNode) toastEl.parentNode.removeChild(toastEl);
      }, 350);
    }, 4500);
  }

  window.alert = function (msg) {
    showAstraToast(msg);
  };

  function flushQueue() {
    while (alertQueue.length > 0) {
      showAstraToast(alertQueue.shift());
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', flushQueue);
  } else {
    flushQueue();
  }
})();

// ========================================================
// Dark Mode Toggle Support & Theme Engine
// ========================================================
(function() {
  function updateThemeIcons(theme) {
    var buttons = document.querySelectorAll('[onclick*="toggleAstraTheme"], .theme-toggle-btn');
    buttons.forEach(function(btn) {
      var icon = btn.querySelector('i');
      if (icon) {
        if (theme === 'dark') {
          icon.className = 'bi bi-sun-fill text-warning';
          btn.setAttribute('title', 'Switch to Light Mode');
          btn.setAttribute('aria-label', 'Switch to Light Mode');
        } else {
          icon.className = 'bi bi-moon-stars';
          btn.setAttribute('title', 'Switch to Dark Mode');
          btn.setAttribute('aria-label', 'Switch to Dark Mode');
        }
      }
    });
  }

  function updateChartsTheme(theme) {
    if (typeof Chart !== 'undefined') {
      var isDark = theme === 'dark';
      var textColor = isDark ? '#E2E8F0' : '#475569';
      var gridColor = isDark ? 'rgba(255, 255, 255, 0.08)' : 'rgba(0, 0, 0, 0.06)';

      Chart.defaults.color = textColor;
      Chart.defaults.borderColor = gridColor;

      if (Chart.instances) {
        Object.keys(Chart.instances).forEach(function(key) {
          try {
            var c = Chart.instances[key];
            if (c && c.options) {
              if (c.options.scales) {
                Object.keys(c.options.scales).forEach(function(sk) {
                  var s = c.options.scales[sk];
                  if (s.ticks) s.ticks.color = textColor;
                  if (s.grid) s.grid.color = gridColor;
                });
              }
              if (c.options.plugins && c.options.plugins.legend && c.options.plugins.legend.labels) {
                c.options.plugins.legend.labels.color = textColor;
              }
              c.update();
            }
          } catch(e) {}
        });
      }
    }
  }

  function applyTheme() {
    var savedTheme = localStorage.getItem('astra_theme') || 'light';
    if (savedTheme === 'dark') {
      document.documentElement.setAttribute('data-bs-theme', 'dark');
      if (document.body) {
        document.body.classList.add('dark-mode');
        document.body.setAttribute('data-bs-theme', 'dark');
      }
    } else {
      document.documentElement.removeAttribute('data-bs-theme');
      if (document.body) {
        document.body.classList.remove('dark-mode');
        document.body.removeAttribute('data-bs-theme');
      }
    }
    updateThemeIcons(savedTheme);
    updateChartsTheme(savedTheme);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', applyTheme);
  } else {
    applyTheme();
  }

  window.toggleAstraTheme = function() {
    var current = (document.documentElement.getAttribute('data-bs-theme') === 'dark' || (document.body && document.body.classList.contains('dark-mode'))) ? 'dark' : 'light';
    var next = current === 'dark' ? 'light' : 'dark';
    localStorage.setItem('astra_theme', next);
    applyTheme();
  };
})();

// Password Eye Toggle Handler for portal pages (change-password, profile, etc.)
document.addEventListener('click', function (e) {
  var btn = e.target.closest('.ap-auth-eye, .btn-toggle-password, [data-toggle="password"], [data-password-toggle]');
  if (!btn) {
    if (e.target.matches('.bi-eye, .bi-eye-slash') && e.target.closest('.input-group, .ap-auth-input, .has-eye')) {
      var parentSpan = e.target.closest('.input-group, .ap-auth-input, .has-eye');
      var potentialBtn = parentSpan ? parentSpan.querySelector('button, .ap-auth-eye, a') : null;
      if (potentialBtn) btn = potentialBtn;
    }
  }
  if (!btn) return;

  e.preventDefault();
  e.stopPropagation();

  var targetId = btn.getAttribute('data-target') || btn.getAttribute('data-bs-target');
  var input = null;
  if (targetId) {
    targetId = targetId.replace(/^#/, '');
    input = document.getElementById(targetId) || document.querySelector('[id$="' + targetId + '"]');
  }
  if (!input) {
    var container = btn.closest('.input-group, .ap-auth-input, .has-eye, div') || btn.parentElement;
    if (container) {
      input = container.querySelector('input[type="password"], input[type="text"]');
    }
  }
  if (!input) return;

  var isPassword = input.type === 'password';
  input.type = isPassword ? 'text' : 'password';

  var icon = btn.querySelector('i, svg');
  if (icon) {
    if (isPassword) {
      icon.classList.remove('bi-eye');
      icon.classList.add('bi-eye-slash');
    } else {
      icon.classList.remove('bi-eye-slash');
      icon.classList.add('bi-eye');
    }
  }
  btn.setAttribute('aria-label', isPassword ? 'Hide password' : 'Show password');
  try {
    var len = input.value.length;
    input.focus();
    if (input.setSelectionRange) input.setSelectionRange(len, len);
  } catch (err) {}
}, true);


// ========================================================
// Double-Submit Protection & Spinner
// ========================================================
document.addEventListener('DOMContentLoaded', function () {
  var forms = document.querySelectorAll('form');
  forms.forEach(function (form) {
    form.addEventListener('submit', function () {
      var submitButtons = form.querySelectorAll('input[type="submit"], button[type="submit"]');
      submitButtons.forEach(function (btn) {
        if (!btn.disabled && !btn.dataset.submitting) {
          btn.dataset.submitting = "true";
          setTimeout(function() {
            btn.classList.add('disabled');
          }, 100);
        }
      });
    });
  });
});


