<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Random" %>

<%
    String email = request.getParameter("email");
    String dbURL = "jdbc:derby://localhost:1527/AmritaVaidya";
    String dbUser = "av";
    String dbPass = "av";

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

         // Check if email exists in both doctor and patient tables
        String query = "SELECT EMAIL FROM AV.DOCTOR WHERE EMAIL = ? UNION SELECT EMAIL FROM AV.PATIENT WHERE EMAIL = ?";
        pst = conn.prepareStatement(query);
        pst.setString(1, email);
        pst.setString(2, email);
        rs = pst.executeQuery();

        if (rs.next()) { // If email found
            // Generate 6-digit OTP
            int otp = new Random().nextInt(900000) + 100000;
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            // Debugging - Show OTP (Remove in production)
            out.println("<script>alert('Your OTP is: " + otp + " (for testing)'); window.location='resetPassword.jsp';</script>");
        } else {
            out.println("<script>alert('Email not found!'); window.location='forgotPassword.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error occurred!'); window.location='forgotPassword.jsp';</script>");
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
%>