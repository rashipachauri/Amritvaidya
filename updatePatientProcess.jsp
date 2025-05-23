<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String name = request.getParameter("name"); // Retrieved but not updated
    String bloodgroup = request.getParameter("bloodgroup");
    String gender = request.getParameter("gender"); // Retrieved but not updated
    String dob = request.getParameter("dob"); // Retrieved but not updated
    String email = request.getParameter("email");
    String contact = request.getParameter("contact");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

        String query = "UPDATE AV.PATIENT SET BLOODGROUP=?, EMAIL=?, CONTACTNUM=? WHERE USERNAME=?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, bloodgroup);
        pstmt.setString(2, email);
        pstmt.setString(3, contact);
        pstmt.setString(4, username);

        int updated = pstmt.executeUpdate();
        if (updated > 0) {
            response.sendRedirect("patientrec.jsp"); // Redirect to patient list
        } else {
            out.println("<p>Failed to update record!</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
