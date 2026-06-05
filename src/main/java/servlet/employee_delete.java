package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import empdao.employeedao;

@WebServlet("/DeleteEmployeeServlet")
public class employee_delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	  public employee_delete() {
	        super();
	    }

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			int id = Integer.parseInt(request.getParameter("id"));

			employeedao dao = new employeedao();
			dao.delete(id);

			response.sendRedirect("EmployeeServlet");
		}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
