package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import empdao.ApplicationDAO;

@WebServlet("/updateStatus")
public class UpdateApplicationStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        ApplicationDAO dao = new ApplicationDAO();
        int result = dao.updateApplicationStatus(id, status);

        if (result > 0) {
            request.getSession().setAttribute("msg", "Status updated to " + status);
        } else {
            request.getSession().setAttribute("msg", "Failed to update status");
        }
        
        response.sendRedirect("viewApplications");
    }
}
