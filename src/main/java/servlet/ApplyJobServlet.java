package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import empdao.ApplicationDAO;
import model.Application;

@WebServlet("/ApplyJobServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 15    // 15MB
)
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int jobId = Integer.parseInt(request.getParameter("jobId"));
            String candidateName = request.getParameter("candidateName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String qualification = request.getParameter("qualification");
            String experience = request.getParameter("experience");

            Part filePart = request.getPart("resume");
            String fileName = getFileName(filePart);
            
            // Save file
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // To avoid name collision, prepend timestamp
            String savedFileName = System.currentTimeMillis() + "_" + fileName;
            File file = new File(uploadFilePath + File.separator + savedFileName);
            
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            Application app = new Application(jobId, candidateName, email, phone, qualification, experience, savedFileName, "Pending");
            
            ApplicationDAO dao = new ApplicationDAO();
            int result = dao.submitApplication(app);

            if (result > 0) {
                request.getSession().setAttribute("msg", "Application submitted successfully!");
            } else {
                request.getSession().setAttribute("msg", "Failed to submit application.");
            }
            
            response.sendRedirect("JobServlet");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "Error: " + e.getMessage());
            response.sendRedirect("JobServlet");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1).replace("\"", "");
            }
        }
        return "";
    }
}
