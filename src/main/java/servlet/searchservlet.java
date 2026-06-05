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

import java.util.List;


@WebServlet("/search")
public class searchservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public searchservlet() {
        super();
       
    }

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String query = request.getParameter("searchname");
		
		employeedao dao = new employeedao();
		
		List<employee> list = dao.getsearch(query);
		
		request.setAttribute("empList",list);
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		
		rd.forward(request, response);
		
		}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
