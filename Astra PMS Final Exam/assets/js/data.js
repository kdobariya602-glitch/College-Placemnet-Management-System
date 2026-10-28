/**
 * Placement Management System - Sample Data & LocalStorage
 */

const PMS_STORAGE_KEY = 'pms_data';

const sampleData = {
  admin: {
    id: 'admin1',
    name: 'Dr. Rajesh Kumar',
    email: 'admin@university.edu',
    password: 'admin123',
    role: 'admin'
  },
  students: [
    { id: 'STU001', name: 'Aarav Sharma', email: 'aarav@student.edu', password: 'student123', phone: '+91 98765 43210', gender: 'Male', dob: '2004-05-12', address: 'Mumbai, Maharashtra', branch: 'Computer Science', course: 'B.Tech Computer Science', semester: '8th', cgpa: 8.7, backlogs: 0, year: '2026', skills: ['JavaScript', 'React', 'Node.js'], status: 'active', placed: true, company: 'TCS', photoUrl: '', registeredAt: '2025-08-15' },
    { id: 'STU002', name: 'Priya Patel', email: 'priya@student.edu', password: 'student123', phone: '+91 98765 43211', gender: 'Female', dob: '2004-02-20', address: 'Ahmedabad, Gujarat', branch: 'Information Technology', course: 'B.Tech Information Technology', semester: '8th', cgpa: 9.1, backlogs: 0, year: '2026', skills: ['Python', 'Machine Learning', 'SQL'], status: 'active', placed: true, company: 'Infosys', photoUrl: '', registeredAt: '2025-08-16' },
    { id: 'STU003', name: 'Rahul Verma', email: 'rahul@student.edu', password: 'student123', phone: '+91 98765 43212', gender: 'Male', dob: '2004-07-08', address: 'Pune, Maharashtra', branch: 'Electronics', course: 'B.Tech Electronics', semester: '8th', cgpa: 7.8, backlogs: 1, year: '2026', skills: ['Embedded Systems', 'C++', 'IoT'], status: 'active', placed: false, company: null, photoUrl: '', registeredAt: '2025-08-17' },
    { id: 'STU004', name: 'Sneha Reddy', email: 'sneha@student.edu', password: 'student123', phone: '+91 98765 43213', gender: 'Female', dob: '2004-11-30', address: 'Hyderabad, Telangana', branch: 'Computer Science', course: 'B.Tech Computer Science', semester: '8th', cgpa: 8.5, backlogs: 0, year: '2026', skills: ['Java', 'Spring Boot', 'AWS'], status: 'active', placed: false, company: null, photoUrl: '', registeredAt: '2025-08-18' },
    { id: 'STU005', name: 'Vikram Singh', email: 'vikram@student.edu', password: 'student123', phone: '+91 98765 43214', gender: 'Male', dob: '2004-03-15', address: 'Jaipur, Rajasthan', branch: 'Mechanical', course: 'B.Tech Mechanical', semester: '8th', cgpa: 7.5, backlogs: 2, year: '2026', skills: ['AutoCAD', 'SolidWorks', 'MATLAB'], status: 'active', placed: true, company: 'L&T', photoUrl: '', registeredAt: '2025-08-19' },
    { id: 'STU006', name: 'Ananya Iyer', email: 'ananya@student.edu', password: 'student123', phone: '+91 98765 43215', gender: 'Female', dob: '2004-09-25', address: 'Chennai, Tamil Nadu', branch: 'Computer Science', course: 'B.Tech Computer Science', semester: '8th', cgpa: 9.3, backlogs: 0, year: '2026', skills: ['React', 'TypeScript', 'GraphQL'], status: 'active', placed: false, company: null, photoUrl: '', registeredAt: '2025-08-20' },
    { id: 'STU007', name: 'Karan Malhotra', email: 'karan@student.edu', password: 'student123', phone: '+91 98765 43216', gender: 'Male', dob: '2004-01-18', address: 'Delhi, NCR', branch: 'Information Technology', course: 'B.Tech Information Technology', semester: '8th', cgpa: 8.0, backlogs: 1, year: '2026', skills: ['DevOps', 'Docker', 'Kubernetes'], status: 'active', placed: false, company: null, photoUrl: '', registeredAt: '2025-08-21' },
    { id: 'STU008', name: 'Divya Nair', email: 'divya@student.edu', password: 'student123', phone: '+91 98765 43217', gender: 'Female', dob: '2004-06-05', address: 'Kochi, Kerala', branch: 'Electronics', course: 'B.Tech Electronics', semester: '8th', cgpa: 8.9, backlogs: 0, year: '2026', skills: ['VLSI', 'Verilog', 'FPGA'], status: 'active', placed: true, company: 'Wipro', photoUrl: '', registeredAt: '2025-08-22' }
  ],
  companies: [
    { id: 'COM001', name: 'TCS', email: 'hr@tcs.com', password: 'company123', industry: 'IT Services', website: 'https://tcs.com', location: 'Mumbai', contact: '+91 22 6778 9595', description: 'Leading global IT services company.', status: 'active', registeredAt: '2025-07-01' },
    { id: 'COM002', name: 'Infosys', email: 'careers@infosys.com', password: 'company123', industry: 'IT Services', website: 'https://infosys.com', location: 'Bangalore', contact: '+91 80 2852 0261', description: 'Digital services and consulting company.', status: 'active', registeredAt: '2025-07-05' },
    { id: 'COM003', name: 'Wipro', email: 'hr@wipro.com', password: 'company123', industry: 'IT Services', website: 'https://wipro.com', location: 'Bangalore', contact: '+91 80 2844 0011', description: 'Global technology services provider.', status: 'active', registeredAt: '2025-07-10' },
    { id: 'COM004', name: 'Google', email: 'university@google.com', password: 'company123', industry: 'Technology', website: 'https://google.com', location: 'Hyderabad', contact: '+91 40 6721 8000', description: 'Global technology leader.', status: 'active', registeredAt: '2025-07-15' },
    { id: 'COM005', name: 'Microsoft', email: 'campus@microsoft.com', password: 'company123', industry: 'Technology', website: 'https://microsoft.com', location: 'Hyderabad', contact: '+91 40 6658 5000', description: 'Leading software and cloud company.', status: 'active', registeredAt: '2025-07-20' },
    { id: 'COM006', name: 'L&T', email: 'campus@lnt.com', password: 'company123', industry: 'Engineering', website: 'https://larsentoubro.com', location: 'Mumbai', contact: '+91 22 6752 5656', description: 'Engineering and construction conglomerate.', status: 'active', registeredAt: '2025-07-25' }
  ],
  jobs: [
    { id: 'JOB001', title: 'Software Engineer', companyId: 'COM001', companyName: 'TCS', type: 'Full-time', location: 'Mumbai', salary: '₹6-8 LPA', cgpaMin: 7.0, branches: ['Computer Science', 'Information Technology'], skills: ['Java', 'Python', 'SQL'], description: 'Develop and maintain enterprise applications.', deadline: '2026-03-15', status: 'active', postedAt: '2026-01-10', openings: 15 },
    { id: 'JOB002', title: 'Data Analyst', companyId: 'COM002', companyName: 'Infosys', type: 'Full-time', location: 'Bangalore', salary: '₹7-9 LPA', cgpaMin: 7.5, branches: ['Computer Science', 'Information Technology'], skills: ['Python', 'SQL', 'Tableau'], description: 'Analyze business data and create insights.', deadline: '2026-03-20', status: 'active', postedAt: '2026-01-12', openings: 10 },
    { id: 'JOB003', title: 'Frontend Developer', companyId: 'COM004', companyName: 'Google', type: 'Full-time', location: 'Hyderabad', salary: '₹15-20 LPA', cgpaMin: 8.5, branches: ['Computer Science'], skills: ['JavaScript', 'React', 'TypeScript'], description: 'Build user-facing web applications.', deadline: '2026-02-28', status: 'active', postedAt: '2026-01-05', openings: 5 },
    { id: 'JOB004', title: 'Cloud Engineer', companyId: 'COM005', companyName: 'Microsoft', type: 'Full-time', location: 'Hyderabad', salary: '₹12-16 LPA', cgpaMin: 8.0, branches: ['Computer Science', 'Information Technology'], skills: ['Azure', 'DevOps', 'Kubernetes'], description: 'Design and implement cloud solutions.', deadline: '2026-03-10', status: 'active', postedAt: '2026-01-08', openings: 8 },
    { id: 'JOB005', title: 'Graduate Engineer Trainee', companyId: 'COM006', companyName: 'L&T', type: 'Full-time', location: 'Mumbai', salary: '₹5-7 LPA', cgpaMin: 7.0, branches: ['Mechanical', 'Electronics', 'Civil'], skills: ['AutoCAD', 'Project Management'], description: 'Training program for engineering graduates.', deadline: '2026-04-01', status: 'active', postedAt: '2026-01-15', openings: 20 },
    { id: 'JOB006', title: 'Backend Developer', companyId: 'COM003', companyName: 'Wipro', type: 'Full-time', location: 'Bangalore', salary: '₹8-10 LPA', cgpaMin: 7.5, branches: ['Computer Science', 'Information Technology'], skills: ['Java', 'Spring Boot', 'Microservices'], description: 'Develop scalable backend systems.', deadline: '2026-03-25', status: 'active', postedAt: '2026-01-18', openings: 12 },
    { id: 'JOB007', title: 'ML Engineer Intern', companyId: 'COM004', companyName: 'Google', type: 'Internship', location: 'Hyderabad', salary: '₹50K/month', cgpaMin: 8.0, branches: ['Computer Science'], skills: ['Python', 'TensorFlow', 'ML'], description: '6-month ML engineering internship.', deadline: '2026-02-15', status: 'closed', postedAt: '2025-12-01', openings: 3 }
  ],
  drives: [
    { id: 'DRV001', name: 'TCS Campus Drive 2026', companyId: 'COM001', companyName: 'TCS', jobRole: 'Software Engineer', date: '2026-02-15', time: '09:30 AM', venue: 'Main Auditorium', mode: 'Offline', eligibility: 'CGPA ≥ 7.0, CS/IT', registrationDeadline: '2026-02-10', status: 'upcoming', registered: 45 },
    { id: 'DRV002', name: 'Infosys Super Drive', companyId: 'COM002', companyName: 'Infosys', jobRole: 'Data Analyst', date: '2026-02-20', time: '10:00 AM', venue: 'Seminar Hall A', mode: 'Offline', eligibility: 'CGPA ≥ 7.5, All Branches', registrationDeadline: '2026-02-15', status: 'upcoming', registered: 62 },
    { id: 'DRV003', name: 'Google Tech Talk & Hiring', companyId: 'COM004', companyName: 'Google', jobRole: 'ML Engineer Intern', date: '2026-01-25', time: '11:00 AM', venue: 'Conference Room', mode: 'Online', eligibility: 'CGPA ≥ 8.5, CS Only', registrationDeadline: '2026-01-20', status: 'completed', registered: 30 },
    { id: 'DRV004', name: 'Microsoft Azure Workshop', companyId: 'COM005', companyName: 'Microsoft', jobRole: 'Cloud Engineer', date: '2026-03-05', time: '02:00 PM', venue: 'Lab Block B', mode: 'Hybrid', eligibility: 'CGPA ≥ 8.0, CS/IT', registrationDeadline: '2026-02-28', status: 'upcoming', registered: 38 },
    { id: 'DRV005', name: 'L&T Engineering Drive', companyId: 'COM006', companyName: 'L&T', jobRole: 'Graduate Engineer Trainee', date: '2026-02-28', time: '09:00 AM', venue: 'Main Auditorium', mode: 'Offline', eligibility: 'CGPA ≥ 7.0, Core Branches', registrationDeadline: '2026-02-22', status: 'upcoming', registered: 55 }
  ],
  applications: [
    { id: 'APP001', studentId: 'STU001', studentName: 'Aarav Sharma', jobId: 'JOB001', jobTitle: 'Software Engineer', companyId: 'COM001', companyName: 'TCS', status: 'selected', appliedAt: '2026-01-12', interviewDate: '2026-02-01' },
    { id: 'APP002', studentId: 'STU002', studentName: 'Priya Patel', jobId: 'JOB002', jobTitle: 'Data Analyst', companyId: 'COM002', companyName: 'Infosys', status: 'selected', appliedAt: '2026-01-14', interviewDate: '2026-02-05' },
    { id: 'APP003', studentId: 'STU003', studentName: 'Rahul Verma', jobId: 'JOB001', jobTitle: 'Software Engineer', companyId: 'COM001', companyName: 'TCS', status: 'shortlisted', appliedAt: '2026-01-13', interviewDate: '2026-02-15' },
    { id: 'APP004', studentId: 'STU004', studentName: 'Sneha Reddy', jobId: 'JOB003', jobTitle: 'Frontend Developer', companyId: 'COM004', companyName: 'Google', status: 'pending', appliedAt: '2026-01-16', interviewDate: null },
    { id: 'APP005', studentId: 'STU005', studentName: 'Vikram Singh', jobId: 'JOB005', jobTitle: 'Graduate Engineer Trainee', companyId: 'COM006', companyName: 'L&T', status: 'selected', appliedAt: '2026-01-17', interviewDate: '2026-02-10' },
    { id: 'APP006', studentId: 'STU006', studentName: 'Ananya Iyer', jobId: 'JOB003', jobTitle: 'Frontend Developer', companyId: 'COM004', companyName: 'Google', status: 'shortlisted', appliedAt: '2026-01-18', interviewDate: '2026-02-20' },
    { id: 'APP007', studentId: 'STU007', studentName: 'Karan Malhotra', jobId: 'JOB004', jobTitle: 'Cloud Engineer', companyId: 'COM005', companyName: 'Microsoft', status: 'pending', appliedAt: '2026-01-19', interviewDate: null },
    { id: 'APP008', studentId: 'STU008', studentName: 'Divya Nair', jobId: 'JOB006', jobTitle: 'Backend Developer', companyId: 'COM003', companyName: 'Wipro', status: 'selected', appliedAt: '2026-01-20', interviewDate: '2026-02-08' },
    { id: 'APP009', studentId: 'STU003', studentName: 'Rahul Verma', jobId: 'JOB006', jobTitle: 'Backend Developer', companyId: 'COM003', companyName: 'Wipro', status: 'rejected', appliedAt: '2026-01-21', interviewDate: null },
    { id: 'APP010', studentId: 'STU004', studentName: 'Sneha Reddy', jobId: 'JOB001', jobTitle: 'Software Engineer', companyId: 'COM001', companyName: 'TCS', status: 'shortlisted', appliedAt: '2026-01-22', interviewDate: '2026-02-18' }
  ],
  interviews: [],
  placements: [],
  notifications: [
    { id: 'NOT001', userId: 'admin1', userType: 'admin', title: 'New Company Registered', message: 'Microsoft has registered on the portal.', time: '2 hours ago', read: false },
    { id: 'NOT002', userId: 'admin1', userType: 'admin', title: 'Drive Completed', message: 'Google Tech Talk drive completed successfully.', time: '1 day ago', read: false },
    { id: 'NOT003', userId: 'STU004', userType: 'student', title: 'Application Update', message: 'Your Google application is under review.', time: '3 hours ago', read: false },
    { id: 'NOT004', userId: 'COM001', userType: 'company', title: 'New Application', message: 'Rahul Verma applied for Software Engineer.', time: '1 hour ago', read: false },
    { id: 'NOT005', userId: 'COM004', userType: 'company', title: 'Interview Scheduled', message: 'Interview with Ananya Iyer on Feb 20.', time: '5 hours ago', read: true }
  ],
  tpoOfficers: [
    { id: 'TPO001', name: 'Placement Officer', email: 'tpo@university.edu', password: 'tpo123', status: 'active' }
  ],
  departments: [
    { id: 'DEP001', name: 'Computer Science', code: 'CSE', hod: 'Dr. Anil Mehta', students: 120, status: 'active' },
    { id: 'DEP002', name: 'Information Technology', code: 'IT', hod: 'Dr. Sunita Rao', students: 95, status: 'active' },
    { id: 'DEP003', name: 'Electronics', code: 'ECE', hod: 'Dr. Vivek Nair', students: 80, status: 'active' },
    { id: 'DEP004', name: 'Mechanical', code: 'MECH', hod: 'Dr. Sanjay Gupta', students: 70, status: 'active' }
  ],
  courses: [
    { id: 'CRS001', name: 'B.Tech Computer Science', code: 'BTCSE', department: 'Computer Science', duration: 4, status: 'active' },
    { id: 'CRS002', name: 'B.Tech Information Technology', code: 'BTIT', department: 'Information Technology', duration: 4, status: 'active' },
    { id: 'CRS003', name: 'B.Tech Electronics', code: 'BTECE', department: 'Electronics', duration: 4, status: 'active' }
  ],
  batches: [
    { id: 'BAT001', name: '2022-2026', course: 'B.Tech Computer Science', startYear: 2022, endYear: 2026, students: 60, status: 'active' },
    { id: 'BAT002', name: '2023-2027', course: 'B.Tech Information Technology', startYear: 2023, endYear: 2027, students: 55, status: 'active' }
  ],
  skillsMaster: [
    { id: 'SKL001', name: 'JavaScript', category: 'Technical', status: 'active' },
    { id: 'SKL002', name: 'Python', category: 'Technical', status: 'active' },
    { id: 'SKL003', name: 'Communication', category: 'Soft Skill', status: 'active' },
    { id: 'SKL004', name: 'SQL', category: 'Technical', status: 'active' }
  ],
  jobRoles: [
    { id: 'ROLE001', title: 'Software Engineer', category: 'Engineering', description: 'Designs, builds and maintains software applications.', status: 'active' },
    { id: 'ROLE002', title: 'Data Analyst', category: 'Analytics', description: 'Analyzes data to support business decisions.', status: 'active' },
    { id: 'ROLE003', title: 'Cloud Engineer', category: 'Infrastructure', description: 'Builds and manages cloud infrastructure.', status: 'active' }
  ],
  notices: [
    { id: 'NTC001', title: 'Pre-Placement Talk Schedule Released', description: 'Check the drives page for updated venues and timings for the upcoming pre-placement talks.', category: 'Drive', audience: 'all', postedAt: '2026-01-20', expiryDate: '2026-04-30', attachment: '', status: 'active' },
    { id: 'NTC002', title: 'Resume Submission Deadline', description: 'All final-year students must upload an updated resume before applying to any drive.', category: 'General', audience: 'students', postedAt: '2026-01-15', expiryDate: '2026-04-30', attachment: '', status: 'active' }
  ],
  announcements: [
    { id: 'ANN001', title: 'Pre-Placement Talk Schedule Released', message: 'Check the drives page for updated venues and timings for the upcoming pre-placement talks.', postedBy: 'Placement Cell', date: '2026-01-20' },
    { id: 'ANN002', title: 'Resume Submission Deadline', message: 'All final-year students must upload an updated resume before applying to any drive.', postedBy: 'Placement Cell', date: '2026-01-15' },
    { id: 'ANN003', title: 'Mock Interview Sessions', message: 'Mock interview sessions will be conducted for shortlisted students before every major drive.', postedBy: 'Training & Placement Office', date: '2026-01-08' }
  ],
  activities: [
    { id: 'ACT001', action: 'Student Placed', detail: 'Aarav Sharma placed at TCS', time: '2 hours ago', icon: 'bi-check-circle', color: 'green' },
    { id: 'ACT002', action: 'New Job Posted', detail: 'Wipro posted Backend Developer role', time: '5 hours ago', icon: 'bi-briefcase', color: 'blue' },
    { id: 'ACT003', action: 'Drive Scheduled', detail: 'Microsoft Azure Workshop on Mar 5', time: '1 day ago', icon: 'bi-calendar-event', color: 'purple' },
    { id: 'ACT004', action: 'Application Received', detail: 'Sneha Reddy applied to Google', time: '1 day ago', icon: 'bi-file-earmark-text', color: 'orange' },
    { id: 'ACT005', action: 'Company Registered', detail: 'Microsoft joined the portal', time: '2 days ago', icon: 'bi-building', color: 'teal' },
    { id: 'ACT006', action: 'Student Shortlisted', detail: 'Ananya Iyer shortlisted by Google', time: '2 days ago', icon: 'bi-star', color: 'red' }
  ]
};

function initData() {
  if (!localStorage.getItem(PMS_STORAGE_KEY)) {
    localStorage.setItem(PMS_STORAGE_KEY, JSON.stringify(sampleData));
  }
}

function getData() {
  initData();
  const data = JSON.parse(localStorage.getItem(PMS_STORAGE_KEY));
  // Migration guard: patch missing collections for sessions created before this array existed.
  let patched = false;
  if (!Array.isArray(data.interviews)) { data.interviews = []; patched = true; }
  if (!Array.isArray(data.placements)) { data.placements = []; patched = true; }
  if (patched) saveData(data);
  return data;
}

function saveData(data) {
  localStorage.setItem(PMS_STORAGE_KEY, JSON.stringify(data));
}

function generateId(prefix) {
  const data = getData();
  let items, key;
  switch (prefix) {
    case 'STU': items = data.students; break;
    case 'COM': items = data.companies; break;
    case 'JOB': items = data.jobs; break;
    case 'DRV': items = data.drives; break;
    case 'APP': items = data.applications; break;
    case 'INT': items = data.interviews; break;
    case 'PLC': items = data.placements; break;
    case 'NOT': items = data.notifications; break;
    case 'ACT': items = data.activities; break;
    case 'TPO': items = data.tpoOfficers; break;
    case 'DEP': items = data.departments; break;
    case 'CRS': items = data.courses; break;
    case 'BAT': items = data.batches; break;
    case 'SKL': items = data.skillsMaster; break;
    case 'ROLE': items = data.jobRoles; break;
    case 'NTC': items = data.notices; break;
    default: return prefix + Date.now();
  }
  const num = String(items.length + 1).padStart(3, '0');
  return prefix + num;
}

function getStats() {
  const data = getData();
  const totalStudents = data.students.length;
  const placedStudents = data.students.filter(s => s.placed).length;
  const placementPercentage = totalStudents ? Math.round((placedStudents / totalStudents) * 100) : 0;
  return {
    totalStudents,
    totalCompanies: data.companies.length,
    totalTpos: data.tpoOfficers.length,
    totalJobs: data.jobs.filter(j => j.status === 'active').length,
    totalDrives: data.drives.length,
    upcomingDrives: data.drives.filter(d => d.status === 'upcoming').length,
    totalInterviews: data.interviews.length,
    totalPlacements: placedStudents,
    placementPercentage,
    totalApplications: data.applications.length,
    pendingApplications: data.applications.filter(a => a.status === 'pending').length,
    shortlistedApplications: data.applications.filter(a => a.status === 'shortlisted').length,
    selectedApplications: data.applications.filter(a => a.status === 'selected').length
  };
}

function addActivity(action, detail) {
  const data = getData();
  data.activities.unshift({
    id: generateId('ACT'),
    action,
    detail,
    time: 'Just now',
    icon: 'bi-bell',
    color: 'blue'
  });
  if (data.activities.length > 20) data.activities.pop();
  saveData(data);
}

function addNotification(userId, userType, title, message) {
  const data = getData();
  data.notifications.unshift({
    id: generateId('NOT'),
    userId,
    userType,
    title,
    message,
    time: 'Just now',
    read: false
  });
  saveData(data);
}

initData();
