<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");

    Connection conn = null;
    PreparedStatement pstmt1 = null;
    PreparedStatement pstmt2 = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");
       
        // First, delete the login details from AV.LOGIN_DETAILS
        String deleteLoginQuery = "DELETE FROM AV.LOGIN_DETAILS WHERE USERNAME=?";
        pstmt1 = conn.prepareStatement(deleteLoginQuery);
        pstmt1.setString(1, username);
        pstmt1.executeUpdate();  

        // Then, delete the patient record from AV.PATIENT
        String deletePatientQuery = "DELETE FROM AV.PATIENT WHERE USERNAME=?";
        pstmt2 = conn.prepareStatement(deletePatientQuery);
        pstmt2.setString(1, username);
        int deleted = pstmt2.executeUpdate();

        if (deleted > 0) {
            response.sendRedirect("patientrec.jsp"); // Redirect to the patient list after deletion
        } else {
            out.println("<p>Failed to delete patient record!</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt1 != null) pstmt1.close();
        if (pstmt2 != null) pstmt2.close();
        if (conn != null) conn.close();
    }
%>