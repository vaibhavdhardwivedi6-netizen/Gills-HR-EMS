package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import empdao.employeedao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.employee;

@WebServlet("/emp")
public class employee_list  extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public employee_list() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	int off = Integer.parseInt(request.getParameter("offset"));
    	
        employeedao dao = new employeedao();
        
        List<employee> list = dao.getEmployeesWithOffset(off);
        
        int total = dao.getCount();

        request.setAttribute("empList", list);
        request.setAttribute("count", total);

        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);
    }

   
   
}