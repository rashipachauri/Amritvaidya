<%@ page import="java.sql.*" %>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login1.jsp"); // Redirect to login page if not logged in
        return;
    }

    // Get form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String bloodGroup = request.getParameter("bloodGroup");
    String gender = request.getParameter("gender");
    String dob = request.getParameter("dob");
    String contact = request.getParameter("contact");
    String qualification = request.getParameter("qualification");
    String specialty = request.getParameter("specialty");

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    String userRole = "";

    try {
        // Load Derby JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

        // Fetch the user role
        String sql = "SELECT role FROM LOGIN_DETAILS WHERE username = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        resultSet = statement.executeQuery();

        if (resultSet.next()) {
            userRole = resultSet.getString("role");
        }

        resultSet.close();
        statement.close();

        // Update patient details
        if ("patient".equalsIgnoreCase(userRole)) {
            sql = "UPDATE PATIENT SET name = ?, email = ?, bloodgroup = ?, gender = ?, dob = ?, contactnum = ? WHERE username = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, bloodGroup);
            statement.setString(4, gender);
            statement.setString(5, dob);
            statement.setString(6, contact);
            statement.setString(7, username);
        } 
        // Update doctor details
        else if ("doctor".equalsIgnoreCase(userRole)) {
            sql = "UPDATE DOCTOR SET name = ?, email = ?, bloodgroup = ?, gender = ?, dob = ?, qualification = ?, specialty = ?, contact = ? WHERE username = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, bloodGroup);
            statement.setString(4, gender);
            statement.setString(5, dob);
            statement.setString(6, qualification);
            statement.setString(7, specialty);
            statement.setString(8, contact);
            statement.setString(9, username);
        }

        // Execute update
        int rowsUpdated = statement.executeUpdate();

        if (rowsUpdated > 0) {
            response.sendRedirect("profile.jsp?success=true"); // Redirect back with success message
        } else {
            response.sendRedirect("profile.jsp?error=true"); // Redirect back with error message
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("profile.jsp?error=true"); // Redirect back in case of an error
    } finally {
        try {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
