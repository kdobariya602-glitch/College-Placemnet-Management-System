<%@ Page Title="AI Job Writer" Language="C#" MasterPageFile="~/company/Company_Site4.Master" AutoEventWireup="true" CodeBehind="ai-job-writer.aspx.cs" Inherits="Astra_PMS_Final_Exam.company.ai_job_writer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .role-preset-chip {
            cursor: pointer;
            transition: all 0.2s ease-in-out;
            font-size: 0.78rem;
        }
        .role-preset-chip:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.2);
        }
        .campus-skill-pill {
            cursor: pointer;
            transition: all 0.2s;
        }
        .campus-skill-pill:hover {
            transform: scale(1.04);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-content">
        <div class="ai-tabs-scroller">
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link" href="ai-assistant.aspx"><i class="bi bi-robot"></i><span>AI Recruiter Copilot</span></a></li>
            <li class="nav-item"><a class="nav-link active" href="ai-job-writer.aspx"><i class="bi bi-pencil-square"></i><span>AI Job Description Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-interview-questions.aspx"><i class="bi bi-patch-question"></i><span>AI Technical Questions Generator</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-candidate-screener.aspx"><i class="bi bi-person-check"></i><span>AI Candidate Screener</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-campus-feedback.aspx"><i class="bi bi-chat-heart"></i><span>AI Campus Feedback Review</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-offer-drafter.aspx"><i class="bi bi-award"></i><span>AI Offer Letter Terms Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-scorecard-generator.aspx"><i class="bi bi-card-checklist"></i><span>AI Scorecard & Evaluation Remarks</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-internship-scope.aspx"><i class="bi bi-rocket-takeoff"></i><span>AI Internship Scope Drafter</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-talent-matching.aspx"><i class="bi bi-trophy"></i><span>AI Neural Candidate Matcher</span></a></li>
            <li class="nav-item"><a class="nav-link" href="ai-outreach-invitation.aspx"><i class="bi bi-megaphone"></i><span>AI Campus Invitation Drafter</span></a></li>
        </ul>
    </div>
        <div class="mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-1">
                    <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                    <li class="breadcrumb-item active">AI Job Writer</li>
                </ol>
            </nav>
            <div class="d-flex align-items-center gap-2">
                <h3 class="fw-bold mb-0 text-gradient"><i class="bi bi-stars text-primary me-2"></i>Astra AI Job Architect &amp; JD Generator</h3>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 px-2 py-1"><i class="bi bi-cpu me-1"></i>Neural v3.0</span>
            </div>
            <small class="text-muted">Draft structured, campus-appealing job descriptions, technical competencies, and screening guidelines aligned with student skill supply.</small>
        </div>

        

        <asp:Label ID="lblMsg" runat="server"></asp:Label>

        <!-- Role Presets Carousel / Quick Buttons -->
        <div class="content-card p-3 mb-4 shadow-sm border">
            <div class="d-flex align-items-center gap-2 mb-2">
                <i class="bi bi-magic text-primary"></i>
                <span class="fw-semibold small">1-Click Industry Job Presets:</span>
                <small class="text-muted">(Click any role to prefill parameters)</small>
            </div>
            <div class="d-flex flex-wrap gap-2">
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2 role-preset-chip" onclick="applyPreset('Junior .NET Developer', 'C#, ASP.NET, SQL Server, HTML, CSS, JavaScript', 'Fresher', 'On-site')">
                    <i class="bi bi-code-slash me-1"></i>.NET / C# Developer
                </a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2 role-preset-chip" onclick="applyPreset('Frontend React Engineer', 'React, JavaScript, HTML5, CSS3, Tailwind, Git', 'Fresher', 'Hybrid')">
                    <i class="bi bi-laptop me-1"></i>React / Frontend Dev
                </a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2 role-preset-chip" onclick="applyPreset('Python AI / ML Trainee', 'Python, Machine Learning, SQL, Pandas, NumPy, Deep Learning', 'Fresher', 'On-site')">
                    <i class="bi bi-robot me-1"></i>Python / AI Trainee
                </a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2 role-preset-chip" onclick="applyPreset('Data & Business Intelligence Analyst', 'SQL, PowerBI, Excel, Python, Statistics, Tableau', 'Fresher', 'Hybrid')">
                    <i class="bi bi-bar-chart-line me-1"></i>Data / BI Analyst
                </a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2 role-preset-chip" onclick="applyPreset('Cloud DevOps Engineer', 'AWS, Azure, Docker, Linux, CI/CD, Git, Shell Scripting', 'Intermediate', 'Remote')">
                    <i class="bi bi-cloud-check me-1"></i>DevOps / Cloud
                </a>
                <a href="javascript:void(0);" class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 text-decoration-none px-3 py-2 role-preset-chip" onclick="applyPreset('Quality Assurance & Automation Tester', 'Selenium, Java, Manual Testing, SQL, JIRA, Test Cases', 'Fresher', 'On-site')">
                    <i class="bi bi-check2-all me-1"></i>QA / Automation
                </a>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left: Settings & Campus Pool -->
            <div class="col-lg-5">
                <div class="content-card p-3 p-md-4 shadow-sm border mb-4">
                    <h6 class="fw-bold mb-3 pb-2 border-bottom"><i class="bi bi-sliders text-primary me-2"></i>Job Specifications</h6>
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="form-label small fw-semibold text-muted mb-0">Job Title / Designation *</label>
                            <button type="button" class="btn btn-sm btn-outline-primary rounded-pill py-0 px-2" onclick="dictateField('<%= txtTitle.ClientID %>', this)"><i class="bi bi-mic-fill me-1"></i>Voice Speak</button>
                        </div>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="e.g. Junior .NET Developer" MaxLength="100"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="form-label small fw-semibold text-muted mb-0">Required Skills (comma separated) *</label>
                            <button type="button" class="btn btn-sm btn-outline-primary rounded-pill py-0 px-2" onclick="dictateField('<%= txtSkills.ClientID %>', this)"><i class="bi bi-mic-fill me-1"></i>Voice Speak</button>
                        </div>
                        <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" placeholder="e.g. C#, SQL, ASP.NET, JavaScript" MaxLength="200"></asp:TextBox>
                        <small class="text-muted" style="font-size:0.75rem;">Tip: Click skills from the Campus Talent Pool below or speak them via microphone.</small>
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Experience Level</label>
                            <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Fresher (Campus Batch)" Value="Fresher"></asp:ListItem>
                                <asp:ListItem Text="Intermediate (1-3 yrs)" Value="Intermediate"></asp:ListItem>
                                <asp:ListItem Text="Senior (3+ yrs)" Value="Senior"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Work Arrangement</label>
                            <asp:DropDownList ID="ddlMode" runat="server" CssClass="form-select">
                                <asp:ListItem Text="On-site / Campus" Value="On-site"></asp:ListItem>
                                <asp:ListItem Text="Hybrid" Value="Hybrid"></asp:ListItem>
                                <asp:ListItem Text="Remote" Value="Remote"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <asp:Button ID="btnGen" runat="server" Text="Synthesize Job Description" CssClass="btn btn-primary w-100 fw-semibold shadow-sm py-2" OnClick="btnGen_Click" />
                </div>

                <div class="content-card p-3 shadow-sm border">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <h6 class="fw-bold mb-0"><i class="bi bi-people-fill text-primary me-1"></i>Campus Talent Supply Matrix</h6>
                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25" style="font-size:0.7rem;">Live Database</span>
                    </div>
                    <small class="text-muted d-block mb-3">Unplaced students available with these skills. Click any skill chip to append it to your job criteria.</small>
                    <div id="poolContainer">
                        <%= poolHtml %>
                    </div>
                </div>
            </div>

            <!-- Right: Generated Output -->
            <div class="col-lg-7">
                <div class="content-card p-3 p-md-4 shadow-sm border h-100 d-flex flex-column">
                    <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 pb-2 border-bottom gap-2">
                        <div>
                            <h5 class="fw-bold mb-0 text-primary"><i class="bi bi-file-earmark-text me-2"></i>Generated AI Job Description</h5>
                            <small class="text-muted" id="charCountNotice">0 characters | 0 words</small>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <button type="button" class="btn btn-outline-secondary btn-sm" onclick="copyJobDraft()"><i class="bi bi-clipboard me-1"></i>Copy Draft</button>
                            <button type="button" class="btn btn-primary btn-sm" onclick="sendToPostJob()"><i class="bi bi-pencil-square me-1"></i>Edit in Post Job</button>
                            <asp:Button ID="btnDirectPost" runat="server" Text="Direct Publish Job Now" CssClass="btn btn-success btn-sm fw-semibold" OnClick="btnDirectPost_Click" />
                        </div>
                    </div>

                    <asp:TextBox ID="txtOut" runat="server" TextMode="MultiLine" Rows="20" CssClass="form-control flex-grow-1 font-monospace" style="font-size:0.88rem; line-height: 1.6;" placeholder="Your complete AI-generated job description will be rendered here. You can refine and edit it directly before posting."></asp:TextBox>

                    <div class="d-flex flex-wrap justify-content-between align-items-center mt-3 pt-2 border-top gap-2">
                        <small class="text-muted"><i class="bi bi-shield-check text-success me-1"></i>Engineered to attract top campus candidates &amp; pass modern job scrapers.</small>
                        <a href="post-job.aspx" class="btn btn-outline-primary btn-sm">Direct Post Job Form &rarr;</a>
                    </div>
                </div>
            </div>
        </div>
    
        <!-- Page Guide & Capabilities Box -->
        <div class="content-card p-3 p-md-4 mt-4 border shadow-sm rounded-4 bg-light">
            <div class="d-flex align-items-center gap-2 mb-2">
                <i class="bi bi-info-circle-fill text-primary fs-5"></i>
                <h6 class="fw-bold mb-0 text-dark">AI Job Description Drafter - Guide &amp; Capabilities</h6>
                <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25 ms-auto small">Live Database Connected</span>
            </div>
            <div class="row g-3 small">
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-gear-wide-connected text-primary me-1"></i>What This Page Does:</div>
                        <div class="text-muted">Drafts structured, compelling job descriptions tailored to campus talent supply and publishes them directly to Job_post_tbl with 1 click.</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-2 bg-white rounded-3 border h-100">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-play-circle-fill text-success me-1"></i>How to Use:</div>
                        <div class="text-muted">Type job designation and required skills (or speak via microphone), click "Synthesize Job Description", refine the generated text, and click "Direct Publish Job Now".</div>
                    </div>
                </div>
            </div>
        </div>

    </div><script>
        function applyPreset(title, skills, level, mode) {
            document.getElementById('<%= txtTitle.ClientID %>').value = title;
            document.getElementById('<%= txtSkills.ClientID %>').value = skills;
            var ddlL = document.getElementById('<%= ddlLevel.ClientID %>');
            if (ddlL) ddlL.value = level;
            var ddlM = document.getElementById('<%= ddlMode.ClientID %>');
            if (ddlM) ddlM.value = mode;
        }

        function copyJobDraft() {
            var txt = document.getElementById('<%= txtOut.ClientID %>');
            if (!txt || !txt.value.trim()) {
                alert("Please generate a job description first.");
                return;
            }
            navigator.clipboard.writeText(txt.value).then(function() {
                alert("Job description copied to clipboard successfully!");
            });
        }

        function sendToPostJob() {
            var txtDesc = document.getElementById('<%= txtOut.ClientID %>').value;
            var txtTitle = document.getElementById('<%= txtTitle.ClientID %>').value;
            var txtSkills = document.getElementById('<%= txtSkills.ClientID %>').value;

            if (!txtDesc.trim()) {
                alert("Please generate a job description first.");
                return;
            }

            // Save to sessionStorage for post-job.aspx
            sessionStorage.setItem("astra_prefill_job_title", txtTitle);
            sessionStorage.setItem("astra_prefill_job_skills", txtSkills);
            sessionStorage.setItem("astra_prefill_job_desc", txtDesc);

            window.location.href = "post-job.aspx";
        }

        // Auto update word/character count
        function updateCounts() {
            var txt = document.getElementById('<%= txtOut.ClientID %>');
            var notice = document.getElementById('charCountNotice');
            if (txt && notice) {
                var val = txt.value.trim();
                var chars = val.length;
                var words = val ? val.split(/\s+/).length : 0;
                notice.innerText = chars + " characters | " + words + " words";
            }
        }

        function dictateField(targetId, btn) {
            var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
            if (!SpeechRecognition) {
                alert("Speech recognition not supported in this browser. Please use Chrome or Edge.");
                return;
            }
            var rec = new SpeechRecognition();
            rec.lang = 'en-IN';
            var orig = btn ? btn.innerHTML : '';
            if (btn) btn.innerHTML = '<span class="text-danger fw-bold"><i class="bi bi-record-circle-fill me-1"></i>Listening...</span>';

            rec.onresult = function(e) {
                var text = e.results[0][0].transcript;
                var el = document.getElementById(targetId);
                if (el) {
                    el.value = text;
                }
            };
            rec.onend = function() {
                if (btn) btn.innerHTML = orig;
            };
            rec.onerror = function() {
                if (btn) btn.innerHTML = orig;
            };
            rec.start();
        }

        window.addEventListener('DOMContentLoaded', function() {
            updateCounts();
            var txt = document.getElementById('<%= txtOut.ClientID %>');
            if (txt) {
                txt.addEventListener('input', updateCounts);
            }

            // Add click-to-append on pool badges
            var badges = document.querySelectorAll('#poolContainer .badge');
            badges.forEach(function(b) {
                b.classList.add('campus-skill-pill');
                b.title = "Click to append to required skills";
                b.addEventListener('click', function() {
                    var skillText = this.innerText.split('•')[0].trim();
                    var skillInput = document.getElementById('<%= txtSkills.ClientID %>');
                    if (skillInput) {
                        var cur = skillInput.value.trim();
                        if (cur) {
                            if (cur.toLowerCase().indexOf(skillText.toLowerCase()) === -1) {
                                skillInput.value = cur + ", " + skillText;
                            }
                        } else {
                            skillInput.value = skillText;
                        }
                    }
                });
            });
        });
    </script>
</asp:Content>

