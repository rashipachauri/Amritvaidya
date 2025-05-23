<%--
    Document   : resetPassword
    Created on : Mar 25, 2025, 4:10:55 PM
    Author     : HP
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f9;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}
.header {
    background: linear-gradient(45deg, #b2dfdb, #e1f5fe, #dcedc1);
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 98%;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1000;
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
            text-decoration:none;
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
       
      .form-container h2 {
  color: #26547c;
  margin-bottom: 20px;
  font-size: 34px;
  letter-spacing: 1px;
  position: relative;
}

.form-container h2::after {
  content: '';
  display: block;
  width: 60px;
  height: 3px;
  background-color: #06d6a0;
  margin: 8px auto 0;
  border-radius: 2px;
}


form {
    background: #ffffff;
    padding: 30px 25px;
    border-radius: 12px;
    box-shadow: 0 8px 16px rgba(38, 84, 124, 0.15);
    width: 320px;
    display: flex;
    flex-direction: column;
}



label {
    color: #26547c;
    margin-top: 15px;
    margin-bottom: 5px;
    font-weight: 600;
    text-align: left;
}

input[type="text"],
input[type="password"] {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 8px;
    outline: none;
    font-size: 16px;
    transition: border-color 0.3s ease;
}

input[type="text"]:focus,
input[type="password"]:focus {
    border-color: #06d6a0;
}

input[type="submit"] {
    margin-top: 20px;
    background-color: #06d6a0;
    color: #ffffff;
    padding: 12px;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

input[type="submit"]:hover {
    background-color: #04b68a;
    transform: translateY(-2px);
}
.footer {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(to right, #b2fefa, #0ed2f7);
    padding: 20px;
    text-align: center;
    color: white;
    font-size: 15px;
    font-weight: bold;
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
            <h2>Reset Password</h2>
            <form method="post" action="updatePassword.jsp">
                <label for="otp">Enter OTP:</label>
                <input type="text" name="otp" required>
               
                <label for="password">New Password:</label>
                <input type="password" name="password" required>

                <input type="submit" value="Reset Password">
            </form>
        </div>
    </div>
    <footer class="footer">
   
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>
</body>
</html>
