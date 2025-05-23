<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AmritaVaidya - Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('images/bg3.jpg');
            display: flex;
            height: 100vh;
            justify-content: center;
            align-items: center;
        }
        .container {
            display: flex;
            width: 90%;
            height: 85%;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .left-section {
            width: 50%;
            height: 100%;
            background: linear-gradient(135deg, #4CAF50, #008CBA);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
            color: white;
        }
        .modal {
            background: linear-gradient(90deg, #008CBA, #4CAF50);
            padding: 45px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 90%;
            max-width: 400px;
        }
        .modal h1 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: white;
        }
        .modal label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            font-size: 1rem;
            text-transform: capitalize;
        }
        .modal input[type="text"],
        .modal input[type="password"] {
            width: calc(100% - 20px);
            padding: 12px;
            margin-bottom: 15px;
            border: none;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.8);
            font-size: 16px;
        }
        .modal input[type="submit"] {
            width: calc(100% - 20px);
            padding: 12px;
            background: #6fd6ff;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            transition: background 0.3s ease;
        }
        .modal input[type="submit"]:hover {
            background: linear-gradient(90deg, #38adae, #cd295a);
        }
        .footer-text a {
            color: #ffcc80;
            text-decoration: none;
        }
        .footer-text a:hover {
            text-decoration: underline;
        }
        .right-section {
            width: 50%;
            background: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }
        .slideshow {
            position: relative;
            width: 90%;
            height: 90%;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .slideshow img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }
        .slideshow img.active {
            opacity: 1;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="left-section">
            <div class="modal">
                <h1>Login</h1>
                <form method="post" action="login1.jsp">
                    <label for="username">Username:</label>
                    <input type="text" name="username" id="username" required>
                    <label for="password">Password:</label>
                    <input type="password" name="password" id="password" required>
                    <input type="submit" value="Login">
                </form>
                <div class="footer-text">
                    Don't have an account? <a href="roleSelection1.jsp?defaultRole=Patient">Sign Up</a>
                </div>
            </div>
        </div>
        <div class="right-section">
            <div class="slideshow">
                <img src="images/p2.jpg" alt="Healthcare Service" class="active">
                <img src="images/p3.jpg" alt="Doctor Consultation">
                <img src="images/p4.jpg" alt="Medical Record">
                <img src="images/p6.jpg" alt="Chat With Us">
            </div>
        </div>
    </div>
    <script>
        let slides = document.querySelectorAll(".slideshow img");
        let currentIndex = 0;
        function showNextSlide() {
            slides[currentIndex].classList.remove("active");
            currentIndex = (currentIndex + 1) % slides.length;
            slides[currentIndex].classList.add("active");
        }
        setInterval(showNextSlide, 3000);
    </script>


    <%
       
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
           
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
               
                Class.forName("org.apache.derby.jdbc.ClientDriver");

               
                connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

               
                String sql = "SELECT * FROM LOGIN_DETAILS WHERE USERNAME = ? AND PASSWORD = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, username);
                statement.setString(2, password);

               
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                   
                    session.setAttribute("username", username); // Store username in session
                    response.sendRedirect("website.jsp");
                } else {
                   
                    response.sendRedirect("login1.jsp?message=Invalid username or password.");
                }
            } catch (Exception e) {
                response.sendRedirect("error.jsp");
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    %>
</body>
</html>