/**
 * Admin Module JavaScript
 */

const Admin = {
  initDashboard() {
    const stats = getStats();
    document.getElementById('statStudents').textContent = stats.totalStudents;
    document.getElementById('statCompanies').textContent = stats.totalCompanies;
    document.getElementById('statJobs').textContent = stats.totalJobs;
    document.getElementById('statPlacements').textContent = stats.totalPlacements;
    document.getElementById('statPercentage').textContent = stats.placementPercentage + '%';

    const activities = getData().activities.slice(0, 6);
    const activityEl = document.getElementById('activityList');
    if (activityEl) {
      activityEl.innerHTML = activities.map(a => `
        <div class="activity-item">
          <div class="activity-icon stat-icon ${a.color}"><i class="bi ${a.icon}"></i></div>
          <div class="activity-content">
            <h6>${a.action}</h6>
            <p>${a.detail}</p>
            <span class="time">${a.time}</span>
          </div>
        </div>`).join('');
    }

    Charts.initAdminDashboard();
  },

  renderStudentsTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.students, page);
    const tbody = document.getElementById('studentsTableBody');
    if (!tbody) return;

    tbody.innerHTML = items.map(s => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(s.name)}</span></td>
        <td><strong>${s.name}</strong><br><small class="text-muted">${s.id}</small></td>
        <td>${s.email}</td>
        <td>${s.branch}</td>
        <td>${s.cgpa}</td>
        <td data-filter="status" data-filter-value="${s.placed ? 'placed' : 'unplaced'}">
          ${s.placed ? App.getStatusBadge('selected') : App.getStatusBadge('pending')}
        </td>
        <td>${App.getStatusBadge(s.status)}</td>
        <td>
          <button class="btn-icon me-1" onclick="Admin.editStudent('${s.id}')" data-bs-toggle="tooltip" title="Edit"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon danger" onclick="Admin.deleteStudent('${s.id}')" data-bs-toggle="tooltip" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');

    App.renderPagination('studentsPagination', totalPages, page, (p) => Admin.renderStudentsTable(p));
    App.initTooltips();
  },

  editStudent(id) {
    const data = getData();
    const student = data.students.find(s => s.id === id);
    if (!student) return;

    document.getElementById('studentModalTitle').textContent = 'Edit Student';
    document.getElementById('studentId').value = student.id;
    document.getElementById('studentName').value = student.name;
    document.getElementById('studentEmail').value = student.email;
    document.getElementById('studentPhone').value = student.phone;
    document.getElementById('studentBranch').value = student.branch;
    document.getElementById('studentCgpa').value = student.cgpa;
    new bootstrap.Modal(document.getElementById('studentModal')).show();
  },

  deleteStudent(id) {
    App.confirmDelete('Delete this student record?', () => {
      const data = getData();
      data.students = data.students.filter(s => s.id !== id);
      saveData(data);
      Admin.renderStudentsTable();
      App.showToast('Student deleted successfully');
    });
  },

  saveStudent() {
    const form = document.getElementById('studentForm');
    if (!App.validateForm(form)) return;

    const data = getData();
    const id = document.getElementById('studentId').value;
    const studentData = {
      name: document.getElementById('studentName').value,
      email: document.getElementById('studentEmail').value,
      phone: document.getElementById('studentPhone').value,
      branch: document.getElementById('studentBranch').value,
      cgpa: parseFloat(document.getElementById('studentCgpa').value),
      password: 'student123',
      year: '2026',
      skills: [],
      status: 'active',
      placed: false,
      company: null
    };

    if (id) {
      const idx = data.students.findIndex(s => s.id === id);
      if (idx > -1) data.students[idx] = { ...data.students[idx], ...studentData };
    } else {
      studentData.id = generateId('STU');
      studentData.registeredAt = new Date().toISOString().split('T')[0];
      data.students.push(studentData);
    }

    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('studentModal'))?.hide();
    Admin.renderStudentsTable();
    App.showToast('Student saved successfully');
    addActivity('Student Updated', `${studentData.name} record saved`);
  },

  renderCompaniesTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.companies, page);
    const tbody = document.getElementById('companiesTableBody');
    if (!tbody) return;

    tbody.innerHTML = items.map(c => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(c.name)}</span></td>
        <td><strong>${c.name}</strong><br><small class="text-muted">${c.id}</small></td>
        <td>${c.email}</td>
        <td>${c.industry}</td>
        <td>${c.location}</td>
        <td>${App.getStatusBadge(c.status)}</td>
        <td>
          <button class="btn-icon me-1" onclick="Admin.editCompany('${c.id}')"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon danger" onclick="Admin.deleteCompany('${c.id}')"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');

    App.renderPagination('companiesPagination', totalPages, page, (p) => Admin.renderCompaniesTable(p));
  },

  editCompany(id) {
    const data = getData();
    const company = data.companies.find(c => c.id === id);
    if (!company) return;
    document.getElementById('companyModalTitle').textContent = 'Edit Company';
    document.getElementById('companyId').value = company.id;
    document.getElementById('companyName').value = company.name;
    document.getElementById('companyEmail').value = company.email;
    document.getElementById('companyIndustry').value = company.industry;
    document.getElementById('companyLocation').value = company.location;
    document.getElementById('companyContact').value = company.contact;
    new bootstrap.Modal(document.getElementById('companyModal')).show();
  },

  deleteCompany(id) {
    App.confirmDelete('Delete this company?', () => {
      const data = getData();
      data.companies = data.companies.filter(c => c.id !== id);
      saveData(data);
      Admin.renderCompaniesTable();
      App.showToast('Company deleted');
    });
  },

  saveCompany() {
    const form = document.getElementById('companyForm');
    if (!App.validateForm(form)) return;
    const data = getData();
    const id = document.getElementById('companyId').value;
    const companyData = {
      name: document.getElementById('companyName').value,
      email: document.getElementById('companyEmail').value,
      industry: document.getElementById('companyIndustry').value,
      location: document.getElementById('companyLocation').value,
      contact: document.getElementById('companyContact').value,
      password: 'company123',
      website: '',
      description: '',
      status: 'active'
    };
    if (id) {
      const idx = data.companies.findIndex(c => c.id === id);
      if (idx > -1) data.companies[idx] = { ...data.companies[idx], ...companyData };
    } else {
      companyData.id = generateId('COM');
      companyData.registeredAt = new Date().toISOString().split('T')[0];
      data.companies.push(companyData);
    }
    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('companyModal'))?.hide();
    Admin.renderCompaniesTable();
    App.showToast('Company saved');
  },

  renderJobsTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.jobs, page);
    const tbody = document.getElementById('jobsTableBody');
    if (!tbody) return;

    tbody.innerHTML = items.map(j => `
      <tr data-searchable>
        <td><strong>${j.title}</strong><br><small class="text-muted">${j.id}</small></td>
        <td>${j.companyName}</td>
        <td>${j.type}</td>
        <td>${j.location}</td>
        <td>${j.salary}</td>
        <td data-filter="status" data-filter-value="${j.status}">${App.getStatusBadge(j.status)}</td>
        <td>${App.formatDate(j.deadline)}</td>
        <td>
          <button class="btn-icon danger" onclick="Admin.deleteJob('${j.id}')"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');

    App.renderPagination('jobsPagination', totalPages, page, (p) => Admin.renderJobsTable(p));
    App.filterTable('jobStatusFilter', 'jobsTableBody', 'status');
  },

  deleteJob(id) {
    App.confirmDelete('Delete this job posting?', () => {
      const data = getData();
      data.jobs = data.jobs.filter(j => j.id !== id);
      saveData(data);
      Admin.renderJobsTable();
      App.showToast('Job deleted');
    });
  },

  renderDrivesTable() {
    const data = getData();
    const tbody = document.getElementById('drivesTableBody');
    if (!tbody) return;

    tbody.innerHTML = data.drives.map(d => `
      <tr data-searchable>
        <td><strong>${d.name}</strong></td>
        <td>${d.companyName}</td>
        <td>${App.formatDate(d.date)}</td>
        <td>${d.venue}</td>
        <td>${d.registered} students</td>
        <td data-filter="status" data-filter-value="${d.status}">${App.getStatusBadge(d.status)}</td>
        <td>
          <button class="btn-icon danger" onclick="Admin.deleteDrive('${d.id}')"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');
    App.filterTable('driveStatusFilter', 'drivesTableBody', 'status');
  },

  deleteDrive(id) {
    App.confirmDelete('Delete this drive?', () => {
      const data = getData();
      data.drives = data.drives.filter(d => d.id !== id);
      saveData(data);
      Admin.renderDrivesTable();
      App.showToast('Drive deleted');
    });
  },

  saveDrive() {
    const form = document.getElementById('driveForm');
    if (!App.validateForm(form)) return;
    const data = getData();
    const companyId = document.getElementById('driveCompany').value;
    const company = data.companies.find(c => c.id === companyId);
    data.drives.push({
      id: generateId('DRV'),
      name: document.getElementById('driveName').value,
      companyId,
      companyName: company?.name || '',
      date: document.getElementById('driveDate').value,
      venue: document.getElementById('driveVenue').value,
      eligibility: document.getElementById('driveEligibility').value,
      status: 'upcoming',
      registered: 0
    });
    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('driveModal'))?.hide();
    Admin.renderDrivesTable();
    App.showToast('Drive created');
  },

  renderApplicationsTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.applications, page);
    const tbody = document.getElementById('applicationsTableBody');
    if (!tbody) return;

    tbody.innerHTML = items.map(a => `
      <tr data-searchable>
        <td>${a.studentName}<br><small class="text-muted">${a.studentId}</small></td>
        <td>${a.jobTitle}</td>
        <td>${a.companyName}</td>
        <td data-filter="status" data-filter-value="${a.status}">${App.getStatusBadge(a.status)}</td>
        <td>${App.formatDate(a.appliedAt)}</td>
        <td>${a.interviewDate ? App.formatDate(a.interviewDate) : '—'}</td>
        <td>
          <select class="form-select form-select-sm" style="width:auto" onchange="Admin.updateApplicationStatus('${a.id}', this.value)">
            <option value="">Update</option>
            <option value="pending">Pending</option>
            <option value="shortlisted">Shortlisted</option>
            <option value="selected">Selected</option>
            <option value="rejected">Rejected</option>
          </select>
        </td>
      </tr>`).join('');

    App.renderPagination('applicationsPagination', totalPages, page, (p) => Admin.renderApplicationsTable(p));
    App.filterTable('appStatusFilter', 'applicationsTableBody', 'status');
  },

  updateApplicationStatus(id, status) {
    if (!status) return;
    const data = getData();
    const app = data.applications.find(a => a.id === id);
    if (app) {
      app.status = status;
      if (status === 'selected') {
        const student = data.students.find(s => s.id === app.studentId);
        if (student) { student.placed = true; student.company = app.companyName; }
      }
      saveData(data);
      Admin.renderApplicationsTable();
      App.showToast('Application status updated');
    }
  },

  renderSelectedTable() {
    const data = getData();
    const selected = data.applications.filter(a => a.status === 'selected');
    const tbody = document.getElementById('selectedTableBody');
    if (!tbody) return;

    tbody.innerHTML = selected.map(a => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(a.studentName)}</span></td>
        <td><strong>${a.studentName}</strong></td>
        <td>${a.companyName}</td>
        <td>${a.jobTitle}</td>
        <td>${App.formatDate(a.appliedAt)}</td>
        <td>${App.getStatusBadge('selected')}</td>
      </tr>`).join('');
  },

  changePassword() {
    const form = document.getElementById('passwordForm');
    if (!App.validateForm(form)) return;
    const current = document.getElementById('currentPassword').value;
    const newPass = document.getElementById('newPassword').value;
    const confirm = document.getElementById('confirmPassword').value;

    const data = getData();
    if (data.admin.password !== current) {
      App.showToast('Current password is incorrect', 'error');
      return;
    }
    if (newPass !== confirm) {
      App.showToast('Passwords do not match', 'error');
      return;
    }
    data.admin.password = newPass;
    saveData(data);
    App.showToast('Password changed successfully');
    form.reset();
  }
};
