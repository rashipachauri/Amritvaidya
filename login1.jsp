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
        background: radial-gradient(circle, #a8e6cf, #dcedc1, #ffffff, #add8e6);

        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        display: flex;
        height: 100vh;
        justify-content: center;
        align-items: center;
    }
   

   
    .container {
    display: flex;
    width: 80%;
    height: 500px;
    margin: auto;
    border-radius: 15px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}
    .left-section {
    flex: 1;
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 70px;
    color: white;
    text-align: center;
    background: url('images/p2.jpg');
    background-size: cover;
    background-position: center;
}

.left-section::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 255, 0.5); /* Blue overlay */
    z-index: 1;
}

.left-section * {
    position: relative;
    z-index: 2;
}
.left-section h1 {
    font-size: 46px;
    font-weight: bold;
    color: #ffffff;
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
    margin-bottom: 10px;
}

.left-section p {
    font-size: 28px;
    color:#ffffff;
    opacity: 0.9;
    letter-spacing: 1px;
}


    .right-section {
        flex: 1;
        background: #f5f5f5;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 70px;
    }
    .login-container {
        width: 100%;
        text-align: left;
    }
    .login-container h2 {
    font-size: 50px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
    color: #26547c; /* Deep blue shade */
    text-transform: uppercase;
    letter-spacing: 2px;
    position: relative;
    padding-bottom: 10px;
}

.login-container h2::after {
    content: "";
    width: 60px;
    height: 4px;
    background: linear-gradient(90deg, #06d6a0, #26547c);
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    border-radius: 2px;
}



    .input-group {
        margin-bottom: 15px;
    }
    .input-group label {
        font-size: 22px;
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }
    .input-group input {
        width: 100%;
        padding: 10px;
        font-size: 22px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .login-button {
    width: 100%;
    padding: 12px;
    background: linear-gradient(135deg, #26547c, #06d6a0);
    color: white;
    font-size: 18px;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    letter-spacing: 1px;
    text-transform: uppercase;
}

.login-button:hover {
    background: linear-gradient(135deg, #06d6a0, #26547c);
    transform: scale(1.05);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
}

.login-button:active {
    transform: scale(0.98);
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
}

.footer-text {
    text-align: center;
    margin-top: 20px;
}

.footer-text a {
    color: #26547c;
    text-decoration: none;
    font-weight: 600;
    font-size: 20px;
    position: relative;
    transition: color 0.3s ease;
}

.footer-text a::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -2px;
    width: 100%;
    height: 2px;
    background-color: #06d6a0;
    transform: scaleX(0);
    transform-origin: right;
    transition: transform 0.3s ease;
}



    .signup-text {
        text-align: center;
        margin-top: 10px;
        font-size: 24px;
    }
    .signup-text a {
        color: #03A9F4;
        font-weight: bold;
        text-decoration: none;
    }
    .error-message {
            color: red;
            font-size: 22px;
            text-align: center;
            margin-bottom: 10px;
        }
   
</style>
</head>
<body>
   

       
    <div class="container">
    <div class="left-section">
        <h1>Welcome To AmritaVaidya</h1>
        <p>Log in to stay connected with us</p>
    </div>
    <div class="right-section">
    <div class="login-container">
        <h2>Login</h2>
        <% if (request.getParameter("message") != null) { %>
                    <p class="error-message"><%= request.getParameter("message") %></p>
                <% } %>
        <form method="post" action="login1.jsp"> <!-- Action to your JSP page -->
            <div class="input-group">
                <label>Username:</label>
                <input type="text" name="username" placeholder="Enter Username" required> <!-- Added name attribute -->
            </div>
            <div class="input-group">
                <label>Password:</label>
                <input type="password" name="password" placeholder="Enter Password" required> <!-- Added name attribute -->
            </div>
            <button type="submit" class="login-button">Login</button> <!-- Correct button type -->
        </form>
         <div class="footer-text">
            <a href="forgotPassword.jsp">Forgot Password?</a>  <!-- Added Forgot Password Link -->
        </div>
        <p class="signup-text">Don't have an account? <a href="roleSelection.jsp">Sign Up</a></p>
    </div>
</div>
</div>

    <script>
       
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
                String sql = "SELECT ROLE FROM LOGIN_DETAILS WHERE USERNAME = ? AND PASSWORD = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, username);
                statement.setString(2, password);
                resultSet = statement.executeQuery();
               
                if (resultSet.next()) {
                    String role = resultSet.getString("ROLE");
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);
                    if ("admin".equalsIgnoreCase(role)) {
                        response.sendRedirect("webadmin.jsp");
                    } else {
                        response.sendRedirect("website.jsp");
                    }
                } else {
                    response.sendRedirect("login1.jsp?message=Invalid username or password.");
                }
            } catch (Exception e) {
                response.sendRedirect("error.jsp");
                e.printStackTrace();
            }
        }
    %>
</body>
</html>