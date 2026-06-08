package servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.employee;

import java.io.File;
import java.io.IOException;
import java.util.List;

import empdao.employeedao;

@WebServlet("/add_employee")
@MultipartConfig
public class add_employee extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String position = request.getParameter("position");
		String address = request.getParameter("address") != null ? request.getParameter("address") : "";
		int age = Integer.parseInt(request.getParameter("age"));
		String skill = request.getParameter("skill") != null ? request.getParameter("skill") : "";
		double salary = Double.parseDouble(request.getParameter("salary"));
		String phone = request.getParameter("phone");
		String department = request.getParameter("department");
		String joiningDate = request.getParameter("joiningDate");

		Part filePart = request.getPart("image");
		String fileName = (filePart != null) ? filePart.getSubmittedFileName() : "";

		if (fileName != null && !fileName.isEmpty()) {
			String path = getServletContext().getRealPath("/") + "image";
			File dir = new File(path);
			if (!dir.exists())
				dir.mkdirs();
			filePart.write(path + File.separator + fileName);
		} else {
			fileName = "";
		}

		employee emp = new employee(name, email, address, position, age, skill, salary, phone, department, joiningDate,
				fileName);

		employeedao dao = new employeedao();
		dao.addEmployee(emp);

		List<employee> list = dao.getAllEmployees();
		int total = dao.getCount();

		request.setAttribute("empList", list);
		request.setAttribute("count", total);

		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}
}