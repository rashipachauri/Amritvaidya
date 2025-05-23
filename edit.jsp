<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>

<%
    // Ensure the user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login1.jsp?message=Please login to access this feature.");
        return;
    }

    String recordId = request.getParameter("recordId");

    if (recordId == null || recordId.trim().isEmpty()) {
        response.sendRedirect("medical_record.jsp?message=Invalid record selection.");
        return;
    }

    boolean isDoctor = false;
    String patientName = "";
   
    try {
        // Database connection
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");

        // Check user role
        String roleQuery = "SELECT ROLE FROM AV.LOGIN_DETAILS WHERE USERNAME = ?";
        PreparedStatement roleStmt = conn.prepareStatement(roleQuery);
        roleStmt.setString(1, username);
        ResultSet rsRole = roleStmt.executeQuery();

        if (rsRole.next()) {
            String role = rsRole.getString("ROLE");
            if ("Doctor".equalsIgnoreCase(role)) {
                isDoctor = true;
            }
        }

        // Restrict non-doctors
        if (!isDoctor) {
            conn.close();
            response.sendRedirect("medical_record.jsp?message=Access Denied. Doctors Only.");
            return;
        }

        // Fetch patient name
        String nameQuery = "SELECT NAME FROM AV.MEDICAL_RECORDS WHERE RECORD_ID = ?";
        PreparedStatement nameStmt = conn.prepareStatement(nameQuery);
        nameStmt.setString(1, recordId);
        ResultSet rsName = nameStmt.executeQuery();
       
        if (rsName.next()) {
            patientName = rsName.getString("NAME");
        }

        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("medical_record.jsp?message=Error loading record.");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Medical Record</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .header {
            background: linear-gradient(45deg, #b2dfdb, #e1f5fe, #dcedc1);
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 15px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
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
            text-decoration: none;
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

        /* Footer styles */
        .footer {
            background: linear-gradient(to right, #b2fefa, #0ed2f7);
            padding: 40px 20px;
            text-align: center;
            color: white;
            font-size: 16px;
            font-weight: bold;
            margin-top: 50px;
            overflow: hidden;
        }

        .container {
            width: 50%;
            margin: auto;
            background: white;
            padding: 20px;
            margin-top: 50px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: green;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 4px;
            display: block;
            width: 100%;
        }
        button:hover {
            background-color: #0056b3;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            text-decoration: none;
            color: blue;
            font-weight: bold;
        }
        .footer {
    background: linear-gradient(to right, #b2fefa, #0ed2f7);
    padding: 20px;
    text-align: center;
    color: white;
    font-size: 15px;
    font-weight: bold;
    margin-top: auto; /* Pushes footer to the bottom */
}
    </style>
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
<div class="container">
    <h2>Edit Medical Record for <%= patientName %></h2>

    <form action="update.jsp" method="post">
        <input type="hidden" name="recordId" value="<%= recordId %>">

        <div class="form-group">
            <label>Diagnosis:</label>
            <input type="text" name="diagnosis" required>
        </div>

        <div class="form-group">
            <label>Treatment:</label>
            <input type="text" name="treatment" required>
        </div>

        <button type="submit">Save Changes</button>
    </form>

    <div class="back-link">
        <a href="medical_record.jsp">← Back to Records</a>
    </div>
</div>
        <footer class="footer">
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>

</body>
</html>