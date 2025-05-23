<%@ page import="java.sql.*" %>
<%
    // Get parameters from the form
    String email = (String) session.getAttribute("email");
    String newPassword = request.getParameter("password");

    // Validate session email
    if (email == null) {
        out.println("<script>alert('Session expired! Please try again.'); window.location='forgotPassword.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String username = null;
    int rowsAffected = 0;

    try {
        // Database Connection
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");
        conn.setAutoCommit(false); // Disable autocommit for transaction handling

        // Check if email exists in DOCTOR table and retrieve USERNAME
        String queryDoctor = "SELECT USERNAME FROM AV.DOCTOR WHERE EMAIL = ?";
        pst = conn.prepareStatement(queryDoctor);
        pst.setString(1, email);
        rs = pst.executeQuery();

        if (rs.next()) {
            username = rs.getString("USERNAME");
            // Update password in DOCTOR table
            String updateDoctor = "UPDATE AV.DOCTOR SET PASSWORD = ? WHERE EMAIL = ?";
            pst = conn.prepareStatement(updateDoctor);
            pst.setString(1, newPassword);
            pst.setString(2, email);
            rowsAffected += pst.executeUpdate();
        }
        rs.close();
        pst.close();

        // Check if email exists in PATIENT table and retrieve USERNAME
        String queryPatient = "SELECT USERNAME FROM AV.PATIENT WHERE EMAIL = ?";
        pst = conn.prepareStatement(queryPatient);
        pst.setString(1, email);
        rs = pst.executeQuery();

        if (rs.next()) {
            username = rs.getString("USERNAME");
            // Update password in PATIENT table
            String updatePatient = "UPDATE AV.PATIENT SET PASSWORD = ? WHERE EMAIL = ?";
            pst = conn.prepareStatement(updatePatient);
            pst.setString(1, newPassword);
            pst.setString(2, email);
            rowsAffected += pst.executeUpdate();
        }
        rs.close();
        pst.close();

        // If username was found in DOCTOR or PATIENT, update password in LOGIN_DETAILS
        if (username != null) {
            String updateLogin = "UPDATE AV.LOGIN_DETAILS SET PASSWORD = ? WHERE USERNAME = ?";
            pst = conn.prepareStatement(updateLogin);
            pst.setString(1, newPassword);
            pst.setString(2, username);
            rowsAffected += pst.executeUpdate();
        }

        if (rowsAffected > 0) {
            conn.commit(); // Commit transaction if updates were successful
            out.println("<script>alert('Password updated successfully!'); window.location='login1.jsp';</script>");
        } else {
            conn.rollback(); // Rollback in case of failure
            out.println("<script>alert('Error: Email not found or password not updated!'); window.location='forgotPassword.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        if (conn != null) conn.rollback();
        out.println("<script>alert('Error occurred! Try again later.'); window.location='forgotPassword.jsp';</script>");
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
%>