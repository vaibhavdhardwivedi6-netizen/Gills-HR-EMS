<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User loginUser = (User) session.getAttribute("userobj");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | GlisHR EMS</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .profile-hero {
            height: 200px;
            background: var(--primary-gradient);
            border-radius: 32px 32px 0 0;
            position: relative;
        }
        
        .profile-avatar-wrapper {
            position: absolute;
            bottom: -60px;
            left: 50px;
            padding: 5px;
            background: white;
            border-radius: 32px;
            box-shadow: var(--shadow-premium);
        }
        
        .profile-avatar-large {
            width: 150px;
            height: 150px;
            border-radius: 28px;
            object-fit: cover;
        }
        
        .profile-badge {
            padding: 8px 16px;
            border-radius: 50px;
            font-weight: 800;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            background: rgba(255,255,255,0.2);
            color: white;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255,255,255,0.3);
        }
    </style>
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
                <a href="viewApplications" class="nav-link">
                    <i class="bi bi-envelope-paper-fill"></i>
                    <span><%= "admin".equals(loginUser.getRole()) ? "Applications" : "My Applications" %></span>
                </a>
            </div>

            <div class="mt-5 text-uppercase smallest fw-bold text-muted mb-4 px-3" style="letter-spacing: 2px;">System Profile</div>
            
            <div class="nav-item">
                <a href="logout" class="nav-link text-danger"> <i class="bi bi-box-arrow-left"></i> <span>Logout</span> </a>
            </div>
        </nav>
    </div>

    <div class="main-content">
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

        <div class="glass-card p-0 overflow-hidden mb-5 animate-fade-in">
            <div class="profile-hero">
                <div class="p-5 d-flex justify-content-end">
                    <span class="profile-badge"><%= loginUser.getRole() %> Account</span>
                </div>
                <div class="profile-avatar-wrapper shadow-premium">
                    <img src="<%= (loginUser.getProfilePic() != null && !loginUser.getProfilePic().isEmpty()) ? "uploads/profiles/" + loginUser.getProfilePic() : "https://api.dicebear.com/7.x/avataaars/svg?seed=" + loginUser.getName() %>" 
                         class="profile-avatar-large" id="profilePreview">
                </div>
            </div>
            <div style="padding: 80px 50px 40px;">
                <h1 class="fw-800 ls-tight mb-1"><%= loginUser.getName() %></h1>
                <p class="text-secondary"><i class="bi bi-envelope me-2"></i><%= loginUser.getEmail() %></p>
            </div>
        </div>

        <div class="row g-4 animate-fade-in" style="animation-delay: 100ms;">
            <div class="col-lg-8">
                <div class="glass-card shadow-soft p-5">
                    <h4 class="fw-800 ls-tight mb-4">Account Information</h4>
                    <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label smallest fw-800 text-uppercase">Full Name</label>
                                <input type="text" name="name" class="form-control rounded-3 py-3" value="<%= loginUser.getName() %>" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label smallest fw-800 text-uppercase">Username</label>
                                <input type="text" name="username" class="form-control rounded-3 py-3" value="<%= loginUser.getUsername() %>" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label smallest fw-800 text-uppercase">Email Address</label>
                                <input type="email" name="email" class="form-control rounded-3 py-3" value="<%= loginUser.getEmail() %>" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label smallest fw-800 text-uppercase">Update Profile Picture</label>
                                <div class="p-4 border-2 border-dashed rounded-4 bg-light text-center">
                                    <i class="bi bi-cloud-arrow-up fs-2 text-primary d-block mb-2"></i>
                                    <input type="file" name="profilePic" class="form-control" accept="image/*" onchange="previewImage(this)">
                                    <span class="smallest text-muted mt-2 d-block">Recommended size: 512x512px (Max 5MB)</span>
                                </div>
                            </div>
                            <div class="col-12 pt-3">
                                <button type="submit" class="btn btn-primary-custom px-5 py-3 shadow-premium">
                                    Save Profile Changes
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="glass-card shadow-soft p-5">
                    <h4 class="fw-800 ls-tight mb-4">Security</h4>
                    <div class="space-y-4">
                        <div class="p-4 bg-light rounded-4 mb-3">
                            <div class="d-flex align-items-center gap-3 mb-2">
                                <div class="bg-primary bg-opacity-10 text-primary rounded-3 p-2">
                                    <i class="bi bi-shield-lock-fill"></i>
                                </div>
                                <span class="fw-800 smallest">BCRYPT ACTIVE</span>
                            </div>
                            <p class="smallest text-muted mb-0">Your account is secured with advanced salted hashing algorithms.</p>
                        </div>
                        <button class="btn btn-outline-primary w-100 rounded-4 py-3 fw-800 smallest" onclick="alert('Password reset link sent to your email!')">
                            CHANGE PASSWORD
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profilePreview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <style>
        .border-dashed { border-style: dashed !important; border-color: #cbd5e1 !important; }
    </style>
</body>
</html>