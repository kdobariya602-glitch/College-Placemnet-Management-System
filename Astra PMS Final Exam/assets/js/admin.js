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
    const elDrives = document.getElementById('statDrives');
    if (elDrives) elDrives.textContent = stats.totalDrives;
    const elApplications = document.getElementById('statApplications');
    if (elApplications) elApplications.textContent = stats.totalApplications;
    const elSelected = document.getElementById('statSelected');
    if (elSelected) elSelected.textContent = stats.selectedApplications;
    const elTpos = document.getElementById('statTpos');
    if (elTpos) elTpos.textContent = stats.totalTpos;
    const elShortlisted = document.getElementById('statShortlisted');
    if (elShortlisted) elShortlisted.textContent = stats.shortlistedApplications;

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
          <button class="btn-icon me-1" onclick="Admin.editCompany('${c.id}')" title="Edit"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon me-1" onclick="Admin.toggleCompanyStatus('${c.id}')" title="${c.status === 'active' ? 'Deactivate' : 'Activate'}"><i class="bi ${c.status === 'active' ? 'bi-toggle-on' : 'bi-toggle-off'}"></i></button>
          <button class="btn-icon danger" onclick="Admin.deleteCompany('${c.id}')" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');

    App.renderPagination('companiesPagination', totalPages, page, (p) => Admin.renderCompaniesTable(p));
  },

  toggleCompanyStatus(id) {
    const data = getData();
    const company = data.companies.find(c => c.id === id);
    if (!company) return;
    company.status = company.status === 'active' ? 'inactive' : 'active';
    saveData(data);
    Admin.renderCompaniesTable();
    App.showToast(`Company ${company.status === 'active' ? 'activated' : 'deactivated'}`);
    addActivity('Company Status Updated', `${company.name} is now ${company.status}`);
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
      addActivity('Company Registered', `${companyData.name} joined the portal`);
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
    const driveName = document.getElementById('driveName').value;
    data.drives.push({
      id: generateId('DRV'),
      name: driveName,
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
    addActivity('Drive Scheduled', `${driveName} scheduled with ${company?.name || 'a company'}`);
    addNotification('all', 'student', 'New Placement Drive', `${driveName} has been scheduled. Check the drives page for details.`);
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
        addNotification(app.studentId, 'student', 'Placement Confirmed', `Your placement at ${app.companyName} for ${app.jobTitle} has been confirmed.`);
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
  },

  /* ===================== Manage TPO ===================== */
  renderTpoTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.tpoOfficers, page);
    const tbody = document.getElementById('tpoTableBody');
    if (!tbody) return;
    tbody.innerHTML = items.map(t => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(t.name)}</span></td>
        <td><strong>${t.name}</strong></td>
        <td>${t.email}</td>
        <td data-filter="status" data-filter-value="${t.status}">${App.getStatusBadge(t.status)}</td>
        <td>
          <button class="btn-icon me-1" onclick="Admin.editTpo('${t.id}')" title="Edit"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon me-1" onclick="Admin.toggleTpoStatus('${t.id}')" title="${t.status === 'active' ? 'Deactivate' : 'Activate'}"><i class="bi ${t.status === 'active' ? 'bi-toggle-on' : 'bi-toggle-off'}"></i></button>
          <button class="btn-icon danger" onclick="Admin.deleteTpo('${t.id}')" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');
    App.renderPagination('tpoPagination', totalPages, page, (p) => Admin.renderTpoTable(p));
    App.filterTable('statusFilter', 'tpoTableBody', 'status');
  },
  toggleTpoStatus(id) {
    const data = getData();
    const tpo = data.tpoOfficers.find(t => t.id === id);
    if (!tpo) return;
    tpo.status = tpo.status === 'active' ? 'inactive' : 'active';
    saveData(data);
    Admin.renderTpoTable();
    App.showToast(`TPO officer ${tpo.status === 'active' ? 'activated' : 'deactivated'}`);
    addActivity('TPO Status Updated', `${tpo.name} is now ${tpo.status}`);
  },
  editTpo(id) {
    const data = getData();
    const t = data.tpoOfficers.find(x => x.id === id);
    if (!t) return;
    document.getElementById('tpoId').value = t.id;
    document.getElementById('tpoName').value = t.name;
    document.getElementById('tpoEmail').value = t.email;
    document.getElementById('tpoPassword').value = t.password;
    document.getElementById('tpoModalTitle').textContent = 'Edit TPO Officer';
    new bootstrap.Modal(document.getElementById('tpoModal')).show();
  },
  deleteTpo(id) {
    if (!confirm('Remove this TPO officer?')) return;
    const data = getData();
    data.tpoOfficers = data.tpoOfficers.filter(t => t.id !== id);
    saveData(data);
    Admin.renderTpoTable();
    App.showToast('TPO officer removed');
  },
  saveTpo() {
    const form = document.getElementById('tpoForm');
    if (!App.validateForm(form)) return;
    const data = getData();
    const id = document.getElementById('tpoId').value;
    const tpoData = {
      name: document.getElementById('tpoName').value,
      email: document.getElementById('tpoEmail').value,
      password: document.getElementById('tpoPassword').value,
      status: 'active'
    };
    if (id) {
      const idx = data.tpoOfficers.findIndex(t => t.id === id);
      if (idx > -1) data.tpoOfficers[idx] = { ...data.tpoOfficers[idx], ...tpoData };
    } else {
      tpoData.id = generateId('TPO');
      data.tpoOfficers.push(tpoData);
      addActivity('TPO Officer Added', `${tpoData.name} added as placement officer`);
    }
    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('tpoModal'))?.hide();
    Admin.renderTpoTable();
    App.showToast('TPO officer saved');
  },

  /* ===================== Departments ===================== */
  renderDepartmentsTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.departments, page);
    const tbody = document.getElementById('departmentsTableBody');
    if (!tbody) return;
    tbody.innerHTML = items.map(d => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(d.name)}</span></td>
        <td><strong>${d.name}</strong></td>
        <td>${d.code}</td>
        <td>${d.hod}</td>
        <td>${d.students}</td>
        <td data-filter="status" data-filter-value="${d.status}">${App.getStatusBadge(d.status)}</td>
        <td>
          <button class="btn-icon me-1" onclick="Admin.editDepartment('${d.id}')" title="Edit"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon me-1" onclick="Admin.toggleDepartmentStatus('${d.id}')" title="${d.status === 'active' ? 'Deactivate' : 'Activate'}"><i class="bi ${d.status === 'active' ? 'bi-toggle-on' : 'bi-toggle-off'}"></i></button>
          <button class="btn-icon danger" onclick="Admin.deleteDepartment('${d.id}')" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');
    App.renderPagination('departmentsPagination', totalPages, page, (p) => Admin.renderDepartmentsTable(p));
  },
  toggleDepartmentStatus(id) {
    const data = getData();
    const d = data.departments.find(x => x.id === id);
    if (!d) return;
    d.status = d.status === 'active' ? 'inactive' : 'active';
    saveData(data);
    Admin.renderDepartmentsTable();
    App.showToast(`Department ${d.status === 'active' ? 'activated' : 'deactivated'}`);
  },
  editDepartment(id) {
    const data = getData();
    const d = data.departments.find(x => x.id === id);
    if (!d) return;
    document.getElementById('departmentsId').value = d.id;
    document.getElementById('deptName').value = d.name;
    document.getElementById('deptCode').value = d.code;
    document.getElementById('deptHod').value = d.hod;
    document.getElementById('departmentsModalTitle') && (document.getElementById('departmentsModalTitle').textContent = 'Edit Department');
    new bootstrap.Modal(document.getElementById('departmentsModal')).show();
  },
  deleteDepartment(id) {
    if (!confirm('Delete this department?')) return;
    const data = getData();
    data.departments = data.departments.filter(d => d.id !== id);
    saveData(data);
    Admin.renderDepartmentsTable();
    App.showToast('Department deleted');
  },
  saveDepartment() {
    const form = document.getElementById('departmentsForm');
    if (!App.validateForm(form)) return;
    const data = getData();
    const id = document.getElementById('departmentsId').value;
    const deptData = {
      name: document.getElementById('deptName').value,
      code: document.getElementById('deptCode').value,
      hod: document.getElementById('deptHod').value,
      students: 0,
      status: 'active'
    };
    if (id) {
      const idx = data.departments.findIndex(d => d.id === id);
      if (idx > -1) data.departments[idx] = { ...data.departments[idx], ...deptData };
    } else {
      deptData.id = generateId('DEP');
      data.departments.push(deptData);
    }
    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('departmentsModal'))?.hide();
    Admin.renderDepartmentsTable();
    App.showToast('Department saved');
  },

  /* ===================== Courses ===================== */
  renderCoursesTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.courses, page);
    const tbody = document.getElementById('coursesTableBody');
    if (!tbody) return;
    tbody.innerHTML = items.map(c => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(c.name)}</span></td>
        <td><strong>${c.name}</strong></td>
        <td>${c.code}</td>
        <td>${c.department}</td>
        <td>${c.duration} yrs</td>
        <td data-filter="status" data-filter-value="${c.status}">${App.getStatusBadge(c.status)}</td>
        <td>
          <button class="btn-icon me-1" onclick="Admin.editCourse('${c.id}')" title="Edit"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon me-1" onclick="Admin.toggleCourseStatus('${c.id}')" title="${c.status === 'active' ? 'Deactivate' : 'Activate'}"><i class="bi ${c.status === 'active' ? 'bi-toggle-on' : 'bi-toggle-off'}"></i></button>
          <button class="btn-icon danger" onclick="Admin.deleteCourse('${c.id}')" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');
    App.renderPagination('coursesPagination', totalPages, page, (p) => Admin.renderCoursesTable(p));
  },
  toggleCourseStatus(id) {
    const data = getData();
    const c = data.courses.find(x => x.id === id);
    if (!c) return;
    c.status = c.status === 'active' ? 'inactive' : 'active';
    saveData(data);
    Admin.renderCoursesTable();
    App.showToast(`Course ${c.status === 'active' ? 'activated' : 'deactivated'}`);
  },
  editCourse(id) {
    const data = getData();
    const c = data.courses.find(x => x.id === id);
    if (!c) return;
    document.getElementById('coursesId').value = c.id;
    document.getElementById('courseName').value = c.name;
    document.getElementById('courseCode').value = c.code;
    document.getElementById('courseDept').value = c.department;
    document.getElementById('courseDuration').value = c.duration;
    new bootstrap.Modal(document.getElementById('coursesModal')).show();
  },
  deleteCourse(id) {
    if (!confirm('Delete this course?')) return;
    const data = getData();
    data.courses = data.courses.filter(c => c.id !== id);
    saveData(data);
    Admin.renderCoursesTable();
    App.showToast('Course deleted');
  },
  saveCourse() {
    const form = document.getElementById('coursesForm');
    if (!App.validateForm(form)) return;
    const data = getData();
    const id = document.getElementById('coursesId').value;
    const courseData = {
      name: document.getElementById('courseName').value,
      code: document.getElementById('courseCode').value,
      department: document.getElementById('courseDept').value,
      duration: parseInt(document.getElementById('courseDuration').value, 10),
      status: 'active'
    };
    if (id) {
      const idx = data.courses.findIndex(c => c.id === id);
      if (idx > -1) data.courses[idx] = { ...data.courses[idx], ...courseData };
    } else {
      courseData.id = generateId('CRS');
      data.courses.push(courseData);
    }
    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('coursesModal'))?.hide();
    Admin.renderCoursesTable();
    App.showToast('Course saved');
  },

  /* ===================== Batches ===================== */
  renderBatchesTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.batches, page);
    const tbody = document.getElementById('batchesTableBody');
    if (!tbody) return;
    tbody.innerHTML = items.map(b => {
      const courseObj = data.courses.find(c => c.name === b.course);
      const dept = courseObj ? courseObj.department : '—';
      return `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(b.name)}</span></td>
        <td><strong>${b.name}</strong></td>
        <td>${b.course}</td>
        <td>${dept}</td>
        <td>${b.startYear}</td>
        <td>${b.endYear}</td>
        <td>${b.students}</td>
        <td data-filter="status" data-filter-value="${b.status}">${App.getStatusBadge(b.status)}</td>
        <td>
          <button class="btn-icon me-1" onclick="Admin.editBatch('${b.id}')" title="Edit"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon me-1" onclick="Admin.toggleBatchStatus('${b.id}')" title="${b.status === 'active' ? 'Deactivate' : 'Activate'}"><i class="bi ${b.status === 'active' ? 'bi-toggle-on' : 'bi-toggle-off'}"></i></button>
          <button class="btn-icon danger" onclick="Admin.deleteBatch('${b.id}')" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`;
    }).join('');
    App.renderPagination('batchesPagination', totalPages, page, (p) => Admin.renderBatchesTable(p));
  },
  toggleBatchStatus(id) {
    const data = getData();
    const b = data.batches.find(x => x.id === id);
    if (!b) return;
    b.status = b.status === 'active' ? 'inactive' : 'active';
    saveData(data);
    Admin.renderBatchesTable();
    App.showToast(`Batch ${b.status === 'active' ? 'activated' : 'deactivated'}`);
  },
  editBatch(id) {
    const data = getData();
    const b = data.batches.find(x => x.id === id);
    if (!b) return;
    document.getElementById('batchesId').value = b.id;
    document.getElementById('batchName').value = b.name;
    document.getElementById('batchCourse').value = b.course;
    document.getElementById('batchStartYear').value = b.startYear;
    document.getElementById('batchEndYear').value = b.endYear;
    new bootstrap.Modal(document.getElementById('batchesModal')).show();
  },
  deleteBatch(id) {
    if (!confirm('Delete this batch?')) return;
    const data = getData();
    data.batches = data.batches.filter(b => b.id !== id);
    saveData(data);
    Admin.renderBatchesTable();
    App.showToast('Batch deleted');
  },
  saveBatch() {
    const form = document.getElementById('batchesForm');
    if (!App.validateForm(form)) return;
    const data = getData();
    const id = document.getElementById('batchesId').value;
    const batchData = {
      name: document.getElementById('batchName').value,
      course: document.getElementById('batchCourse').value,
      startYear: parseInt(document.getElementById('batchStartYear').value, 10),
      endYear: parseInt(document.getElementById('batchEndYear').value, 10),
      students: 0,
      status: 'active'
    };
    if (id) {
      const idx = data.batches.findIndex(b => b.id === id);
      if (idx > -1) data.batches[idx] = { ...data.batches[idx], ...batchData };
    } else {
      batchData.id = generateId('BAT');
      data.batches.push(batchData);
    }
    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('batchesModal'))?.hide();
    Admin.renderBatchesTable();
    App.showToast('Batch saved');
  },

  /* ===================== Skills ===================== */
  renderSkillsTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.skillsMaster, page);
    const tbody = document.getElementById('skillsTableBody');
    if (!tbody) return;
    tbody.innerHTML = items.map(s => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(s.name)}</span></td>
        <td><strong>${s.name}</strong></td>
        <td>${s.category}</td>
        <td data-filter="status" data-filter-value="${s.status}">${App.getStatusBadge(s.status)}</td>
        <td>
          <button class="btn-icon me-1" onclick="Admin.editSkill('${s.id}')" title="Edit"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon me-1" onclick="Admin.toggleSkillStatus('${s.id}')" title="${s.status === 'active' ? 'Deactivate' : 'Activate'}"><i class="bi ${s.status === 'active' ? 'bi-toggle-on' : 'bi-toggle-off'}"></i></button>
          <button class="btn-icon danger" onclick="Admin.deleteSkill('${s.id}')" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');
    App.renderPagination('skillsPagination', totalPages, page, (p) => Admin.renderSkillsTable(p));
  },
  toggleSkillStatus(id) {
    const data = getData();
    const s = data.skillsMaster.find(x => x.id === id);
    if (!s) return;
    s.status = s.status === 'active' ? 'inactive' : 'active';
    saveData(data);
    Admin.renderSkillsTable();
    App.showToast(`Skill ${s.status === 'active' ? 'activated' : 'deactivated'}`);
  },
  editSkill(id) {
    const data = getData();
    const s = data.skillsMaster.find(x => x.id === id);
    if (!s) return;
    document.getElementById('skillsId').value = s.id;
    document.getElementById('skillName').value = s.name;
    document.getElementById('skillCategory').value = s.category;
    new bootstrap.Modal(document.getElementById('skillsModal')).show();
  },
  deleteSkill(id) {
    if (!confirm('Delete this skill?')) return;
    const data = getData();
    data.skillsMaster = data.skillsMaster.filter(s => s.id !== id);
    saveData(data);
    Admin.renderSkillsTable();
    App.showToast('Skill deleted');
  },
  saveSkill() {
    const form = document.getElementById('skillsForm');
    if (!App.validateForm(form)) return;
    const data = getData();
    const id = document.getElementById('skillsId').value;
    const skillData = {
      name: document.getElementById('skillName').value,
      category: document.getElementById('skillCategory').value,
      status: 'active'
    };
    if (id) {
      const idx = data.skillsMaster.findIndex(s => s.id === id);
      if (idx > -1) data.skillsMaster[idx] = { ...data.skillsMaster[idx], ...skillData };
    } else {
      skillData.id = generateId('SKL');
      data.skillsMaster.push(skillData);
    }
    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('skillsModal'))?.hide();
    Admin.renderSkillsTable();
    App.showToast('Skill saved');
  },

  /* ===================== Job Roles ===================== */
  renderJobRolesTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.jobRoles, page);
    const tbody = document.getElementById('jobRolesTableBody');
    if (!tbody) return;
    tbody.innerHTML = items.map(r => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(r.title)}</span></td>
        <td><strong>${r.title}</strong></td>
        <td>${r.category}</td>
        <td>${r.description}</td>
        <td data-filter="status" data-filter-value="${r.status}">${App.getStatusBadge(r.status)}</td>
        <td>
          <button class="btn-icon me-1" onclick="Admin.editJobRole('${r.id}')" title="Edit"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon me-1" onclick="Admin.toggleJobRoleStatus('${r.id}')" title="${r.status === 'active' ? 'Deactivate' : 'Activate'}"><i class="bi ${r.status === 'active' ? 'bi-toggle-on' : 'bi-toggle-off'}"></i></button>
          <button class="btn-icon danger" onclick="Admin.deleteJobRole('${r.id}')" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');
    App.renderPagination('jobRolesPagination', totalPages, page, (p) => Admin.renderJobRolesTable(p));
  },
  toggleJobRoleStatus(id) {
    const data = getData();
    const r = data.jobRoles.find(x => x.id === id);
    if (!r) return;
    r.status = r.status === 'active' ? 'inactive' : 'active';
    saveData(data);
    Admin.renderJobRolesTable();
    App.showToast(`Job role ${r.status === 'active' ? 'activated' : 'deactivated'}`);
  },
  editJobRole(id) {
    const data = getData();
    const r = data.jobRoles.find(x => x.id === id);
    if (!r) return;
    document.getElementById('job_rolesId').value = r.id;
    document.getElementById('roleTitle').value = r.title;
    document.getElementById('roleCategory').value = r.category;
    document.getElementById('roleDescription').value = r.description;
    new bootstrap.Modal(document.getElementById('job_rolesModal')).show();
  },
  deleteJobRole(id) {
    if (!confirm('Delete this job role?')) return;
    const data = getData();
    data.jobRoles = data.jobRoles.filter(r => r.id !== id);
    saveData(data);
    Admin.renderJobRolesTable();
    App.showToast('Job role deleted');
  },
  saveJobRole() {
    const form = document.getElementById('job_rolesForm');
    if (!App.validateForm(form)) return;
    const data = getData();
    const id = document.getElementById('job_rolesId').value;
    const roleData = {
      title: document.getElementById('roleTitle').value,
      category: document.getElementById('roleCategory').value,
      description: document.getElementById('roleDescription').value,
      status: 'active'
    };
    if (id) {
      const idx = data.jobRoles.findIndex(r => r.id === id);
      if (idx > -1) data.jobRoles[idx] = { ...data.jobRoles[idx], ...roleData };
    } else {
      roleData.id = generateId('ROLE');
      data.jobRoles.push(roleData);
    }
    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('job_rolesModal'))?.hide();
    Admin.renderJobRolesTable();
    App.showToast('Job role saved');
  },

  /* ===================== Notices ===================== */
  renderNoticesTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.notices, page);
    const tbody = document.getElementById('noticesTableBody');
    if (!tbody) return;
    tbody.innerHTML = items.map(n => `
      <tr data-searchable>
        <td><strong>${n.title}</strong></td>
        <td>${n.description}</td>
        <td>${n.audience}</td>
        <td>${App.formatDate(n.postedAt)}</td>
        <td>${App.getStatusBadge(n.status)}</td>
        <td>
          <button class="btn-icon danger" onclick="Admin.deleteNotice('${n.id}')" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');
    App.renderPagination('noticesPagination', totalPages, page, (p) => Admin.renderNoticesTable(p));
  },
  deleteNotice(id) {
    if (!confirm('Delete this notice?')) return;
    const data = getData();
    data.notices = data.notices.filter(n => n.id !== id);
    saveData(data);
    Admin.renderNoticesTable();
    App.showToast('Notice deleted');
  },
  saveNotice() {
    const form = document.getElementById('noticeForm');
    if (!App.validateForm(form)) return;
    const data = getData();
    const noticeData = {
      id: generateId('NTC'),
      title: document.getElementById('noticeTitle').value,
      description: document.getElementById('noticeDescription').value,
      audience: document.getElementById('noticeAudience').value,
      postedAt: new Date().toISOString().split('T')[0],
      status: 'active'
    };
    data.notices.unshift(noticeData);
    saveData(data);
    bootstrap.Modal.getInstance(document.getElementById('noticeModal'))?.hide();
    Admin.renderNoticesTable();
    App.showToast('Notice published');
    addActivity('Notice Published', noticeData.title);
    addNotification('all', noticeData.audience === 'all' ? 'student' : noticeData.audience, 'New Notice', noticeData.title);
  },

  /* ===================== Notifications (admin-sent) ===================== */
  renderNotificationsTable(page = 1) {
    const data = getData();
    const { items, totalPages } = App.paginate(data.notifications, page);
    const tbody = document.getElementById('notificationsTableBody');
    if (!tbody) return;
    tbody.innerHTML = items.map(n => `
      <tr data-searchable>
        <td><strong>${n.title}</strong></td>
        <td>${n.message}</td>
        <td>${n.userType}</td>
        <td>${n.time}</td>
        <td>${n.read ? App.getStatusBadge('approved') : App.getStatusBadge('pending')}</td>
      </tr>`).join('');
    App.renderPagination('notificationsPagination', totalPages, page, (p) => Admin.renderNotificationsTable(p));
  },
  saveNotification() {
    const form = document.getElementById('notificationForm');
    if (!App.validateForm(form)) return;
    const recipient = document.getElementById('notificationRecipient').value;
    addNotification('all', recipient, document.getElementById('notificationTitle').value, document.getElementById('notificationMessage').value);
    bootstrap.Modal.getInstance(document.getElementById('notificationModal'))?.hide();
    Admin.renderNotificationsTable();
    App.showToast('Notification sent');
  }
};
