<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Role Selection Page</title>
    <style>
        body {
            text-align: center;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(180deg, #002366 0%, #87CEEB 50%, #FAFAFA 100%);
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

           .profile-container {
            display: flex;
            align-items: center;
            margin-left: 10px;
            cursor: pointer;
            position: relative;
        }
        .profile-pic {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #0077b6;
        }
        .dropdown-profile-container {
            display: none;
            position: absolute;
            top: 110px;
            left: -100%;
            transform: translateX(-50%);
            background: white;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            padding: 10px;
            z-index: 1000;
            width: 280px;
            max-height: 300px;
            overflow-y: auto;
        }
        .dropdown-profile-container .images-grid {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            gap: 8px;
            padding: 5px;
        }
        .dropdown-profile-container img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .dropdown-profile-container img:hover {
            transform: scale(1.1);
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
       
       

        body {
            text-align: center;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #0073e6;
        }
       
        header {
            background-color: #333;
            color: white;
            padding: 20px;
            font-size: 28px;
            font-weight: bold;
        }
       
        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 60vh;
        }
       
        .popup {
            background: linear-gradient(135deg, #CFF5E7, #FFFFFF);

            padding: 35px;
            border-radius: 20px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.3);
            width: 400px;
            text-align: center;
            transition: transform 0.3s ease-in-out;
            color: black;
        }

        .popup:hover {
            transform: scale(1.1);
        }
       
        h2 {
            font-size: 36px;
            font-weight: bold;
        }
       
        table {
            width: 100%;
            margin-top: 20px;
        }
       
        td {
            padding: 15px;
            font-size: 20px;
            font-weight: 500;
        }
       
        .patient-btn, .doctor-btn {
            padding: 12px 20px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 18px;
            font-weight: bold;
            transition: background 0.3s ease-in-out, transform 0.2s;
            color: white;
        }
       
        .patient-btn {
            background: linear-gradient(135deg, #11998e, #38ef7d);
        }
       
        .doctor-btn {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
        }
       
        .patient-btn:hover {
            background: linear-gradient(135deg, #0c8467, #2ed573);
            transform: scale(1.1);
        }
       
        .doctor-btn:hover {
            background: linear-gradient(135deg, #162e50, #23408d);
            transform: scale(1.1);
        }

        .image-section {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
            padding: 20px;
        }
       
        .image-section img {
            border-radius: 50%;
            object-fit: cover;
        }

        .image-section img:nth-child(1),
        .image-section img:nth-child(5) {
            width: 280px;
            height: 280px;
        }

        .image-section img:nth-child(2),
        .image-section img:nth-child(4) {
            width: 260px;
            height: 260px;
        }

        .image-section img:nth-child(3) {
            width: 300px;
            height: 300px;
        }
        .footer {
        position: relative;
        background: linear-gradient(to right, #b2fefa, #0ed2f7);
        padding: 20px 15px;
        text-align: center;
        color: white;
        font-size: 15px;
        font-weight: bold;
        margin-top: 50px;
        overflow: hidden;
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
    <div class="form-container">
         <div class="popup">
            <h2>Role Selection Page</h2>
       
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
   
   
   
    <div class="image-section">
        <img src="images/D1.jpg" alt="Image 1">
        <img src="images/D2.jpg" alt="Image 2">
        <img src="images/D3.jpg" alt="Image 3">
        <img src="images/D4.jpg" alt="Image 4">
        <img src="images/D5.jpg" alt="Image 5">
    </div>
   <footer class="footer">
       
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>


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