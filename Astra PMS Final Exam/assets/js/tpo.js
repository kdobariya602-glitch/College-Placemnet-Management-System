/**
 * TPO (Training & Placement Officer) Module JavaScript
 * Handles all client-side, non-database-backed functionality for the TPO panel.
 * Reuses the shared getData()/saveData() localStorage architecture from data.js.
 *
 * NOTE: Student Management (students.aspx) is database-backed via Student_reg_tbl
 * and is handled entirely in code-behind (students.aspx.cs) — it does not use this module.
 * Student Details, Company Details and Contact Messages are also database-backed
 * and are handled entirely in code-behind.
 */

const Tpo = {
  initDashboard() {
    const stats = getStats();
    document.getElementById('statStudents').textContent = stats.totalStudents;
    document.getElementById('statCompanies').textContent = stats.totalCompanies;
    document.getElementById('statJobs').textContent = stats.totalJobs;
    document.getElementById('statPlacements').textContent = stats.totalPlacements;
    document.getElementById('statPercentage').textContent = stats.placementPercentage + '%';
    const interviewsEl = document.getElementById('statInterviews');
    if (interviewsEl) interviewsEl.textContent = stats.totalInterviews;
    const drivesEl = document.getElementById('statDrives');
    if (drivesEl) drivesEl.textContent = stats.totalDrives;
    const applicationsEl = document.getElementById('statApplications');
    if (applicationsEl) applicationsEl.textContent = stats.totalApplications;
    const shortlistedEl = document.getElementById('statShortlisted');
    if (shortlistedEl) shortlistedEl.textContent = stats.shortlistedApplications;
    const selectedEl = document.getElementById('statSelected');
    if (selectedEl) selectedEl.textContent = stats.selectedApplications;

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

  /* ===================== Companies ===================== */
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
          <button class="btn-icon me-1" onclick="Tpo.editCompany('${c.id}')"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon danger" onclick="Tpo.deleteCompany('${c.id}')"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');

    App.renderPagination('companiesPagination', totalPages, page, (p) => Tpo.renderCompaniesTable(p));
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
      Tpo.renderCompaniesTable();
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
    Tpo.renderCompaniesTable();
    App.showToast('Company saved');
    addActivity('Company Updated', `${companyData.name} record saved`);
  },

  /* ===================== Jobs ===================== */
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
          ${j.status === 'pending' ? `
            <button class="btn-icon me-1" title="Approve" onclick="Tpo.approveJob('${j.id}')"><i class="bi bi-check-circle text-success"></i></button>
            <button class="btn-icon me-1" title="Reject" onclick="Tpo.rejectJob('${j.id}')"><i class="bi bi-x-circle text-danger"></i></button>` : ''}
          <button class="btn-icon danger" onclick="Tpo.deleteJob('${j.id}')"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');

    App.renderPagination('jobsPagination', totalPages, page, (p) => Tpo.renderJobsTable(p));
    App.filterTable('jobStatusFilter', 'jobsTableBody', 'status');
  },

  /**
   * Job approval workflow (company posts -> TPO approves/rejects -> students see it).
   * A job only becomes visible to students once its status is 'active'.
   */
  approveJob(id) {
    const data = getData();
    const job = data.jobs.find(j => j.id === id);
    if (!job) return;
    job.status = 'active';
    job.approvalRemarks = '';
    saveData(data);
    addActivity('Job Approved', `${job.title} at ${job.companyName} approved`);
    addNotification(job.companyId, 'company', 'Job Approved', `Your job "${job.title}" has been approved and is now live to students.`);
    data.students
      .filter(s => s.status === 'active' && App.checkJobEligibility(s, job, data).eligible)
      .forEach(s => addNotification(s.id, 'student', 'New Job', `A new job "${job.title}" at ${job.companyName} matches your profile.`));
    Tpo.renderJobsTable();
    App.showToast('Job approved');
  },

  rejectJob(id) {
    const data = getData();
    const job = data.jobs.find(j => j.id === id);
    if (!job) return;
    job.status = 'rejected';
    saveData(data);
    addActivity('Job Rejected', `${job.title} at ${job.companyName} rejected`);
    addNotification(job.companyId, 'company', 'Job Rejected', `Your job "${job.title}" was not approved. Please review and resubmit.`);
    Tpo.renderJobsTable();
    App.showToast('Job rejected');
  },

  deleteJob(id) {
    App.confirmDelete('Delete this job posting?', () => {
      const data = getData();
      data.jobs = data.jobs.filter(j => j.id !== id);
      saveData(data);
      Tpo.renderJobsTable();
      App.showToast('Job deleted');
    });
  },

  /* ===================== Placement Drives ===================== */
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
          <button class="btn-icon danger" onclick="Tpo.deleteDrive('${d.id}')"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');
    App.filterTable('driveStatusFilter', 'drivesTableBody', 'status');
  },

  deleteDrive(id) {
    App.confirmDelete('Delete this drive?', () => {
      const data = getData();
      data.drives = data.drives.filter(d => d.id !== id);
      saveData(data);
      Tpo.renderDrivesTable();
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
    Tpo.renderDrivesTable();
    App.showToast('Drive created');
    addActivity('Drive Scheduled', `${document.getElementById('driveName').value} drive created`);
    data.students.filter(s => s.status === 'active').forEach(s =>
      addNotification(s.id, 'student', 'New Placement Drive', `A new placement drive "${document.getElementById('driveName').value}" has been scheduled by ${company?.name || 'the placement cell'}.`));
  },

  /* Populate the "Approved Job" dropdown on create-drive.aspx — a drive can only be created from a job TPO has already approved. */
  populateApprovedJobDropdown(elementId) {
    const el = document.getElementById(elementId);
    if (!el) return;
    const data = getData();
    const approvedJobs = data.jobs.filter(j => j.status === 'active');
    el.innerHTML = '<option value="">Select an approved job</option>' +
      approvedJobs.map(j => `<option value="${j.id}">${j.title} — ${j.companyName}</option>`).join('');
  },

  /* Auto-fill Job Role / Min CGPA / Eligible Branches from the selected approved job. */
  onDriveJobSelected() {
    const jobEl = document.getElementById('driveJobSelect');
    const jobId = jobEl?.value;
    const data = getData();
    const job = data.jobs.find(j => j.id === jobId);
    const roleEl = document.getElementById('driveJobRole');
    const cgpaEl = document.getElementById('driveMinCgpa');
    const branchesEl = document.getElementById('driveBranches');
    if (!job) {
      if (roleEl) roleEl.value = '';
      if (cgpaEl) cgpaEl.value = '';
      if (branchesEl) branchesEl.value = '';
      return;
    }
    if (roleEl) roleEl.value = job.title;
    if (cgpaEl && typeof job.cgpaMin === 'number') cgpaEl.value = job.cgpaMin;
    if (branchesEl && Array.isArray(job.branches)) branchesEl.value = job.branches.join(', ');
  },

  /* Full-page drive creation used by create-drive.aspx (richer field set than the drives.aspx quick-create modal).
     Drives can only be created from a job TPO has already approved (status === 'active'). */
  createDrive() {
    const nameEl = document.getElementById('driveName');
    const jobSelectEl = document.getElementById('driveJobSelect');
    const dateEl = document.getElementById('driveDate');
    const deadlineEl = document.getElementById('driveDeadline');
    const venueEl = document.getElementById('driveVenue');
    const jobRoleEl = document.getElementById('driveJobRole');
    const minCgpaEl = document.getElementById('driveMinCgpa');
    const branchesEl = document.getElementById('driveBranches');
    const packageEl = document.getElementById('drivePackage');
    const descriptionEl = document.getElementById('driveDescription');

    if (!nameEl.value.trim() || !jobSelectEl.value || !dateEl.value || !deadlineEl.value || !venueEl.value.trim() || !minCgpaEl.value) {
      App.showToast('Please fill in all required fields', 'error');
      return;
    }

    const data = getData();
    const job = data.jobs.find(j => j.id === jobSelectEl.value);
    if (!job) {
      App.showToast('Selected job could not be found', 'error');
      return;
    }
    if (job.status !== 'active') {
      App.showToast('A drive can only be created from an approved job', 'error');
      return;
    }

    const company = data.companies.find(c => c.id === job.companyId);
    const companyName = company ? company.name : job.companyName;

    const drive = {
      id: generateId('DRV'),
      name: nameEl.value.trim(),
      jobId: job.id,
      companyId: job.companyId,
      companyName,
      date: dateEl.value,
      driveDate: dateEl.value,
      deadline: deadlineEl.value,
      registrationDeadline: deadlineEl.value,
      venue: venueEl.value.trim(),
      jobRole: jobRoleEl.value.trim() || job.title,
      minCgpa: parseFloat(minCgpaEl.value) || 0,
      eligibility: branchesEl.value.trim() ? `CGPA ≥ ${minCgpaEl.value}, ${branchesEl.value.trim()}` : `CGPA ≥ ${minCgpaEl.value}`,
      eligibleBranches: branchesEl.value.trim(),
      package: packageEl.value.trim(),
      description: descriptionEl.value.trim(),
      status: 'upcoming',
      registered: 0
    };
    data.drives.push(drive);
    saveData(data);
    addActivity('Drive Scheduled', `${drive.name} drive created for ${companyName} (${job.title})`);
    App.showToast('Placement drive created successfully');
    data.students.filter(s => s.status === 'active').forEach(s =>
      addNotification(s.id, 'student', 'New Placement Drive', `A new placement drive "${drive.name}" has been scheduled for ${companyName}.`));
    window.location.href = 'drives.aspx';
  },

  /* Populate a <select>/<asp:DropDownList> with the current list of companies. Safe no-op if the element is missing. */
  populateCompanyDropdown(elementId, includeAllOption = true) {
    const el = document.getElementById(elementId);
    if (!el) return;
    const data = getData();
    const current = el.value;
    el.innerHTML = (includeAllOption ? '<option value="">All Companies</option>' : '') +
      data.companies.map(c => `<option value="${c.id}">${c.name}</option>`).join('');
    if (current) el.value = current;
  },

  /* Populate a <select>/<asp:DropDownList> with the current list of jobs. Safe no-op if the element is missing. */
  populateJobDropdown(elementId) {
    const el = document.getElementById(elementId);
    if (!el) return;
    const data = getData();
    const current = el.value;
    el.innerHTML = '<option value="">All Jobs</option>' +
      data.jobs.map(j => `<option value="${j.id}">${j.title} (${j.companyName})</option>`).join('');
    if (current) el.value = current;
  },

  /* Populate a <select>/<asp:DropDownList> with the current list of drives. Safe no-op if the element is missing. */
  populateDriveDropdown(elementId) {
    const el = document.getElementById(elementId);
    if (!el) return;
    const data = getData();
    const current = el.value;
    el.innerHTML = '<option value="">All Drives</option>' +
      data.drives.map(d => `<option value="${d.id}">${d.name}</option>`).join('');
    if (current) el.value = current;
  },

  /* ===================== Applications ===================== */
  renderApplicationsTable(page = 1) {
    const data = getData();
    const companyFilterEl = document.getElementById('appCompanyFilter');
    const jobFilterEl = document.getElementById('appJobFilter');
    const driveFilterEl = document.getElementById('appDriveFilter');
    const companyFilter = companyFilterEl ? companyFilterEl.value : '';
    const jobFilter = jobFilterEl ? jobFilterEl.value : '';
    const driveFilter = driveFilterEl ? driveFilterEl.value : '';

    let rows = data.applications.slice();
    if (companyFilter) rows = rows.filter(a => a.companyId === companyFilter);
    if (jobFilter) rows = rows.filter(a => a.jobId === jobFilter);
    if (driveFilter) rows = rows.filter(a => a.driveId === driveFilter);

    const { items, totalPages } = App.paginate(rows, page);
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
          <select class="form-select form-select-sm" style="width:auto" onchange="Tpo.updateApplicationStatus('${a.id}', this.value)">
            <option value="">Update</option>
            <option value="pending">Pending</option>
            <option value="shortlisted">Shortlisted</option>
            <option value="selected">Selected</option>
            <option value="rejected">Rejected</option>
          </select>
        </td>
      </tr>`).join('');

    App.renderPagination('applicationsPagination', totalPages, page, (p) => Tpo.renderApplicationsTable(p));
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
        addNotification(app.studentId, 'student', 'Selected!', `You have been selected for ${app.jobTitle} at ${app.companyName}.`);
      } else if (status === 'shortlisted') {
        addNotification(app.studentId, 'student', 'Shortlisted', `You have been shortlisted for ${app.jobTitle} at ${app.companyName}.`);
      } else if (status === 'rejected') {
        const student = data.students.find(s => s.id === app.studentId);
        if (student && student.company === app.companyName) { student.placed = false; student.company = null; }
      }
      saveData(data);
      Tpo.renderApplicationsTable();
      Tpo.renderShortlistedTable && Tpo.renderShortlistedTable();
      App.showToast('Application status updated');
      addActivity('Application Status Updated', `${app.studentName}'s application for ${app.jobTitle} marked ${status}`);
    }
  },

  /* ===================== Shortlisted Students ===================== */
  renderShortlistedTable(page = 1) {
    const data = getData();
    const companyFilterEl = document.getElementById('shortlistedCompanyFilter');
    const companyFilter = companyFilterEl ? companyFilterEl.value : '';

    let rows = data.applications.filter(a => a.status === 'shortlisted' || a.status === 'selected');
    if (companyFilter) rows = rows.filter(a => a.companyId === companyFilter);

    const { items, totalPages } = App.paginate(rows, page);
    const tbody = document.getElementById('shortlistedTableBody');
    if (!tbody) return;

    tbody.innerHTML = items.length ? items.map(a => {
      const drive = data.drives.find(d => d.companyId === a.companyId);
      return `
      <tr data-searchable>
        <td>${a.studentName}<br><small class="text-muted">${a.studentId}</small></td>
        <td>${a.jobTitle}</td>
        <td>${a.companyName}</td>
        <td>${drive ? App.formatDate(drive.date) : '—'}</td>
        <td>${a.interviewDate ? App.formatDate(a.interviewDate) : '—'}</td>
        <td>${App.getStatusBadge(a.status)}</td>
      </tr>`;
    }).join('') : `<tr><td colspan="6" class="text-center text-muted py-4">No shortlisted students found.</td></tr>`;

    App.renderPagination('shortlistedTableBodyPagination', totalPages, page, (p) => Tpo.renderShortlistedTable(p));
  },

  /* ===================== Interview Schedule =====================
     Reads/writes the SAME shared `data.interviews` entity (interviewId,
     applicationId, studentId, companyId, jobId, date, time, venue, mode,
     status) that the Company panel uses, so TPO / Company / Student all
     see identical interview records. */
  renderInterviewTable(page = 1) {
    const data = getData();
    const statusFilterEl = document.getElementById('interviewStatusFilter');
    const statusFilter = statusFilterEl ? statusFilterEl.value : '';

    let rows = data.interviews.slice();
    if (statusFilter === 'scheduled') rows = rows.filter(i => i.status === 'Scheduled' || i.status === 'Rescheduled');
    else if (statusFilter === 'completed') rows = rows.filter(i => i.status === 'Completed');
    rows.sort((x, y) => new Date(x.date || 0) - new Date(y.date || 0));

    const { items, totalPages } = App.paginate(rows, page);
    const tbody = document.getElementById('interviewTableBody');
    if (!tbody) return;

    tbody.innerHTML = items.length ? items.map(i => `
      <tr data-searchable>
        <td>${i.studentName}<br><small class="text-muted">${i.studentId}</small></td>
        <td>${i.companyName}</td>
        <td>${i.jobTitle}</td>
        <td>${i.date ? App.formatDate(i.date) : '—'}</td>
        <td>${i.time || '—'}</td>
        <td>${i.venue || '—'} <small class="text-muted">(${i.mode || 'Not specified'})</small></td>
        <td>${App.getStatusBadge(i.status === 'Completed' ? 'approved' : (i.status === 'Cancelled' ? 'rejected' : 'upcoming'))}</td>
      </tr>`).join('') : `<tr><td colspan="7" class="text-center text-muted py-4">No interviews scheduled.</td></tr>`;

    App.renderPagination('interviewTableBodyPagination', totalPages, page, (p) => Tpo.renderInterviewTable(p));
  },

  /* Populate the "candidate" dropdown in the Schedule Interview modal with only
     shortlisted applications — interviews cannot be booked for anyone else. */
  populateInterviewCandidateDropdown(elementId) {
    const el = document.getElementById(elementId);
    if (!el) return;
    const data = getData();
    const shortlisted = data.applications.filter(a => a.status === 'shortlisted');
    el.innerHTML = '<option value="">Select a shortlisted candidate</option>' +
      shortlisted.map(a => `<option value="${a.id}">${a.studentName} — ${a.jobTitle} (${a.companyName})</option>`).join('');
  },

  openScheduleInterviewModal() {
    const form = document.getElementById('tpoInterviewForm');
    if (form) form.reset();
    Tpo.populateInterviewCandidateDropdown('tpoInterviewApplication');
    new bootstrap.Modal(document.getElementById('tpoInterviewModal')).show();
  },

  /* TPO-side interview scheduling. Enforces: only shortlisted students may be
     interviewed. Writes into the shared interviews collection AND keeps the
     application record's mirrored fields in sync (same pattern company.js uses). */
  scheduleInterviewTpo() {
    const appEl = document.getElementById('tpoInterviewApplication');
    const dateEl = document.getElementById('tpoInterviewDate');
    const timeEl = document.getElementById('tpoInterviewTime');
    const modeEl = document.getElementById('tpoInterviewMode');
    const venueEl = document.getElementById('tpoInterviewVenue');

    const applicationId = appEl?.value;
    const date = dateEl?.value;
    if (!applicationId || !date) {
      App.showToast('Please select a candidate and an interview date', 'error');
      return;
    }

    const data = getData();
    const app = data.applications.find(a => a.id === applicationId);
    if (!app) { App.showToast('Application not found', 'error'); return; }
    if (app.status !== 'shortlisted') {
      App.showToast('Only shortlisted students can be scheduled for an interview', 'error');
      return;
    }

    const fields = {
      round: 'Round 1',
      date,
      time: timeEl?.value || '',
      mode: modeEl?.value || 'Offline',
      venue: venueEl?.value?.trim() || '',
      interviewer: 'TPO / Placement Cell',
      remarks: '',
      status: 'Scheduled'
    };

    const interview = {
      id: generateId('INT'),
      applicationId: app.id,
      studentId: app.studentId,
      studentName: app.studentName,
      jobId: app.jobId,
      jobTitle: app.jobTitle,
      companyId: app.companyId,
      companyName: app.companyName,
      ...fields
    };
    data.interviews.push(interview);

    // Mirror onto the application so it stays consistent with what the
    // Company/Student panels read directly off the application record.
    app.interviewDate = date;
    app.interviewRound = fields.round;
    app.interviewTime = fields.time;
    app.interviewMode = fields.mode;
    app.interviewVenue = fields.venue;
    app.interviewer = fields.interviewer;
    app.interviewStatus = 'scheduled';

    saveData(data);
    addActivity('Interview Scheduled', `${app.studentName}'s interview for ${app.jobTitle} at ${app.companyName} scheduled`);
    addNotification(app.studentId, 'student', 'Interview Scheduled', `Your interview for ${app.jobTitle} at ${app.companyName} is on ${App.formatDate(date)}${fields.time ? ' at ' + fields.time : ''}.`);
    addNotification(app.companyId, 'company', 'Interview Scheduled', `TPO has scheduled an interview with ${app.studentName} for ${app.jobTitle} on ${App.formatDate(date)}.`);

    bootstrap.Modal.getInstance(document.getElementById('tpoInterviewModal'))?.hide();
    Tpo.renderInterviewTable();
    App.showToast('Interview scheduled');
  },

  /* ===================== Selected Students ===================== */
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

  /* ===================== Placed Students =====================
     Selection (status='selected') and final Placement are kept as two
     distinct steps, matching the workflow: TPO/Company select a student,
     then TPO formally confirms the placement, which creates a stable
     placementId record (placementId, applicationId, studentId, companyId,
     jobId, placementDate, status). Confirmed placements are the source of
     truth for this table; students.placed continues to be kept true from
     the moment they're selected (existing behaviour, used elsewhere in the
     app) but the placement record + "Confirmed" badge is what represents
     the TPO's official placement confirmation. */
  renderPlacedTable(page = 1) {
    const data = getData();
    const branchFilterEl = document.getElementById('placedBranchFilter');
    const branchFilter = branchFilterEl ? branchFilterEl.value : '';

    let placedStudents = data.students.filter(s => s.placed);
    if (branchFilter) placedStudents = placedStudents.filter(s => s.branch === branchFilter);

    const rows = placedStudents.map(s => {
      const app = data.applications.find(a => a.studentId === s.id && a.status === 'selected');
      const job = app ? data.jobs.find(j => j.id === app.jobId) : null;
      const placement = app ? data.placements.find(p => p.applicationId === app.id) : null;
      return { student: s, app, job, placement };
    });

    const { items, totalPages } = App.paginate(rows, page);
    const tbody = document.getElementById('placedTableBody');
    if (!tbody) return;

    tbody.innerHTML = items.length ? items.map(r => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(r.student.name)}</span> ${r.student.name}</td>
        <td>${r.student.branch}</td>
        <td>${r.student.company || '—'}</td>
        <td>${r.job ? r.job.title : (r.app ? r.app.jobTitle : '—')}</td>
        <td>${r.job ? r.job.salary : '—'}</td>
        <td>${r.app ? App.formatDate(r.app.appliedAt) : '—'}</td>
        <td>${r.placement
            ? `<span class="badge badge-status badge-approved">Confirmed</span> <div class="small text-muted">${App.formatDate(r.placement.placementDate)}</div>`
            : (r.app
                ? `<button class="btn btn-sm btn-primary-custom" onclick="Tpo.confirmPlacement('${r.app.id}')">Confirm Placement</button>`
                : App.getStatusBadge('pending'))}
        </td>
      </tr>`).join('') : `<tr><td colspan="7" class="text-center text-muted py-4">No placed students yet.</td></tr>`;

    App.renderPagination('placedTableBodyPagination', totalPages, page, (p) => Tpo.renderPlacedTable(p));

    const countEl = document.getElementById('placedCount');
    if (countEl) countEl.textContent = placedStudents.length;
  },

  /* TPO confirms the final placement for a selected student, creating the
     canonical placementId record. Guards: application must be 'selected',
     and a placement can only be confirmed once per application. */
  confirmPlacement(applicationId) {
    const data = getData();
    const app = data.applications.find(a => a.id === applicationId);
    if (!app) { App.showToast('Application not found', 'error'); return; }
    if (app.status !== 'selected') {
      App.showToast('Placement can only be confirmed after the student is selected', 'error');
      return;
    }
    if (data.placements.some(p => p.applicationId === applicationId)) {
      App.showToast('This placement has already been confirmed', 'warning');
      return;
    }

    const placement = {
      id: generateId('PLC'),
      applicationId: app.id,
      studentId: app.studentId,
      companyId: app.companyId,
      jobId: app.jobId,
      placementDate: new Date().toISOString().split('T')[0],
      status: 'confirmed'
    };
    data.placements.push(placement);

    const student = data.students.find(s => s.id === app.studentId);
    if (student) { student.placed = true; student.company = app.companyName; }

    saveData(data);
    addActivity('Placement Confirmed', `${app.studentName}'s placement at ${app.companyName} confirmed`);
    addNotification(app.studentId, 'student', 'Placement Confirmed', `Congratulations! Your placement at ${app.companyName} for ${app.jobTitle} has been officially confirmed by the Placement Cell.`);
    addNotification(app.companyId, 'company', 'Placement Confirmed', `The placement of ${app.studentName} for ${app.jobTitle} has been confirmed by the TPO.`);

    Tpo.renderPlacedTable();
    App.showToast('Placement confirmed');
  },

  /* Populate branch filter dropdown from the current student list. */
  populateBranchDropdown(elementId) {
    const el = document.getElementById(elementId);
    if (!el) return;
    const data = getData();
    const branches = [...new Set(data.students.map(s => s.branch))].sort();
    const current = el.value;
    el.innerHTML = '<option value="">All Branches</option>' + branches.map(b => `<option value="${b}">${b}</option>`).join('');
    if (current) el.value = current;
  },

  /* ===================== Placement History =====================
     Sourced from the confirmed `data.placements` records (placementId,
     applicationId, studentId, companyId, jobId, placementDate, status) —
     i.e. only placements TPO has formally confirmed, not every "selected"
     application. */
  renderPlacementHistoryTable(page = 1) {
    const data = getData();
    const confirmed = data.placements.filter(p => p.status === 'confirmed');

    const enriched = confirmed.map(p => {
      const student = data.students.find(s => s.id === p.studentId);
      const app = data.applications.find(a => a.id === p.applicationId);
      const job = data.jobs.find(j => j.id === p.jobId);
      const year = (p.placementDate || '').slice(0, 4) || (student ? student.year : '') || 'Unknown';
      return { placement: p, student, app, job, year };
    });

    const years = [...new Set(enriched.map(e => e.year))].sort();
    const rows = years.map(year => {
      const entries = enriched.filter(e => e.year === year);
      const companies = new Set(entries.map(e => e.student?.company || e.app?.companyName).filter(Boolean));
      let highest = 0, lowest = 0, total = 0, count = 0;
      entries.forEach(e => {
        const match = e.job && e.job.salary && e.job.salary.match(/(\d+)/g);
        if (match) {
          const lpa = Math.max(...match.map(Number));
          highest = Math.max(highest, lpa);
          lowest = count ? Math.min(lowest, lpa) : lpa;
          total += lpa;
          count++;
        }
      });
      return {
        year,
        placed: entries.length,
        companies: companies.size,
        highest: highest ? `₹${highest} LPA` : '—',
        lowest: count ? `₹${lowest} LPA` : '—',
        average: count ? `₹${(total / count).toFixed(1)} LPA` : '—'
      };
    }).reverse();

    const { items, totalPages } = App.paginate(rows, page);
    const tbody = document.getElementById('placementHistoryTableBody');
    if (!tbody) return;

    tbody.innerHTML = items.length ? items.map(r => `
      <tr>
        <td><strong>${r.year}</strong></td>
        <td>${r.placed}</td>
        <td>${r.companies}</td>
        <td>${r.highest}</td>
        <td>${r.lowest}</td>
        <td>${r.average}</td>
      </tr>`).join('') : `<tr><td colspan="6" class="text-center text-muted py-4">No confirmed placements yet.</td></tr>`;

    App.renderPagination('placementHistoryTableBodyPagination', totalPages, page, (p) => Tpo.renderPlacementHistoryTable(p));
  },

  /* ===================== Company-wise Reports ===================== */
  renderCompanyWiseReports(page = 1) {
    const data = getData();
    const rows = data.companies.map(c => {
      const drives = data.drives.filter(d => d.companyId === c.id);
      const apps = data.applications.filter(a => a.companyId === c.id);
      const shortlisted = apps.filter(a => a.status === 'shortlisted' || a.status === 'selected');
      const placedApps = apps.filter(a => a.status === 'selected');

      let total = 0, count = 0;
      placedApps.forEach(a => {
        const job = data.jobs.find(j => j.id === a.jobId);
        const match = job && job.salary && job.salary.match(/(\d+)/g);
        if (match) { total += Math.max(...match.map(Number)); count++; }
      });

      return {
        company: c,
        drives: drives.length,
        applied: apps.length,
        shortlisted: shortlisted.length,
        placed: placedApps.length,
        avgPackage: count ? `₹${(total / count).toFixed(1)} LPA` : '—'
      };
    });

    const { items, totalPages } = App.paginate(rows, page);
    const tbody = document.getElementById('reportsCompanyTableBody');
    if (!tbody) return;

    tbody.innerHTML = items.length ? items.map(r => `
      <tr data-searchable>
        <td><strong>${r.company.name}</strong><br><small class="text-muted">${r.company.industry}</small></td>
        <td>${r.drives}</td>
        <td>${r.applied}</td>
        <td>${r.shortlisted}</td>
        <td>${r.placed}</td>
        <td>${r.avgPackage}</td>
      </tr>`).join('') : `<tr><td colspan="6" class="text-center text-muted py-4">No company data yet.</td></tr>`;

    App.renderPagination('reportsCompanyTableBodyPagination', totalPages, page, (p) => Tpo.renderCompanyWiseReports(p));
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
          <button class="btn-icon danger" onclick="Tpo.deleteNotice('${n.id}')" title="Delete"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('');
    App.renderPagination('noticesPagination', totalPages, page, (p) => Tpo.renderNoticesTable(p));
  },
  deleteNotice(id) {
    if (!confirm('Delete this notice?')) return;
    const data = getData();
    data.notices = data.notices.filter(n => n.id !== id);
    saveData(data);
    Tpo.renderNoticesTable();
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
    Tpo.renderNoticesTable();
    App.showToast('Notice published');
    addActivity('Notice Published', noticeData.title);
  },

  /* ===================== Notifications ===================== */
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
    App.renderPagination('notificationsTableBodyPagination', totalPages, page, (p) => Tpo.renderNotificationsTable(p));
  },
  saveNotification() {
    const form = document.getElementById('notificationForm');
    if (!App.validateForm(form)) return;
    const recipient = document.getElementById('notificationRecipient').value;
    addNotification('all', recipient, document.getElementById('notificationTitle').value, document.getElementById('notificationMessage').value);
    bootstrap.Modal.getInstance(document.getElementById('notificationModal'))?.hide();
    Tpo.renderNotificationsTable();
    App.showToast('Notification sent');
  },

  /* ===================== Settings / Change Password ===================== */
  changePassword() {
    const form = document.getElementById('passwordForm');
    if (!App.validateForm(form)) return;
    const current = document.getElementById('currentPassword').value;
    const newPass = document.getElementById('newPassword').value;
    const confirm = document.getElementById('confirmPassword').value;

    const data = getData();
    const officer = data.tpoOfficers && data.tpoOfficers[0];
    if (!officer) {
      App.showToast('Unable to locate your TPO account', 'error');
      return;
    }
    if (officer.password !== current) {
      App.showToast('Current password is incorrect', 'error');
      return;
    }
    if (newPass !== confirm) {
      App.showToast('Passwords do not match', 'error');
      return;
    }
    officer.password = newPass;
    saveData(data);
    App.showToast('Password changed successfully');
    form.reset();
  }
};
