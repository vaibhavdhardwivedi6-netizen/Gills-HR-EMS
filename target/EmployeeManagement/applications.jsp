<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.Application" %>
<%@ page import="model.User" %>
<%
    User loginUser = (User) session.getAttribute("userobj");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Application> appList = (List<Application>) request.getAttribute("appList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= "admin".equals(loginUser.getRole()) ? "Pipeline Center" : "My Career Hub" %> | GlisHR EMS</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <div class="sidebar">
        <div class="brand">
            <i class="bi bi-rocket-takeoff-fill"></i> <span>GlisHR</span>
        </div>

        <nav>
            <div class="text-uppercase smallest fw-bold text-muted mb-4 px-3" style="letter-spacing: 2px;">Main Navigation</div>
            
            <div class="nav-item">
                <a href="home" class="nav-link"> <i class="bi bi-grid-1x2-fill"></i> <span>Dashboard</span></a>
            </div>

            <% if("admin".equals(loginUser.getRole())) { %>
            <div class="nav-item">
                <a href="EmployeeServlet" class="nav-link"> <i class="bi bi-people-fill"></i> <span>Candidates</span></a>
            </div>
            <% } %>

            <div class="nav-item">
                <a href="JobServlet" class="nav-link"> <i class="bi bi-briefcase-fill"></i> <span>Jobs</span> </a>
            </div>

            <div class="nav-item">
                <a href="viewApplications" class="nav-link active">
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

            <div class="mt-5 text-uppercase smallest fw-bold text-muted mb-4 px-3" style="letter-spacing: 2px;">System Profile</div>
            
            <div class="nav-item">
                <a href="logout" class="nav-link text-danger"> <i class="bi bi-box-arrow-left"></i> <span>Logout</span> </a>
            </div>
        </nav>
    </div>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-5 animate-fade-in">
            <div>
                <h1 class="fw-800 mb-1 ls-tight">
                    <%= "admin".equals(loginUser.getRole()) ? "Application Pipeline" : "My Carrier Journey" %>
                </h1>
                <p class="text-muted">
                    <%= "admin".equals(loginUser.getRole()) ? "Real-time influx of professional talent applications" : "Continuous tracking of your submitted applications and progress" %>
                </p>
            </div>
            <% if(!"admin".equals(loginUser.getRole())) { %>
            <a href="JobServlet" class="btn btn-primary-custom px-5 rounded-4 shadow-premium">
                <i class="bi bi-search me-2"></i>Apply for More
            </a>
            <% } %>
        </div>

        <% if(appList != null && !appList.isEmpty()) { %>
            
            <% if("admin".equals(loginUser.getRole())) { %>
                <!-- Admin Table View -->
                <div class="glass-card p-0 overflow-hidden shadow-soft animate-fade-in" style="border-radius: 32px;">
                    <div class="table-responsive">
                        <table class="table-custom w-100 mb-0">
                            <thead class="bg-light opacity-75">
                                <tr class="text-secondary smallest text-uppercase fw-800">
                                    <th class="ps-5 py-4">Full Profile</th>
                                    <th class="py-4">Job Reference</th>
                                    <th class="py-4">Apply Date</th>
                                    <th class="py-4">Status</th>
                                    <th class="py-4 text-end pe-5">Command</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white">
                                <% for(Application app : appList) { %>
                                <tr class="border-bottom border-light">
                                    <td class="ps-5 py-4">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm bg-primary bg-opacity-10 text-primary rounded-4 me-3 d-flex align-items-center justify-content-center fw-800" style="width: 50px; height: 50px; font-size: 1.25rem;">
                                                <%= app.getCandidateName().substring(0, 1).toUpperCase() %>
                                            </div>
                                            <div>
                                                <div class="fw-800 text-dark mb-0 ls-tight"><%= app.getCandidateName() %></div>
                                                <div class="smallest text-muted"><%= app.getEmail() %></div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="small fw-700 text-dark">REFID: #<%= app.getJobId() %></div>
                                        <div class="smallest text-muted fw-600"><%= app.getQualification() %></div>
                                    </td>
                                    <td>
                                        <div class="small fw-600 text-secondary"><i class="bi bi-calendar-check me-2"></i><%= app.getApplyDate() %></div>
                                    </td>
                                    <td>
                                        <% 
                                            String statusClass = "status-pending";
                                            if("Approved".equals(app.getStatus())) statusClass = "status-approved";
                                            if("Rejected".equals(app.getStatus())) statusClass = "status-rejected";
                                        %>
                                        <span class="status-badge <%= statusClass %> fw-800 shadow-sm"><%= app.getStatus() %></span>
                                    </td>
                                    <td class="text-end pe-5">
                                        <div class="d-flex justify-content-end gap-3">
                                            <a href="uploads/<%= app.getResumeFileName() %>" class="btn-icon btn-outline-primary shadow-soft" target="_blank" title="Inspect Resume">
                                                <i class="bi bi-file-earmark-pdf-fill"></i>
                                            </a>
                                            <a href="updateStatus?id=<%= app.getId() %>&status=Approved" class="btn-icon btn-success shadow-soft" title="Accept Candidate">
                                                <i class="bi bi-check-lg"></i>
                                            </a>
                                            <a href="updateStatus?id=<%= app.getId() %>&status=Rejected" class="btn-icon btn-danger shadow-soft" title="Decline Request">
                                                <i class="bi bi-x-lg"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            <% } else { %>
                <!-- User Card View -->
                <div class="row g-4 animate-fade-in">
                    <% 
                        int delay = 0;
                        for(Application app : appList) { 
                            delay += 80;
                    %>
                    <div class="col-lg-6 col-xl-4 animate-fade-in" style="animation-delay: <%= delay %>ms">
                        <div class="glass-card hover-glow p-4 d-flex flex-column" style="border-radius: 32px;">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="bg-primary bg-opacity-10 p-3 rounded-4 text-primary shadow-sm">
                                    <i class="bi bi-briefcase-fill fs-3"></i>
                                </div>
                                <% 
                                    String statusClass = "status-pending";
                                    if("Approved".equals(app.getStatus())) statusClass = "status-approved";
                                    if("Rejected".equals(app.getStatus())) statusClass = "status-rejected";
                                %>
                                <span class="status-badge <%= statusClass %> fw-800 rounded-pill"><%= app.getStatus() %></span>
                            </div>
                            
                            <h4 class="fw-800 mb-1 ls-tight">Job Reference #<%= app.getJobId() %></h4>
                            <p class="smallest text-muted fw-700 text-uppercase mb-4">Posted on <%= app.getApplyDate() %></p>
                            
                            <div class="p-3 bg-light rounded-4 mb-4">
                                <div class="d-flex align-items-center gap-2 mb-2">
                                    <div class="bg-success rounded-circle" style="width: 8px; height: 8px;"></div>
                                    <span class="smallest fw-800 text-dark">APPLICATION PROCESSED</span>
                                </div>
                                <div class="smallest text-secondary fw-600">The hiring team has acknowledged your profile. You are currently in the <%= app.getStatus() %> stage.</div>
                            </div>
                            
                            <div class="pt-4 border-top mt-auto d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-patch-check-fill text-primary me-2 shadow-sm"></i>
                                    <span class="smallest fw-800 text-muted">VERIFIED PROFILE</span>
                                </div>
                                <a href="uploads/<%= app.getResumeFileName() %>" class="btn btn-link btn-sm text-decoration-none fw-800 p-0 text-primary" target="_blank">
                                    DOWNLOAD CV <i class="bi bi-cloud-arrow-down-fill ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } %>

        <% } else { %>
            <div class="empty-state glass-card animate-fade-in shadow-soft py-5 text-center" style="border-radius: 32px;">
                <img src="https://illustrations.popsy.co/amber/working-on-laptop.svg" style="width: 250px;" class="mb-5 animate-float">
                <h2 class="fw-800 mb-2 ls-tight">Awaiting Your Start</h2>
                <p class="text-secondary mb-5 mx-auto opacity-75" style="max-width: 480px;">
                    Our database indicates zero active application streams. Launch your professional expedition by applying for curated positions today.
                </p>
                <a href="JobServlet" class="btn btn-primary-custom px-5 py-3 rounded-4 shadow-premium fw-800">
                    START EXPEDITION
                </a>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
