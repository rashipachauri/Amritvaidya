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
        .dropdown-profile-container {
            display: none;
            position: absolute;
            top: 110px;
            left: -100%;
            transform: translateX(-50%);
            background: white;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            padding: 10px;
            z-index: 1000;
            width: 280px;
            max-height: 300px;
            overflow-y: auto;
        }
        .dropdown-profile-container .images-grid {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            gap: 8px;
            padding: 5px;
        }
        .dropdown-profile-container img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .dropdown-profile-container img:hover {
            transform: scale(1.1);
        }
        .header img {
            height: 100px;
            width: 100px;
        }
        .menu { display: flex; gap: 20px; }
        .menu a { text-decoration: none; color: blue; font-weight: bold; }
        .main-section
              {
                     background-image:  url('images/b5.jpg');
                     text-align: center;
                     padding: 50px;
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
         .footer {
            background: linear-gradient(to right, #b2fefa, #0ed2f7);
            padding: 20px;
            text-align: center;
            margin-top: 50px;
        }
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
          <div class="profile-container">
        <img src="images/pp1.jpg" alt="Profile Picture" class="profile-pic" onclick="toggleDropdown()">
        <div class="dropdown-profile-container" id="dropdown">
            <img src="images/pp1.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp2.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp3.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp4.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp5.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp6.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp7.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp8.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp9.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp10.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp11.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp12.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp13.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp14.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp15.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp16.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp17.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp18.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp19.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp20.jpg" onclick="changeProfilePic(this.src)">
            <img src="images/pp21.jpg" onclick="changeProfilePic(this.src)">
           
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
                   
                    String query = "SELECT MR.NAME, MH.RECORD_DATE, MH.DIAGNOSIS, MH.TREATMENT, MR.RECORD_ID " +
                                   "FROM AV.MEDICAL_RECORDS MR " +
                                   "JOIN AV.MEDICAL_HISTORY MH ON MR.RECORD_ID = MH.RECORD_ID " +
                                   "ORDER BY MR.NAME, MH.RECORD_DATE DESC";

                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
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
   
   
    <div class="footer">
        <% Calendar calendar = Calendar.getInstance(); int year = calendar.get(Calendar.YEAR); %>
        <p>&copy; <%= year %> AmritaVaidya. All Rights Reserved.</p>
    </div>
</body>
</html>