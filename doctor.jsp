<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Entry Page</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
             background-image: url('images/D8.jpg');
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .main-container {
            display: flex;
            flex-direction: column;
            max-width: 1500px;
            width: 95%;
            height: 90%;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        @media (min-width: 768px) {
            .main-container {
                flex-direction: row;
            }
        }

        .form-container {
            flex: 1;
            padding: 40px;
            background-color: #f9f9fc;
            overflow-y: auto;
        }

        .form-container h1 {
            color: #444;
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: bold;
            text-align: center;
            border-bottom: 4px solid #007bff;
            display: inline-block;
            padding-bottom: 5px;
        }

        form {
            max-width: 600px;
            margin: 0 auto;
        }

        form table {
            width: 100%;
            color: #555;
            border-collapse: collapse;
        }

        table td {
            padding: 10px 5px;
            font-size: 16px;
        }

        td input,
        td select {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-top: 5px;
            transition: border-color 0.3s ease;
        }

        td input:focus,
        td select:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .radio-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
        }

        .radio-group label {
            font-size: 14px;
            color: #666;
        }

        .button-row {
            text-align: center;
            margin-top: 20px;
        }

        td input[type="submit"],
        td input[type="reset"],
        td input[type="button"] {
            background: linear-gradient(90deg, #4CAF50, #008CBA);
            color: #fff;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 8px;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin: 5px;
        }

        td input[type="submit"]:hover {
            background: linear-gradient(90deg, #4CAF50, #008CBA);
        }

        td input[type="reset"] {
            background: linear-gradient(90deg, #4CAF50, #008CBA);
        }

        td input[type="reset"]:hover {
           background: linear-gradient(90deg, #4CAF50, #008CBA);
        }

        td input[type="button"] {
            background: linear-gradient(90deg, #4CAF50, #008CBA);
        }

        td input[type="button"]:hover {
            background-color: #c82333;
        }

        td input[type="submit"]:active,
        td input[type="reset"]:active,
        td input[type="button"]:active {
            transform: scale(0.97);
        }

        .image-container {
            flex: 1;
            background-color: #d4e6f1;
            position: relative;
        }

        .slideshow {
            width: 100%;
            height: 100%;
            position: absolute;
            overflow: hidden;
        }

        .slideshow img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }

        .slideshow img.active {
            opacity: 1;
        }

        @media (min-width: 768px) {
            .image-container {
                display: block;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="form-container">
            <h1>Doctor Entry Form</h1>
            <form name="f2">
                <table>
                    <tr>
                        <td>Enter the Name of Doctor</td>
                        <td><input type="text" name="txtname" placeholder="Enter full name" required /></td>
                    </tr>
                    <tr>
                        <td>Enter the Username</td>
                        <td><input type="text" name="txtuid" placeholder="Choose a username" required /></td>
                    </tr>
                    <tr>
                        <td>Enter the Password</td>
                        <td><input type="password" name="txtpwd" placeholder="Create a password" required /></td>
                    </tr>
                    <tr>
                        <td>Gender</td>
                        <td class="radio-group">
                            <label><input type="radio" name="rdogroup" value="MALE" checked /> Male</label>
                            <label><input type="radio" name="rdogroup" value="FEMALE" /> Female</label>
                            <label><input type="radio" name="rdogroup" value="OTHERS" /> Others</label>
                        </td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td><input type="email" name="txtemail" placeholder="Enter email address" required /></td>
                    </tr>
                    <tr>
                        <td>Qualification</td>
                        <td>
                            <select name="qualification" required>
                                <option value="">Select Qualification</option>
                                <option>MBBS</option>
                                <option>BAMS</option>
                                <option>BHMS</option>
                                <option>BUMS</option>
                                <option>BNYS</option>
                                <option>MD</option>
                                <option>MS</option>
                                <option>DNB</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Blood Group</td>
                        <td>
                            <select name="bloodgrp" required>
                                <option value="">Select Blood Group</option>
                                <option>A+</option>
                                <option>A-</option>
                                <option>B+</option>
                                <option>B-</option>
                                <option>AB+</option>
                                <option>AB-</option>
                                <option>O+</option>
                                <option>O-</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Specialty</td>
                        <td>
                            <select name="specialty" id="specialty" required onchange="toggleSpecialtyInput()">
    <option value="">Select Specialty</option>
    <option>MD (General Medicine)</option>
    <option>MS (General Surgery)</option>
    <option>MD (Pediatrics)</option>
    <option>MD (Gynecology)</option>
    <option>MD (Dermatology)</option>
    <option>MD (Cardiology)</option>
    <option>MD (Neurology)</option>
    <option>MD (Oncology)</option>
    <option>MS (Orthopedics)</option>
    <option>MS (Ophthalmology)</option>
    <option>MS (ENT)</option>
    <option>MD (Psychiatry)</option>
    <option>MD (Pulmonology)</option>
    <option>MD (Endocrinology)</option>
    <option>MD (Nephrology)</option>
    <option>MD (Gastroenterology)</option>
    <option>MD (Radiology)</option>
    <option>MD (Anesthesiology)</option>
    <option>MD (Pathology)</option>
    <option>MD (Rheumatology)</option>
    <option>MD (Hematology)</option>
    <option>MD (Immunology)</option>
    <option>MD (Geriatrics)</option>
    <option value="other">Other (Self Mention)</option>
</select>
                            <input type="text" id="otherSpecialty" name="otherSpecialty" placeholder="Enter your specialty" style="display: none; margin-top: 10px;">

                        </td>
                    </tr>
                    <tr>
                        <td>Date of Birth</td>
                        <td><input type="date" name="dob" required /></td>
                    </tr>
                    <tr>
                        <td>Contact Number</td>
                        <td><input type="tel" name="txtnumber" placeholder="Enter contact number" required /></td>
                    </tr>
                    <tr class="button-row">
                        <td colspan="2">
                            <input type="submit" name="btnSubmit" value="Submit" />
                            <input type="button" value="Cancel" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="image-container">
            <div class="slideshow">
                <img src="images/D6.jpg" class="active" alt="Doctor Image 1">
               
            </div>
        </div>
    </div>
    
    

<script>
function toggleSpecialtyInput() {
    var specialtySelect = document.getElementById("specialty");
    var otherSpecialtyInput = document.getElementById("otherSpecialty");
    
    if (specialtySelect.value === "other") {
        otherSpecialtyInput.style.display = "block";
        otherSpecialtyInput.required = true;
    } else {
        otherSpecialtyInput.style.display = "none";
        otherSpecialtyInput.required = false;
    }
}
</script>

    <script>
        const images = document.querySelectorAll('.slideshow img');
        let currentIndex = 0;

        function showNextImage() {
            images[currentIndex].classList.remove('active');
            currentIndex = (currentIndex + 1) % images.length;
            images[currentIndex].classList.add('active');
        }

        setInterval(showNextImage, 3000);
    </script>
    
     <script>
    document.addEventListener("DOMContentLoaded", function() {
        let contactInput = document.querySelector("input[name='txtnumber']");
        let errorMessage = document.createElement("div");
        errorMessage.style.color = "red";
        errorMessage.style.fontSize = "12px";
        errorMessage.style.display = "none";
        errorMessage.style.marginTop = "5px";
        contactInput.insertAdjacentElement("afterend", errorMessage);

        document.querySelector("form[name='f2']").addEventListener("submit", function(event) {
            let contactValue = contactInput.value.trim();
            
            if (!/^[0-9]{10}$/.test(contactValue)) {
                errorMessage.textContent = "Invalid contact number. Must be exactly 10 digits.";
                errorMessage.style.display = "block";
                event.preventDefault();
            } else {
                errorMessage.style.display = "none";
            }
        });

        
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        let dobInput = document.querySelector("input[name='dob']");

        // Calculate the date 24 years ago from today
        let today = new Date();
        let minAgeDate = new Date(today.getFullYear() - 24, today.getMonth(), today.getDate());

        // Convert to YYYY-MM-DD format
        let maxDate = minAgeDate.toISOString().split("T")[0];

        // Set max attribute so user can't choose future dates or dates that make them under 24
        dobInput.setAttribute("max", maxDate);
    });
</script>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        let nameInput = document.querySelector("input[name='txtname']");
        let nameError = document.createElement("div");
        nameError.style.color = "red";
        nameError.style.fontSize = "12px";
        nameError.style.display = "none";
        nameError.style.marginTop = "5px";
        nameInput.insertAdjacentElement("afterend", nameError);

        document.querySelector("form[name='f2']").addEventListener("submit", function(event) {
            let nameValue = nameInput.value.trim();

            if (!/^[a-zA-Z\s.]+$/.test(nameValue)) {
                nameError.textContent = "Doctor name must contain only letters.";
                nameError.style.display = "block";
                event.preventDefault();
            } else {
                nameError.style.display = "none";
            }
        });
    });
</script>




</body>
</html>




<%
    if (request.getParameter("btnSubmit")!= null) {
        try {
            String name = request.getParameter("txtname");
            String gender = request.getParameter("rdogroup");
            String email = request.getParameter("txtemail");
            String qualification = request.getParameter("qualification");
            String specialty = request.getParameter("specialty");
            String bloodgroup = request.getParameter("bloodgrp");
            String dob = request.getParameter("dob");
            String contact = request.getParameter("txtnumber");
            String username = request.getParameter("txtuid");
            String password = request.getParameter("txtpwd");

            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/AmritaVaidya", "av", "av");
            Statement stmt = conn.createStatement();
           
            int x = stmt.executeUpdate("INSERT INTO AV.DOCTOR (NAME, GENDER, EMAIL, QUALIFICATION, DOB, SPECIALTY, USERNAME, PASSWORD, BLOODGROUP, CONTACT, STATUS) VALUES ('"+name+"','"+gender+"','"+email+"','"+qualification+"','"+dob+"','"+specialty+"','"+username+"','"+password+"','"+bloodgroup+"','"+contact+"', 'Active')");

            if (x > 0) {
                Statement stmt2 = conn.createStatement();
                stmt2.executeUpdate("INSERT INTO AV.LOGIN_DETAILS (USERNAME, PASSWORD, ROLE) VALUES ('"+username+"', '"+password+"', 'Doctor')");
                response.sendRedirect("website.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
 %>