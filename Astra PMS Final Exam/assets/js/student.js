/**
 * Student Module JavaScript
 */

const Student = {
  // Derives the student-facing status label from the shared application
  // record (spec #6): Applied, Under Review, Shortlisted, Interview
  // Scheduled, Selected, Rejected, Placed. This never changes the
  // underlying a.status value (pending/shortlisted/selected/rejected),
  // which stays the single shared field Company/TPO read and write —
  // it's purely a richer display label derived from that same record
  // plus the shared data.placements array.
  deriveApplicationDisplayStatus(app, data) {
    data = data || getData();
    if (data.placements.some(p => p.applicationId === app.id)) return 'Placed';
    if (app.status === 'selected') return 'Selected';
    if (app.status === 'rejected') return 'Rejected';
    if (app.status === 'shortlisted') return app.interviewDate ? 'Interview Scheduled' : 'Shortlisted';
    return 'Applied';
  },

  initDashboard() {
    const user = App.currentUser;
    const data = getData();
    const myApps = data.applications.filter(a => a.studentId === user.id);
    const interviews = myApps.filter(a => a.interviewDate && a.status !== 'rejected');
    const shortlisted = myApps.filter(a => a.status === 'shortlisted');
    const activeApps = myApps.filter(a => a.status === 'pending' || a.status === 'shortlisted');
    const selected = myApps.filter(a => a.status === 'selected');
    const upcomingDrives = data.drives.filter(d => d.status === 'upcoming');
    // Eligible Drives: upcoming drives this student can actually apply to,
    // via the same centralized eligibility check used on drives.aspx /
    // eligible-drives.aspx / apply.aspx (App.checkDriveEligibility).
    const eligibleDrives = upcomingDrives.filter(d => App.checkDriveEligibility(user, d, data).eligible);

    document.getElementById('statEligibleDrives').textContent = eligibleDrives.length;
    document.getElementById('statApplied').textContent = myApps.length;
    document.getElementById('statActiveApplications').textContent = activeApps.length;
    document.getElementById('statShortlisted').textContent = shortlisted.length;
    document.getElementById('statInterviews').textContent = interviews.length;
    document.getElementById('statSelected').textContent = selected.length;
    document.getElementById('statPlacement').textContent = user.placed ? 'Placed' : 'Not Placed';

    const drivesEl = document.getElementById('upcomingDrivesList');
    if (drivesEl) {
      drivesEl.innerHTML = upcomingDrives.slice(0, 4).map(d => `
        <div class="activity-item">
          <div class="activity-icon stat-icon blue"><i class="bi bi-calendar-event"></i></div>
          <div class="activity-content">
            <h6>${d.name}</h6>
            <p>${d.companyName} • ${d.venue}</p>
            <span class="time">${App.formatDate(d.date)}</span>
          </div>
        </div>`).join('') || '<p class="text-muted">No upcoming drives</p>';
    }
  },

  register() {
    const form = document.getElementById('registerForm');
    if (!App.validateForm(form)) return;

    const data = getData();
    const email = document.getElementById('email').value;
    if (data.students.find(s => s.email === email)) {
      App.showToast('Email already registered', 'error');
      return;
    }

    data.students.push({
      id: generateId('STU'),
      name: document.getElementById('fullName').value,
      email,
      password: document.getElementById('password').value,
      phone: document.getElementById('phone').value,
      branch: document.getElementById('branch').value,
      cgpa: parseFloat(document.getElementById('cgpa').value),
      year: document.getElementById('year').value,
      skills: document.getElementById('skills').value.split(',').map(s => s.trim()).filter(Boolean),
      status: 'active',
      placed: false,
      company: null,
      registeredAt: new Date().toISOString().split('T')[0]
    });
    saveData(data);
    addActivity('New Registration', `${document.getElementById('fullName').value} registered`);
    App.showToast('Registration successful! Please login.');
    setTimeout(() => window.location.href = 'login.aspx', 1500);
  },

  renderProfile() {
    const user = App.currentUser;
    document.getElementById('profileName').textContent = user.name;
    document.getElementById('profileId').textContent = user.id;
    const avatarEl = document.getElementById('profileAvatar');
    if (avatarEl) {
      if (user.photoUrl) { avatarEl.style.backgroundImage = `url('${user.photoUrl}')`; avatarEl.style.backgroundSize = 'cover'; avatarEl.style.backgroundPosition = 'center'; avatarEl.textContent = ''; }
      else { avatarEl.textContent = App.getInitials(user.name); }
    }
    document.getElementById('infoEmail').textContent = user.email;
    document.getElementById('infoPhone').textContent = user.phone || '—';
    document.getElementById('infoBranch').textContent = user.branch;
    document.getElementById('infoCgpa').textContent = user.cgpa;
    document.getElementById('infoYear').textContent = user.year;
    document.getElementById('infoStatus').innerHTML = user.placed 
      ? `<span class="badge badge-status badge-selected">Placed at ${user.company}</span>`
      : App.getStatusBadge('pending');

    const setText = (id, val) => { const el = document.getElementById(id); if (el) el.textContent = val || '—'; };
    setText('infoGender', user.gender);
    setText('infoDob', user.dob ? App.formatDate(user.dob) : '');
    setText('infoAddress', user.address);
    setText('infoCourse', user.course);
    setText('infoBatch', user.year);

    const skillsEl = document.getElementById('skillsList');
    if (skillsEl && user.skills) {
      skillsEl.innerHTML = user.skills.map(s => `<span class="badge bg-light text-dark me-1 mb-1">${s}</span>`).join('');
    }
  },

  loadEditProfile() {
    const user = App.currentUser;
    document.getElementById('editName').value = user.name;
    document.getElementById('editPhone').value = user.phone || '';
    document.getElementById('editBranch').value = user.branch;
    document.getElementById('editCgpa').value = user.cgpa;
    document.getElementById('editSkills').value = (user.skills || []).join(', ');

    const setVal = (id, val) => { const el = document.getElementById(id); if (el) el.value = val || ''; };
    setVal('editGender', user.gender);
    setVal('editDob', user.dob);
    setVal('editAddress', user.address);
    setVal('editCourse', user.course);
    setVal('editPhotoUrl', user.photoUrl);
  },

  saveProfile() {
    const form = document.getElementById('editProfileForm');
    if (!App.validateForm(form)) return;

    const data = getData();
    const idx = data.students.findIndex(s => s.id === App.currentUser.id);
    if (idx > -1) {
      const getVal = id => document.getElementById(id)?.value;
      data.students[idx].name = document.getElementById('editName').value;
      data.students[idx].phone = document.getElementById('editPhone').value;
      data.students[idx].branch = document.getElementById('editBranch').value;
      data.students[idx].cgpa = parseFloat(document.getElementById('editCgpa').value);
      data.students[idx].skills = document.getElementById('editSkills').value.split(',').map(s => s.trim()).filter(Boolean);
      if (getVal('editGender') !== undefined) data.students[idx].gender = getVal('editGender');
      if (getVal('editDob') !== undefined) data.students[idx].dob = getVal('editDob');
      if (getVal('editAddress') !== undefined) data.students[idx].address = getVal('editAddress');
      if (getVal('editCourse') !== undefined) data.students[idx].course = getVal('editCourse');
      if (getVal('editPhotoUrl') !== undefined) data.students[idx].photoUrl = getVal('editPhotoUrl');
      saveData(data);
      App.setSession({ ...App.currentUser, ...data.students[idx], role: 'student' });
      App.showToast('Profile updated');
      setTimeout(() => window.location.href = 'profile.aspx', 1000);
    }
  },

  renderJobs(filter = '') {
    const data = getData();
    const user = App.currentUser;
    let jobs = data.jobs.filter(j => j.status === 'active');

    const companySel = document.getElementById('filterCompany');
    const typeSel = document.getElementById('filterType');
    const locationSel = document.getElementById('filterLocation');
    const branchSel = document.getElementById('filterBranch');
    const eligibleOnlyChk = document.getElementById('filterEligibleOnly');
    const sortSel = document.getElementById('sortJobs');

    // Populate filter dropdowns once (idempotent).
    if (companySel && !companySel.dataset.populated) {
      const companies = [...new Set(data.jobs.map(j => j.companyName))].sort();
      companySel.innerHTML = '<option value="">All Companies</option>' + companies.map(c => `<option value="${c}">${c}</option>`).join('');
      companySel.dataset.populated = '1';
    }
    if (typeSel && !typeSel.dataset.populated) {
      const types = [...new Set(data.jobs.map(j => j.type))].sort();
      typeSel.innerHTML = '<option value="">All Types</option>' + types.map(t => `<option value="${t}">${t}</option>`).join('');
      typeSel.dataset.populated = '1';
    }
    if (locationSel && !locationSel.dataset.populated) {
      const locs = [...new Set(data.jobs.map(j => j.location))].sort();
      locationSel.innerHTML = '<option value="">All Locations</option>' + locs.map(l => `<option value="${l}">${l}</option>`).join('');
      locationSel.dataset.populated = '1';
    }
    if (branchSel && !branchSel.dataset.populated) {
      const branches = [...new Set(data.jobs.flatMap(j => j.branches || []))].sort();
      branchSel.innerHTML = '<option value="">All Branches</option>' + branches.map(b => `<option value="${b}">${b}</option>`).join('');
      branchSel.dataset.populated = '1';
    }

    const searchTerm = (filter || document.getElementById('jobSearch')?.value || '').toLowerCase();
    if (searchTerm) jobs = jobs.filter(j => j.title.toLowerCase().includes(searchTerm) || j.companyName.toLowerCase().includes(searchTerm));
    if (companySel?.value) jobs = jobs.filter(j => j.companyName === companySel.value);
    if (typeSel?.value) jobs = jobs.filter(j => j.type === typeSel.value);
    if (locationSel?.value) jobs = jobs.filter(j => j.location === locationSel.value);
    if (branchSel?.value) jobs = jobs.filter(j => (j.branches || []).includes(branchSel.value));
    if (eligibleOnlyChk?.checked) jobs = jobs.filter(j => App.checkJobEligibility(user, j, data).eligible);

    if (sortSel?.value === 'deadline') jobs = jobs.slice().sort((a, b) => new Date(a.deadline) - new Date(b.deadline));
    else if (sortSel?.value === 'cgpa') jobs = jobs.slice().sort((a, b) => (a.cgpaMin || 0) - (b.cgpaMin || 0));
    else if (sortSel?.value === 'package') jobs = jobs.slice().sort((a, b) => parseFloat(b.salary) - parseFloat(a.salary));

    const container = document.getElementById('jobsContainer');
    if (!container) return;

    container.innerHTML = jobs.map(j => {
      const elig = App.checkJobEligibility(user, j, data);
      return `
        <div class="col-md-6 col-lg-4" data-search-card>
          <div class="job-card">
            <div class="d-flex align-items-start gap-3 mb-3">
              <div class="company-logo">${App.getInitials(j.companyName)}</div>
              <div class="flex-grow-1">
                <h6 class="mb-1">${j.title}</h6>
                <p class="text-muted small mb-0">${j.companyName}</p>
              </div>
            </div>
            <div class="d-flex flex-wrap gap-2 mb-3">
              <span class="badge bg-light text-dark"><i class="bi bi-geo-alt me-1"></i>${j.location}</span>
              <span class="badge bg-light text-dark"><i class="bi bi-currency-rupee me-1"></i>${j.salary}</span>
              <span class="badge bg-light text-dark">${j.type}</span>
              <span class="badge bg-light text-dark">Openings: ${j.openings}</span>
            </div>
            <p class="small text-muted mb-3">${j.description.substring(0, 80)}...</p>
            <div class="d-flex justify-content-between align-items-center">
              <small class="text-muted">Deadline: ${App.formatDate(j.deadline)}</small>
              <a href="job-details.aspx?id=${j.id}" class="btn btn-sm ${elig.alreadyApplied ? 'btn-outline-custom' : 'btn-primary-custom'}">
                ${elig.alreadyApplied ? 'View' : 'View & Apply'}
              </a>
            </div>
            ${!elig.eligible && !elig.alreadyApplied ? '<small class="text-danger d-block mt-2"><i class="bi bi-exclamation-circle"></i> Not Eligible</small>' : ''}
          </div>
        </div>`;
    }).join('') || '<div class="col-12"><div class="empty-state"><i class="bi bi-briefcase"></i><p>No jobs match your filters</p></div></div>';
  },

  loadJobDetails() {
    const params = new URLSearchParams(window.location.search);
    const jobId = params.get('id');
    const data = getData();
    const job = data.jobs.find(j => j.id === jobId);
    if (!job) { window.location.href = 'jobs.aspx'; return; }
    const user = App.currentUser;

    document.getElementById('jobTitle').textContent = job.title;
    document.getElementById('jobCompany').textContent = job.companyName;
    document.getElementById('jobLocation').textContent = job.location;
    document.getElementById('jobSalary').textContent = job.salary;
    document.getElementById('jobType').textContent = job.type;
    document.getElementById('jobDeadline').textContent = App.formatDate(job.deadline);
    document.getElementById('jobDescription').textContent = job.description;
    document.getElementById('jobCgpa').textContent = job.cgpaMin;
    document.getElementById('jobOpenings').textContent = job.openings;
    document.getElementById('jobSkills').innerHTML = job.skills.map(s => `<span class="badge bg-light text-dark me-1">${s}</span>`).join('');
    document.getElementById('jobBranches').textContent = job.branches.join(', ');
    const statusEl = document.getElementById('jobStatus');
    if (statusEl) statusEl.innerHTML = App.getStatusBadge(job.status);

    // Company details, looked up via job.companyId (spec #3: "job + company
    // details using jobId/companyId").
    const company = data.companies.find(c => c.id === job.companyId);
    const industryEl = document.getElementById('companyIndustry');
    const locationEl = document.getElementById('companyLocation');
    const websiteEl = document.getElementById('companyWebsite');
    const descEl = document.getElementById('companyDescription');
    if (industryEl) industryEl.textContent = company?.industry || '—';
    if (locationEl) locationEl.textContent = company?.location || job.location || '—';
    if (websiteEl) websiteEl.innerHTML = company?.website ? `<a href="${company.website}" target="_blank" rel="noopener">${company.website}</a>` : '—';
    if (descEl) descEl.textContent = company?.description || 'No company description available.';

    const elig = App.checkJobEligibility(user, job, data);
    const eligBadge = document.getElementById('eligibilityResult');
    if (eligBadge) {
      eligBadge.innerHTML = elig.eligible
        ? '<span class="badge badge-status badge-selected"><i class="bi bi-check-circle me-1"></i>Eligible</span>'
        : `<span class="badge badge-status badge-rejected"><i class="bi bi-x-circle me-1"></i>Not Eligible</span>
           <ul class="small text-danger mt-2 mb-0">${elig.reasons.map(r => `<li>${r}</li>`).join('')}</ul>`;
    }

    const applyBtn = document.getElementById('applyBtn');
    if (elig.alreadyApplied) {
      applyBtn.textContent = 'Already Applied';
      applyBtn.classList.add('disabled');
      applyBtn.removeAttribute('href');
    } else if (!elig.eligible) {
      applyBtn.textContent = 'Not Eligible to Apply';
      applyBtn.classList.add('disabled');
      applyBtn.removeAttribute('href');
    } else {
      applyBtn.href = `apply.aspx?id=${jobId}`;
    }
  },

  submitApplication() {
    // Full validation per spec 13: logged in, job exists, job active, deadline
    // not passed, student eligible, no duplicate application.
    if (!App.requireAuth('student', 'login.aspx')) return;

    const params = new URLSearchParams(window.location.search);
    const jobId = params.get('id');
    const data = getData();
    const job = data.jobs.find(j => j.id === jobId);
    const user = App.currentUser;

    if (!job) {
      App.showToast('This job no longer exists', 'error');
      return;
    }

    const elig = App.checkJobEligibility(user, job, data);
    if (elig.alreadyApplied) {
      App.showToast('You have already applied to this job', 'warning');
      return;
    }
    if (!elig.jobActive) {
      App.showToast('This job is no longer active', 'error');
      return;
    }
    if (elig.deadlinePassed) {
      App.showToast('The application deadline has passed', 'error');
      return;
    }
    if (!elig.eligible) {
      App.showToast('You are not eligible for this job: ' + elig.reasons.join(' '), 'error');
      return;
    }

    const agree = document.getElementById('agreeTerms');
    if (agree && !agree.checked) {
      App.showToast('Please confirm your information is accurate', 'warning');
      return;
    }

    data.applications.push({
      id: generateId('APP'),
      studentId: user.id,
      studentName: user.name,
      jobId,
      jobTitle: job.title,
      companyId: job.companyId,
      companyName: job.companyName,
      driveId: job.driveId || null,
      coverLetter: document.getElementById('coverLetter')?.value.trim() || '',
      cgpa: user.cgpa,
      status: 'pending',
      appliedAt: new Date().toISOString().split('T')[0],
      interviewDate: null
    });
    saveData(data);
    addActivity('Application Received', `${user.name} applied to ${job.companyName}`);
    addNotification(job.companyId, 'company', 'New Application', `${user.name} applied for ${job.title}`);
    addNotification(user.id, 'student', 'Application Submitted', `Your application for ${job.title} at ${job.companyName} was submitted.`);
    App.showToast('Application submitted successfully!');
    setTimeout(() => window.location.href = 'applications.aspx', 1500);
  },

  renderApplications() {
    const data = getData();
    let apps = data.applications.filter(a => a.studentId === App.currentUser.id);

    const companySel = document.getElementById('appFilterCompany');
    const jobSel = document.getElementById('appFilterJob');
    if (companySel && !companySel.dataset.populated) {
      const companies = [...new Set(apps.map(a => a.companyName))].sort();
      companySel.innerHTML = '<option value="">All Companies</option>' + companies.map(c => `<option value="${c}">${c}</option>`).join('');
      companySel.dataset.populated = '1';
    }
    if (jobSel && !jobSel.dataset.populated) {
      const jobs = [...new Set(apps.map(a => a.jobTitle))].sort();
      jobSel.innerHTML = '<option value="">All Jobs</option>' + jobs.map(j => `<option value="${j}">${j}</option>`).join('');
      jobSel.dataset.populated = '1';
    }

    const searchTerm = (document.getElementById('appSearch')?.value || '').toLowerCase();
    const statusFilter = document.getElementById('appFilterStatus')?.value;
    if (searchTerm) apps = apps.filter(a => a.jobTitle.toLowerCase().includes(searchTerm) || a.companyName.toLowerCase().includes(searchTerm));
    if (companySel?.value) apps = apps.filter(a => a.companyName === companySel.value);
    if (jobSel?.value) apps = apps.filter(a => a.jobTitle === jobSel.value);
    if (statusFilter) apps = apps.filter(a => a.status === statusFilter);

    const nextStepFor = a => {
      if (a.status === 'selected') return 'Awaiting placement confirmation';
      if (a.status === 'rejected') return 'Application closed';
      if (a.status === 'shortlisted') return a.interviewDate ? `Interview on ${App.formatDate(a.interviewDate)}` : 'Awaiting interview schedule';
      return 'Awaiting review by placement cell';
    };

    const tbody = document.getElementById('applicationsTableBody');
    if (!tbody) return;

    tbody.innerHTML = apps.map(a => `
      <tr data-searchable>
        <td>${a.id}</td>
        <td><strong>${a.jobTitle}</strong></td>
        <td>${a.companyName}</td>
        <td>${App.getStatusBadge(Student.deriveApplicationDisplayStatus(a, data))}</td>
        <td>${App.formatDate(a.appliedAt)}</td>
        <td>${a.interviewDate ? App.formatDate(a.interviewDate) : '—'}</td>
        <td><small class="text-muted">${nextStepFor(a)}</small></td>
        <td><a href="application-status.aspx?id=${a.id}" class="btn btn-sm btn-outline-custom">View</a></td>
      </tr>`).join('') || '<tr><td colspan="8" class="text-center text-muted py-4">No applications yet</td></tr>';
  },

  renderPlacementStatus() {
    const user = App.currentUser;
    const data = getData();
    const apps = data.applications.filter(a => a.studentId === user.id);

    document.getElementById('placementStatus').innerHTML = user.placed
      ? `<div class="alert alert-success"><i class="bi bi-check-circle me-2"></i><strong>Congratulations!</strong> You have been placed at <strong>${user.company}</strong>.</div>`
      : `<div class="alert alert-warning"><i class="bi bi-hourglass-split me-2"></i>Your placement process is ongoing. Keep applying!</div>`;

    const detailsCard = document.getElementById('placementDetailsCard');
    if (detailsCard) {
      if (user.placed) {
        const placedApp = apps.find(a => a.status === 'selected' && a.companyName === user.company) || apps.find(a => a.status === 'selected');
        const job = placedApp ? data.jobs.find(j => j.id === placedApp.jobId) : null;
        detailsCard.style.display = '';
        document.getElementById('pdCompany').textContent = user.company || (placedApp ? placedApp.companyName : '—');
        document.getElementById('pdJob').textContent = placedApp ? placedApp.jobTitle : '—';
        document.getElementById('pdPackage').textContent = job ? job.salary : '—';
        document.getElementById('pdOfferStatus').innerHTML = '<span class="badge badge-status badge-selected">Joined</span>';
        document.getElementById('pdPlacementDate').textContent = placedApp ? App.formatDate(placedApp.interviewDate || placedApp.appliedAt) : '—';
        document.getElementById('pdJoiningDate').textContent = user.joiningDate ? App.formatDate(user.joiningDate) : 'Not confirmed yet';
        const offerLetterEl = document.getElementById('pdOfferLetter');
        offerLetterEl.innerHTML = user.offerLetterUrl ? `<a href="${user.offerLetterUrl}" target="_blank">View Offer Letter</a>` : 'Not uploaded by placement cell yet';
        document.getElementById('pdRemarks').textContent = user.placementRemarks || placedApp?.remarks || '—';
      } else {
        detailsCard.style.display = 'none';
      }
    }

    const timeline = document.getElementById('placementTimeline');
    if (timeline) {
      timeline.innerHTML = apps.map(a => `
        <div class="activity-item">
          <div class="activity-icon stat-icon ${a.status === 'selected' ? 'green' : a.status === 'rejected' ? 'red' : 'blue'}">
            <i class="bi ${a.status === 'selected' ? 'bi-trophy' : a.status === 'rejected' ? 'bi-x-circle' : 'bi-clock'}"></i>
          </div>
          <div class="activity-content">
            <h6>${a.jobTitle} — ${a.companyName}</h6>
            <p>Status: ${App.getStatusBadge(a.status)}</p>
            <span class="time">Applied: ${App.formatDate(a.appliedAt)}</span>
          </div>
        </div>`).join('') || '<p class="text-muted">No placement activity yet</p>';
    }
  },

  renderAcademicDetails() {
    const user = App.currentUser;
    const data = getData();

    document.getElementById('acBranch').textContent = user.branch;
    document.getElementById('acCgpa').textContent = user.cgpa;
    document.getElementById('acYear').textContent = user.year;
    document.getElementById('acId').textContent = user.id;
    const courseEl = document.getElementById('acCourse');
    if (courseEl) courseEl.textContent = user.course || '—';
    const semesterEl = document.getElementById('acSemester');
    if (semesterEl) semesterEl.value = user.semester || '8th';

    const skillsEl = document.getElementById('acSkillsList');
    if (skillsEl) {
      skillsEl.innerHTML = (user.skills || []).map(s => `<span class="badge bg-light text-dark me-1 mb-1">${s}</span>`).join('') || '<p class="text-muted mb-0">No skills added yet</p>';
    }

    const activeJobs = data.jobs.filter(j => j.status === 'active');
    const eligibleJobs = activeJobs.filter(j => user.cgpa >= j.cgpaMin && j.branches.includes(user.branch));
    const summaryEl = document.getElementById('acEligibilitySummary');
    if (summaryEl) {
      summaryEl.innerHTML = `
        <div class="d-flex justify-content-between mb-2"><span>Active Openings</span><strong>${activeJobs.length}</strong></div>
        <div class="d-flex justify-content-between"><span>You Are Eligible For</span><strong>${eligibleJobs.length}</strong></div>`;
    }
  },

  saveSemester() {
    const semester = document.getElementById('acSemester')?.value;
    if (!semester) return;
    const data = getData();
    const idx = data.students.findIndex(s => s.id === App.currentUser.id);
    if (idx > -1) {
      data.students[idx].semester = semester;
      saveData(data);
      App.setSession({ ...App.currentUser, ...data.students[idx], role: 'student' });
      App.showToast('Semester updated');
    }
  },

  loadResume() {
    const user = App.currentUser;
    document.getElementById('resumeLink').value = user.resumeLink || '';
    document.getElementById('resumeSummary').value = user.resumeSummary || '';
    this.refreshResumeStatus(user);
  },

  refreshResumeStatus(user) {
    const statusEl = document.getElementById('resumeStatus');
    const openLink = document.getElementById('resumeOpenLink');
    const updatedEl = document.getElementById('resumeUpdatedAt');
    const hasResume = !!(user.resumeLink || user.resumeSummary);

    statusEl.innerHTML = hasResume
      ? '<span class="badge badge-status badge-selected">Resume on file</span>'
      : '<span class="badge badge-status badge-pending">No resume added yet</span>';

    if (user.resumeLink) {
      openLink.href = user.resumeLink;
      openLink.classList.remove('d-none');
    } else {
      openLink.classList.add('d-none');
    }
    updatedEl.textContent = user.resumeUpdatedAt ? App.formatDate(user.resumeUpdatedAt) : '—';
  },

  saveResume() {
    const data = getData();
    const idx = data.students.findIndex(s => s.id === App.currentUser.id);
    if (idx === -1) return;

    data.students[idx].resumeLink = document.getElementById('resumeLink').value.trim();
    data.students[idx].resumeSummary = document.getElementById('resumeSummary').value.trim();
    data.students[idx].resumeUpdatedAt = new Date().toISOString().split('T')[0];
    saveData(data);

    App.setSession({ ...App.currentUser, ...data.students[idx], role: 'student' });
    this.refreshResumeStatus(App.currentUser);
    App.showToast('Resume saved');
  },

  removeResume() {
    App.confirmDelete('Remove your resume? Recruiters will no longer see it.', () => {
      const data = getData();
      const idx = data.students.findIndex(s => s.id === App.currentUser.id);
      if (idx === -1) return;
      data.students[idx].resumeLink = '';
      data.students[idx].resumeSummary = '';
      data.students[idx].resumeUpdatedAt = new Date().toISOString().split('T')[0];
      saveData(data);
      App.setSession({ ...App.currentUser, ...data.students[idx], role: 'student' });
      document.getElementById('resumeLink').value = '';
      document.getElementById('resumeSummary').value = '';
      this.refreshResumeStatus(App.currentUser);
      App.showToast('Resume removed');
    });
  },

  renderDrives() {
    const data = getData();
    const tbody = document.getElementById('drivesTableBody');
    if (!tbody) return;

    tbody.innerHTML = data.drives.map(d => `
      <tr data-searchable>
        <td><strong>${d.name}</strong></td>
        <td>${d.companyName}</td>
        <td>${d.jobRole || '—'}</td>
        <td>${App.formatDate(d.date)}</td>
        <td>${d.time || '—'}</td>
        <td>${d.venue}</td>
        <td>${d.mode || '—'}</td>
        <td>${d.eligibility}</td>
        <td>${App.getStatusBadge(d.status)}</td>
      </tr>`).join('') || '<tr><td colspan="9" class="text-center text-muted py-4">No drives scheduled</td></tr>';
  },

  isEligibleForDrive(user, drive, data) {
    // Delegates to the centralized eligibility engine (spec section 24).
    return App.checkDriveEligibility(user, drive, data).eligible;
  },

  renderEligibleDrives() {
    const data = getData();
    const user = App.currentUser;
    const eligible = data.drives.filter(d => this.isEligibleForDrive(user, d, data));
    const tbody = document.getElementById('eligibleDrivesTableBody');
    if (!tbody) return;

    tbody.innerHTML = eligible.map(d => `
      <tr data-searchable>
        <td><strong>${d.name}</strong></td>
        <td>${d.companyName}</td>
        <td>${d.jobRole || '—'}</td>
        <td>${App.formatDate(d.date)}</td>
        <td>${d.time || '—'}</td>
        <td>${d.venue}</td>
        <td>${d.mode || '—'}</td>
        <td>${d.eligibility}</td>
        <td><span class="badge badge-status badge-selected">Eligible</span></td>
      </tr>`).join('') || '<tr><td colspan="9" class="text-center text-muted py-4">No upcoming drives match your profile right now</td></tr>';
  },

  renderApplicationStatus() {
    const data = getData();
    const apps = data.applications.filter(a => a.studentId === App.currentUser.id);

    document.getElementById('statPending').textContent = apps.filter(a => a.status === 'pending').length;
    document.getElementById('statShortlisted').textContent = apps.filter(a => a.status === 'shortlisted').length;
    document.getElementById('statSelectedCount').textContent = apps.filter(a => a.status === 'selected').length;
    document.getElementById('statRejected').textContent = apps.filter(a => a.status === 'rejected').length;

    const listEl = document.getElementById('statusBreakdownList');
    if (listEl) {
      listEl.innerHTML = apps.map(a => {
        const displayStatus = Student.deriveApplicationDisplayStatus(a, data);
        return `
        <div class="activity-item">
          <div class="activity-icon stat-icon ${a.status === 'selected' ? 'green' : a.status === 'rejected' ? 'red' : a.status === 'shortlisted' ? 'blue' : 'orange'}">
            <i class="bi ${a.status === 'selected' ? 'bi-trophy' : a.status === 'rejected' ? 'bi-x-circle' : a.status === 'shortlisted' ? 'bi-star' : 'bi-hourglass-split'}"></i>
          </div>
          <div class="activity-content">
            <h6>${a.jobTitle} — ${a.companyName}</h6>
            <p>${App.getStatusBadge(displayStatus)}</p>
            <span class="time">Applied: ${App.formatDate(a.appliedAt)}</span>
          </div>
        </div>`;
      }).join('') || '<p class="text-muted">No applications yet</p>';
    }
  },

  renderInterviewSchedule() {
    const data = getData();
    const user = App.currentUser;
    const today = new Date(); today.setHours(0, 0, 0, 0);

    const apps = data.applications
      .filter(a => a.studentId === user.id && a.interviewDate)
      .sort((a, b) => new Date(a.interviewDate) - new Date(b.interviewDate));

    const rowFor = a => `
      <tr data-searchable>
        <td><strong>${a.jobTitle}</strong></td>
        <td>${a.companyName}</td>
        <td>${a.interviewRound || 'Round 1'}</td>
        <td>${App.formatDate(a.interviewDate)}</td>
        <td>${a.interviewTime || '—'}</td>
        <td>${a.interviewMode || 'Not specified'}</td>
        <td>${a.interviewVenue || a.interviewLink || '—'}</td>
        <td>${a.interviewer || '—'}</td>
        <td>${a.interviewRemarks || a.remarks || '—'}</td>
        <td>${App.getStatusBadge(a.status === 'rejected' ? 'cancelled' : (a.interviewStatus || (new Date(a.interviewDate) < today ? 'completed' : 'scheduled')))}</td>
      </tr>`;

    const upcoming = apps.filter(a => a.status !== 'rejected' && new Date(a.interviewDate) >= today && (!a.interviewStatus || a.interviewStatus === 'scheduled'));
    const todays = upcoming.filter(a => new Date(a.interviewDate).toDateString() === today.toDateString());
    const completed = apps.filter(a => a.interviewStatus === 'completed' || (a.status !== 'rejected' && new Date(a.interviewDate) < today));
    const cancelled = apps.filter(a => a.status === 'rejected' || a.interviewStatus === 'cancelled');

    const fill = (id, list) => {
      const tbody = document.getElementById(id);
      if (!tbody) return;
      tbody.innerHTML = list.map(rowFor).join('') || `<tr><td colspan="10" class="text-center text-muted py-4">None</td></tr>`;
    };
    // Backward-compatible single table (if page still uses one tbody).
    fill('interviewTableBody', apps);
    fill('upcomingInterviewsBody', upcoming);
    fill('todayInterviewsBody', todays);
    fill('completedInterviewsBody', completed);
    fill('cancelledInterviewsBody', cancelled);
  },

  renderSelectionStatus() {
    const user = App.currentUser;
    const data = getData();
    const selections = data.applications.filter(a => a.studentId === user.id && a.status === 'selected');

    const bannerEl = document.getElementById('selectionBanner');
    bannerEl.innerHTML = selections.length
      ? `<div class="alert alert-success"><i class="bi bi-trophy me-2"></i><strong>Congratulations!</strong> You have ${selections.length} selection${selections.length > 1 ? 's' : ''}.</div>`
      : `<div class="alert alert-warning"><i class="bi bi-hourglass-split me-2"></i>No selections yet — keep applying and preparing for interviews.</div>`;

    const listEl = document.getElementById('selectionList');
    listEl.innerHTML = selections.map(a => {
      const job = data.jobs.find(j => j.id === a.jobId);
      const offerStatus = (user.placed && user.company === a.companyName) ? 'Joined' : (a.offerStatus || 'Offer Received');
      return `
      <div class="activity-item">
        <div class="activity-icon stat-icon green"><i class="bi bi-trophy"></i></div>
        <div class="activity-content">
          <h6>${a.jobTitle} — ${a.companyName}</h6>
          <p>Package: ${job ? job.salary : '—'} &nbsp;•&nbsp; ${App.getStatusBadge(offerStatus)}</p>
          <p class="small text-muted mb-0">Selection Date: ${App.formatDate(a.selectionDate || a.interviewDate || a.appliedAt)} &nbsp;•&nbsp; Joining Date: ${user.joiningDate ? App.formatDate(user.joiningDate) : 'Not confirmed yet'}</p>
        </div>
      </div>`;
    }).join('') || '<p class="text-muted">No selections yet</p>';

    const rejections = data.applications.filter(a => a.studentId === user.id && a.status === 'rejected');
    const rejectedEl = document.getElementById('rejectedList');
    if (rejectedEl) {
      rejectedEl.innerHTML = rejections.map(a => `
        <div class="activity-item">
          <div class="activity-icon stat-icon red"><i class="bi bi-x-circle"></i></div>
          <div class="activity-content">
            <h6>${a.jobTitle} — ${a.companyName}</h6>
            <p>${App.getStatusBadge('rejected')}</p>
            <span class="time">Applied: ${App.formatDate(a.appliedAt)}${a.remarks ? ` • Remarks: ${a.remarks}` : ''}</span>
          </div>
        </div>`).join('') || '<p class="text-muted">No rejections</p>';
    }
  },

  // Spec #10: "Show student's confirmed historical placements" — sourced
  // from the shared data.placements records (placementId, applicationId,
  // studentId, companyId, jobId) that Tpo.confirmPlacement() writes, i.e.
  // only placements the TPO has formally confirmed, not every application
  // or even every 'selected' application.
  renderPlacementHistory() {
    const data = getData();
    const placements = data.placements
      .filter(p => p.studentId === App.currentUser.id)
      .sort((a, b) => new Date(b.placementDate) - new Date(a.placementDate));

    const tbody = document.getElementById('historyTableBody');
    if (!tbody) return;

    tbody.innerHTML = placements.map(p => {
      const app = data.applications.find(a => a.id === p.applicationId);
      return `
      <tr data-searchable>
        <td>${app ? App.formatDate(app.appliedAt) : '—'}</td>
        <td><strong>${app ? app.jobTitle : '—'}</strong></td>
        <td>${app ? app.companyName : '—'}</td>
        <td>${app && app.interviewDate ? App.formatDate(app.interviewDate) : '—'}</td>
        <td>${App.getStatusBadge('Placed')} <small class="text-muted d-block">Confirmed: ${App.formatDate(p.placementDate)}</small></td>
      </tr>`;
    }).join('') || '<tr><td colspan="5" class="text-center text-muted py-4">No confirmed placements yet</td></tr>';
  },

  renderNotifications() {
    const user = App.currentUser;
    const data = getData();
    let notifs = data.notifications.filter(n => n.userType === 'student' && (n.userId === user.id || n.userId === 'student'));

    const searchTerm = (document.getElementById('notificationSearch')?.value || '').toLowerCase();
    if (searchTerm) notifs = notifs.filter(n => n.title.toLowerCase().includes(searchTerm) || n.message.toLowerCase().includes(searchTerm));

    const filterSel = document.getElementById('notificationFilter');
    if (filterSel?.value === 'unread') notifs = notifs.filter(n => !n.read);
    else if (filterSel?.value === 'read') notifs = notifs.filter(n => n.read);

    const listEl = document.getElementById('notificationsList');
    if (!listEl) return;

    listEl.innerHTML = notifs.map(n => `
      <div class="activity-item">
        <div class="activity-icon stat-icon ${n.read ? 'blue' : 'orange'}"><i class="bi bi-bell"></i></div>
        <div class="activity-content flex-grow-1">
          <h6>${n.title} ${!n.read ? '<span class="badge bg-danger ms-1">New</span>' : ''}</h6>
          <p>${n.message}</p>
          <span class="time">${n.time}</span>
        </div>
        <div class="d-flex gap-2 align-items-start">
          <button type="button" class="btn btn-sm btn-outline-custom" onclick="Student.toggleNotificationRead('${n.id}')">${n.read ? 'Mark Unread' : 'Mark Read'}</button>
          <button type="button" class="btn btn-sm btn-outline-danger" onclick="Student.deleteNotification('${n.id}')"><i class="bi bi-trash"></i></button>
        </div>
      </div>`).join('') || '<p class="text-muted">No notifications</p>';
  },

  markAllNotificationsRead() {
    const user = App.currentUser;
    const data = getData();
    data.notifications.forEach(n => {
      if (n.userType === 'student' && (n.userId === user.id || n.userId === 'student')) n.read = true;
    });
    saveData(data);
    this.renderNotifications();
    App.showToast('All notifications marked as read');
  },

  toggleNotificationRead(id) {
    const data = getData();
    const n = data.notifications.find(x => x.id === id);
    if (!n) return;
    n.read = !n.read;
    saveData(data);
    this.renderNotifications();
  },

  deleteNotification(id) {
    App.confirmDelete('Delete this notification?', () => {
      const data = getData();
      data.notifications = data.notifications.filter(n => n.id !== id);
      saveData(data);
      this.renderNotifications();
      App.showToast('Notification deleted');
    });
  },

  renderAnnouncements() {
    // Reads the TPO/Admin-managed shared `notices` entity (spec section 23) so a
    // notice published from the TPO panel shows up here automatically — this is
    // the same audience-targeted record, not an isolated student-only dataset.
    const data = getData();
    const user = App.currentUser;
    const listEl = document.getElementById('announcementsList');
    if (!listEl) return;

    const today = new Date(); today.setHours(0, 0, 0, 0);

    const targetsMe = n => {
      const aud = (n.audience || 'all').toLowerCase();
      if (aud === 'all' || aud === 'students') return true;
      if (user.branch && aud === user.branch.toLowerCase()) return true;
      if (user.year && aud === String(user.year).toLowerCase()) return true;
      return false;
    };

    const notices = (data.notices || [])
      .filter(n => n.status !== 'inactive')
      .filter(n => !n.expiryDate || new Date(n.expiryDate) >= today)
      .filter(targetsMe)
      .slice()
      .sort((a, b) => new Date(b.postedAt) - new Date(a.postedAt));

    listEl.innerHTML = notices.map(n => `
      <div class="activity-item">
        <div class="activity-icon stat-icon purple"><i class="bi bi-megaphone"></i></div>
        <div class="activity-content">
          <h6>${n.title} ${n.category ? `<span class="badge bg-light text-dark ms-1">${n.category}</span>` : ''}</h6>
          <p>${n.description}</p>
          <span class="time">Published ${App.formatDate(n.postedAt)}${n.expiryDate ? ` • Valid till ${App.formatDate(n.expiryDate)}` : ''}${n.attachment ? ` • <a href="${n.attachment}" target="_blank">Attachment</a>` : ''}</span>
        </div>
      </div>`).join('') || '<p class="text-muted">No announcements yet</p>';
  },

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

    if (App.resetPassword(user.email, next, 'student')) {
      App.setSession({ ...user, password: next });
      App.showToast('Password updated successfully');
      form.reset();
    } else {
      App.showToast('Could not update password', 'error');
    }
  }
};
