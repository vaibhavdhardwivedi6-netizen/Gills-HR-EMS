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


@WebServlet("/updated")
public class Edit_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public Edit_Servlet() {
        super();
     }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
			int id = Integer.parseInt(request.getParameter("id"));
			
			employeedao dao =  new employeedao();
			
			employee em =dao.getEmployeeById(id);
			
			request.setAttribute("empList", em);
			
			RequestDispatcher rd = request.getRequestDispatcher("Edit.jsp");
			rd.forward(request, response);
			
			
	}
		
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		    int id = Integer.parseInt(request.getParameter("id"));

		    employeedao dao = new employeedao();

		    employee emp = new employee();
		    emp.setId(id);
		    emp.setName(request.getParameter("name"));
		    
		    emp.setEmail(request.getParameter("email"));
		    emp.setPosition(request.getParameter("position"));
		    emp.setAddress(request.getParameter("address"));
		    emp.setAge(Integer.parseInt(request.getParameter("age")));
		    emp.setSkill(request.getParameter("skill"));
		    emp.setSalary(Double.parseDouble(request.getParameter("salary")));
		    emp.setPhone(request.getParameter("phone"));
		    emp.setDepartment(request.getParameter("department"));
	        emp.setJoiningDate(request.getParameter("joiningDate"));

		    

		    dao.updateuser(emp);

		    response.sendRedirect("view?id=" + id);
		}
	}


