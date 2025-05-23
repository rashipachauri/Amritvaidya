<%--
    Document   : videocall2
    Created on : 21 Jan, 2025, 11:15:36 PM
    Author     : Pradeepti Gaur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
    // Check if the user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        // If not logged in, redirect to login page with a message
        response.sendRedirect("login1.jsp?message=Please login to access this feature.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Doctor Consultation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff;
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

       .hero {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 80px;
   
    background: linear-gradient(180deg, #002366 0%, #87CEEB 50%, #FAFAFA 100%);
}

.hero-text {
    max-width: 60%;
}

.hero h1 {
    font-size: 3em;
    color: #333;
}

.hero p {
    font-size: 1.5em;
    color: #555;
}
.hero button  {
        background: linear-gradient(135deg, #0077b6, #005f99);
        color: white;
        border: none;
        padding: 12px 25px;
        font-size: 20px;
        font-weight: bold;
        border-radius: 50px;
        cursor: pointer;
        transition: all 0.3s ease-in-out;
        box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
        outline: none;
    }

    /* Hover Effect */
    .hero button :hover {
        background: linear-gradient(135deg, #005f99, #004c80);
        transform: scale(1.05);
        box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
    }

    /* Button Click Effect */
    .hero button :active {
        transform: scale(0.98);
        box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.2);
    }


.hero-images {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px; /* Teeno images ke beech proper gap */
    left: -40px; /* Thoda left shift */
    position: relative;
}

.hero-images img {
    width: 220px;  /* Image size */
    height: 220px;
    border-radius: 50%;
    object-fit: cover;
    border: 5px solid white; /* Extra styling ke liye */
}


/* First Image */
.hero-images img:nth-child(1) {
    top: 0;
    left: -100px; /* Thoda aur left shift */
}

/* Second Image (Thoda neeche & right) */
.hero-images img:nth-child(2) {
    top: 80px;
    left: -10px;
}

/* Third Image (Wapas first wali position par) */
.hero-images img:nth-child(3) {
    top: 160px;
    left: -100px;
}


     

        .features {
    background: url('images/W3.png');
    padding: 40px;
    text-align: center;
}

.features h2 {
    font-size: 2.5em;
    color: #2c3e50;
    margin-bottom: 40px;
}

.stats {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 50px;
    position: relative;
    margin-top: 30px;
}

.stats::before {
    content: "";
    position: absolute;
    top: 20px;
    left: 10%;
    width: 80%;
    height: 3px;
    background: repeating-linear-gradient(
        to right,
        #27ae60,
        #27ae60 10px,
        transparent 10px,
        transparent 20px
    );
}

.stat {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
}

.stat::before {
    content: "";
    width: 50px;
    height: 50px;
    background: #27ae60;
    border-radius: 50%;
    position: absolute;
    top: -30px;
    z-index: 2;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.stat span {
    width: 50px;
    height: 50px;
    background: #27ae60;
    color: white;
    font-weight: bold;
    font-size: 1.2em;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    z-index: 3;
    position: relative;
}

.stat p {
    margin-top: 60px;
    font-size: 1.2em;
    color: #333;
    max-width: 150px;
    text-align: center;
}


       .steps {
    padding: 50px;
     background: url('images/bg2.jpg');
    text-align: center;
}

.steps h2 {
    font-size: 2.5em;
    color: #2c3e50;
    margin-bottom: 40px;
}

.steps ol {
    list-style: none;
    counter-reset: step-counter;
    max-width: 600px;
    margin: 0 auto;
    padding: 0;
    position: relative;
}

.steps ol::before {
    content: "";
    position: absolute;
    top: 10px;
    left: 20px;
    width: 2px;
    height: calc(100% - 20px);
    background: repeating-linear-gradient(
        to bottom,
        #27ae60,
        #27ae60 8px,
        transparent 8px,
        transparent 16px
    );
}

.steps li {
    counter-increment: step-counter;
    display: flex;
    align-items: center;
    margin-bottom: 30px;
    position: relative;
}

.steps li:last-child {
    margin-bottom: 0;
}

.steps li::before {
    content: counter(step-counter);
    width: 40px;
    height: 40px;
    background: #27ae60;
    color: white;
    font-weight: bold;
    font-size: 1.2em;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    position: absolute;
    left: 0;
    z-index: 2;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.steps li span {
    margin-left: 60px;
    font-size: 1.2em;
    color: #333;
}


        .queries {
            padding: 50px;
            background-color: #ffffff;
            text-align: center;
        }

        .queries h2 {
            font-size: 2.5em;
            color: #333;
            margin-bottom: 20px;
        }

        .queries form {
            max-width: 600px;
            margin: 0 auto;
        }

        .queries textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .queries button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .query-list {
            margin-top: 20px;
            text-align: left;
            max-width: 600px;
            margin: 0 auto;
        }

        .query-list h3 {
            color: #007bff;
            margin-bottom: 10px;
        }

        .query-list p {
            background: #f9f9f9;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 10px;
        }
         .footer {
        position: relative;
        background: linear-gradient(to right, #b2fefa, #0ed2f7);
        padding: 40px 20px;
        text-align: center;
        color: white;
        font-size: 16px;
        font-weight: bold;
        margin-top: 50px;
        overflow: hidden;
    }

    /* Wave Design */
    .wave {
        position: absolute;
        top: -50px; /* Adjust wave height */
        left: 0;
        width: 100%;
        height: auto;
    }
    .footer {
        position: relative;
        background: linear-gradient(to right, #b2fefa, #0ed2f7);
        padding: 30px 15px;
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

    <section class="hero">
        <div class="hero-text">
            <h1>Your doctor is now as close as your phone – start your consultation today</h1>
            <p>Consult experienced doctors online and get the care you need from the comfort of your home.</p>
            <button onclick="consultNow()">Consult Now</button>
        </div>
        <div class="hero-images">
        <img src="images/A6.jpg" alt="Doctor 1">
        <img src="images/A7.jpg" alt="Doctor 2">
        <img src="images/A8.jpg" alt="Doctor 3">
    </div>
    </section>

    <section class="features">
    <h2>Benefits of Online Consultation</h2>
    <div class="stats">
        <div class="stat">
            <span>1</span>
            <p>Consult Top Doctors 24x7 from the comfort of your home.</p>
        </div>
        <div class="stat">
            <span>2</span>
            <p>Get personalized prescriptions and free follow-ups.</p>
        </div>
        <div class="stat">
            <span>3</span>
            <p>Completely private and secure consultations.</p>
        </div>
        <div class="stat">
            <span>4</span>
            <p>Easy access to a variety of specialists for different needs.</p>
        </div>
    </div>
</section>


    <section class="steps">
    <h2>Steps for Online Consultation</h2>
    <ol>
        <li><span>Sign up or log in to your account.</span></li>
        <li><span>Choose the specialty or symptom you need help with.</span></li>
        <li><span>Connect with a doctor via video or audio call.</span></li>
        <li><span>Receive a digital prescription and follow-up care.</span></li>
    </ol>
</section>

 <footer class="footer">
   
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>
   

    <script>
        function consultNow() {
            alert("Redirecting to consultation page...");
            window.location.href = "videocall31.jsp";
        }
    </script>
   
       
       
</body>
</html>