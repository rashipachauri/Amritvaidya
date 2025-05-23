<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Ensure user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login1.jsp?message=Please login to access this feature.");
        return;
    }

    boolean isDoctor = false;
    boolean isPatient = false;
    String patientName = ""; // Stores the patient's actual name

    try {
        // Database connection
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");

        // Fetch user's role from LOGIN_DETAILS
        PreparedStatement pstmt = conn.prepareStatement("SELECT ROLE FROM AV.LOGIN_DETAILS WHERE USERNAME = ?");
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            String role = rs.getString("ROLE");
            if ("Doctor".equalsIgnoreCase(role)) {
                isDoctor = true;
            } else if ("Patient".equalsIgnoreCase(role)) {
                isPatient = true;

                // Fetch the patient's name from the PATIENT table
                PreparedStatement pstmtPatient = conn.prepareStatement("SELECT NAME FROM AV.PATIENT WHERE USERNAME = ?");
                pstmtPatient.setString(1, username);
                ResultSet rsPatient = pstmtPatient.executeQuery();

                if (rsPatient.next()) {
                    patientName = rsPatient.getString("NAME");
                }

                rsPatient.close();
                pstmtPatient.close();
            }
        }

        rs.close();
        pstmt.close();
        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    // Redirect if the user is neither a doctor nor a patient
    if (!isDoctor && !isPatient) {
        response.sendRedirect("error.jsp?message=Access Denied.");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f8ff;
        }

        .header {
            background: linear-gradient(45deg, #b2dfdb, #e1f5fe, #dcedc1);
            padding: 15px 20px;
            height: 10vh;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header img {
            height: 120px;
        }

        .menu a {
            text-decoration: none;
            color: black;
            font-weight: bold;
            font-size: 22px;
            padding: 10px 15px;
        }

        .menu a:hover {
            background-color: #007bff;
            color: #fff;
        }

        .main-section {
            text-align: center;
            padding: 50px;
        }

        .record-table {
            margin: auto;
            width: 80%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .record-table th, .record-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
            font-size: 22px;
        }

        .record-table th {
            background-color: #00c6ff;
            color: white;
        }

        button {
            padding: 10px 15px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            color: white;
            background: linear-gradient(to right, #007bff, #00c6ff);
        }

        button:hover {
            background: linear-gradient(to right, #00c6ff, #007bff);
        }

        .footer {
            background: linear-gradient(to right, #b2fefa, #0ed2f7);
            padding: 20px;
            text-align: center;
            color: white;
            font-size: 15px;
            font-weight: bold;
        }
    </style>

    <script>
        function cancelAppointment(appointmentId) {
            if (confirm("Are you sure you want to cancel this appointment?")) {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "cancelAppointment.jsp", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        location.reload();
                    }
                };
                xhr.send("appointmentId=" + appointmentId);
            }
        }
        function confirmAppointment(appointmentId) {
        if (confirm("Are you sure you want to confirm this appointment?")) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "confirmAppointment.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    location.reload();
                }
            };
            xhr.send("appointmentId=" + appointmentId);
        }
    }
    </script>
</head>
<body>
    <div class="header">
        <img src="images/LOGO.png" alt="AmritaVaidya Logo">
        <div class="menu">
            <a href="website.jsp">Home</a>
            <a href="ocTemplate.jsp">Search for your patient consultation details</a>
        </div>
    </div>

    <div class="main-section">
        <h1><%= isDoctor ? "Doctor's Appointments" : "My Appointments" %></h1>

        <table class="record-table">
            <tr>
                <th><%= isDoctor ? "Patient Name" : "Doctor Name" %></th>
                <th>Appointment Date</th>
                <th>Appointment Time</th>
                <th> Appointment</th>
            </tr>

           <%
                String query;
                if (isDoctor) {
                    query = "SELECT PATIENT_NAME, APPOINTMENT_DATE, TIMESLOT, ID FROM APPOINTMENT WHERE DOCTOR_USERNAME = ?";
                } else {
                    // Fetch doctor's name instead of username
                    query = "SELECT D.NAME AS DOCTOR_NAME, A.APPOINTMENT_DATE, A.TIMESLOT, A.ID " +
                            "FROM APPOINTMENT A " +
                            "JOIN DOCTOR D ON A.DOCTOR_USERNAME = D.USERNAME " +
                            "WHERE A.PATIENT_NAME = ?";
                }

                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");

                    PreparedStatement stmt = conn.prepareStatement(query);
                    if (isDoctor) {
                        stmt.setString(1, username);
                    } else {
                        stmt.setString(1, patientName);
                    }
                    ResultSet rsMed = stmt.executeQuery();

                    while (rsMed.next()) {
            %>
            <tr>
                <td><%= isDoctor ? rsMed.getString("PATIENT_NAME") : rsMed.getString("DOCTOR_NAME") %></td>
                <td><%= rsMed.getDate("APPOINTMENT_DATE") %></td>
                <td><%= rsMed.getString("TIMESLOT") %></td>
                <td>
                    <button onclick="cancelAppointment(<%= rsMed.getInt("ID") %>)">Cancel</button>
             <button onclick="confirmAppointment(<%= rsMed.getInt("ID") %>)">Confirm</button>    </td>
            </tr>
            <% }
                rsMed.close();
                stmt.close();
                conn.close();
            } catch (Exception e) { e.printStackTrace(); }
            %>
        </table>
    </div>

    <footer class="footer">
        <p>© 2025 Amritavaidya. All Rights Reserved.</p>
    </footer>
</body>
</html>
