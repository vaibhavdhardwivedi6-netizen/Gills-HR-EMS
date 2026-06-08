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


@WebServlet("/jobsupdate")
public class Edit_jobs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public Edit_jobs() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
		int Id = Integer.parseInt(request.getParameter("id"));
		
		jobdao dao =  new jobdao();
		
		jobs em = dao.getJobById(Id);
		
		request.setAttribute("job", em);
		
		RequestDispatcher rd = request.getRequestDispatcher("update_jobs.jsp");
		rd.forward(request, response);
		
		
        }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  
		int id = Integer.parseInt(request.getParameter("jobId"));
		String companyName = request.getParameter("companyName");
        String jobTitle = request.getParameter("jobTitle");
        int vacancies = Integer.parseInt(request.getParameter("vacancies"));
        String jobLocation = request.getParameter("jobLocation");
        String qualification = request.getParameter("qualification");
        String experience = request.getParameter("experience");
        String salary = request.getParameter("salary");
        String startDate = request.getParameter("applicationStartDate");
        String lastDate = request.getParameter("applicationLastDate");

        jobs job = new jobs(id,companyName,jobTitle,vacancies,jobLocation,qualification,experience,salary,startDate,lastDate);
      

        jobdao dao = new jobdao();
          
       int i = dao.updatejob(job);


        response.sendRedirect("JobServlet");
 }
}