/**
 * Company Module JavaScript
 */

const Company = {
  initDashboard() {
    const user = App.currentUser;
    const data = getData();
    const myJobs = data.jobs.filter(j => j.companyId === user.id);
    const myApps = data.applications.filter(a => a.companyId === user.id);
    const shortlisted = myApps.filter(a => a.status === 'shortlisted');
    const selected = myApps.filter(a => a.status === 'selected');

    document.getElementById('statJobs').textContent = myJobs.length;
    document.getElementById('statApplications').textContent = myApps.length;
    document.getElementById('statShortlisted').textContent = shortlisted.length;
    document.getElementById('statSelected').textContent = selected.length;

    const recentEl = document.getElementById('recentApplications');
    if (recentEl) {
      recentEl.innerHTML = myApps.slice(0, 5).map(a => `
        <div class="activity-item">
          <div class="activity-icon stat-icon blue"><i class="bi bi-person"></i></div>
          <div class="activity-content">
            <h6>${a.studentName}</h6>
            <p>Applied for ${a.jobTitle}</p>
            <span class="time">${App.formatDate(a.appliedAt)} • ${App.getStatusBadge(a.status)}</span>
          </div>
        </div>`).join('') || '<p class="text-muted">No applications yet</p>';
    }
  },

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

  postJob() {
    const form = document.getElementById('postJobForm');
    if (!App.validateForm(form)) return;

    const user = App.currentUser;
    const data = getData();
    data.jobs.push({
      id: generateId('JOB'),
      title: document.getElementById('jobTitle').value,
      companyId: user.id,
      companyName: user.name,
      type: document.getElementById('jobType').value,
      location: document.getElementById('jobLocation').value,
      salary: document.getElementById('jobSalary').value,
      cgpaMin: parseFloat(document.getElementById('jobCgpa').value),
      branches: document.getElementById('jobBranches').value.split(',').map(b => b.trim()),
      skills: document.getElementById('jobSkills').value.split(',').map(s => s.trim()),
      description: document.getElementById('jobDescription').value,
      deadline: document.getElementById('jobDeadline').value,
      status: 'active',
      postedAt: new Date().toISOString().split('T')[0],
      openings: parseInt(document.getElementById('jobOpenings').value) || 1
    });
    saveData(data);
    addActivity('New Job Posted', `${user.name} posted ${document.getElementById('jobTitle').value}`);
    App.showToast('Job posted successfully!');
    setTimeout(() => window.location.href = 'manage-jobs.aspx', 1500);
  },

  renderManageJobs() {
    const user = App.currentUser;
    const data = getData();
    const jobs = data.jobs.filter(j => j.companyId === user.id);
    const tbody = document.getElementById('jobsTableBody');
    if (!tbody) return;

    tbody.innerHTML = jobs.map(j => `
      <tr data-searchable>
        <td><strong>${j.title}</strong></td>
        <td>${j.type}</td>
        <td>${j.location}</td>
        <td>${j.salary}</td>
        <td>${data.applications.filter(a => a.jobId === j.id).length}</td>
        <td>${App.getStatusBadge(j.status)}</td>
        <td>
          <button class="btn-icon me-1" onclick="Company.toggleJobStatus('${j.id}')" title="Toggle Status"><i class="bi bi-toggle-on"></i></button>
          <button class="btn-icon danger" onclick="Company.deleteJob('${j.id}')"><i class="bi bi-trash"></i></button>
        </td>
      </tr>`).join('') || '<tr><td colspan="7" class="text-center text-muted py-4">No jobs posted</td></tr>';
  },

  toggleJobStatus(id) {
    const data = getData();
    const job = data.jobs.find(j => j.id === id);
    if (job) {
      job.status = job.status === 'active' ? 'closed' : 'active';
      saveData(data);
      Company.renderManageJobs();
      App.showToast(`Job ${job.status}`);
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

  renderApplications() {
    const user = App.currentUser;
    const data = getData();
    const apps = data.applications.filter(a => a.companyId === user.id);
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
            <select class="form-select form-select-sm" style="width:auto" onchange="Company.updateStatus('${a.id}', this.value)">
              <option value="">Action</option>
              <option value="shortlisted">Shortlist</option>
              <option value="selected">Select</option>
              <option value="rejected">Reject</option>
            </select>
          </td>
        </tr>`;
    }).join('') || '<tr><td colspan="6" class="text-center text-muted py-4">No applications</td></tr>';

    App.filterTable('appStatusFilter', 'applicationsTableBody', 'status');
  },

  updateStatus(id, status) {
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
      addNotification(app.studentId, 'student', 'Application Update', `Your ${app.jobTitle} application is ${status}`);
      Company.renderApplications();
      App.showToast('Status updated');
    }
  },

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
            <button class="btn btn-sm btn-primary-custom" onclick="Company.selectStudent('${a.id}')">Select</button>
          </td>
        </tr>`;
    }).join('') || '<tr><td colspan="6" class="text-center text-muted py-4">No shortlisted students</td></tr>';
  },

  selectStudent(id) {
    Company.updateStatus(id, 'selected');
    Company.renderShortlist();
    App.showToast('Student selected!');
  },

  renderSelected() {
    const user = App.currentUser;
    const data = getData();
    const apps = data.applications.filter(a => a.companyId === user.id && a.status === 'selected');
    const tbody = document.getElementById('selectedTableBody');
    if (!tbody) return;

    tbody.innerHTML = apps.map(a => `
      <tr data-searchable>
        <td><span class="table-avatar">${App.getInitials(a.studentName)}</span></td>
        <td><strong>${a.studentName}</strong></td>
        <td>${a.jobTitle}</td>
        <td>${App.formatDate(a.appliedAt)}</td>
        <td>${App.getStatusBadge('selected')}</td>
      </tr>`).join('') || '<tr><td colspan="5" class="text-center text-muted py-4">No selected students</td></tr>';
  },

  renderNotifications() {
    const user = App.currentUser;
    const data = getData();
    const notifs = data.notifications.filter(n => n.userId === user.id || n.userType === 'company');
    const container = document.getElementById('notificationsList');
    if (!container) return;

    container.innerHTML = notifs.map(n => `
      <div class="activity-item ${n.read ? 'opacity-75' : ''}">
        <div class="activity-icon stat-icon ${n.read ? 'blue' : 'red'}"><i class="bi bi-bell"></i></div>
        <div class="activity-content flex-grow-1">
          <h6>${n.title} ${!n.read ? '<span class="badge bg-danger ms-1">New</span>' : ''}</h6>
          <p>${n.message}</p>
          <span class="time">${n.time}</span>
        </div>
        ${!n.read ? `<button class="btn btn-sm btn-outline-custom" onclick="Company.markRead('${n.id}')">Mark Read</button>` : ''}
      </div>`).join('') || '<div class="empty-state"><i class="bi bi-bell"></i><p>No notifications</p></div>';
  },

  markRead(id) {
    const data = getData();
    const notif = data.notifications.find(n => n.id === id);
    if (notif) { notif.read = true; saveData(data); Company.renderNotifications(); }
  }
};
