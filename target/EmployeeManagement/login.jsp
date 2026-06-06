<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | GlisHR EMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Outfit', sans-serif;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 30px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 450px;
            padding: 40px;
        }
        .brand-logo {
            width: 60px;
            height: 60px;
            background: var(--primary-gradient, linear-gradient(45deg, #007bff, #00d4ff));
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 30px;
            margin: 0 auto 20px;
        }
    </style>
</head>
<body>
    <div class="login-card animate-fade-in">
        <div class="brand-logo">
            <i class="bi bi-rocket-takeoff-fill"></i>
        </div>
        <h3 class="text-center fw-bold mb-1">Welcome Back</h3>
        <p class="text-center text-muted mb-4">Login to manage your workspace</p>

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

        <% 
            String succMsg = (String) session.getAttribute("succMsg");
            if (succMsg != null) {
        %>
            <div class="alert alert-success border-0 rounded-3 mb-4 small">
                <i class="bi bi-check-circle-fill me-2"></i> <%= succMsg %>
            </div>
        <% 
                session.removeAttribute("succMsg");
            }
        %>

        <form action="login" method="post">
            <div class="mb-3">
                <label class="form-label small fw-bold">Username</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-0"><i class="bi bi-person"></i></span>
                    <input type="text" name="username" class="form-control bg-light border-0 py-2" required placeholder="Enter username">
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label small fw-bold">Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-0"><i class="bi bi-lock"></i></span>
                    <input type="password" name="password" class="form-control bg-light border-0 py-2" required placeholder="Enter password">
                </div>
            </div>
            <button type="submit" class="btn btn-primary-custom w-100 py-3 rounded-3 mb-3">
                Login to Account
            </button>
            <p class="text-center mb-0 small">
                Don't have an account? <a href="signup.jsp" class="text-decoration-none fw-bold">Sign Up</a>
            </p>
        </form>
    </div>
</body>
</html>
