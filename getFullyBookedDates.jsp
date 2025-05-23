<%--
    Document   : getFullyBookedDates
    Created on : Feb 23, 2025, 11:14:38 PM
    Author     : HP
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String doctorUsername = request.getParameter("doctor_username");

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

        // Count appointments per date for the selected doctor
        String sql = "SELECT appointment_date FROM AV.appointment WHERE doctor_username = ? GROUP BY appointment_date HAVING COUNT(timeslot) >= 5";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, doctorUsername);
        resultSet = preparedStatement.executeQuery();

        StringBuilder fullyBookedDates = new StringBuilder();
        while (resultSet.next()) {
            if (fullyBookedDates.length() > 0) {
                fullyBookedDates.append(",");
            }
            fullyBookedDates.append(resultSet.getString("appointment_date"));
        }

        out.print(fullyBookedDates.toString()); // Output booked dates as CSV
    } catch (Exception e) {
        out.print("error");
    } finally {
        if (resultSet != null) resultSet.close();
        if (preparedStatement != null) resultSet.close();
        if (connection != null) connection.close();
    }
%>