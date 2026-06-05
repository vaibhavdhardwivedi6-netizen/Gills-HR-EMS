
package servlet;

import java.io.IOException;
import empdao.jobdao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteJobServlet")
public class Delete_jobs extends HttpServlet {

    private static final long serialVersionUID = 1L;

   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
      
        
                jobdao dao = new jobdao();
               
                dao.deleteJob(id); 
            
                response.sendRedirect("JobServlet");
        }

    }