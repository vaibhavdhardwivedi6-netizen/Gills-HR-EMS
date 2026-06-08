package empdao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Application;

import db.DatabaseConnection;

public class ApplicationDAO {

    public static Connection getConnection() {
        return DatabaseConnection.getConnection();
    }

    public int submitApplication(Application app) {
        int i = 0;
        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO applications (job_id, candidate_name, email, phone, qualification, experience, resumeFileName, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, app.getJobId());
            ps.setString(2, app.getCandidateName());
            ps.setString(3, app.getEmail());
            ps.setString(4, app.getPhone());
            ps.setString(5, app.getQualification());
            ps.setString(6, app.getExperience());
            ps.setString(7, app.getResumeFileName());
            ps.setString(8, app.getStatus());

            i = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }

    public List<Application> getApplicationsByJobId(int jobId) {
        List<Application> list = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM applications WHERE job_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = mapResultSetToApplication(rs);
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Application> getAllApplications() {
        List<Application> list = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM applications ORDER BY apply_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = mapResultSetToApplication(rs);
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int updateApplicationStatus(int id, String status) {
        int i = 0;
        try (Connection conn = getConnection()) {
            String sql = "UPDATE applications SET status = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, id);
            i = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }

    public List<Application> getApplicationsByEmail(String email) {
        List<Application> list = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM applications WHERE email = ? ORDER BY apply_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = mapResultSetToApplication(rs);
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Application mapResultSetToApplication(ResultSet rs) throws SQLException {
        Application app = new Application();
        app.setId(rs.getInt("id"));
        app.setJobId(rs.getInt("job_id"));
        app.setCandidateName(rs.getString("candidate_name"));
        app.setEmail(rs.getString("email"));
        app.setPhone(rs.getString("phone"));
        app.setQualification(rs.getString("qualification"));
        app.setExperience(rs.getString("experience"));
        app.setApplyDate(rs.getTimestamp("apply_date"));
        app.setResumeFileName(rs.getString("resumeFileName"));
        app.setStatus(rs.getString("status"));
        return app;
    }
}
