<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<html>
    <head>
        <title>Doctor Appointment Booking</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <style>
            /* Full-page layout */
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
               
                height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                background: linear-gradient(to right, #4682b4, #ffffff);
            }
            .header {
        width: 100%;
        background: linear-gradient(45deg, #b2dfdb, #e1f5fe, #dcedc1);
        padding: 15px 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-radius: 15px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
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

            /* Main Content Area */
            .main-container {
                display: flex;
                width: 80%;
                max-width: 1800px;
                height: 70vh;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
                border-radius: 12px;
                overflow: hidden;
                background: rgba(255, 255, 255, 0.9);
            }

            /* Left Image Section */
            .left-section {
                width: 35%;
                background: url('images/doctor-side-image.jpg') no-repeat center center;
                background-size: cover;
            }

            /* Right Booking Form Section */
            .right-section {
                width: 65%;
                padding: 30px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            /* Appointment Form Styling */
            .container {
                width: 80%;
                text-align: center;
            padding: 30px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
            }

            h2 {
                color: #2c3e50;
                font-weight: bold;
                text-transform: uppercase;
                margin-bottom: 20px;
                font-size: 26px;
            }

            h3 {
                color: #27ae60;
                font-weight: bold;
            }

            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
                width: 100%;
            }

            label {
                font-weight: bold;
                text-align: left;
                display: block;
                font-size: 16px;
                color: #333;
            }

            select, input {
                padding: 12px;
                border: 2px solid #007BFF;
                border-radius: 8px;
                font-size: 16px;
                width: 100%;
                background: #f8f9fa;
                transition: 0.3s;
                outline: none;
            }

            select:focus, input:focus {
                border-color: #0056b3;
                background: white;
            }

            /* Submit Button */
            .button {
    background: linear-gradient(45deg, #28a745, #5cb85c); /* Green gradient */
    color: white;
    font-size: 18px;
    font-weight: bold;
    padding: 10px 20px; /* Decreased padding for a shorter button */
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
    box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
    width: auto; /* Set width to auto for a shorter button */
    margin-top: 20px; /* Add some margin for spacing */
}

.button:hover {
    background: linear-gradient(45deg, #218838, #4cae4c); /* Darker green on hover */
    transform: scale(1.05);
    box-shadow: 0 6px 15px rgba(0, 123, 255, 0.3);
}
.error {
    color: red;
    font-size: 14px;
}


            /* Responsive Design */
            @media screen and (max-width: 768px) {
                .main-container {
                    flex-direction: column;
                    height: auto;
                }

                .left-section {
                    width: 100%;
                    height: 350px;
                }

                .right-section {
                    width: 100%;
                }

                .container {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>

        <!-- Header Section -->
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
                    <a href="cancelappointment.jsp">Cancel Appointment</a>
                </div>
            </div>
            </div>
         <div class="profile-container">
        <img src="images/pp1.jpg" alt="Profile Picture" class="profile-pic" onclick="toggleDropdown()">
       
       
    </div>
       
    </div>

        <!-- Main Content Section -->
        <div class="main-container">
            <!-- Left Image Section -->
            <div class="left-section">
                <img src="images/D6.jpg">
            </div>

            <!-- Right Booking Form Section -->
            <div class="right-section">
                <div class="container">
<%
    String doctorUsername = request.getParameter("doctor_username");
    if (doctorUsername == null || doctorUsername.isEmpty()) {
        response.sendRedirect("bookappointment.jsp"); // Redirect if no doctor is selected
        return;
    }

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

        String sql = "SELECT * FROM AV.doctor WHERE username = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, doctorUsername);
        resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
%>
        <h2>Book an Appointment with Dr. <%= resultSet.getString("name") %></h2>
        <p><strong>Specialty:</strong> <%= resultSet.getString("specialty") %></p>
        <p><strong>Email:</strong> <%= resultSet.getString("email") %></p>

        <form action="confirmappointment.jsp" method="post">
            <input type="hidden" name="doctor_username" value="<%= doctorUsername %>">
           
            <div class="form-group">
                <label for="appointmentDate">Select Date:</label>
                <input type="date" id="appointmentDate" name="appointmentDate" class="input-box" required>
            </div>

            <div class="form-group">
    <label for="timeslot">Select Time Slot:</label>
    <select name="timeslot" id="timeslot" required>
        <option value="10:00 AM">10:00 AM</option>
        <option value="11:00 AM">11:00 AM</option>
        <option value="12:00 PM">12:00 PM</option>
        <option value="2:00 PM">2:00 PM</option>
        <option value="4:00 PM">4:00 PM</option>
    </select>
</div>

<script>
    document.getElementById("appointmentDate").addEventListener("change", function () {
        let selectedDate = this.value;
        let doctorUsername = "<%= doctorUsername %>";

        fetch('getBookedSlots.jsp?doctor_username=' + doctorUsername + '&date=' + selectedDate)
            .then(response => response.text())
            .then(data => {
                let bookedSlots = data.split(",").map(slot => slot.trim());
                let options = document.querySelectorAll("#timeslot option");

                // Re-enable all slots first
                options.forEach(option => {
                    option.disabled = false;
                    option.style.color = "black"; // Reset style
                });

                // Disable booked slots
                options.forEach(option => {
                    if (bookedSlots.includes(option.value)) {
                        option.disabled = true;
                        option.style.color = "red"; // Highlight booked slots
                    }
                });
            })
            .catch(error => console.error("Error fetching booked slots:", error));
    });
</script>


            <button type="submit" class="button">Confirm Appointment</button>
        </form>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
    let today = new Date();
    let formattedDate = today.toISOString().split("T")[0];
    let dateInput = document.getElementById("appointmentDate");

    dateInput.setAttribute("min", formattedDate); // Set min date to today

    let doctorUsername = "<%= doctorUsername %>"; // Fetch the selected doctor's username

    // Fetch fully booked dates and disable them
    fetch('getFullyBookedDates.jsp?doctor_username=' + doctorUsername)
        .then(response => response.text())
        .then(data => {
            let fullyBookedDates = data.split(",").map(date => date.trim());

            dateInput.addEventListener("input", function () {
                if (fullyBookedDates.includes(this.value)) {
                    alert("All slots for this date are fully booked. Please select another date.");
                    this.value = ""; // Clear the date field
                }
            });
        })
        .catch(error => console.error("Error fetching fully booked dates:", error));
});

       
        </script>
<%
        } else {
            out.println("<p class='error'>Doctor not found.</p>");
        }
    } catch (Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (resultSet != null) resultSet.close();
        if (preparedStatement != null) preparedStatement.close();
        if (connection != null) connection.close();
    }
%>
    </div>


    </body>
</html>
