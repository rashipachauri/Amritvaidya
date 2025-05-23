<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String doctorUsername = request.getParameter("doctor_username");
    String appointmentDate = request.getParameter("date");

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

        // Fetch already booked time slots for the given doctor and date
        String sql = "SELECT timeslot FROM AV.appointment WHERE doctor_username = ? AND appointment_date = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, doctorUsername);
        preparedStatement.setString(2, appointmentDate);
        resultSet = preparedStatement.executeQuery();

        StringBuilder bookedSlots = new StringBuilder();
        while (resultSet.next()) {
            if (bookedSlots.length() > 0) {
                bookedSlots.append(",");
            }
            bookedSlots.append(resultSet.getString("timeslot"));
        }

        out.print(bookedSlots.toString()); // Return booked slots as CSV
    } catch (Exception e) {
        out.print("error");
    } finally {
        if (resultSet != null) resultSet.close();
        if (preparedStatement != null) preparedStatement.close();
        if (connection != null) connection.close();
    }
%>
