<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

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
        }

        /* Login Overlay */
        .login-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('images/website.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        /* Login Container */
        .login-container {
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

        .login-container h1 {
            color: white
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            text-shadow: 1px 2px 4px rgba(0, 0, 0, 0.2);
        }

       
        .login-container input[type="submit"] {
            width: 50%;
            padding: 12px;
            margin-top: 15px;
            border-radius: 30px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            background: linear-gradient(45deg, #4CAF50, #008CBA); /* Gradient green */
            color: white;
            transition: all 0.3s ease-in-out;
        }

        .login-container input[type="submit"]:hover {
            background: linear-gradient(45deg, #8eebec); /* Reverse gradient on hover */
            transform: scale(1.1);
            opacity: 0.9;
        }

       
        @media (max-width: 768px) {
            .login-container {
                width: 90%;
                padding: 20px;
            }
            .login-container h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-overlay">
        <div class="login-container">
            <h1 style="opacity: 0.9;">AMRITAVAIDYA</h1> <!-- Added transparency -->
            <form name='f1'>
                <input type="submit" value="Login" name="btnLogin" class="login-btn" />
            </form>
            <%
                if (request.getParameter("btnLogin") != null) {
                    try {
                        response.sendRedirect("login1.jsp");
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }
            %>
        </div>
    </div>
</body>
</html>


    <script>
     
        let slideIndex = 0;
        const slides = document.getElementsByClassName("slides");
        const dots = document.getElementsByClassName("dot");

        function showSlides() {
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slideIndex++;
            if (slideIndex > slides.length) { slideIndex = 1; }
            for (let i = 0; i < dots.length; i++) {
                dots[i].classList.remove("active");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].classList.add("active");
            setTimeout(showSlides, 3000);
        }

        function currentSlide(index) {
            slideIndex = index - 1;
            showSlides();
        }

        showSlides();
    </script>
</body>
</html>