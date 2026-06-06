<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.jobs"%>
<%@page import="model.User"%>
<%
    User loginUser = (User) session.getAttribute("userobj");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (!"admin".equals(loginUser.getRole())) {
        response.sendRedirect("home");
        return;
    }
    jobs j = (jobs) request.getAttribute("job");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Job | GlisHR</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>

<body class="bg-light">

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="glass-card p-5 animate-fade-in">
                    <div class="text-center mb-5">
                        <div class="bg-primary bg-opacity-10 p-3 rounded-circle d-inline-block text-primary mb-3">
                            <i class="bi bi-briefcase fs-1"></i>
                        </div>
                        <h2 class="fw-bold">Edit Job Posting</h2>
                        <p class="text-muted">Update details for <b><%= j.getJobTitle() %></b></p>
                    </div>

                    <form action="jobsupdate" method="post" class="row g-3">
                        <input type="hidden" name="jobId" value="<%= j.getJobId() %>">

                        <div class="col-12">
                            <label class="form-label small fw-bold">Company Name</label>
                            <input type="text" name="companyName" class="form-control rounded-3 py-2" value="<%= j.getCompanyName() %>" required>
                        </div>

                        <div class="col-12">
                            <label class="form-label small fw-bold">Job Title</label>
                            <input type="text" name="jobTitle" class="form-control rounded-3 py-2" value="<%= j.getJobTitle() %>" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Vacancies</label>
                            <input type="number" name="vacancies" class="form-control rounded-3 py-2" value="<%= j.getVacancies() %>">
                        </div>

                        <div class="col-md-8">
                            <label class="form-label small fw-bold">Job Location</label>
                            <input type="text" name="jobLocation" class="form-control rounded-3 py-2" value="<%= j.getJobLocation() %>">
                        </div>

                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Qualification Required</label>
                            <input type="text" name="qualification" class="form-control rounded-3 py-2" value="<%= j.getQualification() %>">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Experience</label>
                            <input type="text" name="experience" class="form-control rounded-3 py-2" value="<%= j.getExperience() %>">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Offered Salary</label>
                            <input type="text" name="salary" class="form-control rounded-3 py-2" value="<%= j.getSalary() %>">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Start Date</label>
                            <input type="date" name="applicationStartDate" class="form-control rounded-3 py-2" value="<%= j.getApplicationStartDate() %>">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Last Date</label>
                            <input type="date" name="applicationLastDate" class="form-control rounded-3 py-2" value="<%= j.getApplicationLastDate() %>">
                        </div>

                        <div class="col-12 mt-5">
                            <button type="submit" class="btn btn-primary-custom w-100 py-3 fs-5">
                                <i class="bi bi-check-circle me-2"></i>Update Posting
                            </button>
                            <a href="JobServlet" class="btn btn-link w-100 mt-2 text-decoration-none text-muted small">Discard Changes</a>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 