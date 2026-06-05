package servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.jobs;

import java.io.IOException;

import empdao.jobdao;

import java.util.List;


@WebServlet("/FindName")
public class Job_Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Job_Search() {
        super();
       
    }

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String query = request.getParameter("searching");
		
		jobdao dao = new jobdao();
		
		List<jobs> list = dao.searchByJobTitle(query);
		
		request.setAttribute("jobList",list);
		
		RequestDispatcher rd = request.getRequestDispatcher("jobs.jsp");
		
		rd.forward(request, response);
		
		}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
}



