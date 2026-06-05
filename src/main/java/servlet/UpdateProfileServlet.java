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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import empdao.UserDAO;
import model.User;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 5,      // 5MB
    maxRequestSize = 1024 * 1024 * 10    // 10MB
)
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads/profiles";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("userobj");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            
            Part filePart = request.getPart("profilePic");
            String fileName = getFileName(filePart);
            
            UserDAO dao = new UserDAO();
            
            if (fileName != null && !fileName.isEmpty()) {
                // Save file
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
                
                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String savedFileName = "profile_" + currentUser.getId() + "_" + System.currentTimeMillis() + "_" + fileName;
                File file = new File(uploadFilePath + File.separator + savedFileName);
                
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
                
                dao.updateProfilePicture(currentUser.getId(), savedFileName);
                currentUser.setProfilePic(savedFileName);
            }

            currentUser.setName(name);
            currentUser.setEmail(email);
            currentUser.setUsername(username);
            
            int result = dao.updateUserInfo(currentUser);

            if (result > 0) {
                session.setAttribute("userobj", currentUser);
                session.setAttribute("msg", "Profile updated successfully!");
            } else {
                session.setAttribute("msg", "Failed to update profile info.");
            }
            
            response.sendRedirect("profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Error: " + e.getMessage());
            response.sendRedirect("profile.jsp");
        }
    }

    private String getFileName(Part part) {
        if (part == null) return null;
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1).replace("\"", "");
            }
        }
        return null;
    }
}
