package servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.employee;

import java.io.IOException;

import empdao.employeedao;

@WebServlet("/view")
public class profile_view extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public profile_view() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        employeedao dao = new employeedao();
        employee emp = dao.getEmployeeById(id);

        System.out.println("ID: " + id);
        System.out.println("Employee: " + emp);

        request.setAttribute("emp", emp);

        RequestDispatcher rd = request.getRequestDispatcher("employee_view.jsp");

        rd.forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
