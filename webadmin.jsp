<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AmritaVaidya - Talk to Doctor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
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
        #whyChooseUs {
        text-align: center;
        padding: 30px 20px;
        background: url('images/W3.png'); /* Light Green to Light Blue */
        color: #333; /* Darker text for better contrast */
    }

   /* Why Choose Us Heading Block */
#whyChooseUs h2 {
    display: inline-block;
    background: linear-gradient(135deg, #fdfbfb, #ebedee); /* Light elegant gradient */
    color: #333; /* Dark text for contrast */
    padding: 15px 30px;
    border-radius: 10px;
    font-size: 36px;
    font-weight: bold;
    text-transform: uppercase;
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
    letter-spacing: 1.5px;
}


    /* Features Container */
    .features {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 50px; /* Space between circles */
    }

    /* Feature Item */
    .feature {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        position: relative;
    }
    /* Sub-Headings Block Style */
.feature p {
    display: inline-block;
    background: linear-gradient(135deg, #ffffff, #f3f4f6); /* Soft gradient for elegance */
    color: #222; /* Darker text for contrast */
    padding: 10px 20px;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    text-align: center;
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
    letter-spacing: 1px;
    max-width: 200px;
}


    /* Circular Image */
    .circle {
        width: 120px;
        height: 120px;
        background: white;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.15);
        position: relative;
    }

    .circle img {
        width: 90px;
        height: 90px;
        border-radius: 50%;
    }

    /* Feature Heading */
    .feature p {
        font-size: 16px;
        margin-top: 15px;
        font-weight: bold;
        max-width: 180px;
    }

    /* Dotted Line Between Circles */
    .feature:not(:last-child)::after {
        content: "";
        position: absolute;
        width: 50px;
        height: 2px;
        border-top: 2px dashed #333;
        top: 60px;
        right: -75px;
    }

    /* Responsive Design */
    @media (max-width: 992px) {
        .features {
            flex-direction: column;
            gap: 30px;
        }
        .feature:not(:last-child)::after {
            display: none; /* Hide lines on small screens */
        }
    }

       .main-section {
            text-align: center;
            padding: 10px;
             height: 450px;
            background-image:  url('images/b5.jpg');
        }
        .main-section h1 {
            color:#26a69a;
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        .icons-section {
            display: flex;
            justify-content: center;
            gap: 50px;
            margin-top: 40px;
        }
        .icon-box {
            text-align: center;
            padding: 20px;
            border: 2.5px solid #000000;
            border-radius: 10px;
            width: 220px;
            transition: transform 0.3s;
           
        }
        .icon-box:hover {
            transform: scale(1.1);
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

   
       .slideshow-container {
    width: 90%;
    height: 100vh;
    position: relative;
    overflow: hidden;
    background-color: #f0f0f0;
    margin: 0 auto;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
}

.slides {
    display: none;
    width: 100%;
    height: 90%;
    object-fit: cover;
}

.slideshow-container img {
    width: 100%;
    height: 100%;
    border-radius: 10px;
}

        .fade {
            animation-name: fade;
            animation-duration: 1.5s;
        }
        @keyframes fade {
            from { opacity: 0.4; }
            to { opacity: 1; }
        }
        .dots-container {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 8px;
        }
        .dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #ddd;
            cursor: pointer;
        }
        .dot.active {
            background: #555;
        }
     
       

section {
    padding: 100px 20px;
    text-align: center;
    border-bottom: 1px solid #ccc;
}

#about {
    background: linear-gradient(135deg, #a8e6cf, #dcedc1, #b3e5fc);
    padding: 80px 20px;
    text-align: center;
    color: #333;
    position: relative;
}

#about h2 {
    font-size: 2.5rem;
    color: #0077b6;
    margin-bottom: 20px;
}

#about p {
    font-size: 1.2rem;
    line-height: 1.8;
    margin-bottom: 20px;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
}

/* Left side bottom circular image */
.left-circle {
    position: absolute;
    bottom: 10px; /* Bottom pe set karne ke liye */
    left: 5%;
    width: 180px; /* Circle ka size */
    height: 180px;
    border-radius: 50%;
    overflow: hidden;
}

.left-circle img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* Right side top circular image */
.right-circle {
    position: absolute;
    top: 10px; /* Top pe set karne ke liye */
    right: 5%;
    width: 200px;
    height: 200px;
    border-radius: 50%;
    overflow: hidden;
}

.right-circle img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}


#faqs {
    background: #48cae4;
}

#contact {
    background: url('images/W3.png');
    padding: 90px;
    min-height: 220px; /* Adjust the height as needed */
}
  #contact h2 {
        font-size: 42px;
        font-weight: bold;
        color: #0077b6;
        text-transform: uppercase;
        letter-spacing: 2px;
        margin-bottom: 10px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
    }

    /* Improved Button Styling */
    #consultButton {
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
    #consultButton:hover {
        background: linear-gradient(135deg, #005f99, #004c80);
        transform: scale(1.05);
        box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
    }

    /* Button Click Effect */
    #consultButton:active {
        transform: scale(0.98);
        box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.2);
    }

    /* Image Gallery Styling */
   #imageGallery {
        display: flex;
        justify-content: space-evenly;
        align-items: center;
        padding: 50px 0;
        margin-top: -10%; /* Overlapping effect */
        background: #white; /* Light background */
        flex-wrap: wrap;
        width: 100%;
    }

    #imageGallery img {
        border-radius: 10px;
        box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
        transition: transform 0.3s ease-in-out;
         gap: 40px;
    }

    /* Small Image */
    .small {
        width: 40vw;
        height: 40vw;
        max-width: 180px;
        max-height: 180px;
    }

    /* Big Image */
    .big {
        width: 50vw;
        height: 55vw;
        max-width: 230px;
        max-height: 230px;
    }

    /* Hover Effect */
    #imageGallery img:hover {
        transform: scale(1.1);
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
           
           
            <a href="#contact">Contact Us</a>
           
            <div class="menu-item">
                <a href="#">Profile</a>
                <div class="dropdown">
                    <a href="profile.jsp">My Profile</a>
                   
                    <a href="logout.jsp">Sign Out</a>
                   
                </div>
            </div>
            </div>
        
       
    </div>
     <div class="slideshow-container">
        <img class="slides fade" src="images/1.png" alt="Slide 1">
        <img class="slides fade" src="images/2.png" alt="Slide 2">
         <img class="slides fade" src="images/4.png" alt="Slide 2">
        <div class="dots-container">
            <span class="dot" onclick="currentSlide(1)"></span>
            <span class="dot" onclick="currentSlide(2)"></span>
            <span class="dot" onclick="currentSlide(2)"></span>
         
        </div>
       
        <div class="dots-container">
            <span class="dot" onclick="currentSlide(1)"></span>
           
           
        </div>
    </div>
   
    <section id="whyChooseUs">
    <h2>Why Choose Us</h2>
    <div class="features">
        <div class="feature">
            <div class="circle"><img src="images/S1.jpg" alt="Health Trends"></div>
            <p>Latest Health Trends & News</p>
        </div>
        <div class="feature">
            <div class="circle"><img src="images/S2.jpg" alt="Consult Anytime"></div>
            <p>Consult Anytime, Anywhere</p>
        </div>
        <div class="feature">
            <div class="circle"><img src="images/S3.jpg" alt="Medical Records"></div>
            <p>Systematic Medical Record Management</p>
        </div>
        <div class="feature">
            <div class="circle"><img src="images/S4.jpg" alt="Real-time Interaction"></div>
            <p>Real-time Interaction</p>
        </div>
    </div>
</section>
 
   
             
    <div class="main-section">
        <h1>Consult with Top Doctors Online </h1>

       
        <div class="icons-section">
             <div class="icon-box" onclick="window.location.href='drlist.jsp';">
                <img src="images/appoint.jpg" alt="Book Appointment" width="130">
                <p>Doctor</p>
            </div>
            <div class="icon-box" onclick="window.location.href='patientrec.jsp';">
                <img src="images/medicine.jpg" alt="Medicine" width="150">
                <p>Patient</p>
            </div>
           
        </div>
    </div>
   
 
<section id="about">
    <h2>About Us</h2>
   
    <p>
        Welcome to <strong>AMRITAVAIDYA</strong>, your trusted healthcare platform where technology meets personalized care.
        We bridge the gap between patients and expert medical professionals through seamless, real-time interactions.
    </p>
    <p>
        Our mission is to empower individuals to take charge of their health by providing access to high-quality medical
        consultations from the comfort of their homes. Whether you're seeking advice for a common illness or need
        guidance on complex health issues, AMRITVAIDYA is here to connect you with the right doctors and specialists.
    </p>
    <p>
        With a focus on innovation and patient satisfaction, we strive to make healthcare accessible, affordable,
        and convenient for everyone.
    </p>
    <div class="left-circle">
        <img src="images/A1.jpg" alt="Left Image">
    </div>

    <!-- Right side top image -->
    <div class="right-circle">
        <img src="images/A2.jpg" alt="Right Image">
    </div>
</section>

   
    <section id="contact">
    <h2>Contact Us</h2>
    <p>Get in touch with us for any assistance or queries.</p>
    <button onclick="window.location.href='contact2.html'" id="consultButton">
        CONSULT US
    </button>
</section>


<section id="imageGallery">
    <img src="images/A1.jpg" alt="Image 1" class="small">
    <img src="images/A3.jpg" alt="Image 2" class="big">
    <img src="images/A4.jpg" alt="Image 3" class="small">
    <img src="images/A5.jpg" alt="Image 4" class="big">
    <img src="images/A2.jpg" alt="Image 5" class="small">
</section>

    <footer class="footer">
   
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>
   
   
   
   
   
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
       
          document.addEventListener("DOMContentLoaded", function() {
    let savedPic = localStorage.getItem("profilePic");
    if (savedPic) {
        document.querySelector(".profile-pic").src = savedPic;
    }
});

function toggleDropdown() {
    var dropdown = document.getElementById("dropdown");
    dropdown.style.display = (dropdown.style.display === "block") ? "none" : "block";
}

function changeProfilePic(src) {
    let confirmChange = confirm("Do you want to set this as your profile picture?");
    if (confirmChange) {
        document.querySelector(".profile-pic").src = src;
        localStorage.setItem("profilePic", src); // Save image in localStorage
    }
    document.getElementById("dropdown").style.display = "none";
}

document.addEventListener("click", function(event) {
    var profileContainer = document.querySelector(".profile-container");
    var dropdown = document.getElementById("dropdown");
    if (!profileContainer.contains(event.target) && !dropdown.contains(event.target)) {
        dropdown.style.display = "none";
    }
});

       
    </script>
</body>
</html>