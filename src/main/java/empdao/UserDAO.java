package empdao;

import java.sql.*;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import db.DatabaseConnection;

public class UserDAO {

    public static Connection getConnection() {
        return DatabaseConnection.getConnection();
    }

    public int registerUser(User user) {
        int i = 0;
        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO users (name, username, password, email, role, profile_pic) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getUsername());
            
            // Hash the password before saving
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            ps.setString(3, hashedPassword);
            
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getRole());
            ps.setString(6, user.getProfilePic());
            i = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }

    public User login(String username, String password) {
        User user = null;
        try (Connection conn = getConnection()) {
            // First, get the user by username
            String sql = "SELECT * FROM users WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String hashedPasswordFromDB = rs.getString("password");
                
                // Verify the password using BCrypt
                if (BCrypt.checkpw(password, hashedPasswordFromDB)) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setProfilePic(rs.getString("profile_pic"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public int updateProfilePicture(int userId, String profilePic) {
        int i = 0;
        try (Connection conn = getConnection()) {
            String sql = "UPDATE users SET profile_pic = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, profilePic);
            ps.setInt(2, userId);
            i = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }

    public int updateUserInfo(User user) {
        int i = 0;
        try (Connection conn = getConnection()) {
            String sql = "UPDATE users SET name = ?, email = ?, username = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getUsername());
            ps.setInt(4, user.getId());
            i = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }
}
