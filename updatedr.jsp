<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String doctorUsername = request.getParameter("username");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String message = "";
   
    String name = "", gender = "", qualification = "", dob = "", specialty = "", bloodGroup = "", contact = "";
   
    if (doctorUsername != null) {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");
           
            String sql = "SELECT * FROM DOCTOR WHERE USERNAME = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, doctorUsername);
            rs = pstmt.executeQuery();
           
            if (rs.next()) {
                name = rs.getString("NAME");
                gender = rs.getString("GENDER");
                qualification = rs.getString("QUALIFICATION");
                dob = rs.getString("DOB");
                specialty = rs.getString("SPECIALTY");
                bloodGroup = rs.getString("BLOODGROUP");
                contact = rs.getString("CONTACT");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
   
    if (request.getMethod().equalsIgnoreCase("POST")) {
        qualification = request.getParameter("qualification");
        specialty = request.getParameter("specialty");
        bloodGroup = request.getParameter("bloodGroup");
        contact = request.getParameter("contact");
       
        try {
            String updateSql = "UPDATE DOCTOR SET QUALIFICATION=?, SPECIALTY=?, BLOODGROUP=?, CONTACT=? WHERE USERNAME=?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setString(1, qualification);
            pstmt.setString(2, specialty);
            pstmt.setString(3, bloodGroup);
            pstmt.setString(4, contact);
            pstmt.setString(5, doctorUsername);
           
            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                message = "Doctor details updated successfully.";
                response.sendRedirect("drlist.jsp");
            } else {
                message = "Update failed. Please try again.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Doctor</title>
    <style>
       body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f4f4;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
        }

        /* Header */
        .header {
           background: linear-gradient(45deg, #b2dfdb, #e1f5fe, #dcedc1);
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            height: 80px;
            z-index: 1000;
           
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Logo */
        .header img {
            height: 60px;
            width: 60px;
            margin-left: 20px;
        }

        /* Navigation Menu */
         .menu {
            display: flex;
            gap: 30px;
            position:center;
            background-color: white;
             padding: 15px 25px;
            border-radius: 20px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            margin-left: -50px;
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
            min-width: 200px;
            transform: translateY(10px);
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .dropdown a {
            display: block;
            padding: 12px;
            text-decoration: none;
            color: #333;
            background: white;
            border-radius: 5px;
            margin: 5px;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .dropdown a:hover {
            background-color: #b2dfdb;
            transform: scale(1.05);
        }

        .menu-item:hover .dropdown {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }

        /* Centered Container */
        .container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.2);
            width: 50%;
            max-width: 1000px;
            text-align: center;
            margin-top: 120px; /* Push container below fixed header */
            animation: fadeIn 0.8s ease-in-out;
        }

        /* Fade-in Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Form Title */
        h2 {
            font-size: 30px;
            color: #26547c;
            text-transform: uppercase;
            margin-bottom: 15px;
            position: relative;
            display: inline-block;
        }

        /* Underline Effect */
        h2::after {
            content: "";
            width: 50%;
            height: 4px;
            background: #06d6a0;
            position: absolute;
            bottom: -5px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        /* Label Styling */
        label {
            font-weight: bold;
            display: block;
            text-align: left;
            margin-top: 10px;
            color: #26547c;
        }

        /* Input Fields */
        input, select {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 2px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            transition: border 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        /* Input Focus Effect */
        input:focus, select:focus {
            border-color: #06d6a0;
            outline: none;
            box-shadow: 0 0 10px rgba(6, 214, 160, 0.3);
        }

        /* Submit Button */
        .btn {
            width: 100%;
            padding: 12px;
           background: #04b78b;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            text-transform: uppercase;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-top: 15px;
        }

        /* Button Hover Effect */
        .btn:hover {
            background: #04b78b;
            transform: scale(1.05);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                width: 80%;
                max-width: 400px;
                padding: 20px;
            }

            h2 {
                font-size: 22px;
            }

            input, select {
                font-size: 14px;
            }

            .btn {
                font-size: 16px;
            }

            .menu {
                gap: 15px;
                padding: 10px 15px;
            }

            .header img {
                height: 50px;
                width: 50px;
            }
        }
        .footer {
    position: relative;
    background: linear-gradient(to right, #b2fefa, #0ed2f7);
    padding: 20px 15px;
    text-align: center;
    color: white;
    font-size: 15px;
    font-weight: bold;
    margin-top: 50px;
    width: 100%;  /* Full width cover karega */
    left: 0;  /* Ensure left se start ho */
    right: 0; /* Ensure right tak jaye */
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
        <h2>Update Doctor Details</h2>
        <form method="post">
            <label>Name:</label>
            <input type="text" name="name" value="<%= name %>" disabled>
           
            <label>Gender:</label>
            <input type="text" name="gender" value="<%= gender %>" disabled>
           
            <label>Date of Birth:</label>
            <input type="date" name="dob" value="<%= dob %>" disabled />
           
            <label>Qualification:</label>
            <select name="qualification">
                <option value="">Select Qualification</option>
                <option value="MBBS" <%= qualification.equals("MBBS") ? "selected" : "" %>>MBBS</option>
                <option value="BAMS" <%= qualification.equals("BAMS") ? "selected" : "" %>>BAMS</option>
                <option value="BHMS" <%= qualification.equals("BHMS") ? "selected" : "" %>>BHMS</option>
                <option value="BUMS" <%= qualification.equals("BUMS") ? "selected" : "" %>>BUMS</option>
                <option value="BNYS" <%= qualification.equals("BNYS") ? "selected" : "" %>>BNYS</option>
                <option value="MD" <%= qualification.equals("MD") ? "selected" : "" %>>MD</option>
                <option value="MS" <%= qualification.equals("MS") ? "selected" : "" %>>MS</option>
                <option value="DNB" <%= qualification.equals("DNB") ? "selected" : "" %>>DNB</option>
            </select>
           
            <label>Specialty:</label>
            <select name="specialty">
                <option value="">Select Specialty</option>
                <option value="MD (General Medicine)" <%= specialty.equals("MD (General Medicine)") ? "selected" : "" %>>MD (General Medicine)</option>
                <option value="MS (General Surgery)" <%= specialty.equals("MS (General Surgery)") ? "selected" : "" %>>MS (General Surgery)</option>
                <option value="MD (Pediatrics)" <%= specialty.equals("MD (Pediatrics)") ? "selected" : "" %>>MD (Pediatrics)</option>
                <option value="MD (Gynecology)" <%= specialty.equals("MD (Gynecology)") ? "selected" : "" %>>MD (Gynecology)</option>
                <option value="MD (Dermatology)" <%= specialty.equals("MD (Dermatology)") ? "selected" : "" %>>MD (Dermatology)</option>
            </select>
           
            <label>Blood Group:</label>
            <select name="bloodGroup">
                <option value="">Select Blood Group</option>
                <option value="A+" <%= bloodGroup.equals("A+") ? "selected" : "" %>>A+</option>
                <option value="A-" <%= bloodGroup.equals("A-") ? "selected" : "" %>>A-</option>
                <option value="B+" <%= bloodGroup.equals("B+") ? "selected" : "" %>>B+</option>
                <option value="B-" <%= bloodGroup.equals("B-") ? "selected" : "" %>>B-</option>
                <option value="AB+" <%= bloodGroup.equals("AB+") ? "selected" : "" %>>AB+</option>
                <option value="AB-" <%= bloodGroup.equals("AB-") ? "selected" : "" %>>AB-</option>
                <option value="O+" <%= bloodGroup.equals("O+") ? "selected" : "" %>>O+</option>
                <option value="O-" <%= bloodGroup.equals("O-") ? "selected" : "" %>>O-</option>
            </select>
           
            <label>Contact:</label>
            <input type="text" name="contact" value="<%= contact %>">
           
            <input type="submit" value="Update" class="btn">
        </form>
        <p><%= message %></p>
        <a href="drlist.jsp">Back to Doctor List</a>
       
    </div>
        <footer class="footer">
       
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>

</body>
</html>