package model;

public class employee {

	private int id;
	private String name;
	private String email;
	private String address;
	private String position;
	private int age;
	private String skill;
	private double salary;
	private String phone;
	private String department;
	private String joiningDate;
	private String image;

	public employee() {
	}

	public employee(String name, String email, String address, String position, int age, String skill, double salary,
			String phone, String department, String joiningDate, String image) {
		super();
		this.name = name;
		this.email = email;
		this.address = address;
		this.position = position;
		this.age = age;
		this.skill = skill;
		this.salary = salary;
		this.phone = phone;
		this.department = department;
		this.joiningDate = joiningDate;
		this.image = image;

	}

	public employee(int id, String name, String email, String address, String position, int age, String skill,
			double salary, String phone, String department, String joiningDate, String image) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.address = address;
		this.position = position;
		this.age = age;
		this.skill = skill;
		this.salary = salary;
		this.phone = phone;
		this.department = department;
		this.joiningDate = joiningDate;
		this.image = image;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getSkill() {
		return skill;
	}

	public void setSkill(String skill) {
		this.skill = skill;
	}

	public double getSalary() {
		return salary;
	}

	public void setSalary(double salary) {
		this.salary = salary;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDepartment() {

		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getJoiningDate() {
		return joiningDate;
	}

	public void setJoiningDate(String joiningDate) {
		this.joiningDate = joiningDate;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {

		this.image = image;
	}

	@Override
	public String toString() {
		return "employee [id=" + id + ", name=" + name + ", email=" + email + ", address=" + address + ", position="
				+ position + ", age=" + age + ", skill=" + skill + ", salary=" + salary + ", phone=" + phone
				+ ", department=" + department + ", joiningDate=" + joiningDate + ", image=" + image + "]";
	}

}