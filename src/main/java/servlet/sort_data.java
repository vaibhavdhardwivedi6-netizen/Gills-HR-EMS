package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

import empdao.employeedao;
import model.employee;

@WebServlet("/SortServlet")
public class sort_data extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            employeedao dao = new employeedao();

            String filter = request.getParameter("filter");

            List<employee> list = new ArrayList<>();

            if ("name".equals(filter)) {
                list = dao.sortByName();
            }
            else if ("salary".equals(filter)) {
                list = dao.sortBySalary();
            }	
            else if ("date".equals(filter)) {
                list = dao.sortByDate();
            }
            else {

            	list = dao.getByDepartment(filter);
            }

            request.setAttribute("empList", list);
            request.setAttribute("count", list.size());

            request.getRequestDispatcher("index.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}