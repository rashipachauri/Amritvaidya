<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String currentStatus = request.getParameter("currentStatus");
    
    String newStatus = currentStatus.equals("DISABLED") ? "ACTIVE" : "DISABLED";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

        String updateQuery = "UPDATE DOCTOR SET STATUS = ? WHERE USERNAME = ?";
        pstmt = conn.prepareStatement(updateQuery);
        pstmt.setString(1, newStatus);
        pstmt.setString(2, username);
        pstmt.executeUpdate();

        response.sendRedirect("drlist.jsp"); // Redirect back to the doctor list
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
