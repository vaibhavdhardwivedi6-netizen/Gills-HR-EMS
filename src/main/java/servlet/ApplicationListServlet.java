package servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import empdao.ApplicationDAO;
import model.Application;

@WebServlet("/viewApplications")
public class ApplicationListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        model.User user = (model.User) session.getAttribute("userobj");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ApplicationDAO dao = new ApplicationDAO();
        List<Application> list;
        
        if ("admin".equals(user.getRole())) {
            list = dao.getAllApplications();
        } else {
            list = dao.getApplicationsByEmail(user.getEmail());
        }
        
        request.setAttribute("appList", list);
        request.getRequestDispatcher("applications.jsp").forward(request, response);
    }
}
