<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login1.jsp"); // Redirect if not logged in
        return;
    }

    // Get form values
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmNewPassword = request.getParameter("confirmNewPassword");

    if (currentPassword == null || newPassword == null || confirmNewPassword == null) {
        response.sendRedirect("profile.jsp?error=emptyFields");
        return;
    }

    // Check if new passwords match
    if (!newPassword.equals(confirmNewPassword)) {
        response.sendRedirect("profile.jsp?error=passwordMismatch");
        return;
    }

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        // Load Derby JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

        // Step 1: Get user's role
        String userRole = "";
        String sql = "SELECT role FROM LOGIN_DETAILS WHERE username = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        resultSet = statement.executeQuery();

        if (resultSet.next()) {
            userRole = resultSet.getString("role");
        }

        resultSet.close();
        statement.close();

        // Step 2: Check current password in LOGIN_DETAILS
        sql = "SELECT * FROM LOGIN_DETAILS WHERE username = ? AND password = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, currentPassword);
        resultSet = statement.executeQuery();

        if (!resultSet.next()) {
            response.sendRedirect("profile.jsp?error=incorrectPassword");
            return;
        }

        resultSet.close();
        statement.close();

        // Step 3: Update password in LOGIN_DETAILS
        sql = "UPDATE LOGIN_DETAILS SET password = ? WHERE username = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, newPassword);
        statement.setString(2, username);
        statement.executeUpdate();
        statement.close();

        // Step 4: Update password in Doctor/Patient table
        if ("doctor".equalsIgnoreCase(userRole)) {
            sql = "UPDATE DOCTOR SET password = ? WHERE username = ?";
        } else if ("patient".equalsIgnoreCase(userRole)) {
            sql = "UPDATE PATIENT SET password = ? WHERE username = ?";
        }

        statement = connection.prepareStatement(sql);
        statement.setString(1, newPassword);
        statement.setString(2, username);
        statement.executeUpdate();
        statement.close();

        // Redirect with success message
        response.sendRedirect("profile.jsp?success=passwordChanged");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("profile.jsp?error=serverError");
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
