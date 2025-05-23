<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Calendar" %>
<%
    // Check if the user is logged in
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

        if (rsRole.next()) {
            String role = rsRole.getString("ROLE");
            if ("Doctor".equalsIgnoreCase(role)) {
                isDoctor = true;
            }
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
       
        .main-section
              {
                     background: white;
                     text-align: center;
                     padding: 30px;
              }
         .main-section h1 {
            color: black;
            font-size: 3.5rem;
            margin-bottom: 20px;
        }
       .search-panel {
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #26547c, #06d6a0);
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            width: 50%;
            margin: 20px auto;
        }
        .search-panel input {
            background-color: white;
            padding: 20px 30px;
            border-radius: 20px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            font-weight: bold;
            width: 70%;
            font-size: 1rem;
            border: none;
            outline: none;
        }
        .record-table { margin: auto; width: 80%; border-collapse: collapse; margin-top: 20px; }
        .record-table th, .record-table td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        .record-table th { background-color: #f2f2f2; font-weight: bold; }
         
        .edit-button { padding: 5px 10px; background-color: #007bff; color: white; border: none; cursor: pointer; border-radius: 5px; }
        .edit-button:hover { background-color: #0056b3; }
        .patient-block { margin-bottom: 30px; border: 2px solid #ddd; padding: 15px; border-radius: 10px; background-color: #f9f9f9; }
        .patient-name { font-size: 1.2rem; font-weight: bold; margin-bottom: 10px; }
    </style>
    <script>
        function searchRecords() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let patientBlocks = document.getElementsByClassName("patient-block");
           
            for (let block of patientBlocks) {
                let patientName = block.getElementsByClassName("patient-name")[0].innerText.toLowerCase();
                block.style.display = patientName.includes(input) ? "" : "none";
            }
        }
    </script>
     
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
   
    <div class="main-section">
        <h1>Patient Medical Records</h1>
        <div class="search-panel">
            <input type="text" id="searchInput" onkeyup="searchRecords()" placeholder="Search by Patient Name...">
        </div>
        <div id="recordsContainer">
           <%
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");
       
        // Fetch the doctor's ID based on the logged-in username
        String doctorIdQuery = "SELECT DOCTOR_ID FROM AV.DOCTORS WHERE USERNAME = ?";
        PreparedStatement pstDoctor = conn.prepareStatement(doctorIdQuery);
        pstDoctor.setString(1, username);
        ResultSet rsDoctor = pstDoctor.executeQuery();
       
        int doctorId = -1; // Default invalid value
        if (rsDoctor.next()) {
            doctorId = rsDoctor.getInt("DOCTOR_ID");
        }
        rsDoctor.close();
        pstDoctor.close();
       
        if (doctorId == -1) {
            out.println("<p>Error: Doctor ID not found.</p>");
        } else {
            // Query to fetch only the records of patients who have booked appointments with this doctor
            String query = "SELECT MR.NAME, MH.RECORD_DATE, MH.DIAGNOSIS, MH.TREATMENT, MR.RECORD_ID " +
                           "FROM AV.MEDICAL_RECORDS MR " +
                           "JOIN AV.MEDICAL_HISTORY MH ON MR.RECORD_ID = MH.RECORD_ID " +
                           "JOIN AV.APPOINTMENTS A ON MR.PATIENT_ID = A.PATIENT_ID " +
                           "WHERE A.DOCTOR_ID = ? " +
                           "ORDER BY MR.NAME, MH.RECORD_DATE DESC";
           
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setInt(1, doctorId);
            ResultSet rs = pst.executeQuery();
           
            String lastPatient = "";
            boolean firstRecord = true;
           
            while (rs.next()) {
                String recordId = rs.getString("RECORD_ID");
                String patientName = rs.getString("NAME");
                String recordDate = rs.getString("RECORD_DATE");
                String diagnosis = rs.getString("DIAGNOSIS");
                String treatment = rs.getString("TREATMENT");
               
                if (!patientName.equals(lastPatient)) {
                    if (!firstRecord) {
                        out.println("</table></div>"); // Close previous patient block
                    }
                    out.println("<div class='patient-block'>");
                    out.println("<div class='patient-name'>" + patientName + "</div>");
                    out.println("<table class='record-table'>");
                    out.println("<tr><th>Date</th><th>Diagnosis</th><th>Treatment</th><th>Action</th></tr>");
                    lastPatient = patientName;
                    firstRecord = false;
                }
%>
                <tr>
                    <td><%= recordDate %></td>
                    <td><%= diagnosis %></td>
                    <td><%= treatment %></td>
                    <td>
                        <form action="edit.jsp" method="post">
                            <input type="hidden" name="recordId" value="<%= recordId %>">
                            <button type="submit" class="edit-button">Edit</button>
                        </form>
                    </td>
                </tr>
<%
            }
            if (!firstRecord) {
                out.println("</table></div>"); // Close last patient block
            }
            rs.close();
            pst.close();
        }
       
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error loading records. Please try again later.</p>");
    }
%>

        </div>
    </div>
   
    <%
    String message = request.getParameter("message");
    if (message != null) {
    %>
        <script>alert("<%= message %>");</script>
    <%
    }
    %>
   
   
   
</body>
</html>