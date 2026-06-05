<%@ page import="model.employee"%>
<%@ page import="model.User"%>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    employee e = (employee)request.getAttribute("empList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile | GlisHR</title>
    
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
                            <i class="bi bi-person-gear fs-1"></i>
                        </div>
                        <h2 class="fw-bold">Update Profile</h2>
                        <p class="text-muted">Modify the credentials for <b><%= e.getName() %></b></p>
                    </div>
                    
                    <form action="updated" method="post" class="row g-3">
                        <input type="hidden" value ="<%=e.getId()%>" name="id"> 
                        
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Full Name</label>
                            <input type="text" name="name" class="form-control rounded-3 py-2" value="<%=e.getName() %>" required>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Email Address</label>
                            <input type="email" name="email" class="form-control rounded-3 py-2" value="<%=e.getEmail() %>" required>
                        </div>
                       
                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Address</label>
                            <input type="text" name="address" class="form-control rounded-3 py-2" value="<%=e.getAddress() %>" required>
                        </div>
                        
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Position</label>
                            <input type="text" name="position" class="form-control rounded-3 py-2" value="<%=e.getPosition() %>" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Age</label>
                            <input type="number" name="age" class="form-control rounded-3 py-2" value="<%=e.getAge() %>" required>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label small fw-bold">Skills</label>
                            <input type="text" name="skill" class="form-control rounded-3 py-2" value="<%=e.getSkill() %>" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Expected Salary (₹)</label>
                            <input type="number" name="salary" class="form-control rounded-3 py-2" value="<%=e.getSalary() %>" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Department</label>
                            <select name="department" class="form-select rounded-3 py-2" required>
                                <option value="IT" <%= "IT".equals(e.getDepartment()) ? "selected" : "" %>>IT</option>
                                <option value="HR" <%= "HR".equals(e.getDepartment()) ? "selected" : "" %>>HR</option>
                                <option value="Other" <%= "Other".equals(e.getDepartment()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Joining Date</label>
                            <input type="date" name="joiningDate" class="form-control rounded-3 py-2" value="<%= e.getJoiningDate() %>" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Contact Number</label>
                            <input type="number" name="phone" class="form-control rounded-3 py-2" value="<%=e.getPhone() %>" required>
                        </div>

                        <div class="col-12 mt-5">
                            <button type="submit" class="btn btn-primary-custom w-100 py-3 fs-5">
                                <i class="bi bi-cloud-upload me-2"></i>Apply Changes
                            </button>
                            <a href="EmployeeServlet" class="btn btn-link w-100 mt-2 text-decoration-none text-muted small">Cancel and Return</a>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>