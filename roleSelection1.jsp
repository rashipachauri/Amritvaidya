<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Role-Selection Page</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            height: 100vh;
            background: url('images/website.jpg');
            background-size: cover;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
        }

        .form-container {
            position: relative;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            width: 400px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            z-index: 1;
            color: white;
            text-align: center;
        }

        .form-container h2 {
            margin-bottom: 20px;
            font-size: 24px;
        }

        .form-container table {
            width: 100%;
        }

        .form-container td {
            padding: 10px 0;
            font-size: 18px;
        }

        .form-container input[type="submit"] {
            width: 100%;
            padding: 15px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            background: linear-gradient(90deg, #4CAF50, #008CBA);
            transition: all 0.3s ease-in-out;
        }

        .form-container input[type="submit"]:hover {
            background: linear-gradient(90deg, #008CBA, #4CAF50);
            transform: scale(1.05);
        }

        /* Optional: Center the form properly */
        .wrapper {
            position: relative;
            z-index: 2;
        }
    </style>
</head>
<body>
    <!-- Background Overlay -->
    <div class="overlay"></div>

    <!-- Form Container -->
    <div class="wrapper">
        <div class="form-container">
            <h2>ROLE-SELECTION PAGE</h2>
            <form name='f1'>
                <table>
                    <tr>
                        <td>For Patient</td>
                        <td><input type="submit" value="Sign-Up" name="btnLogin1" class="patient-btn" /></td>
                    </tr>
                    <tr>
                        <td>For Doctor</td>
                        <td><input type="submit" value="Sign-Up" name="btnLogin2" class="doctor-btn" /></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <%
        if (request.getParameter("btnLogin1") != null) {
            try {
                response.sendRedirect("patient.jsp");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        if (request.getParameter("btnLogin2") != null) {
            try {
                response.sendRedirect("doctor.jsp");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    %>
</body>
</html>