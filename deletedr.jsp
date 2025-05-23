<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");

    Connection conn = null;
    PreparedStatement pstmt1 = null;
    PreparedStatement pstmt2 = null;
    PreparedStatement pstmt3 = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

        // First, delete appointments associated with the doctor from AV.APPOINTMENT
        String deleteAppointmentsQuery = "DELETE FROM AV.APPOINTMENT WHERE DOCTOR_USERNAME=?";
        pstmt1 = conn.prepareStatement(deleteAppointmentsQuery);
        pstmt1.setString(1, username);
        pstmt1.executeUpdate();

        // Then, delete the login details from AV.LOGIN_DETAILS
        String deleteLoginQuery = "DELETE FROM AV.LOGIN_DETAILS WHERE USERNAME=?";
        pstmt2 = conn.prepareStatement(deleteLoginQuery);
        pstmt2.setString(1, username);
        pstmt2.executeUpdate();  

        // Finally, delete the doctor record from AV.DOCTOR
        String deleteDoctorQuery = "DELETE FROM AV.DOCTOR WHERE USERNAME=?";
        pstmt3 = conn.prepareStatement(deleteDoctorQuery);
        pstmt3.setString(1, username);
        int deleted = pstmt3.executeUpdate();

        if (deleted > 0) {
            response.sendRedirect("drlist.jsp"); // Redirect to the doctor list after deletion
        } else {
            out.println("<p>Failed to delete doctor record!</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt1 != null) pstmt1.close();
        if (pstmt2 != null) pstmt2.close();
        if (pstmt3 != null) pstmt3.close();
        if (conn != null) conn.close();
    }
%>
