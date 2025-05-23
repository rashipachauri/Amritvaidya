<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor List</title>
    <style>
        html, body {
            height: 100%; /* Ensure full height */
            margin: 0;
            display: flex;
            flex-direction: column; /* Stack children vertically */
        }

        body {
            font-family: Arial, sans-serif; /* Ensure consistent font */
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

        .footer {
            background: linear-gradient(to right, #b2fefa, #0ed2f7);
            padding: 20px;
            text-align: center;
            color: white;
            font-size: 15px;
            font-weight: bold;
            margin-top: auto; /* Pushes footer to the bottom */
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

        h2 {
            text-align: center;
            left: 40%;
            font-size: 38px;
            font-weight: bold;
            color: #26547c;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 20px;
            padding: 10px;
            border-bottom: 4px solid #06d6a0;
            display: inline-block;
            position: relative;
        }

        h2:hover {
            color: #06d6a0;
            transition: 0.3s ease;
        }

        @media (max-width: 768px) {
            h2 {
                font-size: 24px;
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.95); /* Light transparent background */
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 2px solid #e0e0e0;
        }

        th {
            background-color: #26547c; /* Deep Medical Blue */
            color: white;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        td {
            font-size: 14px;
            color: #333;
        }

        /* Alternate Row Color for Better Readability */
        tr:nth-child(even) {
            background-color: rgba(6, 214, 160, 0.1); /* Light Green Tint */
        }

        /* Hover Effect on Rows */
        tr:hover {
            background-color: rgba(6, 214, 160, 0.3); /* Subtle Green Glow */
        }

        /* Button Styling */
        .btn {
            padding: 8px 12px;
            text-decoration: none;
            color: white;
            font-size: 14px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-block;
        }

        /* Button Colors */
        .update { background-color: #06d6a0; } /* Medical Green */
        .update:hover { background-color: #05c08c; }

        .delete { background-color: #f44336; } /* Danger Red */
        .delete:hover { background-color: #d32f2f; }

        .enable { background-color: #007bff; } /* Bright Blue */
        .enable:hover { background-color: #0056b3; }

        .disable { background-color: #888; } /* Greyed Out */
        .disable:hover { background-color: #666; }

        /* Responsive Design */
        @media (max-width: 768px) {
            th, td {
                padding: 10px;
                font-size: 14px;
            }

            .btn {
                padding: 6px 10px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <img src="images/LOGO.png" alt="AmritaVaidya Logo">
        <div class="menu">
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
    <div class="main-content">
        <h2>List of Doctors</h2>
        <table>
            <tr>
                <th>Username</th>
                <th>Name</th>
                <th>Gender</th>
                <th>Qualification</th>
                <th>DOB</th>
                <th>Specialty</th>
                <th>Blood Group</th>
                <th>Contact</th>
                <th>Actions</th>
            </tr>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");
                   
                    // ✅ Added STATUS column to the query
                    String sql = "SELECT USERNAME, NAME, GENDER, QUALIFICATION, DOB, SPECIALTY, BLOODGROUP, CONTACT, STATUS FROM DOCTOR";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();
                   
                    while (rs.next()) {
                        String doctorStatus = rs.getString("STATUS");

                        if (doctorStatus == null) {
                            doctorStatus = "ACTIVE"; // Default to ACTIVE if null
                        }
            %>
            <tr>
                <td><%= rs.getString("USERNAME") %></td>
                <td><%= rs.getString("NAME") %></td>
                <td><%= rs.getString("GENDER") %></td>
                <td><%= rs.getString("QUALIFICATION") %></td>
                <td><%= rs.getString("DOB") %></td>
                <td><%= rs.getString("SPECIALTY") %></td>
                <td><%= rs.getString("BLOODGROUP") %></td>
                <td><%= rs.getString("CONTACT") %></td>
                <td>
                    <!-- Update Button -->
                    <a href="updatedr.jsp?username=<%= rs.getString("USERNAME") %>" class="btn update">Update</a>

                    <!-- Delete Button -->
                    <a href="deletedr.jsp?username=<%= rs.getString("USERNAME") %>" class="btn delete" onclick="return confirm('Are you sure you want to delete this doctor?');">Delete</a>

                    <!-- Disable/Enable Button -->
                    <form action="toggleDoctorStatus.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="username" value="<%= rs.getString("USERNAME") %>">
                        <input type="hidden" name="currentStatus" value="<%= doctorStatus %>">
                        <% if ("DISABLED".equalsIgnoreCase(doctorStatus)) { %>
                            <input type="submit" value="Enable" class="btn enable">
                        <% } else { %>
                            <input type="submit" value="Disable" class="btn disable">
                        <% } %>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
    </div>
    <footer class="footer">
        <p>© 2025 Amritavaidya. All Rights Reserved.</p>
    </footer>
</body>
</html>