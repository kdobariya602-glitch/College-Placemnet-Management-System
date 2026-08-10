/**
 * Placement Management System - Reusable Components
 */

const Components = {
  adminNav: [
    { href: 'dashboard.aspx', icon: 'bi-speedometer2', label: 'Dashboard' },
    { href: 'students.aspx', icon: 'bi-people', label: 'Student Management' },
    { href: 'companies.aspx', icon: 'bi-building', label: 'Company Management' },
    { href: 'jobs.aspx', icon: 'bi-briefcase', label: 'Job Management' },
    { href: 'drives.aspx', icon: 'bi-calendar-event', label: 'Placement Drives' },
    { href: 'applications.aspx', icon: 'bi-file-earmark-text', label: 'Applications' },
    { href: 'selected.aspx', icon: 'bi-trophy', label: 'Selected Students' },
    { href: 'reports.aspx', icon: 'bi-bar-chart-line', label: 'Reports & Analytics' },
    { href: 'messages.aspx', icon: 'bi-envelope', label: 'Contact Messages' },
    { href: 'settings.aspx', icon: 'bi-gear', label: 'Settings' }
  ],

  studentNav: [
    { href: 'dashboard.aspx', icon: 'bi-speedometer2', label: 'Dashboard' },
    { href: 'profile.aspx', icon: 'bi-person', label: 'My Profile' },
    { href: 'jobs.aspx', icon: 'bi-briefcase', label: 'Available Jobs' },
    { href: 'applications.aspx', icon: 'bi-file-earmark-text', label: 'My Applications' },
    { href: 'placement-status.aspx', icon: 'bi-trophy', label: 'Placement Status' }
  ],

  companyNav: [
    { href: 'dashboard.aspx', icon: 'bi-speedometer2', label: 'Dashboard' },
    { href: 'profile.aspx', icon: 'bi-building', label: 'Company Profile' },
    { href: 'post-job.aspx', icon: 'bi-plus-circle', label: 'Post New Job' },
    { href: 'manage-jobs.aspx', icon: 'bi-briefcase', label: 'Manage Jobs' },
    { href: 'applications.aspx', icon: 'bi-file-earmark-text', label: 'View Applications' },
    { href: 'shortlist.aspx', icon: 'bi-star', label: 'Shortlist Students' },
    { href: 'selected.aspx', icon: 'bi-trophy', label: 'Selected Students' },
    { href: 'notifications.aspx', icon: 'bi-bell', label: 'Notifications' }
  ],

  renderSidebar(module, activePage) {
    const navItems = this[module + 'Nav'] || [];
    const brandText = module === 'admin' ? 'PMS Admin' : module === 'student' ? 'Student Portal' : 'Company Portal';

    const navHtml = navItems.map(item => `
      <a href="${item.href}" class="nav-link ${activePage === item.href ? 'active' : ''}">
        <i class="bi ${item.icon}"></i>
        <span>${item.label}</span>
      </a>`).join('');

    return `
      <aside class="sidebar" id="sidebar">
        <div class="sidebar-brand">
          <div class="sidebar-brand-icon">
            <svg width="26" height="26" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
              <rect x="1" y="1" width="46" height="46" rx="14" fill="#0d1b3e"/>
              <path d="M24 9L34.5 31.5H30L28 27H20L18 31.5H13.5L24 9Z" fill="#ffffff"/>
              <rect x="20.8" y="22.5" width="6.4" height="2.6" fill="#0d1b3e"/>
              <circle cx="34" cy="13.5" r="3.2" fill="#f5a524"/>
            </svg>
          </div>
          <span class="sidebar-brand-text">${brandText}</span>
        </div>
        <div class="sidebar-section-title">Main Menu</div>
        <nav class="sidebar-nav">${navHtml}</nav>
      </aside>`;
  },

  renderNavbar(user, module) {
    const notifications = getData().notifications.filter(n => 
      (n.userType === module || n.userId === user?.id) && !n.read
    ).slice(0, 5);

    const notifHtml = notifications.length ? notifications.map(n => `
      <div class="notification-item">
        <strong>${n.title}</strong>
        <p class="mb-0">${n.message}</p>
        <span class="time">${n.time}</span>
      </div>`).join('') : '<div class="notification-item text-muted">No new notifications</div>';

    const logoutUrl = module === 'admin' ? 'login.aspx' : 'login.aspx';
    const initials = App.getInitials(user?.name || 'U');

    return `
      <header class="top-navbar" id="topNavbar">
        <button class="sidebar-toggle-btn d-none d-lg-flex" id="sidebarToggle" aria-label="Toggle sidebar">
          <i class="bi bi-list"></i>
        </button>
        <button class="sidebar-toggle-btn d-lg-none" id="mobileSidebarToggle" data-bs-toggle="offcanvas" data-bs-target="#mobileSidebar" aria-label="Open menu">
          <i class="bi bi-list"></i>
        </button>
        <div class="navbar-search position-relative d-none d-md-block">
          <i class="bi bi-search search-icon"></i>
          <input type="text" class="form-control" id="globalSearch" placeholder="Search...">
        </div>
        <div class="navbar-actions">
          <div class="dropdown">
            <button class="navbar-btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
              <i class="bi bi-bell"></i>
              ${notifications.length ? '<span class="badge-dot"></span>' : ''}
            </button>
            <div class="dropdown-menu dropdown-menu-end notification-dropdown">
              <div class="dropdown-header d-flex justify-content-between">
                Notifications ${notifications.length ? `<span class="badge bg-danger">${notifications.length}</span>` : ''}
              </div>
              ${notifHtml}
            </div>
          </div>
          <div class="dropdown profile-dropdown">
            <button class="dropdown-toggle" data-bs-toggle="dropdown">
              <div class="profile-avatar">${initials}</div>
              <span class="profile-name">${user?.name || 'User'}</span>
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><h6 class="dropdown-header">${user?.email || ''}</h6></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="${module === 'admin' ? 'settings.aspx' : 'profile.aspx'}"><i class="bi bi-person me-2"></i>Profile</a></li>
              <li><a class="dropdown-item" href="#" id="logoutBtn"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
            </ul>
          </div>
        </div>
      </header>`;
  },

  renderFooter() {
    return `
      <footer class="app-footer">
        &copy; 2026 Placement Management System. All rights reserved. | University Placement Portal
      </footer>`;
  },

  renderMobileSidebar(module, activePage) {
    const navItems = this[module + 'Nav'] || [];
    const navHtml = navItems.map(item => `
      <a href="${item.href}" class="nav-link ${activePage === item.href ? 'active' : ''}">
        <i class="bi ${item.icon} me-2"></i>${item.label}
      </a>`).join('');

    return `
      <div class="offcanvas offcanvas-start offcanvas-sidebar" tabindex="-1" id="mobileSidebar">
        <div class="offcanvas-header border-bottom border-secondary">
          <h5 class="offcanvas-title text-white"><i class="bi bi-mortarboard-fill me-2"></i>PMS Portal</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">${navHtml}</div>
      </div>`;
  },

  renderPageHeader(title, subtitle, breadcrumbs = []) {
    const bcHtml = breadcrumbs.length ? `
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
          ${breadcrumbs.map((b, i) => 
            i === breadcrumbs.length - 1 
              ? `<li class="breadcrumb-item active">${b.label}</li>`
              : `<li class="breadcrumb-item"><a href="${b.href}">${b.label}</a></li>`
          ).join('')}
        </ol>
      </nav>` : '';

    return `
      <div class="page-breadcrumb">
        ${bcHtml}
        <h4>${title}</h4>
        ${subtitle ? `<p>${subtitle}</p>` : ''}
      </div>`;
  },

  renderConfirmModal() {
    return `
      <div class="modal fade" id="confirmDeleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title"><i class="bi bi-exclamation-triangle text-danger me-2"></i>Confirm Delete</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body"><p>Are you sure you want to delete this item?</p></div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
              <button type="button" class="btn btn-primary-custom" id="confirmDeleteBtn">Delete</button>
            </div>
          </div>
        </div>
      </div>`;
  },

  initLayout(module, activePage, user) {
    const sidebarEl = document.getElementById('sidebarContainer');
    const navbarEl = document.getElementById('navbarContainer');
    const footerEl = document.getElementById('footerContainer');
    const mobileEl = document.getElementById('mobileSidebarContainer');
    const modalEl = document.getElementById('modalContainer');

    if (sidebarEl) sidebarEl.innerHTML = this.renderSidebar(module, activePage);
    if (navbarEl) navbarEl.innerHTML = this.renderNavbar(user, module);
    if (footerEl) footerEl.innerHTML = this.renderFooter();
    if (mobileEl) mobileEl.innerHTML = this.renderMobileSidebar(module, activePage);
    if (modalEl) modalEl.innerHTML = this.renderConfirmModal();

    //document.getElementById('logoutBtn')?.addEventListener('click', (e) => {
    //  e.preventDefault();
    //  App.logout('login.aspx');
      //});

      document.getElementById('logoutBtn')?.addEventListener('click', (e) => {
          e.preventDefault();
          if (module === 'admin') {
              window.location.href = 'logout.aspx';
          } else {
              App.logout('login.aspx');
          }
      });

    App.initSidebar();
    App.initSearch();
  }
};
