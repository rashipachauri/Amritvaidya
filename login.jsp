<%-- 
    Document   : login
    Created on : 21 Jan, 2025, 3:09:19 PM
    Author     : Pradeepti Gaur
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
</head>
<body>
    <h1>Login</h1>
    <form method="post" action="login.jsp">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" required><br><br>
        
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required><br><br>
        
        <input type="submit" value="Login">
    </form>

    <%
        // Get parameters from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            // JDBC connection variables
           
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                // Load the Derby driver
                Class.forName("org.apache.derby.jdbc.ClientDriver");

                // Connect to the database
                connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya","av","av");

                // Prepare the SQL query
                String sql = "SELECT * FROM LOGIN_DETAILS WHERE USERNAME = ? AND PASSWORD = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, username);
                statement.setString(2, password);

                // Execute the query
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    // Successful login
                    response.sendRedirect("website.jsp");
                    out.println("<p>Login successful! Welcome, " + username + ".</p>");
                } else {
                    // Login failed
                    out.println("<p>Invalid username or password. Please try again.</p>");
                }
            } catch (Exception e){
                response.sendRedirect("error.jsp");
                // Display an error message if any exception occurs
                out.println("<p>Error connecting to the database: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
