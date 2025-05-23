<%--
    Document   : bookappointment
    Created on : 11 Jan, 2025, 6:56:21 PM
    Author     : Pradeepti Gaur
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<html>
<head>
    <title>Doctor Listings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background:#white;
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
       .doctor-section {
    width: 100%;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    text-align: center;
    background: linear-gradient(180deg, #002366 0%, #87CEEB 50%, #FAFAFA 100%);
    gap: 20px; /* Space between elements */
}

.doctor-section h2 {
    font-size: 3.5em;
    color: black;
    margin: 0;
    padding: 0 20px;
}

.circle-container {
    width: 160px;
    height: 160px;
    border-radius: 50%;
    background-color: white;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.circle-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 50%;
}

        .search-bar {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 20px;
    background: linear-gradient(90deg, #3b9a9c, #a7fff3);
    padding: 10px;
    border-radius: 10px;
    backdrop-filter: blur(8px);
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.search-bar input[type="text"] {
    width: 50%;
    padding: 12px;
    font-size: 18px;
    border: none;
    border-radius: 25px;
    outline: none;
    background: white;
    box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease-in-out;
}

.search-bar input[type="text"]:focus {
    background: rgba(255, 255, 255, 0.9);
    box-shadow: inset 0 2px 8px rgba(0, 0, 0, 0.2);
}

.search-bar button {
    padding: 12px 25px;
    margin-left: 10px;
    background:#2c4059;
    color: white;
    border: none;
    border-radius: 25px;
    cursor: pointer;
    font-size: 18px;
    font-weight: bold;
    transition: all 0.3s ease-in-out;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.search-bar button:hover {
    background: linear-gradient(135deg, #357ae8, #1a56d6);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
    transform: scale(1.05);
}

       
       .card-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
}

.card {
    background: white;
    margin: 10px auto;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    width: 60%;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    position: relative;
    overflow: hidden;
}

.card:nth-child(even) {
    background: linear-gradient(135deg, #a8e6cf, #dcedc1); /* Light Fresh Green Gradient */
    color: #2c3e50; /* Dark text for readability */
}

.card:nth-child(odd) {
    background: linear-gradient(135deg, #b2dfdb, #e0f2f1); /* Soft Mint Green Gradient */
    color: #2c3e50;
}


.card:hover {
    transform: scale(1.03);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
}

.card-header {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 10px;
}

.card-details {
    font-size: 16px;
    color: inherit; /* Adapt text color based on background */
    line-height: 1.6;
}

.card::before {
    content: "";
    position: absolute;
    top: 0;
    left: -50%;
    width: 200%;
    height: 100%;
    background: rgba(255, 255, 255, 0.2);
    transform: rotate(15deg);
    transition: left 0.5s ease-in-out;
}

.card:hover::before {
    left: 100%;
}

        .book-button {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #a7acec;
            color: black;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .book-button:hover {
            background-color: #2c8d45;
        }/* Container Styling */
.card-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    padding: 60px; /* Increased Padding for Bigger Size */
    max-width: 120%; /* Increased Width */
    margin: 0 auto;
    background: linear-gradient(135deg, #d4fc79, #96e6a1); /* Bright Fresh Green Gradient */
}

/* Card Styling */
.card {
    position: relative;
    width: 800px;
    padding: 20px;
    border-radius: 12px;
    text-align: center;
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:nth-child(even) {
    background: linear-gradient(135deg, #56ccf2, #2f80ed); /* Bright Blue Gradient */
    color: #fff;
}

.card:nth-child(odd) {
    background: linear-gradient(135deg, #43e97b, #38f9d7); /* Bright Green-Blue Gradient */
    color: #fff;
}

.card:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
}

/* Card Header */
.card-header {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 12px;
    font-family: 'Poppins', sans-serif;
}

/* Card Details */
.card-details {
    font-size: 18px;
    font-family: 'Roboto', sans-serif;
    line-height: 1.6;
}

/* Shine Effect */
.card::before {
    content: "";
    position: absolute;
    top: 0;
    left: -50%;
    width: 200%;
    height: 100%;
    background: rgba(255, 255, 255, 0.3);
    transform: rotate(15deg);
    transition: left 0.5s ease-in-out;
}

.card:hover::before {
    left: 100%;
}


.book-button {
    display: inline-block;
    margin-top: 15px;
    padding: 12px 24px;
    font-size: 18px;
    font-weight: bold;
    text-transform: uppercase;
    background: linear-gradient(135deg, #00c6ff, #0072ff); /* Vibrant Blue Gradient */
    color: white;
    border-radius: 30px;
    text-decoration: none;
    transition: all 0.3s ease;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    border: none;
    cursor: pointer;
}

.book-button:hover {
    background: linear-gradient(135deg, #0f9b0f, #00ff00); /* Green Highlight Effect */
    transform: scale(1.1);
    box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.3);
}

        .hidden {
            display: none;
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
    </style>
    <script>
        function searchDoctors() {
            const query = document.getElementById('search-input').value.toLowerCase().trim();
            const cards = document.getElementsByClassName('card');

            for (let i = 0; i < cards.length; i++) {
                const card = cards[i];
                const name = card.querySelector('.card-header').innerText.toLowerCase();
                const details = card.querySelector('.card-details').innerText.toLowerCase();

                if (name.includes(query) || details.includes(query)) {
                    card.classList.remove('hidden');
                } else {
                    card.classList.add('hidden');
                }
            }
        }
    </script>
</head>

<body>
    <div class="header">
        <img src="images/LOGO.png" alt="AmritaVaidya Logo">
        <div class="menu">
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
    <div class="doctor-section">
    <div class="circle-container">
        <img src="images/M1.jpg" alt="Doctor Image Left">
    </div>
    <h2>Doctor Listing</h2>
    <div class="circle-container">
        <img src="images/M2.jpg" alt="Doctor Image Right">
    </div>
</div>

    <div class="search-bar">
        <input type="text" id="search-input" placeholder="Search by Name, Qualification, or Specialty">
        <button onclick="searchDoctors()">Search</button>
    </div>
   
   

    <%
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya","av","av");
            statement = connection.createStatement();

            String sql = "SELECT * FROM AV.doctor";
            resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String gender = resultSet.getString("gender");
                String email = resultSet.getString("email");
                String qualification = resultSet.getString("qualification");
                Date dob = resultSet.getDate("dob");
                String speciality = resultSet.getString("specialty");
                String bloodgroup = resultSet.getString("bloodgroup");
                String contact = resultSet.getString("contact");
    %>
   
    <div class="card">
        <div class="card-header"><strong>Name:</strong> <%= name %></div>
        <div class="card-details">
            <p><strong>Gender:</strong> <%= gender %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Qualification:</strong> <%= qualification %></p>
            <p><strong>Date of Birth:</strong> <%= dob %></p>
            <p><strong>Specialty:</strong> <%= speciality %></p>
            <p><strong>Blood Group:</strong> <%= bloodgroup %></p>
            <p><strong>Contact:</strong> <%= contact %></p>
         </div>
           <% if (resultSet.getString("STATUS").equals("DISABLED")) { %>
           <p style="color: red; font-weight: bold;">Not Available for Now</p>
        <% } else { %>
            <a href="allotment.jsp?doctor_username=<%= resultSet.getString("username") %>" class="book-button">Book Consultation</a>
        <% } %>


    </div>
       
    <%
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
            }
        }
    %>
    <footer class="footer">
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>

</body>
</html>