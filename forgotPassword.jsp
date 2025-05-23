<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <style>
        html, body {
            height: 100%; /* Ensure full height */
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        .container {
            flex: 1; /* Allow the container to grow and fill available space */
            display: flex;
            justify-content: center; /* Center the container vertically */
            align-items: center; /* Center the container horizontally */
            padding: 20px; /* Add some padding */
        }

        .footer {
            background: linear-gradient(to right, #b2fefa, #0ed2f7);
            padding: 20px;
            text-align: center;
            color: white;
            font-size: 15px;
            font-weight: bold;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9; /* Light green background */
            text-align: center;
            display: flex;
            flex-direction: column;
        }

        .header {
            background: linear-gradient(45deg, #b2dfdb, #e1f5fe, #dcedc1);
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 15px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .header img {
            height: 100px;
            width: 100px;
        }

        .menu {
            display: flex;
            gap: 35px;
            position: relative;
            background-color: white;
            padding: 20px 30px;
            border-radius: 20px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            font-weight: bold;
        }

        .menu a {
            text-decoration: none;
            color: black;
            font-weight: bold;
            position: relative;
            font-size: 20px;
        }

        .menu-item {
            position: relative;
            font-size: 20px;
        }

        .dropdown {
            position: absolute;
            top: 100%;
            left: 0;
            display: none;
            background: #4db6ac;
            border: 1px solid #ddd;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
            z-index: 1000;
            min-width: 250px;
            overflow: hidden;
            transform: translateY(10px);
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .dropdown a {
            display: block;
            padding: 12px 20px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
            background: white;
            border-radius: 8px;
            margin: 5px 10px;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .dropdown a:hover {
            background-color: #b2dfdb;
            transform: scale(1.05);
        }

        .dropdown.show {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }

        .menu-item:hover .dropdown {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }

        .menu-item:last-child .dropdown {
            left: auto;
            right: 0;
        }

        .form-container {
            width: 100%;
            max-width: 400px;
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 128, 0, 0.2);
        }

        h2 {
            color: #26547c; /* Dark green */
        }

        label {
            display: block;
            font-weight: bold;
            margin-top: 10px;
            color: #388e3c; /* Medium green */
        }

        input[type="email"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #66bb6a;
            border-radius: 5px;
            outline: none;
        }

        input[type="email"]:focus {
            border-color: #2e7d32;
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #06d6a0, #26547c);
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            margin-top: 15px;
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #06d6a0, #26547c);
        }

        a {
            text-decoration: none;
            color: #1b5e20;
            font-weight: bold;
        }

        a:hover {
            color: #0d470f;
        }
    </style>
</head>
<body>
    <div class="header">
        <img src="images/LOGO.png" alt="AmritaVaidya Logo">
        <div class="menu">
            <div class="menu-item">
                <a href="#">Login</a>
                <div class="dropdown">
                    <a href="login1.jsp">Are you a Patient?</a>
                    <a href="login1.jsp">Are you a Doctor?</a>
                </div>
            </div>
            <a href="started.jsp">Home</a>
            <a href="#about">About Us</a>
            <a href="faq.jsp">FAQs</a>
            <a href="contact.html">Contact Us</a>
            <div class="menu-item">
                <a href="#">Profile</a>
                <div class="dropdown">
                    <a href="profile.jsp">My Profile</a>
                    <a href="logout.jsp">Sign Out</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="form-container">
            <h2>Forgot Password</h2>
            <form method="post" action="generateOTP.jsp">
                <label for="email">Enter your registered email:</label>
                <input type="email" name="email" required>
                <input type="submit" value="Submit">
            </form>
            <p><a href="login1.jsp">Back to Login</a></p>
        </div>
    </div>
   
    <footer class="footer">
        <p>© 2025 Amritavaidya. All Rights Reserved.</p>
    </footer>
</body>
</html>