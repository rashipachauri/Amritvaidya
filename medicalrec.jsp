<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Calendar" %>
<%
    // Ensure the user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login1.jsp?message=Please login to access this feature.");
        return;
    }

    boolean isPatient = false;
    String patientName = "";

    try {
        // Database connection
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");
        Statement stmt = conn.createStatement();

        // Check if the logged-in user is a patient
        ResultSet rs = stmt.executeQuery("SELECT ROLE FROM AV.LOGIN_DETAILS WHERE USERNAME = '" + username + "'");
        if (rs.next() && "Patient".equalsIgnoreCase(rs.getString("ROLE"))) {
            isPatient = true;
        }
        rs.close();

        if (!isPatient) {
            conn.close();
            response.sendRedirect("medical_record.jsp?message=Access Denied.");
            return;
        }

        // Fetch patient name
        rs = stmt.executeQuery("SELECT NAME FROM AV.PATIENT WHERE USERNAME = '" + username + "'");
        if (rs.next()) {
            patientName = rs.getString("NAME");
        }
        rs.close();

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AmritaVaidya - Medical Records</title>
    <style>
       body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  background-color: #ffffff;
  color: #26547c;
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

.menu a:hover {
  color: #06d6a0;
}

.main-section {
  text-align: center;
  padding: 60px 20px;
  background-color: #f9f9f9;
}

.main-section h1 {
  color: #26547c;
  font-size: 3rem;
  margin-bottom: 20px;
}

.record-table {
  margin: auto;
  width: 90%;
  border-collapse: collapse;
  margin-top: 30px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.record-table th, .record-table td {
  border: 1px solid #ddd;
  padding: 12px;
  text-align: center;
}

.record-table th {
  background-color: #06d6a0;
  color: white;
  font-weight: bold;
}

.record-table tr:nth-child(even) {
  background-color: #f2f2f2;
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
    font-size: 18px;
    font-weight: bold;
}


    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <img src="images/LOGO.png" alt="AmritaVaidya Logo">
        <div class="menu">
            <a href="website.jsp">Home</a>
            <a href="about.jsp">About Us</a>
        </div>
    </div>

    <!-- Main Section -->
    <div class="main-section">
        <h1>My Medical Records</h1>
        <table class="record-table">
            <tr>
               <th>Record ID</th>
                <th>Patient Name</th>
                <th>Diagnosis</th>
                <th>Treatment</th>
                <th>Date</th>
            </tr>
            <%
                // Fetch patient's medical records
                ResultSet rsMed = stmt.executeQuery(
                    "SELECT MH.RECORD_ID, MH.DIAGNOSIS, MH.TREATMENT, MH.RECORD_DATE " +
                    "FROM AV.MEDICAL_RECORDS MR " +
                    "JOIN AV.MEDICAL_HISTORY MH ON MR.RECORD_ID = MH.RECORD_ID " +
                    "WHERE MR.NAME = '" + patientName + "' " +
                    "ORDER BY MH.RECORD_DATE DESC"
                );

                while (rsMed.next()) {
            %>
            <tr>
               <td><%= rsMed.getString("RECORD_ID") %></td>
                <td><%= patientName %></td>
                <td><%= rsMed.getString("DIAGNOSIS") %></td>
                <td><%= rsMed.getString("TREATMENT") %></td>
                <td><%= rsMed.getString("RECORD_DATE") %></td>
            </tr>
            <%
                }
                rsMed.close();
                conn.close();
            %>
        </table>
    </div>

    <!-- Footer -->
    <footer class="footer">
   
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red; text-align:center;'>Error loading records. Please try again later.</p>");
    }
%>
