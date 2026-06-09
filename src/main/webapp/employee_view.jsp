<%@page import="model.employee"%>

<%
employee emp = (employee) request.getAttribute("emp");

if(emp == null){
    response.sendRedirect("EmployeeServlet");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<div class="container mt-5">

    <div class="card shadow p-4">

        <h2 class="text-center mb-4">Employee Details</h2>

        <table class="table table-bordered">

            <tr>
                <th>ID</th>
                <td><%= emp.getId() %></td>
            </tr>

            <tr>
                <th>Name</th>
                <td><%= emp.getName() %></td>
            </tr>

            <tr>
                <th>Email</th>
                <td><%= emp.getEmail() %></td>
            </tr>

            <tr>
                <th>Phone</th>
                <td><%= emp.getPhone() %></td>
            </tr>

            <tr>
                <th>Department</th>
                <td><%= emp.getDepartment() %></td>
            </tr>

            <tr>
                <th>Position</th>
                <td><%= emp.getPosition() %></td>
            </tr>

            <tr>
                <th>Address</th>
                <td><%= emp.getAddress() %></td>
            </tr>

            <tr>
                <th>Age</th>
                <td><%= emp.getAge() %></td>
            </tr>

            <tr>
                <th>Skill</th>
                <td><%= emp.getSkill() %></td>
            </tr>

            <tr>
                <th>Salary</th>
                <td><%= emp.getSalary() %></td>
            </tr>

        </table>

        <div class="text-center">
            <a href="EmployeeServlet" class="btn btn-primary">
                Back
            </a>
        </div>

    </div>

</div>

</body>
</html>