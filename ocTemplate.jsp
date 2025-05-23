<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Search</title>
    <style>
        /* Global Styles */
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0px;
    background-image: url('images/medical-equipment-desk-with-copy-space.jpg'); /* Background Image */
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
    color: #333; /* Default Text Color */
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

       

/* Main Container */
.container {
    max-width: 800px;
    margin: auto;
    background: rgba(255, 255, 255, 0.9); /* Light Background with Transparency */
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

/* Headings */
h2 {
    text-align: center;
    color: #26547c; /* Deep Blue */
    font-size: 30px;
    font-weight: bold;
}

h3 {
    color: #06d6a0; /* Medical Green */
    font-size: 22px;
    font-weight: bold;
}

/* Search Bar */
.search-bar {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
}

.search-bar input[type="text"] {
    width: 70%;
    padding: 12px;
    border: 2px solid #26547c;
    border-radius: 8px;
    font-size: 16px;
    transition: 0.3s ease-in-out;
}

.search-bar input[type="text"]:focus {
    border-color: #06d6a0;
    outline: none;
    box-shadow: 0 0 8px rgba(6, 214, 160, 0.5);
}

.search-bar input[type="submit"] {
    padding: 12px 18px;
    background-color: #06d6a0;
    color: white;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    transition: background 0.3s ease;
    margin-left: 10px;
}

.search-bar input[type="submit"]:hover {
    background-color: #04b78b;
}

/* Patient Info Section */
.patient-info {
    margin-top: 20px;
    border-top: 3px solid #26547c;
    padding-top: 20px;
    background: rgba(6, 214, 160, 0.1); /* Light Green Tint */
    padding: 15px;
    border-radius: 8px;
}

.patient-info p {
    margin: 5px 0;
    font-size: 16px;
}

/* Section Header */
.section-header {
    background: #26547c;
    color: white;
    padding: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    cursor: pointer;
    border-radius: 5px;
    margin-top: 20px;
    font-size: 18px;
    font-weight: bold;
    transition: background 0.3s ease;
}

.section-header:hover {
    background: #1d3d5f;
}

/* Buttons */
button {
    background: #06d6a0;
    color: white;
    border: none;
    padding: 12px 15px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s ease;
}

button:hover {
    background: #04b78b;
}

/* Responsive Design */
@media (max-width: 768px) {
    .search-bar {
        flex-direction: column;
        align-items: center;
    }

    .search-bar input[type="text"] {
        width: 100%;
        margin-bottom: 10px;
    }

    .search-bar input[type="submit"] {
        width: 100%;
    }
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
    <h2>Search Patient</h2>
    <form method="post">
        <div class="search-bar">
            <input type="text" name="patientName" placeholder="Enter Patient Name" required>
            <input type="submit" value="Search">
        </div>
    </form>
    

    <div class="patient-info">
        <%
            if (request.getMethod().equalsIgnoreCase("post")) {
                String patientName = request.getParameter("patientName");

                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

                    String sql = "SELECT * FROM AV.ONLINE_CONSULTATION WHERE firstname LIKE ? OR lastname LIKE ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, "%" + patientName + "%");
                    pstmt.setString(2, "%" + patientName + "%");

                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        out.println("<h3>Patient Information</h3>");
                        out.println("<p><strong>Full Name:</strong> " + rs.getString("prefix_name") + " " + rs.getString("firstname") + " " + rs.getString("middlename") + " " + rs.getString("lastname") + "</p>");
                        out.println("<p><strong>Birth Date:</strong> " + rs.getString("birthdate") + "</p>");
                        out.println("<p><strong>Gender:</strong> " + rs.getString("gender") + "</p>");
                        out.println("<p><strong>Address:</strong> " + rs.getString("address1") + ", " + rs.getString("address2") + ", " + rs.getString("city") + ", " + rs.getString("state_province") + ", " + rs.getString("zip") + "</p>");
                        out.println("<p><strong>Phone:</strong> " + rs.getString("phone") + "</p>");
                        out.println("<p><strong>Email:</strong> " + rs.getString("email") + "</p>");
                        out.println("<p><strong>Occupation:</strong> " + rs.getString("occupation") + "</p>");
                        out.println("<p><strong>Weight:</strong> " + rs.getString("weight") + " KG</p>");
                        out.println("<p><strong>Main Complaints:</strong> " + rs.getString("complaints") + "</p>");
                        out.println("<p><strong>Factors Affecting Symptoms:</strong> " + rs.getString("factors") + "</p>");
                        out.println("<p><strong>Previous Illness History:</strong> " + rs.getString("illness_history") + "</p>");
                        out.println("<p><strong>Surgical History:</strong> " + rs.getString("surgery") + "</p>");
                        out.println("<p><strong>Family Medical History:</strong> " + rs.getString("family_history") + "</p>");
                        out.println("<p><strong>Wake Up Time:</strong> " + rs.getString("wakeup") + "</p>");
                        out.println("<p><strong>Exercise Frequency:</strong> " + rs.getString("exercise") + "</p>");
                        out.println("<p><strong>Job Type:</strong> " + rs.getString("jobtype") + "</p>");
                        out.println("<p><strong>Appetite:</strong> " + rs.getString("appetite") + "</p>");
                        out.println("<p><strong>Meal Timing:</strong> " + rs.getString("mealtiming") + "</p>");
                        out.println("<p><strong>Breakfast:</strong> " + rs.getString("breakfast") + "</p>");
                        out.println("<p><strong>Breakfast Timing:</strong> " + rs.getString("breakfasttiming") + "</p>");
                        out.println("<p><strong>Hungry at Breakfast:</strong> " + rs.getString("hungrybreakfast") + "</p>");
                        out.println("<p><strong>Lunch Timing:</strong> " + rs.getString("lunchtiming") + "</p>");
                        out.println("<p><strong>Dinner Timing:</strong> " + rs.getString("dinnertiming") + "</p>");
                        out.println("<p><strong>Bad Habits:</strong> " + rs.getString("badhabits") + "</p>");
                        out.println("<p><strong>Details about Bad Habits:</strong> " + rs.getString("badhabitdetails") + "</p>");
                        out.println("<p><strong>Food Preference:</strong> " + rs.getString("foodpreference") + "</p>");
                        out.println("<p><strong>Toilet Frequency:</strong> " + rs.getString("toilet") + "</p>");
                        out.println("<p><strong>Defecation Feeling:</strong> " + rs.getString("defecation") + "</p>");
                        out.println("<p><strong>Need for Tea/Coffee for Sensation:</strong> " + rs.getString("tea") + "</p>");
                        out.println("<p><strong>Nature of Stool:</strong> " + rs.getString("stoolnature") + "</p>");
                        out.println("<p><strong>Urine Frequency:</strong> " + rs.getString("urine") + "</p>");
                        out.println("<p><strong>Sweating:</strong> " + rs.getString("sweating") + "</p>");
                        out.println("<p><strong>Sleep Quality:</strong> " + rs.getString("sleep") + "</p>");
                        out.println("<p><strong>Afternoon Sleep:</strong> " + rs.getString("afternoon_sleep") + "</p>");
                        out.println("<p><strong>Stress Level:</strong> " + rs.getString("stress_level") + "</p>");
                        out.println("<p><strong>Menstrual Cycle:</strong> " + rs.getString("menstrual_cycle") + "</p>");
                        out.println("<p><strong>Complaints During Menstruation:</strong> " + rs.getString("complaints2") + "</p>");
                        out.println("<p><strong>Obstetric History:</strong> " + rs.getString("obstetric_history") + "</p>");
                        out.println("<p><strong>Abortion History:</strong> " + rs.getString("abortion_history") + "</p>");
                        out.println("<p><strong>Abortion Count:</strong> " + rs.getString("abortion_count") + "</p>");
                        out.println("<p><strong>Ayurvedic Medicines Taken:</strong> " + rs.getString("ayurvedic_medicine") + "</p>");
                        out.println("<p><strong>Medicine Details:</strong> " + rs.getString("medicine_details") + "</p>");
                    } else {
                        out.println("<p>No patient found with the name: " + patientName + "</p>");
                    }

                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error retrieving patient data: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</div>
    <footer class="footer">
   
   
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>
</body>
</html>
