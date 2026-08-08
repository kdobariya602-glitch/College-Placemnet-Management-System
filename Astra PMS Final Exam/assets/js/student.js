/**
 * Student Module JavaScript
 */

const Student = {
  initDashboard() {
    const user = App.currentUser;
    const data = getData();
    const myApps = data.applications.filter(a => a.studentId === user.id);
    const interviews = myApps.filter(a => a.interviewDate && a.status !== 'rejected');
    const selected = myApps.filter(a => a.status === 'selected');
    const upcomingDrives = data.drives.filter(d => d.status === 'upcoming');

    document.getElementById('statApplied').textContent = myApps.length;
    document.getElementById('statInterviews').textContent = interviews.length;
    document.getElementById('statSelected').textContent = selected.length;
    document.getElementById('statPlacement').textContent = user.placed ? 'Placed' : 'Not Placed';
    document.getElementById('statDrives').textContent = upcomingDrives.length;

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
    document.getElementById('profileAvatar').textContent = App.getInitials(user.name);
    document.getElementById('infoEmail').textContent = user.email;
    document.getElementById('infoPhone').textContent = user.phone || '—';
    document.getElementById('infoBranch').textContent = user.branch;
    document.getElementById('infoCgpa').textContent = user.cgpa;
    document.getElementById('infoYear').textContent = user.year;
    document.getElementById('infoStatus').innerHTML = user.placed 
      ? `<span class="badge badge-status badge-selected">Placed at ${user.company}</span>`
      : App.getStatusBadge('pending');

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
  },

  saveProfile() {
    const form = document.getElementById('editProfileForm');
    if (!App.validateForm(form)) return;

    const data = getData();
    const idx = data.students.findIndex(s => s.id === App.currentUser.id);
    if (idx > -1) {
      data.students[idx].name = document.getElementById('editName').value;
      data.students[idx].phone = document.getElementById('editPhone').value;
      data.students[idx].branch = document.getElementById('editBranch').value;
      data.students[idx].cgpa = parseFloat(document.getElementById('editCgpa').value);
      data.students[idx].skills = document.getElementById('editSkills').value.split(',').map(s => s.trim()).filter(Boolean);
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

    if (filter) jobs = jobs.filter(j => j.title.toLowerCase().includes(filter) || j.companyName.toLowerCase().includes(filter));

    const container = document.getElementById('jobsContainer');
    if (!container) return;

    container.innerHTML = jobs.map(j => {
      const applied = data.applications.some(a => a.studentId === user.id && a.jobId === j.id);
      const eligible = user.cgpa >= j.cgpaMin;
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
            </div>
            <p class="small text-muted mb-3">${j.description.substring(0, 80)}...</p>
            <div class="d-flex justify-content-between align-items-center">
              <small class="text-muted">Deadline: ${App.formatDate(j.deadline)}</small>
              <a href="job-details.aspx?id=${j.id}" class="btn btn-sm ${applied ? 'btn-outline-custom' : 'btn-primary-custom'}">
                ${applied ? 'View' : 'Apply'}
              </a>
            </div>
            ${!eligible ? '<small class="text-danger d-block mt-2"><i class="bi bi-exclamation-circle"></i> Min CGPA: ' + j.cgpaMin + '</small>' : ''}
          </div>
        </div>`;
    }).join('') || '<div class="col-12"><div class="empty-state"><i class="bi bi-briefcase"></i><p>No jobs available</p></div></div>';
  },

  loadJobDetails() {
    const params = new URLSearchParams(window.location.search);
    const jobId = params.get('id');
    const data = getData();
    const job = data.jobs.find(j => j.id === jobId);
    if (!job) { window.location.href = 'jobs.aspx'; return; }

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

    const applyBtn = document.getElementById('applyBtn');
    const applied = data.applications.some(a => a.studentId === App.currentUser.id && a.jobId === jobId);
    if (applied) {
      applyBtn.textContent = 'Already Applied';
      applyBtn.classList.add('disabled');
    } else {
      applyBtn.href = `apply.aspx?id=${jobId}`;
    }
  },

  submitApplication() {
    const params = new URLSearchParams(window.location.search);
    const jobId = params.get('id');
    const data = getData();
    const job = data.jobs.find(j => j.id === jobId);
    const user = App.currentUser;

    if (data.applications.some(a => a.studentId === user.id && a.jobId === jobId)) {
      App.showToast('Already applied', 'warning');
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
      status: 'pending',
      appliedAt: new Date().toISOString().split('T')[0],
      interviewDate: null
    });
    saveData(data);
    addActivity('Application Received', `${user.name} applied to ${job.companyName}`);
    addNotification(job.companyId, 'company', 'New Application', `${user.name} applied for ${job.title}`);
    App.showToast('Application submitted successfully!');
    setTimeout(() => window.location.href = 'applications.aspx', 1500);
  },

  renderApplications() {
    const data = getData();
    const apps = data.applications.filter(a => a.studentId === App.currentUser.id);
    const tbody = document.getElementById('applicationsTableBody');
    if (!tbody) return;

    tbody.innerHTML = apps.map(a => `
      <tr data-searchable>
        <td><strong>${a.jobTitle}</strong></td>
        <td>${a.companyName}</td>
        <td>${App.getStatusBadge(a.status)}</td>
        <td>${App.formatDate(a.appliedAt)}</td>
        <td>${a.interviewDate ? App.formatDate(a.interviewDate) : '—'}</td>
      </tr>`).join('') || '<tr><td colspan="5" class="text-center text-muted py-4">No applications yet</td></tr>';
  },

  renderPlacementStatus() {
    const user = App.currentUser;
    const data = getData();
    const apps = data.applications.filter(a => a.studentId === user.id);

    document.getElementById('placementStatus').innerHTML = user.placed
      ? `<div class="alert alert-success"><i class="bi bi-check-circle me-2"></i><strong>Congratulations!</strong> You have been placed at <strong>${user.company}</strong>.</div>`
      : `<div class="alert alert-warning"><i class="bi bi-hourglass-split me-2"></i>Your placement process is ongoing. Keep applying!</div>`;

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
  }
};
