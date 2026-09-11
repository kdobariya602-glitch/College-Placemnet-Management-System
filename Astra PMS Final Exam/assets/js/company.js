/**
 * Company Module JavaScript
 * Uses the shared PMS data store (getData/saveData) so that every action
 * here is immediately visible to the TPO and Student panels through the
 * same records and IDs (companyId, jobId, applicationId, interviewId...).
 */

const Company = {
  // ---------------------------------------------------------------------
  // DASHBOARD
  // ---------------------------------------------------------------------
  initDashboard() {
    const user = App.currentUser;
    const data = getData();
    const myJobs = data.jobs.filter(j => j.companyId === user.id);
    const myApps = data.applications.filter(a => a.companyId === user.id);
    const myInterviews = data.interviews.filter(i => i.companyId === user.id);
    const shortlisted = myApps.filter(a => a.status === 'shortlisted');
    const selected = myApps.filter(a => a.status === 'selected');
    const rejected = myApps.filter(a => a.status === 'rejected');
    const pending = myApps.filter(a => a.status === 'pending');
    const activeJobs = myJobs.filter(j => j.status === 'active'); // 'active' == TPO-approved & live
    const pendingApprovalJobs = myJobs.filter(j => j.status === 'pending');
    const placed = selected.filter(a => a.offerStatus === 'Joined');

    const setText = (id, val) => { const el = document.getElementById(id); if (el) el.textContent = val; };

    setText('statJobs', myJobs.length);
    setText('statApplications', myApps.length);
    setText('statShortlisted', shortlisted.length);
    setText('statSelected', selected.length);
    setText('statRejected', rejected.length);
    setText('statActiveJobs', activeJobs.length);
    setText('statPendingApproval', pendingApprovalJobs.length);
    setText('statHired', selected.length);
    setText('statPlaced', placed.length);
    setText('statInterviews', myInterviews.filter(i => i.status === 'Scheduled' || i.status === 'Rescheduled').length);

    const recentEl = document.getElementById('recentApplications');
    if (recentEl) {
      recentEl.innerHTML = myApps.slice(-5).reverse().map(a => `
        <div class="activity-item">
          <div class="activity-icon stat-icon blue"><i class="bi bi-person"></i></div>
          <div class="activity-content">
            <h6>${a.studentName}</h6>
            <p>Applied for ${a.jobTitle}</p>
            <span class="time">${App.formatDate(a.appliedAt)} • ${App.getStatusBadge(a.status)}</span>
          </div>
        </div>`).join('') || '<p class="text-muted">No applications yet</p>';
    }

    const recentJobsEl = document.getElementById('recentJobs');
    if (recentJobsEl) {
      recentJobsEl.innerHTML = myJobs.slice(-5).reverse().map(j => `
        <div class="activity-item">
          <div class="activity-icon stat-icon purple"><i class="bi bi-briefcase"></i></div>
          <div class="activity-content">
            <h6>${j.title}</h6>
            <p>${j.location} • ${j.openings} opening(s)</p>
            <span class="time">${App.formatDate(j.postedAt)} • ${App.getStatusBadge(j.status)}</span>
          </div>
        </div>`).join('') || '<p class="text-muted">No jobs posted yet</p>';
    }

    const upcomingEl = document.getElementById('upcomingInterviews');
    if (upcomingEl) {
      const today = new Date().toISOString().split('T')[0];
      const upcoming = myInterviews
        .filter(i => i.date && i.date >= today && i.status !== 'Cancelled' && i.status !== 'Completed')
        .sort((a, b) => new Date(a.date) - new Date(b.date));
      upcomingEl.innerHTML = upcoming.slice(0, 5).map(i => `
        <div class="activity-item">
          <div class="activity-icon stat-icon orange"><i class="bi bi-calendar-event"></i></div>
          <div class="activity-content">
            <h6>${i.studentName}</h6>
            <p>${i.jobTitle} • ${i.round || 'Round 1'}</p>
            <span class="time">${App.formatDate(i.date)}${i.time ? ' • ' + i.time : ''} • ${App.getStatusBadge(i.status)}</span>
          </div>
        </div>`).join('') || '<p class="text-muted">No upcoming interviews</p>';
    }

    const recentSelectionsEl = document.getElementById('recentSelections');
    if (recentSelectionsEl) {
      recentSelectionsEl.innerHTML = selected.slice(-5).reverse().map(a => `
        <div class="activity-item">
          <div class="activity-icon stat-icon green"><i class="bi bi-trophy"></i></div>
          <div class="activity-content">
            <h6>${a.studentName}</h6>
            <p>Selected for ${a.jobTitle}</p>
            <span class="time">${App.formatDate(a.selectionDate || a.appliedAt)} • ${App.getStatusBadge(a.offerStatus || 'selected')}</span>
          </div>
        </div>`).join('') || '<p class="text-muted">No selections yet</p>';
    }

    const statusOverviewEl = document.getElementById('statusOverview');
    if (statusOverviewEl) {
      const total = myApps.length || 1;
      const rows = [
        { label: 'Pending', count: pending.length, color: 'orange' },
        { label: 'Shortlisted', count: shortlisted.length, color: 'purple' },
        { label: 'Selected', count: selected.length, color: 'green' },
        { label: 'Rejected', count: rejected.length, color: 'red' }
      ];
      statusOverviewEl.innerHTML = rows.map(r => `
        <div class="mb-2">
          <div class="d-flex justify-content-between small mb-1"><span>${r.label}</span><span>${r.count}</span></div>
          <div class="progress" style="height:6px"><div class="progress-bar bg-${r.color === 'orange' ? 'warning' : r.color === 'purple' ? 'info' : r.color === 'green' ? 'success' : 'danger'}" style="width:${Math.round((r.count / total) * 100)}%"></div></div>
        </div>`).join('');
    }

    const hiringOverviewEl = document.getElementById('hiringOverview');
    if (hiringOverviewEl) {
      const conversionRate = myApps.length ? Math.round((selected.length / myApps.length) * 100) : 0;
      hiringOverviewEl.innerHTML = `
        <div class="row g-2 text-center">
          <div class="col-4"><div class="fs-5 fw-bold">${myJobs.length}</div><div class="small text-muted">Jobs Posted</div></div>
          <div class="col-4"><div class="fs-5 fw-bold">${myApps.length}</div><div class="small text-muted">Applicants</div></div>
          <div class="col-4"><div class="fs-5 fw-bold">${conversionRate}%</div><div class="small text-muted">Hire Rate</div></div>
        </div>`;
    }
  },

  // ---------------------------------------------------------------------
  // REGISTRATION (kept for compatibility - register.aspx currently posts
  // directly to SQL Server via code-behind, so this is not wired there)
  // ---------------------------------------------------------------------
  register() {
    const form = document.getElementById('registerForm');
    if (!App.validateForm(form)) return;

    const data = getData();
    const email = document.getElementById('email').value;
    if (data.companies.find(c => c.email === email)) {
      App.showToast('Email already registered', 'error');
      return;
    }

    data.companies.push({
      id: generateId('COM'),
      name: document.getElementById('companyName').value,
      email,
      password: document.getElementById('password').value,
      industry: document.getElementById('industry').value,
      website: document.getElementById('website').value,
      location: document.getElementById('location').value,
      contact: document.getElementById('contact').value,
      description: document.getElementById('description').value,
      status: 'active',
      registeredAt: new Date().toISOString().split('T')[0]
    });
    saveData(data);
    addActivity('Company Registered', document.getElementById('companyName').value + ' joined');
    App.showToast('Registration successful!');
    setTimeout(() => window.location.href = 'login.aspx', 1500);
  },

  // ---------------------------------------------------------------------
  // PROFILE
  // ---------------------------------------------------------------------
  renderProfile() {
    const user = App.currentUser;
    document.getElementById('profileName').textContent = user.name;
    document.getElementById('profileId').textContent = user.id;
    document.getElementById('profileAvatar').textContent = App.getInitials(user.name);
    document.getElementById('infoEmail').textContent = user.email;
    document.getElementById('infoIndustry').textContent = user.industry;
    document.getElementById('infoWebsite').innerHTML = user.website ? `<a href="${user.website}" target="_blank">${user.website}</a>` : '—';
    document.getElementById('infoLocation').textContent = user.location;
    document.getElementById('infoContact').textContent = user.contact;
    document.getElementById('infoDescription').textContent = user.description || '—';
    document.getElementById('infoStatus').innerHTML = App.getStatusBadge(user.status);
  },

  openEditProfile() {
    const user = App.currentUser;
    document.getElementById('editCompanyName').value = user.name || '';
    document.getElementById('editEmail').value = user.email || '';
    document.getElementById('editContact').value = user.contact || '';
    document.getElementById('editWebsite').value = user.website || '';
    document.getElementById('editLocation').value = user.location || '';
    document.getElementById('editIndustry').value = user.industry || '';
    document.getElementById('editDescription').value = user.description || '';
  },

  saveProfile() {
    const form = document.getElementById('editProfileForm');
    if (!App.validateForm(form)) return;

    const user = App.currentUser;
    const data = getData();
    const company = data.companies.find(c => c.id === user.id);
    if (!company) { App.showToast('Company record not found', 'error'); return; }

    const newEmail = document.getElementById('editEmail').value.trim();
    if (newEmail !== company.email && data.companies.find(c => c.email === newEmail)) {
      App.showToast('Email already in use by another company', 'error');
      return;
    }

    company.name = document.getElementById('editCompanyName').value.trim();
    company.email = newEmail;
    company.contact = document.getElementById('editContact').value.trim();
    company.website = document.getElementById('editWebsite').value.trim();
    company.location = document.getElementById('editLocation').value.trim();
    company.industry = document.getElementById('editIndustry').value.trim();
    company.description = document.getElementById('editDescription').value.trim();

    // keep companyName in sync on jobs/applications/interviews so display stays correct
    data.jobs.forEach(j => { if (j.companyId === company.id) j.companyName = company.name; });
    data.applications.forEach(a => { if (a.companyId === company.id) a.companyName = company.name; });
    data.interviews.forEach(i => { if (i.companyId === company.id) i.companyName = company.name; });

    saveData(data);
    App.setSession(company);
    Company.renderProfile();
    bootstrap.Modal.getInstance(document.getElementById('editProfileModal'))?.hide();
    App.showToast('Profile updated successfully');
  },

  // ---------------------------------------------------------------------
  // POST JOB / MANAGE JOBS
  // ---------------------------------------------------------------------
  getEditJobId() {
    return new URLSearchParams(window.location.search).get('id');
  },

  initPostJobPage() {
    const jobId = Company.getEditJobId();
    if (!jobId) return;

    const user = App.currentUser;
    const data = getData();
    const job = data.jobs.find(j => j.id === jobId && j.companyId === user.id);
    if (!job) { window.location.href = 'manage-jobs.aspx'; return; }

    document.getElementById('jobTitle').value = job.title;
    document.getElementById('jobType').value = job.type;
    document.getElementById('jobLocation').value = job.location;
    document.getElementById('jobSalary').value = job.salary;
    document.getElementById('jobCgpa').value = job.cgpaMin;
    document.getElementById('jobOpenings').value = job.openings;
    document.getElementById('jobBranches').value = (job.branches || []).join(', ');
    document.getElementById('jobSkills').value = (job.skills || []).join(', ');
    document.getElementById('jobDescription').value = job.description;
    document.getElementById('jobDeadline').value = job.deadline;
    const qualEl = document.getElementById('jobQualification');
    if (qualEl) qualEl.value = job.qualification || '';
    const statusEl = document.getElementById('jobStatus');
    // Only "draft" is company-selectable; anything else (pending/active/rejected)
    // is controlled by the TPO approval workflow, so default the control to draft
    // unless the job is currently a draft, and show the real status as read-only text.
    if (statusEl) statusEl.value = job.status === 'draft' ? 'draft' : 'pending';
    const currentStatusEl = document.getElementById('jobCurrentStatus');
    if (currentStatusEl) currentStatusEl.innerHTML = Company.jobStatusBadge(job.status);

    const heading = document.querySelector('.page-breadcrumb h4');
    if (heading) heading.textContent = 'Edit Job';
    const btn = document.getElementById('postJobBtn');
    if (btn) btn.value = 'Update Job';
  },

  // ---------------------------------------------------------------------
  // Job status display helper (company-facing labels):
  // draft -> Draft, pending -> Pending TPO Approval, active -> Approved,
  // rejected -> Rejected, closed -> Closed.
  // ---------------------------------------------------------------------
  jobStatusBadge(status) {
    const labels = { draft: 'Draft', pending: 'Pending TPO Approval', active: 'Approved', rejected: 'Rejected', closed: 'Closed' };
    const cls = { draft: 'badge-pending', pending: 'badge-pending', active: 'badge-approved', rejected: 'badge-rejected', closed: 'badge-closed' };
    const key = String(status || '').toLowerCase();
    return `<span class="badge badge-status ${cls[key] || 'badge-pending'}">${labels[key] || status}</span>`;
  },

  postJob() {
    const form = document.getElementById('postJobForm');
    if (!App.validateForm(form)) return;

    const user = App.currentUser;
    const data = getData();
    const editId = Company.getEditJobId();

    const qualEl = document.getElementById('jobQualification');
    const statusEl = document.getElementById('jobStatus');
    // Company can only choose to "Save as Draft" or "Submit for TPO Approval".
    // A job never goes live ('active') directly from the company panel.
    const wantsDraft = statusEl && statusEl.value === 'draft';

    const fields = {
      title: document.getElementById('jobTitle').value,
      type: document.getElementById('jobType').value,
      location: document.getElementById('jobLocation').value,
      salary: document.getElementById('jobSalary').value,
      cgpaMin: parseFloat(document.getElementById('jobCgpa').value),
      branches: document.getElementById('jobBranches').value.split(',').map(b => b.trim()).filter(Boolean),
      skills: document.getElementById('jobSkills').value.split(',').map(s => s.trim()).filter(Boolean),
      description: document.getElementById('jobDescription').value,
      deadline: document.getElementById('jobDeadline').value,
      openings: parseInt(document.getElementById('jobOpenings').value) || 1,
      qualification: qualEl ? qualEl.value.trim() : ''
    };

    if (editId) {
      const job = data.jobs.find(j => j.id === editId && j.companyId === user.id);
      if (!job) { App.showToast('Job not found', 'error'); return; }
      Object.assign(job, fields);
      // Re-editing and resubmitting a job always sends it back through TPO approval,
      // unless the company is deliberately keeping it as a draft.
      job.status = wantsDraft ? 'draft' : 'pending';
      job.approvalRemarks = '';
      saveData(data);
      addActivity('Job Updated', `${user.name} updated ${fields.title}`);
      if (!wantsDraft) {
        addNotification('admin1', 'admin', 'Job Resubmitted', `${user.name} resubmitted "${fields.title}" for approval.`);
      }
      App.showToast(wantsDraft ? 'Job saved as draft' : 'Job updated and resubmitted for TPO approval!');
    } else {
      const newJob = {
        id: generateId('JOB'),
        companyId: user.id,
        companyName: user.name,
        status: wantsDraft ? 'draft' : 'pending',
        postedAt: new Date().toISOString().split('T')[0],
        ...fields
      };
      data.jobs.push(newJob);
      saveData(data);
      // Job is visible to TPO immediately (for approval) via the shared jobs array,
      // but is NOT shown to students until TPO approves it (status becomes 'active').
      addActivity('New Job Posted', `${user.name} posted ${fields.title}`);
      if (!wantsDraft) {
        addNotification('admin1', 'admin', 'New Job Pending Approval', `${user.name} submitted a new job for approval: ${fields.title}`);
      }
      App.showToast(wantsDraft ? 'Job saved as draft' : 'Job submitted for TPO approval!');
    }
    setTimeout(() => window.location.href = 'manage-jobs.aspx', 1200);
  },

  _jobsFilterState: { search: '', status: '', sort: 'newest' },

  renderManageJobs() {
    const user = App.currentUser;
    const data = getData();
    let jobs = data.jobs.filter(j => j.companyId === user.id);

    const state = Company._jobsFilterState;
    if (state.search) {
      const q = state.search.toLowerCase();
      jobs = jobs.filter(j => (j.title + ' ' + j.location + ' ' + j.type).toLowerCase().includes(q));
    }
    if (state.status) jobs = jobs.filter(j => j.status === state.status);

    jobs = jobs.slice().sort((a, b) => {
      if (state.sort === 'oldest') return new Date(a.postedAt || 0) - new Date(b.postedAt || 0);
      if (state.sort === 'title') return a.title.localeCompare(b.title);
      if (state.sort === 'deadline') return new Date(a.deadline || 0) - new Date(b.deadline || 0);
      return new Date(b.postedAt || 0) - new Date(a.postedAt || 0); // newest
    });

    const tbody = document.getElementById('jobsTableBody');
    if (!tbody) return;

    tbody.innerHTML = jobs.map(j => `
      <tr data-searchable>
        <td><strong>${j.title}</strong></td>
        <td>${j.type}</td>
        <td>${j.location}</td>
        <td>${j.salary}</td>
        <td>${data.applications.filter(a => a.jobId === j.id).length}</td>
        <td>${Company.jobStatusBadge(j.status)}</td>
        <td>
          <button class="btn-icon me-1" title="View Job" onclick="Company.viewJob('${j.id}')"><i class="bi bi-eye"></i></button>
          <a href="post-job.aspx?id=${j.id}" class="btn-icon me-1" title="Edit Job"><i class="bi bi-pencil"></i></a>
          ${(j.status === 'active' || j.status === 'closed') ? `<button class="btn-icon me-1" onclick="Company.toggleJobStatus('${j.id}')" title="${j.status === 'active' ? 'Close Job' : 'Reopen Job'}"><i class="bi bi-toggle-${j.status === 'active' ? 'on' : 'off'}"></i></button>` : ''}
          <button class="btn-icon danger" onclick="Company.deleteJob('${j.id}')" title="Delete Job"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('') || '<tr><td colspan="7" class="text-center text-muted py-4">No jobs posted</td></tr>';
  },

  initManageJobsFilters() {
    const searchEl = document.getElementById('jobSearchInput');
    const statusEl = document.getElementById('jobStatusFilter');
    const sortEl = document.getElementById('jobSortSelect');
    if (searchEl) searchEl.addEventListener('input', () => { Company._jobsFilterState.search = searchEl.value.trim(); Company.renderManageJobs(); });
    if (statusEl) statusEl.addEventListener('change', () => { Company._jobsFilterState.status = statusEl.value; Company.renderManageJobs(); });
    if (sortEl) sortEl.addEventListener('change', () => { Company._jobsFilterState.sort = sortEl.value; Company.renderManageJobs(); });
  },

  viewJob(id) {
    const data = getData();
    const job = data.jobs.find(j => j.id === id);
    if (!job) return;
    const body = document.getElementById('viewJobModalBody');
    if (body) {
      body.innerHTML = `
        <div class="mb-2"><strong>${job.title}</strong> ${Company.jobStatusBadge(job.status)}</div>
        <div class="small text-muted mb-3">${job.type} • ${job.location} • ${job.salary}</div>
        ${job.status === 'rejected' && job.approvalRemarks ? `<div class="alert alert-danger py-2 small mb-3"><strong>TPO remarks:</strong> ${job.approvalRemarks}</div>` : ''}
        <p>${job.description || '—'}</p>
        <div class="row g-2 small">
          <div class="col-6"><strong>Openings:</strong> ${job.openings}</div>
          <div class="col-6"><strong>Min CGPA:</strong> ${job.cgpaMin}</div>
          <div class="col-6"><strong>Qualification:</strong> ${job.qualification || '—'}</div>
          <div class="col-6"><strong>Deadline:</strong> ${App.formatDate(job.deadline)}</div>
          <div class="col-12"><strong>Eligible Branches:</strong> ${(job.branches || []).join(', ') || '—'}</div>
          <div class="col-12"><strong>Required Skills:</strong> ${(job.skills || []).join(', ') || '—'}</div>
          <div class="col-12"><strong>Applications:</strong> ${data.applications.filter(a => a.jobId === job.id).length}</div>
        </div>`;
    }
    const modalEl = document.getElementById('viewJobModal');
    if (modalEl) new bootstrap.Modal(modalEl).show();
  },

  toggleJobStatus(id) {
    const data = getData();
    const user = App.currentUser;
    const job = data.jobs.find(j => j.id === id && j.companyId === user.id);
    // Only an approved (active) job can be closed, and only a closed job can be reopened.
    // Draft / pending / rejected jobs must go through post-job.aspx + TPO approval instead.
    if (job && (job.status === 'active' || job.status === 'closed')) {
      job.status = job.status === 'active' ? 'closed' : 'active';
      saveData(data);
      Company.renderManageJobs();
      App.showToast(`Job ${job.status === 'active' ? 'reopened' : 'closed'}`);
    }
  },

  deleteJob(id) {
    App.confirmDelete('Delete this job?', () => {
      const data = getData();
      data.jobs = data.jobs.filter(j => j.id !== id);
      saveData(data);
      Company.renderManageJobs();
      App.showToast('Job deleted');
    });
  },

  // ---------------------------------------------------------------------
  // APPLICATIONS
  // ---------------------------------------------------------------------
  _appsFilterState: { job: '', branch: '' },

  renderApplications() {
    const user = App.currentUser;
    const data = getData();
    let apps = data.applications.filter(a => a.companyId === user.id);

    const state = Company._appsFilterState;
    if (state.job) apps = apps.filter(a => a.jobId === state.job);
    if (state.branch) {
      apps = apps.filter(a => {
        const student = data.students.find(s => s.id === a.studentId);
        return student && student.branch === state.branch;
      });
    }

    const tbody = document.getElementById('applicationsTableBody');
    if (!tbody) return;

    tbody.innerHTML = apps.map(a => {
      const student = data.students.find(s => s.id === a.studentId);
      return `
        <tr data-searchable>
          <td><span class="table-avatar">${App.getInitials(a.studentName)}</span></td>
          <td><strong>${a.studentName}</strong><br><small class="text-muted">${student?.branch || ''} • CGPA: ${student?.cgpa || '—'}</small></td>
          <td>${a.jobTitle}</td>
          <td data-filter="status" data-filter-value="${a.status}">${App.getStatusBadge(a.status)}</td>
          <td>${App.formatDate(a.appliedAt)}</td>
          <td>
            <a href="applicant-details.aspx?id=${a.id}" class="btn-icon me-1" title="View Details"><i class="bi bi-eye"></i></a>
            <select class="form-select form-select-sm d-inline-block" style="width:auto" onchange="Company.updateStatus('${a.id}', this.value)">
              <option value="">Action</option>
              <option value="pending">Mark Under Review</option>
              <option value="shortlisted">Shortlist</option>
              <option value="selected">Select</option>
              <option value="rejected">Reject</option>
            </select>
          </td>
        </tr>`;
    }).join('') || '<tr><td colspan="6" class="text-center text-muted py-4">No applications</td></tr>';

    App.filterTable('appStatusFilter', 'applicationsTableBody', 'status');
  },

  initApplicationsFilters() {
    const user = App.currentUser;
    const data = getData();
    const jobEl = document.getElementById('appJobFilter');
    const branchEl = document.getElementById('appBranchFilter');

    if (jobEl && !jobEl.dataset.bound) {
      const myJobs = data.jobs.filter(j => j.companyId === user.id);
      jobEl.innerHTML = '<option value="">All Jobs</option>' + myJobs.map(j => `<option value="${j.id}">${j.title}</option>`).join('');
      jobEl.addEventListener('change', () => { Company._appsFilterState.job = jobEl.value; Company.renderApplications(); });
      jobEl.dataset.bound = '1';
    }
    if (branchEl && !branchEl.dataset.bound) {
      const branches = [...new Set(data.students.map(s => s.branch))];
      branchEl.innerHTML = '<option value="">All Branches</option>' + branches.map(b => `<option value="${b}">${b}</option>`).join('');
      branchEl.addEventListener('change', () => { Company._appsFilterState.branch = branchEl.value; Company.renderApplications(); });
      branchEl.dataset.bound = '1';
    }
  },

  updateStatus(id, status) {
    if (!status) return;
    const data = getData();
    const app = data.applications.find(a => a.id === id);
    if (app) {
      const prevStatus = app.status;
      app.status = status;
      const today = new Date().toISOString().split('T')[0];

      if (status === 'selected') {
        app.selectionDate = today;
        if (!app.offerStatus) app.offerStatus = 'Selected';
        const student = data.students.find(s => s.id === app.studentId);
        if (student) { student.placed = true; student.company = app.companyName; }
        addNotification(app.studentId, 'student', 'Selected!', `You have been selected for ${app.jobTitle} at ${app.companyName}.`);
      } else if (status === 'rejected') {
        app.rejectedDate = today;
        addNotification(app.studentId, 'student', 'Application Update', `Your ${app.jobTitle} application was not successful this time.`);
      } else if (status === 'shortlisted') {
        addNotification(app.studentId, 'student', 'Shortlisted', `You have been shortlisted for ${app.jobTitle} at ${app.companyName}.`);
      } else {
        addNotification(app.studentId, 'student', 'Application Update', `Your ${app.jobTitle} application status is now ${status}.`);
      }

      // If moving away from 'selected', undo the placed flag on the student record
      if (prevStatus === 'selected' && status !== 'selected') {
        const student = data.students.find(s => s.id === app.studentId);
        if (student && student.company === app.companyName) { student.placed = false; student.company = null; }
        app.offerStatus = undefined;
      }

      saveData(data);
      Company.renderApplications();
      Company.renderShortlist?.();
      App.showToast('Status updated');
    }
  },

  // ---------------------------------------------------------------------
  // SHORTLIST
  // ---------------------------------------------------------------------
  renderShortlist() {
    const user = App.currentUser;
    const data = getData();
    const apps = data.applications.filter(a => a.companyId === user.id && a.status === 'shortlisted');
    const tbody = document.getElementById('shortlistTableBody');
    if (!tbody) return;

    tbody.innerHTML = apps.map(a => {
      const student = data.students.find(s => s.id === a.studentId);
      return `
        <tr data-searchable>
          <td><strong>${a.studentName}</strong></td>
          <td>${student?.branch || '—'}</td>
          <td>${student?.cgpa || '—'}</td>
          <td>${a.jobTitle}</td>
          <td>${a.interviewDate ? App.formatDate(a.interviewDate) : 'Not scheduled'}</td>
          <td>
            <a href="applicant-details.aspx?id=${a.id}" class="btn-icon me-1" title="View"><i class="bi bi-eye"></i></a>
            <button class="btn btn-sm btn-primary-custom me-1" onclick="Company.selectStudent('${a.id}')">Select</button>
            <button class="btn btn-sm btn-outline-custom" onclick="Company.removeFromShortlist('${a.id}')">Remove</button>
          </td>
        </tr>`;
    }).join('') || '<tr><td colspan="6" class="text-center text-muted py-4">No shortlisted students</td></tr>';
  },

  selectStudent(id) {
    Company.updateStatus(id, 'selected');
    Company.renderShortlist();
    App.showToast('Student selected!');
  },

  removeFromShortlist(id) {
    App.confirmDelete('Remove this student from the shortlist?', () => {
      Company.updateStatus(id, 'pending');
      Company.renderShortlist();
      App.showToast('Removed from shortlist');
    });
  },

  // ---------------------------------------------------------------------
  // SELECTED / REJECTED / PLACEMENT HISTORY
  // ---------------------------------------------------------------------
  _selectedFilterState: { job: '', branch: '' },

  renderSelected() {
    const user = App.currentUser;
    const data = getData();
    let apps = data.applications.filter(a => a.companyId === user.id && a.status === 'selected');

    const state = Company._selectedFilterState;
    if (state.job) apps = apps.filter(a => a.jobId === state.job);
    if (state.branch) {
      apps = apps.filter(a => {
        const student = data.students.find(s => s.id === a.studentId);
        return student && student.branch === state.branch;
      });
    }

    const tbody = document.getElementById('selectedTableBody');
    if (!tbody) return;

    tbody.innerHTML = apps.map(a => {
      const student = data.students.find(s => s.id === a.studentId);
      const job = data.jobs.find(j => j.id === a.jobId);
      return `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(a.studentName)}</span></td>
        <td><strong>${a.studentName}</strong><br><small class="text-muted">${student?.branch || ''} • ${student?.year || ''}</small></td>
        <td>${a.jobTitle}</td>
        <td>${job?.salary || '—'}</td>
        <td>${App.formatDate(a.selectionDate || a.appliedAt)}</td>
        <td>${a.joiningDate ? App.formatDate(a.joiningDate) : '—'}</td>
        <td>${App.getStatusBadge(a.offerStatus || 'Selected')}</td>
        <td>
          <button class="btn-icon me-1" title="View" onclick="window.location.href='applicant-details.aspx?id=${a.id}'"><i class="bi bi-eye"></i></button>
          <button class="btn-icon" title="Edit Offer" onclick="Company.openEditSelection('${a.id}')"><i class="bi bi-pencil"></i></button>
        </td>
      </tr>`;
    }).join('') || '<tr><td colspan="8" class="text-center text-muted py-4">No selected students</td></tr>';
  },

  initSelectedFilters() {
    const user = App.currentUser;
    const data = getData();
    const jobEl = document.getElementById('selectedJobFilter');
    const branchEl = document.getElementById('selectedBranchFilter');
    if (jobEl && !jobEl.dataset.bound) {
      const myJobs = data.jobs.filter(j => j.companyId === user.id);
      jobEl.innerHTML = '<option value="">All Jobs</option>' + myJobs.map(j => `<option value="${j.id}">${j.title}</option>`).join('');
      jobEl.addEventListener('change', () => { Company._selectedFilterState.job = jobEl.value; Company.renderSelected(); });
      jobEl.dataset.bound = '1';
    }
    if (branchEl && !branchEl.dataset.bound) {
      const branches = [...new Set(data.students.map(s => s.branch))];
      branchEl.innerHTML = '<option value="">All Branches</option>' + branches.map(b => `<option value="${b}">${b}</option>`).join('');
      branchEl.addEventListener('change', () => { Company._selectedFilterState.branch = branchEl.value; Company.renderSelected(); });
      branchEl.dataset.bound = '1';
    }
  },

  openEditSelection(id) {
    const data = getData();
    const app = data.applications.find(a => a.id === id);
    if (!app) return;
    document.getElementById('editSelectionAppId').value = app.id;
    document.getElementById('editOfferStatus').value = app.offerStatus || 'Selected';
    document.getElementById('editJoiningDate').value = app.joiningDate || '';
    new bootstrap.Modal(document.getElementById('editSelectionModal')).show();
  },

  saveSelectionEdit() {
    const id = document.getElementById('editSelectionAppId').value;
    const offerStatus = document.getElementById('editOfferStatus').value;
    const joiningDate = document.getElementById('editJoiningDate').value;
    const data = getData();
    const app = data.applications.find(a => a.id === id);
    if (app) {
      app.offerStatus = offerStatus;
      app.joiningDate = joiningDate || app.joiningDate;
      saveData(data);
      addNotification(app.studentId, 'student', 'Offer Update', `Your offer status for ${app.jobTitle} is now ${offerStatus}.`);
      Company.renderSelected();
      bootstrap.Modal.getInstance(document.getElementById('editSelectionModal'))?.hide();
      App.showToast('Selection details updated');
    }
  },

  renderRejected() {
    const user = App.currentUser;
    const data = getData();
    const apps = data.applications.filter(a => a.companyId === user.id && a.status === 'rejected');
    const tbody = document.getElementById('rejectedTableBody');
    if (!tbody) return;

    tbody.innerHTML = apps.map(a => {
      const student = data.students.find(s => s.id === a.studentId);
      const interview = data.interviews.filter(i => i.applicationId === a.id).sort((x, y) => new Date(y.date || 0) - new Date(x.date || 0))[0];
      return `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(a.studentName)}</span></td>
        <td><strong>${a.studentName}</strong></td>
        <td>${student?.branch || '—'}</td>
        <td>${a.jobTitle}</td>
        <td>${a.rejectedDate ? App.formatDate(a.rejectedDate) : '—'}</td>
        <td>${(interview && interview.remarks) || a.remarks || '—'}</td>
        <td>
          <a href="applicant-details.aspx?id=${a.id}" class="btn-icon" title="View"><i class="bi bi-eye"></i></a>
        </td>
      </tr>`;
    }).join('') || '<tr><td colspan="7" class="text-center text-muted py-4">No rejected students</td></tr>';
  },

  renderPlacementHistory() {
    const user = App.currentUser;
    const data = getData();
    const apps = data.applications
      .filter(a => a.companyId === user.id && a.status === 'selected')
      .sort((a, b) => new Date(b.selectionDate || b.appliedAt) - new Date(a.selectionDate || a.appliedAt));
    const tbody = document.getElementById('companyHistoryTableBody');
    if (!tbody) return;

    tbody.innerHTML = apps.map(a => {
      const student = data.students.find(s => s.id === a.studentId);
      const job = data.jobs.find(j => j.id === a.jobId);
      return `
      <tr data-searchable>
        <td><strong>${a.studentName}</strong></td>
        <td>${student?.branch || '—'}</td>
        <td>${student?.year || '—'}</td>
        <td>${a.jobTitle}</td>
        <td>${job?.salary || '—'}</td>
        <td>${App.formatDate(a.selectionDate || a.appliedAt)}</td>
        <td>${a.joiningDate ? App.formatDate(a.joiningDate) : '—'}</td>
        <td>${App.getStatusBadge(a.offerStatus || 'Selected')}</td>
      </tr>`;
    }).join('') || '<tr><td colspan="8" class="text-center text-muted py-4">No placement history yet</td></tr>';
  },

  // ---------------------------------------------------------------------
  // NOTIFICATIONS
  // ---------------------------------------------------------------------
  _notifFilterState: { type: '', unreadOnly: false },

  renderNotifications() {
    const user = App.currentUser;
    const data = getData();
    // Access control: a company must only see notifications addressed to itself,
    // never notifications meant for other companies.
    let notifs = data.notifications.filter(n => n.userId === user.id && n.userType === 'company');

    const state = Company._notifFilterState;
    if (state.unreadOnly) notifs = notifs.filter(n => !n.read);
    if (state.type) notifs = notifs.filter(n => n.title === state.type);

    const container = document.getElementById('notificationsList');
    if (!container) return;

    container.innerHTML = notifs.map(n => `
      <div class="activity-item ${n.read ? 'opacity-75' : ''}" data-searchable>
        <div class="activity-icon stat-icon ${n.read ? 'blue' : 'red'}"><i class="bi bi-bell"></i></div>
        <div class="activity-content flex-grow-1">
          <h6>${n.title} ${!n.read ? '<span class="badge bg-danger ms-1">New</span>' : ''}</h6>
          <p>${n.message}</p>
          <span class="time">${n.time}</span>
        </div>
        <div class="d-flex flex-column gap-1">
          ${!n.read ? `<button class="btn btn-sm btn-outline-custom" onclick="Company.markRead('${n.id}')">Mark Read</button>` : `<button class="btn btn-sm btn-outline-custom" onclick="Company.markUnread('${n.id}')">Mark Unread</button>`}
          <button class="btn btn-sm btn-outline-custom text-danger" onclick="Company.deleteNotification('${n.id}')">Delete</button>
        </div>
      </div>`).join('') || '<div class="empty-state"><i class="bi bi-bell"></i><p>No notifications</p></div>';
  },

  initNotificationFilters() {
    const typeEl = document.getElementById('notifTypeFilter');
    const unreadEl = document.getElementById('notifUnreadOnly');
    if (typeEl && !typeEl.dataset.bound) {
      typeEl.addEventListener('change', () => { Company._notifFilterState.type = typeEl.value; Company.renderNotifications(); });
      typeEl.dataset.bound = '1';
    }
    if (unreadEl && !unreadEl.dataset.bound) {
      unreadEl.addEventListener('change', () => { Company._notifFilterState.unreadOnly = unreadEl.checked; Company.renderNotifications(); });
      unreadEl.dataset.bound = '1';
    }
  },

  markRead(id) {
    const data = getData();
    const notif = data.notifications.find(n => n.id === id);
    if (notif) { notif.read = true; saveData(data); Company.renderNotifications(); }
  },

  markUnread(id) {
    const data = getData();
    const notif = data.notifications.find(n => n.id === id);
    if (notif) { notif.read = false; saveData(data); Company.renderNotifications(); }
  },

  deleteNotification(id) {
    const data = getData();
    data.notifications = data.notifications.filter(n => n.id !== id);
    saveData(data);
    Company.renderNotifications();
    App.showToast('Notification deleted');
  },

  // ---------------------------------------------------------------------
  // APPLICANT DETAILS
  // ---------------------------------------------------------------------
  loadApplicantDetails() {
    const params = new URLSearchParams(window.location.search);
    const appId = params.get('id');
    const data = getData();
    const user = App.currentUser;
    const app = data.applications.find(a => a.id === appId && a.companyId === user.id);
    if (!app) { window.location.href = 'applications.aspx'; return; }

    const student = data.students.find(s => s.id === app.studentId);
    const job = data.jobs.find(j => j.id === app.jobId);

    document.getElementById('applicantAvatar').textContent = App.getInitials(app.studentName);
    document.getElementById('applicantName').textContent = app.studentName;
    document.getElementById('applicantBranch').textContent = student?.branch || '—';
    document.getElementById('applicantStatusBadge').innerHTML = App.getStatusBadge(app.status);
    document.getElementById('applicantCgpa').textContent = student?.cgpa || '—';
    document.getElementById('applicantJob').textContent = app.jobTitle;
    document.getElementById('applicantAppliedDate').textContent = App.formatDate(app.appliedAt);
    document.getElementById('applicantInterviewDate').textContent = app.interviewDate ? App.formatDate(app.interviewDate) : 'Not scheduled';
    document.getElementById('applicantEmail').textContent = student?.email || '—';
    document.getElementById('applicantPhone').textContent = student?.phone || '—';
    document.getElementById('applicantYear').textContent = student?.year || '—';
    document.getElementById('applicantSkills').innerHTML = (student?.skills || []).map(s => `<span class="badge bg-light text-dark me-1">${s}</span>`).join('') || '—';

    const resumeEl = document.getElementById('applicantResume');
    if (resumeEl) {
      resumeEl.innerHTML = student?.resume
        ? `<a href="${student.resume}" target="_blank"><i class="bi bi-file-earmark-pdf me-1"></i>View Resume</a>`
        : '<span class="text-muted">Not uploaded</span>';
    }

    const eligibilityEl = document.getElementById('applicantEligibility');
    if (eligibilityEl && student && job) {
      const cgpaOk = (student.cgpa || 0) >= (job.cgpaMin || 0);
      const branchOk = !job.branches || job.branches.length === 0 || job.branches.includes(student.branch);
      const eligible = cgpaOk && branchOk;
      eligibilityEl.innerHTML = eligible
        ? '<span class="badge badge-status badge-active">Eligible</span>'
        : '<span class="badge badge-status badge-rejected">Not Fully Eligible</span>';
    }

    const historyEl = document.getElementById('applicantInterviewHistory');
    if (historyEl) {
      const rounds = data.interviews.filter(i => i.applicationId === app.id).sort((a, b) => new Date(a.date || 0) - new Date(b.date || 0));
      historyEl.innerHTML = rounds.length ? rounds.map(i => `
        <div class="activity-item">
          <div class="activity-icon stat-icon orange"><i class="bi bi-calendar-event"></i></div>
          <div class="activity-content">
            <h6>${i.round || 'Round'} • ${App.getStatusBadge(i.status)}</h6>
            <p>${App.formatDate(i.date)}${i.time ? ' • ' + i.time : ''} • ${i.mode || '—'} ${i.venue ? '• ' + i.venue : ''}</p>
            <span class="time">${i.interviewer ? 'Interviewer: ' + i.interviewer : ''} ${i.remarks ? '• ' + i.remarks : ''}</span>
          </div>
        </div>`).join('') : '<p class="text-muted">No interview rounds yet</p>';
    }

    const selectionEl = document.getElementById('applicantSelectionDetails');
    if (selectionEl) {
      if (app.status === 'selected') {
        selectionEl.innerHTML = `
          <div class="row g-2 small">
            <div class="col-6"><strong>Selection Date:</strong> ${App.formatDate(app.selectionDate || app.appliedAt)}</div>
            <div class="col-6"><strong>Offer Status:</strong> ${App.getStatusBadge(app.offerStatus || 'Selected')}</div>
            <div class="col-6"><strong>Joining Date:</strong> ${app.joiningDate ? App.formatDate(app.joiningDate) : '—'}</div>
            <div class="col-6"><strong>Package:</strong> ${job?.salary || '—'}</div>
          </div>`;
        selectionEl.closest('.selection-details-wrap')?.classList.remove('d-none');
      } else {
        selectionEl.closest('.selection-details-wrap')?.classList.add('d-none');
      }
    }

    document.getElementById('btnShortlist').addEventListener('click', () => { Company.updateStatus(app.id, 'shortlisted'); setTimeout(() => Company.loadApplicantDetails(), 200); });
    document.getElementById('btnSelect').addEventListener('click', () => { Company.updateStatus(app.id, 'selected'); setTimeout(() => Company.loadApplicantDetails(), 200); });
    document.getElementById('btnReject').addEventListener('click', () => { Company.updateStatus(app.id, 'rejected'); setTimeout(() => Company.loadApplicantDetails(), 200); });
  },

  // ---------------------------------------------------------------------
  // INTERVIEW SCHEDULE (dedicated shared "interviews" entity)
  // ---------------------------------------------------------------------
  renderInterviewSchedule() {
    const user = App.currentUser;
    const data = getData();
    const interviews = data.interviews
      .filter(i => i.companyId === user.id)
      .sort((a, b) => new Date(a.date || 0) - new Date(b.date || 0));
    const tbody = document.getElementById('interviewScheduleTableBody');
    if (!tbody) return;

    tbody.innerHTML = interviews.map(i => `
      <tr data-searchable>
        <td><strong>${i.studentName}</strong></td>
        <td>${i.jobTitle}</td>
        <td>${i.round || '—'}</td>
        <td>${i.date ? App.formatDate(i.date) : '—'}${i.time ? ' ' + i.time : ''}</td>
        <td>${i.mode || '—'}</td>
        <td>${i.venue || '—'}</td>
        <td>${App.getStatusBadge(i.status)}</td>
        <td>
          <button class="btn-icon me-1" title="Edit / Reschedule" onclick="Company.openInterviewModal('${i.id}')"><i class="bi bi-pencil"></i></button>
          <button class="btn-icon danger" title="Cancel" onclick="Company.cancelInterview('${i.id}')"><i class="bi bi-x-circle"></i></button>
        </td>
      </tr>`).join('') || '<tr><td colspan="8" class="text-center text-muted py-4">No interviews scheduled</td></tr>';
  },

  initInterviewScheduleFilters() {
    const user = App.currentUser;
    const data = getData();
    const jobEl = document.getElementById('interviewJobFilter');
    const statusEl = document.getElementById('interviewStatusFilter');
    const dateEl = document.getElementById('interviewDateFilter');

    if (jobEl && !jobEl.dataset.bound) {
      const myJobs = data.jobs.filter(j => j.companyId === user.id);
      jobEl.innerHTML = '<option value="">All Jobs</option>' + myJobs.map(j => `<option value="${j.id}">${j.title}</option>`).join('');
      jobEl.dataset.bound = '1';
    }

    const applyFilters = () => {
      const rows = document.querySelectorAll('#interviewScheduleTableBody tr[data-searchable]');
      // simple client re-render honoring filters
      Company.renderInterviewSchedule();
      const jobVal = jobEl?.value, statusVal = statusEl?.value, dateVal = dateEl?.value;
      if (!jobVal && !statusVal && !dateVal) return;
      const data2 = getData();
      let interviews = data2.interviews.filter(i => i.companyId === App.currentUser.id);
      if (jobVal) interviews = interviews.filter(i => i.jobId === jobVal);
      if (statusVal) interviews = interviews.filter(i => i.status === statusVal);
      if (dateVal) interviews = interviews.filter(i => i.date === dateVal);
      const tbody = document.getElementById('interviewScheduleTableBody');
      if (tbody) {
        tbody.innerHTML = interviews.map(i => `
          <tr data-searchable>
            <td><strong>${i.studentName}</strong></td>
            <td>${i.jobTitle}</td>
            <td>${i.round || '—'}</td>
            <td>${i.date ? App.formatDate(i.date) : '—'}${i.time ? ' ' + i.time : ''}</td>
            <td>${i.mode || '—'}</td>
            <td>${i.venue || '—'}</td>
            <td>${App.getStatusBadge(i.status)}</td>
            <td>
              <button class="btn-icon me-1" title="Edit / Reschedule" onclick="Company.openInterviewModal('${i.id}')"><i class="bi bi-pencil"></i></button>
              <button class="btn-icon danger" title="Cancel" onclick="Company.cancelInterview('${i.id}')"><i class="bi bi-x-circle"></i></button>
            </td>
          </tr>`).join('') || '<tr><td colspan="8" class="text-center text-muted py-4">No interviews match the filters</td></tr>';
      }
    };

    jobEl?.addEventListener('change', applyFilters);
    statusEl?.addEventListener('change', applyFilters);
    dateEl?.addEventListener('change', applyFilters);
  },

  openInterviewModal(interviewId) {
    const data = getData();
    const user = App.currentUser;
    const appSelect = document.getElementById('interviewApplicationSelect');
    const idEl = document.getElementById('interviewFormId');
    const heading = document.getElementById('interviewModalTitle');

    if (appSelect) {
      // Only shortlisted candidates can be scheduled for interview.
      let eligibleApps = data.applications.filter(a => a.companyId === user.id && a.status === 'shortlisted');
      // When editing, keep the candidate already on this interview selectable even if
      // their application has since moved on (e.g. selected/rejected after the interview).
      if (interviewId) {
        const existing = data.interviews.find(i => i.id === interviewId);
        if (existing) {
          const existingApp = data.applications.find(a => a.id === existing.applicationId);
          if (existingApp && !eligibleApps.some(a => a.id === existingApp.id)) eligibleApps = eligibleApps.concat([existingApp]);
        }
      }
      appSelect.innerHTML = eligibleApps.length
        ? eligibleApps.map(a => `<option value="${a.id}">${a.studentName} — ${a.jobTitle}</option>`).join('')
        : '<option value="">No shortlisted candidates available</option>';
    }

    if (interviewId) {
      const interview = data.interviews.find(i => i.id === interviewId);
      if (!interview) return;
      idEl.value = interview.id;
      if (appSelect) appSelect.value = interview.applicationId;
      document.getElementById('interviewRound').value = interview.round || '';
      document.getElementById('interviewDate').value = interview.date || '';
      document.getElementById('interviewTime').value = interview.time || '';
      document.getElementById('interviewMode').value = interview.mode || 'Online';
      document.getElementById('interviewVenue').value = interview.venue || '';
      document.getElementById('interviewInterviewer').value = interview.interviewer || '';
      document.getElementById('interviewRemarks').value = interview.remarks || '';
      document.getElementById('interviewStatusSelect').value = interview.status || 'Scheduled';
      if (heading) heading.textContent = 'Edit / Reschedule Interview';
    } else {
      idEl.value = '';
      document.getElementById('interviewRound').value = 'Round 1';
      document.getElementById('interviewDate').value = '';
      document.getElementById('interviewTime').value = '';
      document.getElementById('interviewMode').value = 'Online';
      document.getElementById('interviewVenue').value = '';
      document.getElementById('interviewInterviewer').value = '';
      document.getElementById('interviewRemarks').value = '';
      document.getElementById('interviewStatusSelect').value = 'Scheduled';
      if (heading) heading.textContent = 'Schedule Interview';
    }

    new bootstrap.Modal(document.getElementById('interviewModal')).show();
  },

  saveInterview() {
    const id = document.getElementById('interviewFormId').value;
    const applicationId = document.getElementById('interviewApplicationSelect').value;
    const date = document.getElementById('interviewDate').value;
    const time = document.getElementById('interviewTime').value;

    if (!applicationId || !date) {
      App.showToast('Please select a candidate and a date', 'error');
      return;
    }

    const data = getData();
    const user = App.currentUser;
    const app = data.applications.find(a => a.id === applicationId && a.companyId === user.id);
    if (!app) { App.showToast('Application not found', 'error'); return; }
    if (!id && app.status !== 'shortlisted') {
      App.showToast('Only shortlisted candidates can be scheduled for interview', 'error');
      return;
    }

    const fields = {
      round: document.getElementById('interviewRound').value.trim() || 'Round 1',
      date,
      time,
      mode: document.getElementById('interviewMode').value,
      venue: document.getElementById('interviewVenue').value.trim(),
      interviewer: document.getElementById('interviewInterviewer').value.trim(),
      remarks: document.getElementById('interviewRemarks').value.trim(),
      status: document.getElementById('interviewStatusSelect').value
    };

    let interview;
    let isReschedule = false;
    if (id) {
      interview = data.interviews.find(i => i.id === id);
      if (interview) {
        isReschedule = interview.date !== date && fields.status !== 'Cancelled';
        Object.assign(interview, fields);
      }
    } else {
      interview = {
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
    }

    // Keep the application record (read directly by TPO/Student panels) fully in
    // sync with the interview record itself - both sides must reflect the exact
    // same round/date/time/mode/venue/interviewer/remarks/status, not just the date.
    if (fields.status !== 'Cancelled') {
      app.interviewDate = date;
      app.interviewRound = fields.round;
      app.interviewTime = fields.time;
      app.interviewMode = fields.mode;
      app.interviewVenue = fields.venue;
      app.interviewer = fields.interviewer;
      app.interviewRemarks = fields.remarks;
      app.interviewStatus = fields.status === 'Completed' ? 'completed' : (fields.status === 'Rescheduled' ? 'scheduled' : 'scheduled');
    } else {
      app.interviewStatus = 'cancelled';
    }

    saveData(data);

    if (id && isReschedule) {
      addNotification(app.studentId, 'student', 'Interview Rescheduled', `Your interview for ${app.jobTitle} has been rescheduled to ${App.formatDate(date)}.`);
    } else if (!id) {
      addNotification(app.studentId, 'student', 'Interview Scheduled', `Your interview for ${app.jobTitle} is on ${App.formatDate(date)}${time ? ' at ' + time : ''}.`);
    }

    Company.renderInterviewSchedule();
    Company.initDashboard?.();
    bootstrap.Modal.getInstance(document.getElementById('interviewModal'))?.hide();
    App.showToast(id ? 'Interview updated' : 'Interview scheduled');
  },

  cancelInterview(id) {
    App.confirmDelete('Cancel this interview?', () => {
      const data = getData();
      const user = App.currentUser;
      const interview = data.interviews.find(i => i.id === id && i.companyId === user.id);
      if (interview) {
        interview.status = 'Cancelled';
        // Keep the application's mirrored interview fields in sync with the cancellation.
        const app = data.applications.find(a => a.id === interview.applicationId);
        if (app) app.interviewStatus = 'cancelled';
        saveData(data);
        addNotification(interview.studentId, 'student', 'Interview Cancelled', `Your interview for ${interview.jobTitle} has been cancelled.`);
        Company.renderInterviewSchedule();
        App.showToast('Interview cancelled');
      }
    });
  },

  // ---------------------------------------------------------------------
  // INTERVIEW RESULTS
  // ---------------------------------------------------------------------
  renderInterviewResults() {
    const user = App.currentUser;
    const data = getData();
    const interviews = data.interviews
      .filter(i => i.companyId === user.id && i.status !== 'Cancelled')
      .sort((a, b) => new Date(b.date || 0) - new Date(a.date || 0));
    const tbody = document.getElementById('interviewResultsTableBody');
    if (!tbody) return;

    tbody.innerHTML = interviews.map(i => {
      const app = data.applications.find(a => a.id === i.applicationId);
      const result = app
        ? (app.status === 'selected' ? 'Selected'
          : app.status === 'rejected' ? 'Rejected'
          : i.result === 'On Hold' ? 'On Hold'
          : 'Pending')
        : 'Pending';
      return `
      <tr data-searchable>
        <td><strong>${i.studentName}</strong></td>
        <td>${i.jobTitle}</td>
        <td>${i.round || '—'} • ${i.date ? App.formatDate(i.date) : '—'}</td>
        <td>${App.getStatusBadge(result)}</td>
        <td><input type="text" class="form-control form-control-sm" id="remarks-${i.id}" placeholder="Add remarks" value="${i.remarks || ''}" style="max-width:180px;display:inline-block"></td>
        <td>
          <select class="form-select form-select-sm d-inline-block" style="width:auto" onchange="Company.recordInterviewResult('${i.id}', this.value)">
            <option value="">Update Result</option>
            <option value="selected">Selected</option>
            <option value="rejected">Rejected</option>
            <option value="onhold">On Hold</option>
          </select>
        </td>
      </tr>`;
    }).join('') || '<tr><td colspan="6" class="text-center text-muted py-4">No interview results yet</td></tr>';
  },

  recordInterviewResult(interviewId, result) {
    if (!result) return;
    const data = getData();
    const user = App.currentUser;
    const interview = data.interviews.find(i => i.id === interviewId && i.companyId === user.id);
    if (!interview) return;

    const remarksEl = document.getElementById(`remarks-${interviewId}`);
    interview.remarks = remarksEl ? remarksEl.value.trim() : interview.remarks;
    interview.status = 'Completed';

    if (result === 'onhold') {
      // On Hold: interview is done but no final decision yet - keep the
      // application at 'shortlisted' so it stays actionable, just flag the
      // interview record itself so the result column reflects the decision.
      interview.result = 'On Hold';
      saveData(data);
      addNotification(interview.studentId, 'student', 'Interview Update', `Your interview for ${interview.jobTitle} result is on hold. You'll be notified once a decision is made.`);
    } else {
      interview.result = result === 'selected' ? 'Selected' : 'Rejected';
      saveData(data);
      if (result === 'selected') {
        Company.updateStatus(interview.applicationId, 'selected');
      } else if (result === 'rejected') {
        Company.updateStatus(interview.applicationId, 'rejected');
      }
    }

    // Persist remarks onto the application too for easy display on Rejected/Selected pages.
    const data2 = getData();
    const app2 = data2.applications.find(a => a.id === interview.applicationId);
    if (app2) { app2.remarks = interview.remarks; saveData(data2); }

    Company.renderInterviewResults();
    App.showToast('Interview result recorded');
  },

  // ---------------------------------------------------------------------
  // CHANGE PASSWORD
  // ---------------------------------------------------------------------
  changePassword() {
    const form = document.getElementById('changePasswordForm');
    if (!App.validateForm(form)) return;

    const current = document.getElementById('currentPassword').value;
    const next = document.getElementById('newPassword').value;
    const confirm = document.getElementById('confirmPassword').value;
    const user = App.currentUser;

    if (current !== user.password) {
      App.showToast('Current password is incorrect', 'error');
      return;
    }
    if (next !== confirm) {
      App.showToast('New password and confirmation do not match', 'error');
      return;
    }
    if (next.length < 6) {
      App.showToast('New password must be at least 6 characters', 'error');
      return;
    }

    if (App.resetPassword(user.email, next, 'company')) {
      App.setSession({ ...user, password: next });
      App.showToast('Password updated successfully');
      form.reset();
    } else {
      App.showToast('Could not update password', 'error');
    }
  }
};
