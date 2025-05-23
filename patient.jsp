<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AmritaVaidya - Patient Entry</title>
      <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('images/V8.jpg');
        }

        .container {
            display: flex;
            width: 80%;
            height: 90%;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .image-section {
            width: 40%;
            position: relative;
            overflow: hidden;
        }

        .image-section img {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }

        .image-section img.active {
            opacity: 1;
        }
.form-section {
    width: 60%; 
    background-color: #fff;
    padding: 30px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start; 
    position: relative;
    overflow-y: auto; 
    max-height: 100vh; 
    flex-grow: 1; 
}



        .form-section h1 {
           font-size: 34px;
    font-weight: bold;
    color: #0077b6;
    margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-spacing: 15px;
        }

        td {
            font-size: 16px;
    color: #333;
    padding: 5px 0;
    text-align: left;
        }

       input[type="text"],
input[type="date"],
select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 14px;
    outline: none;
    transition: 0.3s;
}

input[type="text"]:focus,
input[type="date"]:focus,
select:focus {
    border-color: #0077b6;
    box-shadow: 0 0 5px rgba(0, 119, 182, 0.4);
}

        input[type="radio"] {
            margin-right: 10px;
        }

       input[type="submit"],
input[type="reset"] {
    width: 100%;
    padding: 12px;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    color: #fff;
    background: linear-gradient(to right, #0077b6, #00a8e8);
    transition: 0.3s;
    margin-top: 10px;
}

input[type="submit"]:hover,
input[type="reset"]:hover {
    background: linear-gradient(to right, #00a8e8, #0077b6);
}

        .footer {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 15px;
            color: #777;
            text-align: center;
        }
    </style>
</head>
<body>
   
     <div class="container">
       
        <div class="image-section">
            <img src="images/D9.jpg" alt="Slide 1" class="active">
           
        </div>

        <!-- Right Form Section -->
        <div class="form-section">
            <h1>Patient Entry Form</h1>
            <form name="f2" 
                <table>
                    <tr>
                        <td>Enter the Name of Patient</td>
                        <td><input type="text" name="txtname" value="" required /></td>
                    </tr>
                    <tr>
                        <td>Blood Group</td>
                        <td>
                            <select name="bloodgrp" required>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Contact Number</td>
                        <td><input type="text" name="txtnumber" value="" required /></td>
                    </tr>
                    <tr>
                        <td>Gender</td>
                        <td>
                            <input type="radio" name="rdogroup" value="male" required /> Male
                            <input type="radio" name="rdogroup" value="female" /> Female
                            <input type="radio" name="rdogroup" value="others" /> Others
                        </td>
                    </tr>
                    <tr>
                        <td>Date of Birth</td>
                        <td><input type="date" name="dob" required /></td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td><input type="text" name="txtemail" value="" required /></td>
                    </tr>
                    <tr>
                        <td>Enter the Username</td>
                        <td><input type="text" name="txtuid" value="" required /></td>
                    </tr>
                    <tr>
                        <td>Enter the Password</td>
                        <td><input type="text" name="txtpwd" value="" required /></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="Submit" name="btnin" />
                           
                            <input type="submit" value="Cancel" name="btnc" />
                             
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

   
    <div class="footer">
        <%
            Calendar calendar = Calendar.getInstance();
            int year = calendar.get(Calendar.YEAR);
        %>
        <p>&copy; <%= year %> AmritaVaidya. All Rights Reserved.</p>
    </div>
   
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

        // Prevent future dates in date of birth field
        let dobInput = document.querySelector("input[name='dob']");
        let today = new Date().toISOString().split("T")[0];
        dobInput.setAttribute("max", today);
    });
</script>

<script>
let nameInput = document.querySelector("input[name='txtname']");
let nameError = document.createElement("div");
nameError.style.color = "red";
nameError.style.fontSize = "12px";
nameError.style.display = "none";
nameError.style.marginTop = "5px";
nameInput.insertAdjacentElement("afterend", nameError);

document.querySelector("form[name='f2']").addEventListener("submit", function(event) {
    let nameValue = nameInput.value.trim();

    if (/\d/.test(nameValue)) {
        nameError.textContent = "Patient name cannot contain numbers.";
        nameError.style.display = "block";
        event.preventDefault();
    } else {
        nameError.style.display = "none";
    }
});
</script>

    <script>
         let currentIndex = 0;
        const slides = document.querySelectorAll('.image-section img');

        function showNextSlide() {
            slides[currentIndex].classList.remove('active');
            currentIndex = (currentIndex + 1) % slides.length;
            slides[currentIndex].classList.add('active');
        }

        setInterval(showNextSlide, 3000); // Change slide every 3 seconds
    </script>
</body>
</html>  
   
<%
    if (request.getParameter("btnin") != null) {
        try {
            String ename = request.getParameter("txtname");
            String bgrp = request.getParameter("bloodgrp");
            String contactnum = request.getParameter("txtnumber");
            String email = request.getParameter("txtemail");
            String birthdate = request.getParameter("dob");
            String gender = request.getParameter("rdogroup");
            String usern = request.getParameter("txtuid");
            String pwd = request.getParameter("txtpwd");

            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");
            Statement stmt = conn.createStatement();

            int x = stmt.executeUpdate("INSERT INTO AV.PATIENT VALUES ('" + ename + "','" + bgrp + "','" + gender + "','" + birthdate + "','" + email + "','" + usern + "','" + pwd + "','" + contactnum + "')" );

            if (x > 0) {
                System.out.println("Patient record inserted successfully.");

                // Insert into LOGIN_DETAILS with role as "Patient"
                int y = stmt.executeUpdate("INSERT INTO AV.LOGIN_DETAILS (USERNAME, PASSWORD, ROLE) VALUES ('"+usern+"', '"+pwd+"', 'Patient')");

                if (y > 0) {
                    System.out.println("Login details added successfully.");

                    // Insert into MEDICAL_RECORDS and retrieve generated RECORD_ID
                    // Insert into MEDICAL_RECORDS using PATIENT_USERNAME instead of PATIENT_ID
int z = stmt.executeUpdate("INSERT INTO AV.MEDICAL_RECORDS (NAME , PATIENT_USERNAME) VALUES ('" + ename + "','" + usern + "')", Statement.RETURN_GENERATED_KEYS);

if (z > 0) {
    ResultSet generatedKeys = stmt.getGeneratedKeys();
    int recordId = -1;  // Default value

    if (generatedKeys != null && generatedKeys.next()) {
        recordId = generatedKeys.getInt(1); // Get RECORD_ID
    } else {
        System.out.println("Failed to retrieve generated RECORD_ID.");
        response.sendRedirect("error.jsp");
        return;
    }

    System.out.println("Medical record created successfully. RECORD_ID: " + recordId);

    // Ensure valid RECORD_ID before inserting into MEDICAL_HISTORY
    if (recordId > 0) {
        int historyInserted = stmt.executeUpdate("INSERT INTO AV.MEDICAL_HISTORY (RECORD_ID, RECORD_DATE, DIAGNOSIS, TREATMENT) VALUES (" + recordId + ", CURRENT_DATE, 'Not Available', 'Not Available')");

        if (historyInserted > 0) {
            System.out.println("Initial medical history added.");
            response.sendRedirect("website.jsp");
        } else {
            System.out.println("Failed to insert medical history.");
            response.sendRedirect("error.jsp");
        }
    } else {
        System.out.println("Invalid RECORD_ID received.");
        response.sendRedirect("error.jsp");
    }
} else {
    System.out.println("Failed to insert medical record.");
    response.sendRedirect("error.jsp");
}

                } else {
                    System.out.println("Failed to insert login details.");
                    response.sendRedirect("error.jsp");
                }
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    if (request.getParameter("btnc") != null) {
        response.sendRedirect("home1.jsp");
    }
%>