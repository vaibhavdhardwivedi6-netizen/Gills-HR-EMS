package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
import model.*;
import empdao.*;

@WebServlet("/home")
public class Dashboard_servlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	  public Dashboard_servlet() {
	        super();
	    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("userobj");
        
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        employeedao edao = new employeedao();
        jobdao jdao = new jobdao();
        ApplicationDAO adao = new ApplicationDAO();
        
        request.setAttribute("empCount", edao.getCount());
        request.setAttribute("jobCount", jdao.getCount());
        
        List<Application> userApps;
        if ("admin".equals(loginUser.getRole())) {
            userApps = adao.getAllApplications();
        } else {
            userApps = adao.getApplicationsByEmail(loginUser.getEmail());
        }
        request.setAttribute("appCount", userApps.size());
        
        // Fetch extra data for dashboard
        request.setAttribute("recentEmployees", edao.getRecentEmployees(5));
        request.setAttribute("recentJobs", jdao.getRecentJobs(5));
        request.setAttribute("deptStats", edao.getDepartmentStats());
        
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}