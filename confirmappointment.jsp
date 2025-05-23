<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Confirm Appointment</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1e3c72, #2a5298);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }
        h2 {
            color: #1e3c72;
            font-size: 24px;
            margin-bottom: 15px;
        }
        p {
            font-size: 18px;
            color: #555;
            line-height: 1.6;
        }
        .success {
            color: #27ae60;
            font-weight: bold;
            font-size: 20px;
            padding: 15px;
            border-radius: 8px;
            background: rgba(39, 174, 96, 0.1);
            display: inline-block;
            margin-top: 10px;
        }
        .error {
            color: #e74c3c;
            font-weight: bold;
            font-size: 18px;
        }
        .button {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 20px;
            background: #1e3c72;
            color: white;
            font-size: 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
        }
        .button:hover {
            background: #2a5298;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container">
<%
    String doctorUsername = request.getParameter("doctor_username");
    String patientUsername = (String) session.getAttribute("username"); // Retrieve session user name
    String appointmentDate = request.getParameter("appointmentDate");
    String timeslot = request.getParameter("timeslot");
    String doctorName = "";
    String patientName = "";

    if (doctorUsername == null || appointmentDate == null || timeslot == null) {
        out.println("<p class='error'>Invalid data submitted.</p>");
        return;
    }

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya","av","av");

        // Retrieve doctor's name
        String doctorQuery = "SELECT name FROM AV.DOCTOR WHERE username = ?";
        preparedStatement = connection.prepareStatement(doctorQuery);
        preparedStatement.setString(1, doctorUsername);
        resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            doctorName = resultSet.getString("name");
        }
        resultSet.close();
        preparedStatement.close();

        // Retrieve patient's name
        String patientQuery = "SELECT name FROM AV.PATIENT WHERE username = ?";
        preparedStatement = connection.prepareStatement(patientQuery);
        preparedStatement.setString(1, patientUsername);
        resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            patientName = resultSet.getString("name");
        }
        resultSet.close();
        preparedStatement.close();

        // Insert appointment details
        String sql = "INSERT INTO AV.APPOINTMENT (doctor_username, patient_name, appointment_date, timeslot, patient_username) VALUES (?, ?, ?, ?,?)";
preparedStatement = connection.prepareStatement(sql);
preparedStatement.setString(1, doctorUsername); // Doctor's username
preparedStatement.setString(2,patientName );
 preparedStatement.setDate(3, Date.valueOf(appointmentDate)); // Appointment date
preparedStatement.setString(4, timeslot); // Selected timeslot
preparedStatement.setString(5, patientUsername);// Patient's username (instead of patient name)

int result = preparedStatement.executeUpdate();
if (result > 0) {
    out.println("<h2>Appointment Confirmed!</h2>");
    out.println("<p class='success'>Your appointment with Dr. " + doctorName + " is confirmed on " + appointmentDate + " at " + timeslot + ".</p>");
    out.println("<a href='oc.jsp' class='button'>Continue!</a>");


        } else {
            out.println("<p class='error'>Failed to book appointment.</p>");
        }
    } catch (Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            out.println("<p class='error'>Error closing resources: " + e.getMessage() + "</p>");
        }
    }
%>
    </div>
</body>
</html>