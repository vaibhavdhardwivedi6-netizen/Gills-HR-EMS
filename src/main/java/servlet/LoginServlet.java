package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import empdao.UserDAO;
import model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.login(username, pass);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userobj", user);
            
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("home");
            } else {
                response.sendRedirect("JobServlet");
            }
        } else {
            request.getSession().setAttribute("errorMsg", "Invalid Username or Password");
            response.sendRedirect("login.jsp");
        }
    }
}
