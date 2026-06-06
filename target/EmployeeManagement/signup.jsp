<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | GlisHR EMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #e0c3fc 0%, #8ec5fc 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Outfit', sans-serif;
        }
        .signup-card {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(15px);
            border-radius: 30px;
            border: 1px solid rgba(255, 255, 255, 0.4);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            padding: 40px;
        }
    </style>
</head>
<body>
    <div class="signup-card animate-fade-in">
        <h3 class="text-center fw-bold mb-1">Create Account</h3>
        <p class="text-center text-muted mb-4">Join GlisHR Management System</p>

        <% 
            String errorMsg = (String) session.getAttribute("errorMsg");
            if (errorMsg != null) {
        %>
            <div class="alert alert-danger border-0 rounded-3 mb-4 small">
                <i class="bi bi-exclamation-circle-fill me-2"></i> <%= errorMsg %>
            </div>
        <% 
                session.removeAttribute("errorMsg");
            }
        %>

        <form action="signup" method="post" class="row g-3">
            <div class="col-md-12">
                <label class="form-label small fw-bold">Full Name</label>
                <input type="text" name="name" class="form-control bg-light border-0 py-2" required placeholder="John Doe">
            </div>
            <div class="col-md-6">
                <label class="form-label small fw-bold">Username</label>
                <input type="text" name="username" class="form-control bg-light border-0 py-2" required placeholder="johndoe">
            </div>
            <div class="col-md-6">
                <label class="form-label small fw-bold">Email</label>
                <input type="email" name="email" class="form-control bg-light border-0 py-2" required placeholder="john@example.com">
            </div>
            <div class="col-md-12">
                <label class="form-label small fw-bold">Password</label>
                <input type="password" name="password" class="form-control bg-light border-0 py-2" required placeholder="••••••••">
            </div>
            <div class="col-md-12">
                <label class="form-label small fw-bold">Role</label>
                <select name="role" class="form-select bg-light border-0 py-2" required>
                    <option value="admin">Admin / HR</option>
                    <option value="user">Regular User</option>
                </select>
            </div>
            <div class="col-12 mt-4">
                <button type="submit" class="btn btn-primary-custom w-100 py-3 rounded-3 mb-3">
                    Register Now
                </button>
            </div>
            <p class="text-center mb-0 small">
                Already have an account? <a href="login.jsp" class="text-decoration-none fw-bold">Login</a>
            </p>
        </form>
    </div>
</body>
</html>
