<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doctor Entry Page</title>
    </head>
    <body>
        <form name="f2" method="post" action="">
            <table>
                <tr>
                    <td colspan="2" align="center">DOCTOR ENTRY FORM PAGE</td>
                </tr>
                <tr>
                    <td>ENTER THE NAME OF DOCTOR:</td>
                    <td><input type="text" name="txtname" required /></td>
                </tr>
                <tr>
                    <td>ENTER THE USERNAME:</td>
                    <td><input type="text" name="txtuid" required /></td>
                </tr>
                <tr>
                    <td>ENTER THE PASSWORD:</td>
                    <td><input type="password" name="txtpwd" required /></td>
                </tr>
                <tr>
                    <td>GENDER:</td>
                    <td>
                        <input type="radio" name="rdogroup" value="MALE" checked /> MALE
                        <input type="radio" name="rdogroup" value="FEMALE" /> FEMALE
                        <input type="radio" name="rdogroup" value="OTHERS" /> OTHERS
                    </td>
                </tr>
                <tr>
                    <td>EMAIL:</td>
                    <td><input type="email" name="txtemail" required /></td>
                </tr>
                <tr>
                    <td>QUALIFICATION:</td>
                    <td>
                        <select name="qualification" required>
                            <option>MBBS</option>
                            <option>BAMS</option>
                            <option>BHMS</option>
                            <option>BUMS</option>
                            <option>BNYS</option>
                            <option>MD</option>
                            <option>MS</option>
                            <option>DNB</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>BLOOD GROUP:</td>
                    <td>
                        <select name="bloodgrp" required>
                            <option>A+</option>
                            <option>A-</option>
                            <option>B+</option>
                            <option>B-</option>
                            <option>AB+</option>
                            <option>AB-</option>
                            <option>O+</option>
                            <option>O-</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>SPECIALTY:</td>
                    <td>
                        <select name="specialty" required>
                            <option>MD(General Medicine)</option>
                            <option>MS(General Surgery)</option>
                            <option>MD(Pediatrics)</option>
                            <option>MD(Gynecology)</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>DATE OF BIRTH:</td>
                    <td><input type="date" name="dob" required /></td>
                </tr>
                <tr>
                    <td>CONTACT NUMBER:</td>
                    <td><input type="tel" name="txtnumber" pattern="[0-9]{10}" required /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="SUBMIT" name="btnin" />
                        <input type="reset" value="RESET" />
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>

<%
    if (request.getParameter("btnin") != null) {
        try {
            String name = request.getParameter("txtname");
            String gender = request.getParameter("rdogroup");
            String email = request.getParameter("txtemail");
            String qualification = request.getParameter("qualification");
            String dob = request.getParameter("dob");
            String specialty = request.getParameter("specialty");
            String bloodgroup = request.getParameter("bloodgrp");
            String username = request.getParameter("txtuid");
            String password = request.getParameter("txtpwd");
            String contact = request.getParameter("txtnumber");

            // Database connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av")) {
                String query = "INSERT INTO AV.DOCTOR (NAME, GENDER, EMAIL, QUALIFICATION, DOB, SPECIALTY, USERNAME, PASSWORD, BLOODGROUP, CONTACT) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                    pstmt.setString(1, name);
                    pstmt.setString(2, gender);
                    pstmt.setString(3, email);
                    pstmt.setString(4, qualification);
                    pstmt.setDate(5, java.sql.Date.valueOf(dob));
                    pstmt.setString(6, specialty);
                    pstmt.setString(7, username);
                    pstmt.setString(8, password);
                    pstmt.setString(9, bloodgroup);
                    pstmt.setString(10, contact);

                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect("login.jsp");
                    } else {
                        response.sendRedirect("error.jsp");
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
%>
