<%@page import="java.sql.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Check if the user is logged in
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Today's Appointment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
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

        .container {
            max-width: 600px;
            margin: 60px auto;
            background: #ffffff;
            padding: 30px 20px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(38, 84, 124, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .container:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(38, 84, 124, 0.15);
        }
        .container h2 {
            font-size: 26px;
            margin-bottom: 20px;
            color: #26547c;
            position: relative;
            display: inline-block;
        }
        .container h2::after {
            content: "";
            position: absolute;
            width: 60%;
            height: 3px;
            background-color: #06d6a0;
            left: 20%;
            bottom: -8px;
            border-radius: 2px;
        }
        .appointment-details {
            font-size: 18px;
            color: #26547c;
            margin-bottom: 20px;
            line-height: 1.6;
            padding: 10px;
            border: 1px solid #06d6a0;
            border-radius: 10px;
            background: #e1f5fe;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .appointment-details strong {
            color: #06d6a0;
        }
        .message {
            font-size: 16px;
            color: #06d6a0;
            font-weight: bold;
            margin-top: 10px;
        }
        .no-appointment {
            font-size: 18px;
            color: #d62828;
            margin-top: 10px;
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
    <h2>Your Appointments for Today</h2>

    
    <%
        boolean hasAppointments = false;
        try {
            // Database connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");

            // Get today's date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String todayDate = sdf.format(new java.util.Date());

            // Query to get all today's appointment details for the patient
            String query = "SELECT a.TIMESLOT, d.NAME AS DOCTOR_NAME " +
                           "FROM APPOINTMENT a " +
                           "JOIN DOCTOR d ON a.DOCTOR_USERNAME = d.USERNAME " +
                           "WHERE a.PATIENT_USERNAME = ? AND a.APPOINTMENT_DATE = ?";

            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, todayDate);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                hasAppointments = true;
    %>
                <div class="appointment-details">
                    <p><strong>Doctor:</strong> <%= rs.getString("DOCTOR_NAME") %></p>
                    <p><strong>Time:</strong> <%= rs.getString("TIMESLOT") %></p>
                    <p class="message">You will receive a consultation link shortly.</p>
                </div>
    <%
            }

            if (!hasAppointments) {
    %>
                <p class="no-appointment">You do not have any appointments scheduled for today.</p>
    <%
            }

            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>

<footer class="footer">
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>

</body>
</html>
