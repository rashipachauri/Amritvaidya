<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: white;
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

           
        .header img {
            height: 100px;
            width: 100px;
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
        .upper-section {
            text-align: center;
            background:  url('images/F1.png');
            padding: 100px;
            margin-bottom: 50px;
        }

        .upper-section h1 {
            font-size: 8rem;
            color: white;
            margin: 0;
        }

        .faq-container {
            max-width: 1100px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            padding: 20px;
            background: #f1f8ff;
            border-radius: 10px;
        }

        .faq-item {
            background: linear-gradient(to right, #2193b0, #6dd5ed);
            padding: 25px;
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s ease;
            position: relative;
            min-height: 120px;
           
        }

        .faq-item:hover {
            transform: scale(1.05);
        }

        .faq-question {
            font-size: 1rem;
            color: white;
        }

        .faq-answer {
            display: none; /* Keep it hidden by default */
            background: #ffffff;
            padding: 15px;
            border-radius: 5px;
            position: absolute; /* Change to absolute */
            top: 0; /* Position it over the question */
            left: 0; /* Align it with the question */
            width: 100%; /* Make it the same width as the question */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 10;
        }

        .toggle-icon {
            font-size: 1.5rem;
            display: block;
            margin: 10px auto 0;
            transition: transform 0.3s ease;
        }

        .toggle-icon.rotate {
            transform: rotate(180deg);
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
 

    <div class="upper-section">
     
    </div>

    <div class="faq-container">
        <div class="faq-item">
            <div class="faq-question">How do I book an appointment?</div>
            <span class="toggle-icon">&#9660;</span>
            <div class="faq-answer">To book an appointment first you have to register yourself.Then you can book an appointment by selecting a doctor and choosing an available time slot.</div>
        </div>

        <div class="faq-item">
            <div class="faq-question">Can I consult online?</div>
            <span class="toggle-icon">&#9660;</span>
            <div class="faq-answer">Yes, you can consult doctors via video call facility provided .</div>
        </div>

        <div class="faq-item">
            <div class="faq-question">How to cancel an appointment?</div>
            <span class="toggle-icon">&#9660;</span>
            <div class="faq-answer">To cancel or reschedule an appointment, go to your account, find the appointment in the "My Appointments" section, and select the option to cancel or reschedule. Follow the steps provided.</div>
        </div>

        <div class="faq-item">
            <div class="faq-question">Is my information secure?</div>
            <span class="toggle-icon">&#9660;</span>
            <div class="faq-answer">Yes, we prioritize your privacy and use advanced encryption and security protocols to ensure your personal information is safe and secure.</div>
        </div>
        <div class="faq-item">
            <div class="faq-question">Are there any specific system/Internet requirements for video Conferencing?</div>
            <span class="toggle-icon">&#9660;</span>
            <div class="faq-answer">It supports any computer,phone that has an Internet connection webcam and a microphone..</div>
        </div>
        <div class="faq-item">
            <div class="faq-question">
                <span>What should I do in case of a medical emergency?</span>
                <span class="toggle-icon">&#9660;</span>
            </div>
            <div class="faq-answer">
                In case of a medical emergency, please contact your nearest emergency services or visit a hospital immediately. Our platform is not designed for emergency medical care.
            </div>
        </div>
            <div class="faq-item">
            <div class="faq-question">
                <span>What types of doctors are available on this platform?</span>
                <span class="toggle-icon">&#9660;</span>
            </div>
            <div class="faq-answer">
                We have a variety of specialists, including general physicians, pediatricians, dermatologists, gynecologists, and more. You can browse the list of available doctors on our platform.
            </div>
        </div>
        <div class="faq-item">
            <div class="faq-question">
                <span>Can I get a prescription after my consultation?</span>
                <span class="toggle-icon">&#9660;</span>
            </div>
            <div class="faq-answer">
                Yes, after your consultation, the doctor can provide a digital prescription, which will be available in your account for download or printing.
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll('.faq-item').forEach(item => {
    item.addEventListener('click', () => {
        const answer = item.querySelector('.faq-answer');
        const icon = item.querySelector('.toggle-icon');

        // Toggle the display of the answer
        if (answer.style.display === 'block') {
            answer.style.display = 'none'; // Collapse
            icon.classList.remove('rotate');
        } else {
            // Collapse all other answers
            document.querySelectorAll('.faq-answer').forEach(otherAnswer => {
                otherAnswer.style.display = 'none';
                otherAnswer.previousElementSibling.classList.remove('rotate');
            });
            answer.style.display = 'block'; // Expand
            icon.classList.add('rotate');
        }
    });
});
    </script>
    <footer class="footer">
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>
</body>
</html>