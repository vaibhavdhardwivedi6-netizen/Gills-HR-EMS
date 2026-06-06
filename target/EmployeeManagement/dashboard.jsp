<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, model.*"%>
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
<title>Dashboard | GlisHR EMS</title>

<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="css/style.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    .hero-glass {
        background: linear-gradient(135deg, rgba(99, 102, 241, 0.1) 0%, rgba(168, 85, 247, 0.1) 100%);
        border-radius: 32px;
        padding: 3.5rem;
        position: relative;
        overflow: hidden;
        border: 1px solid rgba(255, 255, 255, 0.4);
    }
    
    .hero-glass::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -10%;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(99, 102, 241, 0.15) 0%, transparent 70%);
        z-index: 0;
    }
    
    .floating-badge {
        position: absolute;
        top: 2rem;
        right: 2rem;
        background: white;
        padding: 0.6rem 1.2rem;
        border-radius: 50px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-weight: 800;
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .ls-tight { letter-spacing: -1.5px; }
    .fw-800 { font-weight: 800; }
</style>
</head>

<body>

	<div class="sidebar">
		<div class="brand">
			<i class="bi bi-rocket-takeoff-fill"></i> <span>GlisHR</span>
		</div>

		<nav>
			<div class="text-uppercase small fw-bold text-muted mb-3 px-3" style="letter-spacing: 1px;">Menu</div>

			<div class="nav-item">
				<a href="home" class="nav-link active"> <i class="bi bi-grid-1x2-fill"></i> <span>Dashboard</span></a>
			</div>

			<% if("admin".equals(loginUser.getRole())) { %>
			<div class="nav-item">
				<a href="EmployeeServlet" class="nav-link"> <i class="bi bi-people-fill"></i> <span>Candidates</span></a>
			</div>
			<% } %>

			<div class="nav-item">
				<a href="JobServlet" class="nav-link"><i class="bi bi-briefcase-fill"></i> <span>Jobs</span></a>
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
				<a href="logout" class="nav-link text-danger"><i class="bi bi-box-arrow-left"></i> <span>Logout</span></a>
			</div>
		</nav>
	</div>

	<div class="main-content">
		<!-- Hero Section -->
		<div class="hero-glass mb-5 animate-fade-in shadow-soft">
		    <div class="floating-badge">
		        <div class="bg-success rounded-circle" style="width: 8px; height: 8px;"></div>
		        <span class="text-success">Live Pipeline Active</span>
		    </div>
		    <div class="position-relative z-1">
		        <h1 class="display-5 fw-800 mb-2 ls-tight">Welcome back, <%= loginUser.getName() %>!</h1>
		        <p class="text-secondary fs-5 mb-0" style="max-width: 600px;">
		            <%= "admin".equals(loginUser.getRole()) ? "The recruitment engine is running smoothly. Monitor talent acquisition and departmental health indicators below." : "Your next career milestone is just around the corner. Track your active applications and discover new premium roles." %>
		        </p>
		    </div>
		</div>

		<!-- Quick Stats -->
		<div class="row g-4 mb-5 animate-fade-in">
			<% if("admin".equals(loginUser.getRole())) { %>
			<div class="col-md-3">
				<a href="EmployeeServlet" class="text-decoration-none">
					<div class="stat-card blue shadow-soft">
						<div class="small fw-800 text-uppercase opacity-75 mb-1">Talent Pool</div>
						<div class="display-6 fw-800 mb-2 ls-tight"><%=(request.getAttribute("empCount") != null ? request.getAttribute("empCount") : "0")%></div>
						<div class="small fw-600"><i class="bi bi-graph-up-arrow me-1"></i> Growing Dynamic</div>
						<i class="bi bi-people"></i>
					</div>
				</a>
			</div>
			<% } %>
			<div class="col-md-3">
				<a href="JobServlet" class="text-decoration-none">
					<div class="stat-card purple shadow-soft">
						<div class="small fw-800 text-uppercase opacity-75 mb-1">Open Positions</div>
						<div class="display-6 fw-800 mb-2 ls-tight"><%=(request.getAttribute("jobCount") != null ? request.getAttribute("jobCount") : "0")%></div>
						<div class="small fw-600"><i class="bi bi-lightning-charge me-1"></i> Actively Hiring</div>
						<i class="bi bi-briefcase"></i>
					</div>
				</a>
			</div>
			<div class="col-md-3">
				<a href="viewApplications" class="text-decoration-none">
					<div class="stat-card orange shadow-soft">
						<div class="small fw-800 text-uppercase opacity-75 mb-1">Responses</div>
						<div class="display-6 fw-800 mb-2 ls-tight"><%=(request.getAttribute("appCount") != null ? request.getAttribute("appCount") : "0")%></div>
						<div class="small fw-600"><i class="bi bi-hourglass-split me-1"></i> Status Tracker</div>
						<i class="bi bi-calendar-check"></i>
					</div>
				</a>
			</div>
			<div class="col-md-3">
				<div class="stat-card green shadow-soft">
					<div class="small fw-800 text-uppercase opacity-75 mb-1">Hire Ratio</div>
					<div class="display-6 fw-800 mb-2 ls-tight">92%</div>
					<div class="small fw-600"><i class="bi bi-shield-check me-1"></i> Industry Standard</div>
					<i class="bi bi-award"></i>
				</div>
			</div>
		</div>

		<!-- Charts & Analytics Section -->
		<div class="row g-4 mb-5 animate-fade-in" style="animation-delay: 100ms">
			<div class="col-lg-8">
				<div class="glass-card shadow-soft">
					<div class="d-flex justify-content-between align-items-center mb-5">
					    <div>
					        <h5 class="fw-800 mb-1">Recruitment Analytics</h5>
					        <p class="smallest text-muted mb-0">Visualizing application flow and hiring velocity</p>
					    </div>
					    <div class="d-flex gap-2">
					        <button class="btn btn-light btn-sm rounded-pill px-3 border smallest fw-700">Weekly</button>
					        <button class="btn btn-primary btn-sm rounded-pill px-3 border-0 smallest fw-700 bg-opacity-10 text-primary">Monthly</button>
					    </div>
					</div>
					<div class="chart-container" style="height: 330px;">
						<canvas id="hiringChart"></canvas>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="glass-card shadow-soft">
					<h5 class="fw-800 mb-2">Talent Diversity</h5>
					<p class="smallest text-muted mb-4">Distribution by departments</p>
					<div class="chart-container" style="height: 330px;">
						<canvas id="deptChart"></canvas>
					</div>
				</div>
			</div>
		</div>

		<!-- Data Grid & Action Hub -->
		<div class="row g-4 mb-5 animate-fade-in" style="animation-delay: 200ms">
			<div class="col-lg-9">
				<div class="glass-card shadow-soft">
					<div class="d-flex justify-content-between align-items-center mb-5">
						<h5 class="fw-800 mb-0"><%= "admin".equals(loginUser.getRole()) ? "Live Candidate Feed" : "Applied Opportunities History" %></h5>
						<a href="<%= "admin".equals(loginUser.getRole()) ? "EmployeeServlet" : "viewApplications" %>" 
						   class="btn btn-outline-primary px-4 rounded-pill smallest fw-700 hover-glow">
							Full Report <i class="bi bi-arrow-right ms-2"></i>
						</a>
					</div>
					
					<% if("admin".equals(loginUser.getRole())) { %>
					<div class="table-responsive">
						<table class="table-custom">
							<thead>
								<tr class="text-muted smallest text-uppercase fw-800 opacity-75">
									<th class="pb-4">Candidate</th>
									<th class="pb-4">Target Role</th>
									<th class="pb-4">Status</th>
									<th class="pb-4 text-end">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								List<employee> recentEmps = (List<employee>) request.getAttribute("recentEmployees");
								if (recentEmps != null && !recentEmps.isEmpty()) {
									for (employee emp : recentEmps) {
								%>
								<tr>
									<td>
										<div class="d-flex align-items-center gap-3">
                                            <div class="avatar-sm bg-primary bg-opacity-10 text-primary rounded-4 d-flex align-items-center justify-content-center fw-800" style="width: 45px; height: 45px; font-size: 1.1rem;">
                                                <%= emp.getName().substring(0, 1).toUpperCase() %>
                                            </div>
											<div>
												<div class="fw-700 text-dark mb-0"><%=emp.getName()%></div>
												<div class="smallest text-muted"><%=emp.getEmail()%></div>
											</div>
										</div>
									</td>
									<td>
									    <div class="fw-600 text-dark"><%=emp.getPosition()%></div>
									    <div class="smallest text-secondary"><%=emp.getDepartment()%></div>
									</td>
									<td>
									    <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 py-2 smallest fw-800">Verified</span>
									</td>
									<td class="text-end">
										<a href="profile.jsp?id=<%=emp.getId()%>" class="btn-icon btn-light hover-glow text-primary"><i class="bi bi-chevron-right"></i></a>
									</td>
								</tr>
								<% } } else { %>
								<tr><td colspan="4" class="text-center py-5"><div class="text-muted opacity-50">Pulse sync in progress...</div></td></tr>
								<% } %>
							</tbody>
						</table>
					</div>
					<% } else { %>
					<div class="text-center py-5">
						<img src="https://illustrations.popsy.co/amber/success.svg" style="width: 250px;" class="mb-4">
						<h3 class="fw-800 mb-2 ls-tight">Peak Performance!</h3>
						<p class="text-secondary mx-auto mb-4" style="max-width: 450px;">Your profile visibility has increased by 15% this week. Keep applying to stay on recruiters' radar.</p>
						<a href="JobServlet" class="btn btn-primary-custom px-5 py-3 shadow-premium">Find More Opportunities</a>
					</div>
					<% } %>
				</div>
			</div>
			
			<div class="col-lg-3">
				<h5 class="fw-800 mb-4">Command Center</h5>
				<div class="row g-3">
					<% if("admin".equals(loginUser.getRole())) { %>
					<div class="col-12">
						<a href="index.jsp" class="action-card p-4 shadow-soft"> 
						    <div class="bg-primary bg-opacity-10 text-primary rounded-4 p-3 d-inline-block mb-3">
						        <i class="bi bi-person-plus-fill fs-3"></i>
						    </div>
							<div class="fw-800 small text-uppercase">Onboard Talent</div>
						</a>
					</div>
					<div class="col-12">
						<a href="JobServlet" class="action-card p-4 shadow-soft"> 
						    <div class="bg-purple bg-opacity-10 text-purple rounded-4 p-3 d-inline-block mb-3">
						        <i class="bi bi-megaphone-fill fs-3" style="color: #a855f7;"></i>
						    </div>
							<div class="fw-800 small text-uppercase">Post Opening</div>
						</a>
					</div>
					<% } else { %>
					<div class="col-12">
						<a href="JobServlet" class="action-card p-4 shadow-soft"> 
						    <div class="bg-primary bg-opacity-10 text-primary rounded-4 p-3 d-inline-block mb-3">
						        <i class="bi bi-search-heart-fill fs-3"></i>
						    </div>
							<div class="fw-800 small text-uppercase">Discover Roles</div>
						</a>
					</div>
					<% } %>
					<div class="col-12">
						<button class="action-card w-100 border-0 p-4 shadow-soft text-start" onclick="alert('Compiling analytical datasets...')">
						    <div class="bg-orange bg-opacity-10 text-orange rounded-4 p-3 d-inline-block mb-3">
						        <i class="bi bi-file-earmark-bar-graph-fill fs-3" style="color: #f97316;"></i>
						    </div>
							<div class="fw-800 small text-uppercase">System Audit</div>
							<div class="smallest text-muted mt-1">Export PDF Metrics</div>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		const hiringCtx = document.getElementById('hiringChart').getContext('2d');
		const gradient = hiringCtx.createLinearGradient(0, 0, 0, 400);
        gradient.addColorStop(0, 'rgba(99, 102, 241, 0.2)');
        gradient.addColorStop(1, 'rgba(99, 102, 241, 0)');

		new Chart(hiringCtx, {
			type : 'line',
			data : {
				labels : [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun' ],
				datasets : [ {
					label : 'Engagement Pulsar',
					data : [ 15, 25, 18, 38, 32, 45 ],
					borderColor : '#6366f1',
					borderWidth : 5,
					tension : 0.45,
					fill : true,
					backgroundColor : gradient,
					pointRadius: 4,
					pointBackgroundColor: '#fff',
					pointBorderWidth: 4,
					pointBorderColor: '#6366f1'
				}]
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : { legend : { display: false }},
				scales : {
					y : { 
					    beginAtZero : true, 
					    grid : { color: 'rgba(0,0,0,0.02)' }, 
					    border: {display: false},
					    ticks: {font: {family: 'Outfit', weight: 600}}
					},
					x : { 
					    grid : { display : false }, 
					    border: {display: false},
					    ticks: {font: {family: 'Outfit', weight: 600}}
					}
				}
			}
		});

		<%Map<String, Integer> deptStats = (Map<String, Integer>) request.getAttribute("deptStats");
		StringBuilder labels = new StringBuilder();
		StringBuilder counts = new StringBuilder();
		if (deptStats != null) {
			for (Map.Entry<String, Integer> entry : deptStats.entrySet()) {
				labels.append("'").append(entry.getKey()).append("',");
				counts.append(entry.getValue()).append(",");
			}
		}%>
		const deptCtx = document.getElementById('deptChart').getContext('2d');
		new Chart(deptCtx, {
			type : 'doughnut',
			data : {
				labels : [<%=labels.toString()%>],
				datasets : [ {
					data : [<%=counts.toString()%>],
					backgroundColor : [ '#6366f1', '#a855f7', '#f97316', '#10b981', '#ef4444' ],
					borderWidth : 0,
                    hoverOffset: 20
				} ]
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : { legend : { position : 'bottom', labels: { usePointStyle: true, padding: 30, font: {family: 'Outfit', size: 12, weight: 700} }}},
				cutout : '82%',
                animation: { animateScale: true }
			}
		});
	</script>
</body>
</html>