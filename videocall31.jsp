<%@page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Check if the user is logged in
    String username = (String) session.getAttribute("username");
   

    // Get today's date in the required format (YYYY-MM-DD)
    Date today = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = sdf.format(today);

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String doctorEmail = null;

    try {
        // Database connection
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");

        // Get the doctor's email
        String doctorQuery = "SELECT EMAIL FROM AV.DOCTOR WHERE USERNAME = ?";
        pst = conn.prepareStatement(doctorQuery);
        pst.setString(1, username);
        rs = pst.executeQuery();
        if (rs.next()) {
            doctorEmail = rs.getString("EMAIL");
        }
        rs.close();
        pst.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Today's Appointments</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f9;
    padding: 0px;
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

h2 {
    text-align: center;
    color: #26547c;
    margin-bottom: 24px;
    font-size: 38px;
    font-weight: 700;
    letter-spacing: 1px;
    text-transform: uppercase;
    position: relative;
    display: inline-block;
    padding-bottom: 8px;
}

h2::after {
    content: "";
    position: absolute;
    width: 50%;
    height: 3px;
    background-color: #06d6a0;
    left: 25%;
    bottom: 0;
    border-radius: 2px;
}



.appointments-table {
    width: 100%;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 6px 12px rgba(38, 84, 124, 0.2);
}

.appointments-table th, .appointments-table td {
    padding: 14px;
    text-align: center;
    border: 1px solid #e0e0e0;
}

.appointments-table th {
    background-color: #26547c;
    color: #ffffff;
    font-weight: 600;
    letter-spacing: 0.5px;
}

.appointments-table td {
    color: #333;
}

.copy-icon {
   
    cursor: pointer;
    width: 18px;
    margin-left: 8px;
    transition: transform 0.2s ease;
}

.copy-icon:hover {
    transform: scale(1.2);
}

.continue-btn {
    background-color: #06d6a0;
    color: #ffffff;
    padding: 10px 16px;
    border: none;
    cursor: pointer;
    border-radius: 8px;
    font-weight: 600;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

.continue-btn:hover {
    background-color: #04b68a;
    transform: translateY(-2px);
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
        function copyToClipboard(email) {
            navigator.clipboard.writeText(email).then(() => {
                alert("Copied: " + email);
            }).catch(err => {
                console.error("Error copying text: ", err);
            });
        }

        function startMeet(doctorEmail, patientEmail) {
            if (!doctorEmail || !patientEmail) {
                alert("Doctor or Patient email is missing!");
                return;
            }
           
            // Generate a Google Meet link dynamically
            var meetLink = "https://meet.google.com/new";

            // Open Google Meet in a new tab
            window.open(meetLink, '_blank');
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

<h2>Today's Appointments</h2>

<table class="appointments-table">
    <tr>
        <th>Patient Name</th>
        <th>Email</th>
        

        <th>Time Slot</th>
        <th>VideoCall</th>
    </tr>
    <footer class="footer">
   
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>

    <%
    try {
        // Fetch today's appointments for the logged-in doctor
        String query = "SELECT A.PATIENT_USERNAME, A.TIMESLOT, P.NAME, P.EMAIL " +
                       "FROM AV.APPOINTMENT A " +
                       "JOIN AV.PATIENT P ON A.PATIENT_USERNAME = P.USERNAME " +
                       "WHERE A.DOCTOR_USERNAME = ? AND A.APPOINTMENT_DATE = ?";
        pst = conn.prepareStatement(query);
        pst.setString(1, username);
        pst.setString(2, formattedDate);
        rs = pst.executeQuery();

        boolean hasAppointments = false;
        while (rs.next()) {
            hasAppointments = true;
            String patientName = rs.getString("NAME");
            String patientEmail = rs.getString("EMAIL");
            String timeSlot = rs.getString("TIMESLOT");
    %>
            <tr>
                <td><%= patientName %></td>
                <td>
    <%= patientEmail %>
    <img src="copy_icon.png" alt="Copy" class="copy-icon" 
         onclick="copyToClipboard('<%= patientEmail %>')" 
         style="width: 20px; height: 20px; margin-left: 5px; cursor: pointer;">
</td>
                <td><%= timeSlot %></td>
                <td>
                    <button type="button" class="continue-btn" onclick="startMeet('<%= doctorEmail %>', '<%= patientEmail %>')">Start</button>
                </td>
            </tr>
    <%
        }
        if (!hasAppointments) {
    %>
        <tr>
            <td colspan="4">No appointments for today.</td>
        </tr>
    <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
    %>
</table>

</body>
</html>