<%@page import="model.employee"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

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
List<employee> list = (List<employee>) request.getAttribute("empList");
if (list == null && request.getParameter("searchname") == null && request.getAttribute("count") == null) {
	response.sendRedirect("EmployeeServlet");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Talent Management | GlisHR EMS</title>

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
			<div class="text-uppercase small fw-bold text-muted mb-3 px-3" style="letter-spacing: 1px;">Menu</div>
			<div class="nav-item">
				<a href="home" class="nav-link"> <i class="bi bi-grid-1x2-fill"></i> <span>Dashboard</span></a>
			</div>
			<div class="nav-item">
				<a href="EmployeeServlet" class="nav-link active"> <i class="bi bi-people-fill"></i> <span>Candidates</span></a>
			</div>
			<div class="nav-item">
				<a href="JobServlet" class="nav-link"> <i class="bi bi-briefcase-fill"></i> <span>Jobs</span></a>
			</div>
			<div class="nav-item">
				<a href="viewApplications" class="nav-link">
					<i class="bi bi-envelope-paper-fill"></i>
					<span>Applications</span>
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
				<a href="logout" class="nav-link text-danger"><i class="bi bi-box-arrow-left"></i> <span>Logout</span></a>
			</div>
		</nav>
	</div>

	<div class="main-content">
		<div class="d-flex justify-content-between align-items-center mb-5 animate-fade-in">
			<div>
				<h1 class="fw-800 mb-1 ls-tight">Manage Talent Pool</h1>
				<p class="text-muted">Review, onboard and manage your global workforce</p>
			</div>
			<button class="btn btn-primary-custom px-4 rounded-4" data-bs-toggle="modal" data-bs-target="#registrationModal">
				<i class="bi bi-person-plus-fill me-2"></i>Add New Candidate
			</button>
		</div>

        <div class="glass-card mb-5 p-4 animate-fade-in shadow-soft" style="border-radius: 20px;">
            <div class="d-flex flex-wrap align-items-center gap-4">
                <div class="search-container flex-grow-1">
                    <form action="search" method="get">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" name="searchname" class="search-input" placeholder="Search by name, email or skills...">
                    </form>
                </div>
                <div class="d-flex gap-2">
                    <div class="dropdown">
						<button class="btn btn-light rounded-4 border px-3 dropdown-toggle invisible-caret" data-bs-toggle="dropdown">
							<i class="bi bi-sort-down me-2"></i>Sort
						</button>
						<ul class="dropdown-menu dropdown-menu-end border-0 shadow-premium p-2 rounded-4">
							<li><a class="dropdown-item rounded-3 py-2" href="SortServlet?filter=name">Alphabetical</a></li>
							<li><a class="dropdown-item rounded-3 py-2" href="SortServlet?filter=salary">Annual Package</a></li>
						</ul>
					</div>
                </div>
            </div>
        </div>

		<div class="row g-4 mt-2">
			<%
			if (list != null && !list.isEmpty()) {
				int delay = 0;
				for (employee e : list) {
					delay += 80;
			%>
			<div class="col-xl-4 col-md-6 animate-fade-in" style="animation-delay: <%=delay%>ms">
				<div class="glass-card d-flex flex-column hover-glow transition p-4 h-100">
					<div class="d-flex align-items-start justify-content-between mb-4">
						<div class="position-relative">
							<div class="avatar-container shadow-sm p-1 bg-white rounded-4 overflow-hidden" style="width: 70px; height: 70px;">
                                <img src="image/<%=e.getImage()%>" class="w-100 h-100 object-fit-cover rounded-3" 
                                     onerror="this.src='https://api.dicebear.com/7.x/avataaars/svg?seed=<%=e.getName()%>'">
                            </div>
							<span class="position-absolute translate-middle p-1 bg-success border border-white border-3 rounded-circle" style="left: 65px; top: 65px;"></span>
						</div>
						<div class="dropdown">
							<button class="btn btn-light btn-sm rounded-circle border-0 bg-transparent text-muted" data-bs-toggle="dropdown">
								<i class="bi bi-three-dots-vertical fs-5"></i>
							</button>
							<ul class="dropdown-menu dropdown-menu-end border-0 shadow-premium p-2 rounded-4">
								<li><a class="dropdown-item rounded-3 py-2" href="updated?id=<%=e.getId()%>"><i class="bi bi-pencil me-2"></i>Edit Profile</a></li>
								<li><a class="dropdown-item rounded-3 py-2 text-danger" href="DeleteEmployeeServlet?id=<%=e.getId()%>" onclick="return confirm('Remove this candidate?');"><i class="bi bi-trash me-2"></i>Remove</a></li>
							</ul>
						</div>
					</div>

					<div class="mb-4">
						<h5 class="fw-800 mb-1 ls-tight"><%=e.getName()%></h5>
						<div class="d-flex align-items-center gap-2">
							<span class="badge bg-primary bg-opacity-10 text-primary px-3 py-1 rounded-pill smallest fw-800"><%=e.getPosition()%></span>
							<span class="smallest text-muted fw-800 text-uppercase"><%=e.getDepartment()%></span>
						</div>
					</div>

					<div class="space-y-2 mb-4 flex-grow-1">
						<div class="d-flex align-items-center text-secondary small mb-2">
							<i class="bi bi-envelope me-3 text-primary"></i> <span class="text-truncate" style="max-width: 180px;"><%=e.getEmail()%></span>
						</div>
						<div class="d-flex align-items-center text-secondary small mb-2">
							<i class="bi bi-telephone me-3 text-secondary"></i> <span><%=e.getPhone()%></span>
						</div>
                        <div class="p-3 bg-light rounded-4 d-flex justify-content-between align-items-center mt-3">
                            <span class="smallest text-muted fw-700">ANNUAL SALARY</span>
                            <span class="fw-800 text-dark">₹ <%=String.format("%,.0f", (double) e.getSalary())%></span>
                        </div>
					</div>

					<div class="pt-4 border-top">
						<a href="view?id=<%=e.getId()%>" class="btn btn-outline-primary w-100 fw-800 rounded-4 py-2 hover-glow btn-sm">
							View Full Dossier
						</a>
					</div>
				</div>
			</div>
			<% } } else { %>
			<div class="col-12 text-center py-5">
				<img src="https://illustrations.popsy.co/amber/no-results-found.svg" style="width: 250px;" class="mb-4">
				<h3 class="fw-800">No Candidates Sync'd</h3>
				<p class="text-muted">Adjust filters or register new talent.</p>
				<a href="EmployeeServlet" class="btn btn-primary-custom mt-3">Clear Filters</a>
			</div>
			<% } %>
		</div>

		<div class="mt-5 d-flex justify-content-center">
			<nav>
				<ul class="pagination pagination-custom gap-2">
					<li class="page-item active"><a class="page-link rounded-circle border-0 shadow-soft" href="emp?offset=0">1</a></li>
					<li class="page-item"><a class="page-link rounded-circle border-0 shadow-soft" href="emp?offset=9">2</a></li>
				</ul>
			</nav>
		</div>
	</div>

	<!-- Registration Modal -->
	<div class="modal fade" id="registrationModal" tabindex="-1">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content border-0 shadow-premium" style="border-radius: 32px;">
				<div class="modal-header border-0 pb-0 pt-4 px-4">
					<h4 class="fw-800 ls-tight">Register New Talent</h4>
					<button type="button" class="btn-close me-2 mt-2" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body p-4">
					<form action="add_employee" method="post" enctype="multipart/form-data" class="row g-3">
						<div class="col-md-6">
							<label class="form-label smallest fw-800 text-uppercase">Full Name</label> 
                            <input type="text" name="name" class="form-control rounded-3 py-2" placeholder="e.g. John Doe" required>
						</div>
						<div class="col-md-6">
							<label class="form-label smallest fw-800 text-uppercase">Expected Position</label> 
                            <input type="text" name="position" class="form-control rounded-3 py-2" placeholder="e.g. Lead Dev" required>
						</div>
						<div class="col-md-6">
							<label class="form-label smallest fw-800 text-uppercase">Email Address</label> 
                            <input type="email" name="email" class="form-control rounded-3 py-2" placeholder="name@company.com" required>
						</div>
						<div class="col-md-6">
							<label class="form-label smallest fw-800 text-uppercase">Contact</label> 
                            <input type="number" name="phone" class="form-control rounded-3 py-2" required>
						</div>
						<div class="col-md-4">
							<label class="form-label smallest fw-800 text-uppercase">Department</label> 
                            <select name="department" class="form-select rounded-3 py-2" required>
								<option value="IT">Information Technology</option>
								<option value="HR">Human Resources</option>
								<option value="Other">Other</option>
							</select>
						</div>
						<div class="col-md-4">
							<label class="form-label smallest fw-800 text-uppercase">Annual Package</label> 
                            <input type="number" name="salary" class="form-control rounded-3 py-2" required>
						</div>
						<div class="col-md-4">
							<label class="form-label smallest fw-800 text-uppercase">Availability</label> 
                            <input type="date" name="joiningDate" class="form-control rounded-3 py-2" required>
						</div>
						<div class="col-12 mt-4 pt-2">
							<button type="submit" class="btn btn-primary-custom w-100 py-3 shadow-premium">
								Confirm Registration
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .pagination-custom .page-link { width: 45px; height: 45px; display: flex; align-items: center; justify-content: center; font-weight: 800; }
        .pagination-custom .page-item.active .page-link { background: var(--primary-gradient); color: white; }
    </style>
</body>
</html>
