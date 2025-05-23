<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Entry Page</title>
</head>
<body>
    <form name="f2" method="POST">
        <table>
            <tr>
                <td colspan="2" align="center">DOCTOR ENTRY FORM PAGE</td>
            </tr>
            <tr>
                <td>ENTER THE NAME OF DOCTOR:</td>
                <td><input type="text" name="txtname"  /></td>
            </tr>
            <tr>
                <td>ENTER THE USERNAME:</td>
                <td><input type="text" name="txtuid"  /></td>
            </tr>
            <tr>
                <td>ENTER THE PASSWORD:</td>
                <td><input type="password" name="txtpwd"  /></td>
            </tr>
            <tr>
                <td>GENDER:</td>
                <td>
                    <input type="radio" name="rdogroup" value="MALE" checked="checked" />MALE
                    <input type="radio" name="rdogroup" value="FEMALE" />FEMALE
                    <input type="radio" name="rdogroup" value="OTHERS" />OTHERS
                </td>
            </tr>
            <tr>
                <td>EMAIL:</td>
                <td><input type="email" name="txtemail"/></td>
            </tr>
            <tr>
                <td>QUALIFICATION:</td>
                <td>
                    <select name="qualification">
                        <option>MBBS(Bachelor Of Medicine,Bachelor Of Surgery)</option>
                        <!-- Add other options -->
                    </select>
                </td>
            </tr>
            <tr>
                <td>BLOOD GROUP:</td>
                <td>
                    <select name="bloodgrp">
                        <option>A+</option>
                        <!-- Add other options -->
                    </select>
                </td>
            </tr>
            <tr>
                <td>SPECIALTY:</td>
                <td>
                    <select name="specialty">
                        <option>MD(General Medicine)</option>
                        <!-- Add other options -->
                    </select>
                </td>
            </tr>
            <tr>
                <td>DATE OF BIRTH:</td>
                <td><input type="date" name="dob" /></td>
            </tr>
            <tr>
                <td>CONTACT NUMBER:</td>
                <td><input type="text" name="txtnumber" pattern="\d{10}"/></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="LOGIN" name="btnin" />
                    <input type="reset" value="RESET" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

<%  if (request.getParameter("btnin")!=null) {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");
            String query = "INSERT INTO AV.DOCTOR(NAME, GENDER, EMAIL, QUALIFICATION, DOB, SPECIALTY, USERNAME, PASSWORD, BLOODGROUP, CONTACT) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, request.getParameter("txtname"));
                pstmt.setString(2, request.getParameter("rdogroup"));
                pstmt.setString(3, request.getParameter("txtemail"));
                pstmt.setString(4, request.getParameter("qualification"));
                pstmt.setString(5, request.getParameter("dob"));
                pstmt.setString(6, request.getParameter("specialty"));
                pstmt.setString(7, request.getParameter("txtuid"));
                pstmt.setString(8, request.getParameter("txtpwd"));
                pstmt.setString(9, request.getParameter("bloodgrp"));
                pstmt.setString(10, request.getParameter("txtnumber"));

                int x = pstmt.executeUpdate();
               
                if (x>0) {
                    response.sendRedirect("website.jsp");
                } else {
                    response.sendRedirect("error.jsp");
                }
        } catch (Exception ex) {
            ex.printStackTrace();
           }
    }
%>