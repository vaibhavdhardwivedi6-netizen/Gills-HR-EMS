package servlet;

import java.io.IOException;
import java.util.List;

import empdao.jobdao;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.jobs;

@WebServlet("/JobServlet")
public class add_job extends HttpServlet {

    public add_job() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        jobdao dao = new jobdao();

        List<jobs> list = dao.getAllJobs();

        request.setAttribute("jobList", list);

        RequestDispatcher rd = request.getRequestDispatcher("jobs.jsp");

        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String companyName = request.getParameter("companyName");
        String jobTitle = request.getParameter("jobTitle");
        int vacancies = Integer.parseInt(request.getParameter("vacancies"));
        String jobLocation = request.getParameter("jobLocation");
        String qualification = request.getParameter("qualification");
        String experience = request.getParameter("experience");
        String salary = request.getParameter("salary");
        String startDate = request.getParameter("applicationStartDate");
        String lastDate = request.getParameter("applicationLastDate");

        jobs job = new jobs(companyName, jobTitle, vacancies, jobLocation, qualification, experience, salary, startDate, lastDate);

        jobdao dao = new jobdao();

        int i = dao.insertJob(job);
        response.sendRedirect("JobServlet");
    }
}
