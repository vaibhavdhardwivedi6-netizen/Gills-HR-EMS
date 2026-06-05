package empdao;

import java.sql.*;
import java.util.*;
import model.employee;

import db.DatabaseConnection;

public class employeedao {

	public static Connection getConnection() {
		return DatabaseConnection.getConnection();
	}

	public int addEmployee(employee emp) {

		int i = 0;

		try {

			Connection con = getConnection();

			PreparedStatement ps = con.prepareStatement(

					"INSERT INTO employee(name,email,address,position,age,skill,salary,phone,department,joiningDate,image) VALUES (?,?,?,?,?,?,?,?,?,?,?)");

			ps.setString(1, emp.getName());

			ps.setString(2, emp.getEmail());

			ps.setString(3, emp.getAddress());

			ps.setString(4, emp.getPosition());

			ps.setInt(5, emp.getAge());

			ps.setString(6, emp.getSkill());

			ps.setDouble(7, emp.getSalary());

			ps.setString(8, emp.getPhone());

			ps.setString(9, emp.getDepartment());

			if (emp.getJoiningDate() != null && !emp.getJoiningDate().isEmpty()) {
				ps.setDate(10, java.sql.Date.valueOf(emp.getJoiningDate()));
			} else {
				ps.setNull(10, java.sql.Types.DATE);
			}

			ps.setString(11, emp.getImage());

			i = ps.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		}

		return i;
	}

	public boolean deleteEmployee(int id) {

		boolean status = false;

		try {

			Connection con = getConnection();

			PreparedStatement ps = con.prepareStatement("DELETE FROM employee WHERE id=?");

			ps.setInt(1, id);

			ps.executeUpdate();

			status = true;

		} catch (Exception e) {

			e.printStackTrace();

		}

		return status;

	}

	public List<employee> getAllEmployees() {

		List<employee> list = new ArrayList<>();

		try {

			Connection con = getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * FROM employee");

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				list.add(new employee(

						rs.getInt("id"),

						rs.getString("name"),

						rs.getString("email"),

						rs.getString("address"),

						rs.getString("position"),

						rs.getInt("age"),

						rs.getString("skill"),

						rs.getDouble("salary"),

						rs.getString("phone"),

						rs.getString("department"),

						rs.getDate("joiningDate") != null ? rs.getDate("joiningDate").toString() : "",

						rs.getString("image")

				));

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return list;

	}

	public employee getEmployeeById(int id) {

		employee emp = null;

		try {

			Connection con = getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * FROM employee WHERE id=?");

			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				emp = new employee(

						rs.getInt("id"),

						rs.getString("name"),

						rs.getString("email"),

						rs.getString("address"),

						rs.getString("position"),

						rs.getInt("age"),

						rs.getString("skill"),

						rs.getDouble("salary"),

						rs.getString("phone"),

						rs.getString("department"),

						rs.getDate("joiningDate") != null ? rs.getDate("joiningDate").toString() : "",

						rs.getString("image")

				);

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return emp;

	}

	private List<employee> getSortedEmployees(String orderBy) {

		List<employee> list = new ArrayList<>();

		try {

			Connection conn = getConnection();

			String sql = "SELECT * FROM employee ORDER BY " + orderBy;

			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				list.add(new employee(

						rs.getInt("id"),

						rs.getString("name"),

						rs.getString("email"),

						rs.getString("address"),

						rs.getString("position"),

						rs.getInt("age"),

						rs.getString("skill"),

						rs.getDouble("salary"),

						rs.getString("phone"),

						rs.getString("department"),

						rs.getDate("joiningDate") != null ? rs.getDate("joiningDate").toString() : "",

						rs.getString("image")

				));

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return list;

	}

	public List<employee> getByDepartment(String dept) {

		List<employee> list = new ArrayList<>();

		try {

			Connection conn = getConnection();

			String sql = "SELECT * FROM employee WHERE department = ?";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, dept);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				list.add(new employee(

						rs.getInt("id"),

						rs.getString("name"),

						rs.getString("email"),

						rs.getString("address"),

						rs.getString("position"),

						rs.getInt("age"),

						rs.getString("skill"),

						rs.getDouble("salary"),

						rs.getString("phone"),

						rs.getString("department"),

						rs.getDate("joiningDate") != null ? rs.getDate("joiningDate").toString() : "",

						rs.getString("image")

				));

			}

		} catch (Exception e) {
			e.printStackTrace();

		}

		return list;

	}

	public int getCount() {

		int count = 0;

		try {

			Connection conn = getConnection();

			PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM employee");

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				count = rs.getInt(1);

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return count;

	}

	public void delete(int id) {

		try {
			Connection con = getConnection();

			PreparedStatement ps = con.prepareStatement("DELETE FROM employee WHERE id=?");

			ps.setInt(1, id);

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int updateuser(employee em) {

		int result = 0;

		try (Connection con = getConnection();

				PreparedStatement ps = con.prepareStatement(
						"UPDATE employee SET name=?, email=?, position=?, address=?, age=?, skill=?, salary=?, phone=?, department=?, joiningDate=? WHERE id=?"

				)) {

			ps.setString(1, em.getName());
			ps.setString(2, em.getEmail());
			ps.setString(3, em.getPosition());
			ps.setString(4, em.getAddress());
			ps.setInt(5, em.getAge());
			ps.setString(6, em.getSkill());
			ps.setDouble(7, em.getSalary());
			ps.setString(8, em.getPhone());
			ps.setString(9, em.getDepartment());

			if (em.getJoiningDate() != null && !em.getJoiningDate().isEmpty()) {
				ps.setDate(10, java.sql.Date.valueOf(em.getJoiningDate()));
			} else {
				ps.setNull(10, java.sql.Types.DATE);
			}

			ps.setInt(11, em.getId());

			result = ps.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		}

		return result;

	}

	public List<employee> sortBySalary() {

		List<employee> list = new ArrayList<>();

		try {
			Connection con = getConnection();

			PreparedStatement pre = con.prepareStatement("SELECT * FROM employee ORDER BY salary DESC");

			ResultSet rs = pre.executeQuery();

			while (rs.next()) {

				list.add(new employee(

						rs.getInt("id"),

						rs.getString("name"),

						rs.getString("email"),

						rs.getString("address"),

						rs.getString("position"),

						rs.getInt("age"),

						rs.getString("skill"),

						rs.getDouble("salary"),

						rs.getString("phone"),

						rs.getString("department"),

						rs.getDate("joiningDate") != null ? rs.getDate("joiningDate").toString() : "",

						rs.getString("image")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<employee> getsearch(String namee) {

		List<employee> list = new ArrayList<>();

		try {

			Connection con = getConnection();

			PreparedStatement pre = con.prepareStatement("SELECT * FROM employee WHERE name LIKE ?");

			pre.setString(1, "%" + namee + "%");

			ResultSet rs = pre.executeQuery();

			while (rs.next()) {

				list.add(new employee(

						rs.getInt("id"),

						rs.getString("name"),

						rs.getString("email"),

						rs.getString("address"),

						rs.getString("position"),

						rs.getInt("age"),

						rs.getString("skill"),

						rs.getDouble("salary"),

						rs.getString("phone"),

						rs.getString("department"),

						rs.getDate("joiningDate") != null ? rs.getDate("joiningDate").toString() : "",

						rs.getString("image")

				));

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return list;

	}

	public List<employee> sortByDate() {

		List<employee> list = new ArrayList<>();

		try {
			Connection con = getConnection();

			PreparedStatement pre = con.prepareStatement("SELECT * FROM employee ORDER BY joiningDate DESC");

			ResultSet rs = pre.executeQuery();

			while (rs.next()) {

				list.add(new employee(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
						rs.getString("address"), rs.getString("position"), rs.getInt("age"), rs.getString("skill"),
						rs.getDouble("salary"), rs.getString("phone"), rs.getString("department"),
						rs.getDate("joiningDate").toString(), rs.getString("image")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<employee> sortByName() {

		List<employee> list = new ArrayList<>();

		try {
			Connection con = getConnection();

			PreparedStatement pre = con.prepareStatement("SELECT * FROM employee ORDER BY name ASC");

			ResultSet rs = pre.executeQuery();

			while (rs.next()) {

				list.add(new employee(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
						rs.getString("address"), rs.getString("position"), rs.getInt("age"), rs.getString("skill"),
						rs.getDouble("salary"), rs.getString("phone"), rs.getString("department"),
						rs.getDate("joiningDate").toString(), rs.getString("image")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<employee> getEmployeesWithOffset(int offset) {

		List<employee> list = new ArrayList<>();

		try {
			Connection con = getConnection();

			PreparedStatement ps = con.prepareStatement("SELECT * FROM employee LIMIT 9 OFFSET ?");

			ps.setInt(1, offset);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new employee(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
						rs.getString("address"), rs.getString("position"), rs.getInt("age"),
						rs.getString("skill"),
						rs.getDouble("salary"), rs.getString("phone"), rs.getString("department"),
						rs.getDate("joiningDate") != null ? rs.getDate("joiningDate").toString() : "", rs.getString("image")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<employee> getRecentEmployees(int limit) {
		List<employee> list = new ArrayList<>();
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM employee ORDER BY id DESC LIMIT ?");
			ps.setInt(1, limit);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new employee(
						rs.getInt("id"),
						rs.getString("name"),
						rs.getString("email"),
						rs.getString("address"),
						rs.getString("position"),
						rs.getInt("age"),
						rs.getString("skill"),
						rs.getDouble("salary"),
						rs.getString("phone"),
						rs.getString("department"),
						rs.getDate("joiningDate") != null ? rs.getDate("joiningDate").toString() : "",
						rs.getString("image")
				));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Map<String, Integer> getDepartmentStats() {
		Map<String, Integer> stats = new HashMap<>();
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT department, COUNT(*) as count FROM employee GROUP BY department");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				stats.put(rs.getString("department"), rs.getInt("count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stats;
	}
}