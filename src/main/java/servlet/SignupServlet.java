package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import empdao.UserDAO;
import model.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // "admin" or "user"

        User user = new User(name, username, password, email, role);
        UserDAO dao = new UserDAO();

        int result = dao.registerUser(user);

        if (result > 0) {
            request.getSession().setAttribute("succMsg", "Registration Successful! Please Login.");
            response.sendRedirect("login.jsp");
        } else {
            request.getSession().setAttribute("errorMsg", "Registration Failed. Please try again.");
            response.sendRedirect("signup.jsp");
        }
    }
}
