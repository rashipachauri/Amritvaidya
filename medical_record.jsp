<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Calendar" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login1.jsp?message=Please login to access this feature.");
        return;
    }
   
    boolean isDoctor = false;
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");
        Statement stmt = conn.createStatement();

        String roleQuery = "SELECT ROLE FROM AV.LOGIN_DETAILS WHERE USERNAME = '" + username + "'";
        ResultSet rsRole = stmt.executeQuery(roleQuery);

        if (rsRole.next() && "Doctor".equalsIgnoreCase(rsRole.getString("ROLE"))) {
            isDoctor = true;
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (!isDoctor) {
        response.sendRedirect("medicalrec.jsp?message=Access Denied. Doctors Only.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Medical Records</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
        .header {
             background: linear-gradient(45deg, #b2dfdb, #e1f5fe, #dcedc1);
             padding: 15px;
             display: flex;
             justify-content: space-between;
             align-items: center;
             border-radius: 15px;
             box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
             }
        .profile-container {
            display: flex;
            align-items: center;
            margin-left: 10px;
            cursor: pointer;
            position: relative;
        }
        .profile-pic {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #0077b6;
        }
        .header img {
            height: 100px;
            width: 100px;
        }
        .main-section {
            background-image: url('images/b5.jpg');
            text-align: center;
            padding: 50px;
        }
        .main-section h1 {
            color: black;
            font-size: 3.5rem;
            margin-bottom: 20px;
        }
        .patient-block {
            margin-bottom: 30px;
            border: 2px solid #ddd;
            padding: 15px;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .patient-name {
            font-size: 1.2rem;
            font-weight: bold;
            cursor: pointer;
            color: blue;
            text-decoration: underline;
        }
        .record-table {
            display: none;
            margin-top: 10px;
            width: 100%;
            border-collapse: collapse;
        }
        .record-table th, .record-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .record-table th {
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
    font-size: 15px;
    font-weight: bold;
}
    </style>
    <script>
        function toggleRecords(patientId) {
            var table = document.getElementById("records-" + patientId);
            if (table.style.display === "none") {
                table.style.display = "table";
            } else {
                table.style.display = "none";
            }
        }
    </script>
</head>
<body>
    <div class="header">
        <img src="images/LOGO.png" alt="AmritaVaidya Logo">
    </div>
    <div class="main-section">
        <h1>Patient Medical Records</h1>
        <div id="recordsContainer">
            <%
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");
                    String query = "SELECT MR.NAME, MR.PATIENT_USERNAME, MH.RECORD_DATE, MH.DIAGNOSIS, MH.TREATMENT, MR.RECORD_ID " +
                                   "FROM AV.MEDICAL_RECORDS MR " +
                                   "JOIN AV.MEDICAL_HISTORY MH ON MR.RECORD_ID = MH.RECORD_ID " +
                                   "JOIN AV.APPOINTMENT A ON MR.PATIENT_USERNAME = A.PATIENT_USERNAME " +
                                   "WHERE A.DOCTOR_USERNAME = ? " +
                                   "ORDER BY MR.NAME, MH.RECORD_DATE DESC";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, username);
                    ResultSet rs = pstmt.executeQuery();
                    String lastPatient = "";
                    boolean hasRecords = false;
                    while (rs.next()) {
                        hasRecords = true;
                        String recordId = rs.getString("RECORD_ID");
                        String patientName = rs.getString("NAME");
                        String patientUsername = rs.getString("PATIENT_USERNAME");
                        String recordDate = rs.getString("RECORD_DATE");
                        String diagnosis = rs.getString("DIAGNOSIS");
                        String treatment = rs.getString("TREATMENT");
                        if (!patientName.equals(lastPatient)) {
                            if (!lastPatient.equals("")) {
                                out.println("</table></div>");
                            }
                            out.println("<div class='patient-block'>");
                            out.println("<div class='patient-name' onclick='toggleRecords(\"" + patientUsername + "\")'>" + patientName + "</div>");
                            out.println("<table id='records-" + patientUsername + "' class='record-table'>");
                            out.println("<tr><th>Date</th><th>Diagnosis</th><th>Treatment</th><th>Action</th></tr>");
                            lastPatient = patientName;
                        }
            %>
                    <tr>
                        <td><%= recordDate %></td>
                        <td><%= diagnosis %></td>
                        <td><%= treatment %></td>
                        <td>
                            <form action="edit.jsp" method="post">
                                <input type="hidden" name="recordId" value="<%= recordId %>">
                                <button type="submit">Edit</button>
                            </form>
                        </td>
                    </tr>
            <%
                    }
                    if (hasRecords) {
                        out.println("</table></div>");
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
        <footer class="footer">
   
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>
</body>
</html>