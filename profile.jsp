<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Check if the user is logged in
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login1.jsp"); // Redirect to login page if not logged in
        return;
    }

    String userRole = "";
    String name = "";
    String email = "";
    String bloodGroup = "";
    String gender = "";
    String dob = "";
    String contact = "";
    String qualification = "";
    String specialty = "";

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        // Load Derby JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

        // Step 1: Fetch role from LOGIN_DETAILS using username
        String sql = "SELECT role FROM LOGIN_DETAILS WHERE username = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        resultSet = statement.executeQuery();

        if (resultSet.next()) {
            userRole = resultSet.getString("role");
        }

        resultSet.close();
        statement.close();

        // Step 2: Fetch user details from the appropriate table
        if ("patient".equalsIgnoreCase(userRole)) {
    sql = "SELECT name, email, bloodgroup, gender, dob, contactnum FROM PATIENT WHERE username = ?";
} else if ("doctor".equalsIgnoreCase(userRole)) {
    sql = "SELECT name, email, bloodgroup, gender, dob, qualification, specialty, contact FROM DOCTOR WHERE username = ?";
}

if (!userRole.isEmpty()) {
    statement = connection.prepareStatement(sql);
    statement.setString(1, username);
    resultSet = statement.executeQuery();

    if (resultSet.next()) {
        name = resultSet.getString("name");
        email = resultSet.getString("email");
        bloodGroup = resultSet.getString("bloodgroup");
        gender = resultSet.getString("gender");
        dob = resultSet.getString("dob");

        if ("patient".equalsIgnoreCase(userRole)) {
            contact = resultSet.getString("contactnum"); // Get contactnum from patient
        } else if ("doctor".equalsIgnoreCase(userRole)) {
            contact = resultSet.getString("contact"); // Get contact from doctor
            qualification = resultSet.getString("qualification");
            specialty = resultSet.getString("specialty");
        }
    }
}

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <style>
        body {
    background-color: #f4f4f9;
    font-family: 'Segoe UI', sans-serif;
    margin: 0;
    padding: 0;
}
.header {
    background: linear-gradient(45deg, #b2dfdb, #e1f5fe, #dcedc1);
    padding: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    border-radius: 0;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    position: relative;
    top: 0;
    left: 0;
}
           
        .header img {
            height: 100px;
            width: 100px;
        }
        .menu {
            display: flex;
            gap: 35px;
            position: relative;
            background-color: white;
            padding: 20px 30px;
            border-radius: 20px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
           
            font-weight: bold;
        }
        .menu a {
            text-decoration:none;
            color: black;
            font-weight: bold;
            position: relative;
             font-size: 20px;
        }
        .menu-item {
            position: relative;
           font-size: 20px;
        }
        .dropdown {
            position: absolute;
            top: 100%;
            left: 0;
            display: none;
              background: #4db6ac;
            border: 1px solid #ddd;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
            z-index: 1000;
            min-width: 250px;
            overflow: hidden;
            transform: translateY(10px);
            transition: opacity 0.3s ease, transform 0.3s ease;
   
   
        }
        .dropdown a {
            display: block;
    padding: 12px 20px;
    text-decoration: none;
    color: #333;
    font-weight: bold;
    background: white;
    border-radius: 8px;
    margin: 5px 10px;
    transition: background 0.3s ease, transform 0.2s ease;
        }
       
        .dropdown a:hover {
            background-color: #b2dfdb;
    transform: scale(1.05);
        }
       
        .dropdown.show {
          display: block;
          opacity: 1;
          transform: translateY(0);
}
        .menu-item:hover .dropdown {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }
        .menu-item:last-child .dropdown {
            left: auto;
            right: 0;
        }
.container {
    max-width: 1000px;
    margin: 60px auto 50px;
    background: #ffffff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 8px 16px rgba(38, 84, 124, 0.1);
}

h4 {
    color: #26547c;
    font-size: 38px;
    text-align: center;
    margin-bottom: 30px;
    position: relative;
}

h4::after {
    content: "";
    position: absolute;
    width: 70px;
    height: 3px;
    background-color: #06d6a0;
    left: 50%;
    transform: translateX(-50%);
    bottom: -10px;
    border-radius: 2px;
}

.card {
    border: none;
    border-radius: 10px;
    overflow: hidden;
}

.account-settings-links .list-group-item {
    background: #ffffff;
    color: #26547c;
    font-weight: 600;
    border: none;
    border-bottom: 1px solid #e0e0e0;
    transition: background 0.3s ease;
}

.account-settings-links .list-group-item:hover {
    background-color: #06d6a0;
    color: #ffffff;
}

.account-settings-links .active {
    background-color: #26547c;
    color: #ffffff;
}

.form-group {
    margin-bottom: 20px;
}

.form-label {
    font-weight: 600;
    color: #26547c;
}

.form-control {
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 10px;
    font-size: 16px;
}

.form-control:focus {
    border-color: #06d6a0;
    outline: none;
    box-shadow: 0 0 5px rgba(6, 214, 160, 0.5);
}

.btn-primary {
    background-color: #06d6a0;
    border: none;
    color: #ffffff;
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: bold;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

.btn-primary:hover {
    background-color: #04b68a;
    transform: translateY(-2px);
}

.tab-content {
    padding: 20px;
}

@media (max-width: 768px) {
    .container {
        margin: 100px 10px 30px;
        padding: 20px;
    }
}
.footer {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(to right, #b2fefa, #0ed2f7);
    padding: 20px;
    text-align: center;
    color: white;
    font-size: 15px;
    font-weight: bold;
}


    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
   <div class="header">
        <img src="images/LOGO.png" alt="AmritaVaidya Logo">
        <div class="menu">
            <div class="menu-item">
                <a href="#">Login</a>
                <div class="dropdown">
                    <a href="login1.jsp">Are you a Patient?</a>
                    <a href="login1.jsp">Are you a Doctor?</a>
                </div>
            </div>
            <a href="started.jsp">Home</a>
            <a href="#about">About Us</a>
            <a href="faq.jsp">FAQs</a>
            <a href="contact.html">Contact Us</a>
           
            <div class="menu-item">
                <a href="#">Profile</a>
                <div class="dropdown">
                    <a href="profile.jsp">My Profile</a>
                   
                    <a href="logout.jsp">Sign Out</a>
                   
                </div>
            </div>
            </div>
    </div>

    <div class="container light-style flex-grow-1 container-p-y">
        <h4 class="font-weight-bold py-3 mb-4">Account settings</h4>
        <div class="card overflow-hidden">
            <div class="row no-gutters row-bordered row-border-light">
                <div class="col-md-3 pt-0">
                    <div class="list-group list-group-flush account-settings-links">
                        <a class="list-group-item list-group-item-action active" data-toggle="list" href="#account-general">General</a>
                        <a class="list-group-item list-group-item-action" data-toggle="list" href="#account-change-password">Change password</a>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="tab-content">
                        <div class="tab-pane fade active show" id="account-general">
                            <div class="card-body">
                                <form method="post" action="updateProfile.jsp">
                                    <div class="form-group">
                                        <label class="form-label">Username</label>
                                        <input type="text" class="form-control" name="username" value="<%= username %>" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Name</label>
                                        <input type="text" class="form-control" name="name" value="<%= name %>">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">E-mail</label>
                                        <input type="text" class="form-control" name="email" value="<%= email %>">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Blood Group</label>
                                        <input type="text" class="form-control" name="bloodGroup" value="<%= bloodGroup %>">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Gender</label>
                                        <input type="text" class="form-control" name="gender" value="<%= gender %>">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Date of Birth</label>
                                        <input type="text" class="form-control" name="dob" value="<%= dob %>">
                                    </div>
                                   

                                    <% if ("doctor".equalsIgnoreCase(userRole)) { %>
    <div class="form-group">
        <label class="form-label">Qualification</label>
        <input type="text" class="form-control" name="qualification" value="<%= qualification %>">
    </div>
    <div class="form-group">
        <label class="form-label">Specialty</label>
        <input type="text" class="form-control" name="specialty" value="<%= specialty %>">
    </div>
        <div class="form-group">
    <label class="form-label">Contact</label>
    <input type="text" class="form-control" name="contact" value="<%= contact %>">
</div>
<% } %>

                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </form>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="account-change-password">
    <div class="card-body pb-2">
        <form action="changePassword.jsp" method="post">
            <div class="form-group">
                <label class="form-label">Current Password</label>
                <input type="password" class="form-control" name="currentPassword" required>
            </div>
            <div class="form-group">
                <label class="form-label">New Password</label>
                <input type="password" class="form-control" name="newPassword" required>
            </div>
            <div class="form-group">
                <label class="form-label">Repeat New Password</label>
                <input type="password" class="form-control" name="confirmNewPassword" required>
            </div>
            <button type="submit" class="btn btn-primary">Change Password</button>
        </form>
    </div>
</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<footer class="footer">
   
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>

                                     <%
    String success = request.getParameter("success");
    String error = request.getParameter("error");

    if ("true".equals(success)) {
%>
        <div class="alert alert-success">Profile updated successfully!</div>
<%
    } else if ("true".equals(error)) {
%>
        <div class="alert alert-danger">Error updating profile. Please try again.</div>
<%
    }
%>
<%
    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");

    if ("passwordChanged".equals(successMsg)) {
%>
    <div class="alert alert-success">Password changed successfully!</div>
<% } else if ("incorrectPassword".equals(errorMsg)) { %>
    <div class="alert alert-danger">Incorrect current password. Please try again.</div>
<% } else if ("passwordMismatch".equals(errorMsg)) { %>
    <div class="alert alert-danger">New password and confirm password do not match!</div>
<% } else if ("serverError".equals(errorMsg)) { %>
    <div class="alert alert-danger">An error occurred. Please try again later.</div>
<% } %>


    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>