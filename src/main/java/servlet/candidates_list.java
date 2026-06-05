package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

import empdao.employeedao;
import model.employee;

@WebServlet("/EmployeeServlet")
public class candidates_list extends HttpServlet {

	public candidates_list() {

		super();

	}

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		employeedao dao = new employeedao();

		List<employee> list = dao.getAllEmployees();

		request.setAttribute("empList", list);

		request.getRequestDispatcher("/index.jsp").forward(request, response);

	}

}
