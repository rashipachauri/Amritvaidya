<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login1.jsp?message=Please login to access this feature.");
        return;
    }

    String recordId = request.getParameter("recordId");
    String newDiagnosis = request.getParameter("diagnosis");
    String newTreatment = request.getParameter("treatment");

    if (recordId == null || newDiagnosis == null || newTreatment == null ||
        recordId.trim().isEmpty() || newDiagnosis.trim().isEmpty() || newTreatment.trim().isEmpty()) {
        response.sendRedirect("edit.jsp?recordId=" + recordId + "&message=Please fill all fields.");
        return;
    }

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");

        // Get timestamp
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTimestamp = sdf.format(new Date());

        // Insert new entry instead of replacing old one
        String insertQuery = "INSERT INTO AV.MEDICAL_HISTORY (RECORD_ID, DIAGNOSIS, TREATMENT, RECORD_DATE) VALUES (?, ?, ?, ?)";
        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
        insertStmt.setString(1, recordId);
        insertStmt.setString(2, newDiagnosis);
        insertStmt.setString(3, newTreatment);
        insertStmt.setString(4, currentTimestamp);

        int rowsInserted = insertStmt.executeUpdate();
        conn.close();

        if (rowsInserted > 0) {
            response.sendRedirect("medical_record.jsp?message=Record updated successfully.");
        } else {
            response.sendRedirect("edit.jsp?recordId=" + recordId + "&message=Failed to update record.");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("edit.jsp?recordId=" + recordId + "&message=An error occurred.");
    }
%>
