<%@page import="model.jobs"%>
<%@page import="model.User"%>
<%@ page import="java.util.*" %>
<%
    User loginUser = (User) session.getAttribute("userobj");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<jobs> list = (List<jobs>) request.getAttribute("jobList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jobs | GlisHR EMS</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <div class="sidebar">
        <div class="brand">
            <i class="bi bi-rocket-takeoff-fill"></i>
            <span>GlisHR</span>
        </div>

        <nav>
            <div class="text-uppercase small fw-bold text-muted mb-3 px-3" style="letter-spacing: 1px;">Menu</div>
            
            <div class="nav-item">
                <a href="home" class="nav-link">
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span>Dashboard</span>
                </a>
            </div>

            <% if("admin".equals(loginUser.getRole())) { %>
            <div class="nav-item">
                <a href="EmployeeServlet" class="nav-link">
                    <i class="bi bi-people-fill"></i>
                    <span>Candidates</span>
                </a>
            </div>
            <% } %>

            <div class="nav-item">
                <a href="JobServlet" class="nav-link active">
                    <i class="bi bi-briefcase-fill"></i>
                    <span>Jobs</span>
                </a>
            </div>

            <div class="nav-item">
                <a href="viewApplications" class="nav-link">
                    <i class="bi bi-envelope-paper-fill"></i>
                    <span><%= "admin".equals(loginUser.getRole()) ? "Applications" : "My Applications" %></span>
                </a>
            </div>

            <div class="nav-item">
                <a href="profile.jsp" class="nav-link">
                    <i class="bi bi-person-circle"></i>
                    <span>Profile</span>
                </a>
            </div>

            <div class="mt-5 text-uppercase small fw-bold text-muted mb-3 px-3" style="letter-spacing: 1px;">System</div>
            
            <div class="nav-item">
                <a href="logout" class="nav-link text-danger">
                    <i class="bi bi-box-arrow-left"></i>
                    <span>Logout</span>
                </a>
            </div>
        </nav>
    </div>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-5 animate-fade-in">
            <div>
                <h1 class="fw-bold mb-1">Career Opportunities</h1>
                <p class="text-muted">Find your next big challenge at GlisHR</p>
            </div>
            <% if("admin".equals(loginUser.getRole())) { %>
            <button class="btn btn-primary-custom px-4" data-bs-toggle="modal" data-bs-target="#addJobModal">
                <i class="bi bi-megaphone-fill me-2"></i>Post New Vacancy
            </button>
            <% } %>
        </div>

        <% 
            String msg = (String) session.getAttribute("msg");
            if (msg != null) {
        %>
            <div class="alert alert-info alert-dismissible fade show rounded-4 shadow-soft mb-4 border-0 animate-fade-in" role="alert">
                <i class="bi bi-info-circle-fill me-2"></i> <%= msg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% 
                session.removeAttribute("msg");
            }
        %>

        <div class="glass-card mb-5 p-4 animate-fade-in shadow-soft" style="border-radius: 20px;">
            <div class="d-flex flex-wrap align-items-center gap-4">
                <div class="search-container flex-grow-1">
                    <form action="FindName" method="get">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" name="searching" class="search-input" placeholder="Search by job title or company...">
                    </form>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-light rounded-4 border px-3"><i class="bi bi-filter me-2"></i>Filter</button>
                    <button class="btn btn-light rounded-4 border px-3"><i class="bi bi-sort-down me-2"></i>Sort</button>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <% if(list != null && !list.isEmpty()) { 
                int delay = 0;
                for(jobs j : list){
                    delay += 80;
            %>
            <div class="col-xl-4 col-md-6 animate-fade-in" style="animation-delay: <%= delay %>ms">
                <div class="glass-card d-flex flex-column hover-glow transition p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <div class="d-flex align-items-center">
                            <div class="bg-primary bg-opacity-10 p-3 rounded-4 text-primary me-3">
                                <i class="bi bi-building fs-3"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0 text-truncate" style="max-width: 140px;"><%= j.getCompanyName() %></h5>
                                <span class="badge bg-success bg-opacity-10 text-success border-0 rounded-pill smallest fw-700">
                                    <%= j.getVacancies() %> Openings
                                </span>
                            </div>
                        </div>
                        <% if("admin".equals(loginUser.getRole())) { %>
                        <div class="dropdown">
                            <button class="btn btn-light btn-sm rounded-circle border-0 bg-transparent text-muted" data-bs-toggle="dropdown">
                                <i class="bi bi-three-dots-vertical fs-5"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end border-0 shadow-premium p-2 rounded-4">
                                <li><a class="dropdown-item rounded-3 py-2" href="jobsupdate?id=<%=j.getJobId()%>"><i class="bi bi-pencil me-2"></i>Edit Job</a></li>
                                <li><a class="dropdown-item rounded-3 py-2 text-danger" href="DeleteJobServlet?id=<%=j.getJobId()%>" onclick="return confirm('Archive this posting?');"><i class="bi bi-trash me-2"></i>Delete</a></li>
                            </ul>
                        </div>
                        <% } %>
                    </div>

                    <h4 class="fw-800 mb-4 ls-tight"><%= j.getJobTitle() %></h4>
                    
                    <div class="space-y-3 flex-grow-1">
                        <div class="d-flex align-items-center mb-3 text-secondary small">
                            <div class="icon-box-sm bg-danger bg-opacity-10 text-danger me-3">
                                <i class="bi bi-geo-alt"></i>
                            </div>
                            <%= j.getJobLocation() %>
                        </div>
                        <div class="d-flex align-items-center mb-3 text-secondary small">
                            <div class="icon-box-sm bg-primary bg-opacity-10 text-primary me-3">
                                <i class="bi bi-mortarboard"></i>
                            </div>
                            <%= j.getQualification() %>
                        </div>
                        <div class="d-flex align-items-center mb-3 text-secondary small">
                            <div class="icon-box-sm bg-warning bg-opacity-10 text-warning me-3">
                                <i class="bi bi-calendar-event"></i>
                            </div>
                            Ends: <%= j.getApplicationLastDate() %>
                        </div>
                        <div class="mt-4 p-3 bg-light rounded-4 d-flex align-items-center justify-content-between">
                            <span class="smallest text-muted text-uppercase fw-bold">Package / yr</span>
                            <span class="fw-800 text-primary fs-5">₹ <%= j.getSalary() %></span>
                        </div>
                    </div>

                    <div class="pt-4 mt-auto">
                        <% if(!"admin".equals(loginUser.getRole())) { %>
                        <button class="btn btn-primary-custom w-100 py-3 rounded-4 hover-glow apply-btn" 
                                data-bs-toggle="modal" 
                                data-bs-target="#applyJobModal" 
                                data-jobid="<%= j.getJobId() %>" 
                                data-jobtitle="<%= j.getJobTitle() %>">
                            <i class="bi bi-send me-2"></i>Quick Apply
                        </button>
                        <% } else { %>
                        <button class="btn btn-light w-100 fw-bold rounded-4 py-3 border disabled opacity-50">
                            Admin Preview
                        </button>
                        <% } %>
                    </div>
                </div>
            </div>
            <% } } else { %>
                <div class="col-12 text-center py-5">
                    <img src="https://illustrations.popsy.co/amber/no-results-found.svg" style="width: 280px;" class="mb-4">
                    <h3 class="fw-bold">No Active Vacancies</h3>
                    <p class="text-muted">Stay tuned for new opportunities!</p>
                    <a href="JobServlet" class="btn btn-primary-custom mt-3">Refresh Feed</a>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Add Job Modal -->
    <div class="modal fade" id="addJobModal">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg" style="border-radius: 24px;">
                <div class="modal-header border-0 pb-0">
                    <h4 class="fw-bold px-3 pt-3">Post New Opening</h4>
                    <button type="button" class="btn-close me-2 mt-2" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <form action="JobServlet" method="post" class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Company Name</label>
                            <input type="text" name="companyName" class="form-control rounded-3 py-2" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Job Title</label>
                            <input type="text" name="jobTitle" class="form-control rounded-3 py-2" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Vacancies</label>
                            <input type="number" name="vacancies" class="form-control rounded-3 py-2">
                        </div>
                        <div class="col-md-8">
                            <label class="form-label small fw-bold">Job Location</label>
                            <input type="text" name="jobLocation" class="form-control rounded-3 py-2">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Minimum Qualification</label>
                            <input type="text" name="qualification" class="form-control rounded-3 py-2">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Experience Required</label>
                            <input type="text" name="experience" class="form-control rounded-3 py-2">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Offered Salary</label>
                            <input type="text" name="salary" class="form-control rounded-3 py-2">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-bold">Start Date</label>
                            <input type="date" name="applicationStartDate" class="form-control rounded-3 py-2">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-bold">Last Date</label>
                            <input type="date" name="applicationLastDate" class="form-control rounded-3 py-2">
                        </div>
                        <div class="col-12 mt-4 pt-2">
                            <button type="submit" class="btn btn-primary-custom w-100 py-3 fs-5">
                                <i class="bi bi-megaphone me-2"></i>Publish Job Posting
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Apply Job Modal -->
    <div class="modal fade" id="applyJobModal">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg" style="border-radius: 24px;">
                <div class="modal-header border-0 pb-0">
                    <div>
                        <h4 class="fw-bold px-3 pt-3 mb-1">Apply for Position</h4>
                        <p class="text-muted px-3 small" id="jobTitleDisplay"></p>
                    </div>
                    <button type="button" class="btn-close me-2 mt-2" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <form action="ApplyJobServlet" method="post" enctype="multipart/form-data" class="row g-3">
                        <input type="hidden" name="jobId" id="modalJobId">
                        
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Full Name</label>
                            <input type="text" name="candidateName" class="form-control rounded-3 py-2" required placeholder="John Doe" value="<%= loginUser.getName() %>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Email Address</label>
                            <input type="email" name="email" class="form-control rounded-3 py-2" required placeholder="john@example.com" value="<%= loginUser.getEmail() %>" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Phone Number</label>
                            <input type="tel" name="phone" class="form-control rounded-3 py-2" required placeholder="+1 234 567 8900">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Highest Qualification</label>
                            <input type="text" name="qualification" class="form-control rounded-3 py-2" required placeholder="Master's in CS">
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold">Experience Summary</label>
                            <textarea name="experience" class="form-control rounded-3 py-2" rows="3" required placeholder="Briefly describe your relevant experience..."></textarea>
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold">Resume / CV (PDF Word)</label>
                            <div class="upload-zone p-4 border-2 border-dashed rounded-4 text-center bg-light">
                                <i class="bi bi-cloud-arrow-up fs-2 text-primary mb-2"></i>
                                <input type="file" name="resume" class="form-control mt-2" required accept=".pdf,.doc,.docx">
                                <p class="text-muted smallest mt-2 mb-0">Max file size: 5MB</p>
                            </div>
                        </div>
                        <div class="col-12 mt-4 pt-2">
                            <button type="submit" class="btn btn-primary-custom w-100 py-3 fs-5">
                                <i class="bi bi-send-fill me-2"></i>Submit Application
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var applyModal = document.getElementById('applyJobModal');
            applyModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var jobId = button.getAttribute('data-jobid');
                var jobTitle = button.getAttribute('data-jobtitle');
                
                var modalJobIdInput = applyModal.querySelector('#modalJobId');
                var jobTitleDisplay = applyModal.querySelector('#jobTitleDisplay');
                
                modalJobIdInput.value = jobId;
                jobTitleDisplay.textContent = "Position: " + jobTitle;
            });
        });
    </script>
    <style>
        .smallest { font-size: 0.75rem; }
        .border-dashed { border-style: dashed !important; }
        .upload-zone:hover { background-color: rgba(var(--bs-primary-rgb), 0.05) !important; border-color: var(--bs-primary) !important; }
    </style>
</body>
</html>