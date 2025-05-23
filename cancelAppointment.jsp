<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String appointmentId = request.getParameter("appointmentId");
    if (appointmentId != null) {
        try {
            // Database connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");

            // Delete the appointment from the database
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM AV.APPOINTMENT WHERE ID = ?");
            pstmt.setInt(1, Integer.parseInt(appointmentId));
            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>