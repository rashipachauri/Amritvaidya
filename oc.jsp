<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Calendar" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*, java.util.Calendar" %>
<%@ page import="java.sql.*, java.io.*, javax.servlet.http.*, javax.servlet.*, javax.servlet.annotation.MultipartConfig" %>
<%@ page import="java.sql.*, java.util.Calendar" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Consultation Form</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #f0f8ff; /* Light blue background for a calming effect */
    color: #333;
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

        /* Footer styles */
        .footer {
            background: linear-gradient(to right, #b2fefa, #0ed2f7);
            padding: 20px 15px;
            text-align: center;
            color: white;
            font-size: 15px;
            font-weight: bold;
            margin-top: 50px;
            overflow: hidden;
        }


.container {
    width: 50%;
    margin: auto;
    padding: 20px;
    background: white;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
     border: 2px solid #000000;

}
 .form-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      border-bottom: 8px solid #22ce83;
      padding-bottom: 10px;
    }
    .form-header img {
      width: 60px;  
      height: 60px;
    }
    .form-header h1 {
      font-size: 45px;
      margin: 0;
      color: #333;
    }



/* Form Styles */
label {
    font-weight: bold;
    color: #0056b3;
}

.form-group {
    margin-bottom: 15px;
     

}

.input-box, .textarea-box, .select-box {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    background-color: #f9f9f9;
    transition: 0.3s ease;
}

.input-box:focus, .textarea-box:focus, .select-box:focus {
    border-color: #28a745;
    box-shadow: 0px 0px 5px rgba(40, 167, 69, 0.5);
   
}

.textarea-box {
    height: 80px;
    resize: vertical;
}

.radio-group {
    display: flex;
    gap: 15px;
    color: #0056b3;
}

.row {
    display: flex;
    gap: 10px;
}

.row input {
    flex: 1;
}
        .select-box {
            width: 100%;
            padding: 8px;

        }
        .section-header {
            background: #26547c;
             color: black;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
        }
        .section-header:hover {
         background-color: #26547c;
         color: white;
}
        .form-content {
            display: none;
            padding: 10px;
            border-top: 1px solid #ccc;
        }
        .stress-circle {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: lightgray;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .stress-circle:hover, .stress-circle.selected {
            background-color: blue;
            color: white;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            cursor: pointer;
            font-weight: bold;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f8f8f8;
        }
        .form-content {
            display: none;
            padding: 10px;
            border: 1px solid #ccc;
            margin-top: -1px;
        }
        .captcha-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }
        .captcha-box {
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 3px;
            text-decoration: line-through;
            background: #f1f1f1;
            padding: 10px;
            border: 1px solid #ccc;
            display: inline-block;
        }
        .refresh-button {
            cursor: pointer;
            font-size: 16px;
            color: blue;
            text-decoration: underline;
            border: none;
            background: none;
        }
        .input-box {
            width: 200px;
            padding: 5px;
            font-size: 18px;
        }
        .submit-btn {
            padding: 10px 15px;
            font-size: 16px;
             background: linear-gradient(90deg, #4CAF50, #008CBA);

            color: white;
            border: none;
            cursor: pointer;
            display: block;
            margin-top: 20px;
        }
        .success-message {
            color: green;
            font-weight: bold;
            margin-top: 20px;
        }
        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
       

    table {
        border-collapse: collapse;
    }

    /* Styling buttons */
    input[type="submit"],
    input[type="reset"] {
        background-color: #007bff; /* Blue color */
        color: white;
        padding: 10px 20px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin: 5px;
        transition: background 0.3s ease;
    }

    input[type="reset"] {
        background-color: #dc3545; /* Red color */
    }

    /* Hover effect */
    input[type="submit"]:hover {
        background-color: #0056b3;
    }

    input[type="reset"]:hover {
        background-color: #c82333;
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
   
    <div class="form-header">
       
       <img src="images/LOGO.png" alt="AmritaVaidya Logo">
        <h1>CONSULTATION FORM </h1>
      </div>


    <!-- Personal Information Section -->
    <form id="consultationForm">
        <div class="form-group">
            <label>Full Name *</label><br>
            <input type="text" class="input-box" name="prefix_name" placeholder="Prefix" required>
            <input type="text" class="input-box" name="firstname" placeholder="First Name" required>
            <input type="text" class="input-box" name="middlename" placeholder="Middle Name">
            <input type="text" class="input-box" name="lastname"  placeholder="Last Name" required>
        </div>

        <div class="form-group">
            <label for="birthdate">Birth Date *</label><br>
            <input type="date" name="birthdate"  id="birthdate" class="input-box" required>
        </div>

        <div class="form-group">
            <label>I Am *</label><br>
            <div class="radio-group">
                <input type="radio" name="gender" id="male" value="Male" required>
                <label for="male">Male</label>
               
                <input type="radio" name="gender" id="female" value="Female">
                <label for="female">Female</label>
            </div>
        </div>

        <!-- Collapsible Basic Information Section -->
        <div class="section-header" onclick="toggleSection('basicInfo', 'arrow1')">
            <span>Basic Information</span>
            <span id="arrow1">?</span>
        </div>

        <div class="form-content" id="basicInfo">
            <div class="form-group">
                <label>Address *</label>
                <input type="text" class="input-box" name="address1" placeholder="Street Address" required>
                <input type="text" class="input-box" name="address2" placeholder="Street Address Line 2">
                <div class="row">
                    <input type="text" class="input-box" name="city" placeholder="City" required>
                    <input type="text" class="input-box " name="state_province"  placeholder="State / Province" required>
                </div>
                <input type="text" class="input-box"  name="zip" placeholder="Postal / Zip Code" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="tel" class="input-box" name="phone" placeholder="(000) 000-0000">
            </div>

            <div class="form-group">
                <label>E-mail *</label>
                <input type="email" class="input-box" name="email" placeholder="example@example.com" required>
            </div>

            <div class="form-group">
                <label>Occupation *</label>
                <select class="select-box" name="occupation" required>
                    <option value="">Please Select</option>
                    <option>Student</option>
                    <option>Engineer</option>
                    <option>Doctor</option>
                    <option>Other</option>
                </select>
            </div>
        </div>

        <!-- Collapsible Main Case Paper Section -->
        <div class="section-header" onclick="toggleSection('casePaper', 'arrow2')">
            <span>Main Case Paper</span>
            <span id="arrow2">?</span>
        </div>

        <div class="form-content" id="casePaper">
            <div class="form-group">
                <label>Your Weight in KG *</label>
                <input type="text" class="input-box"   name="weight" placeholder="Enter weight in KG" required>
            </div>

            <div class="form-group">
                <label>Main Complaints *</label>
                <textarea class="textarea-box"  name="complaints" placeholder="Describe your main complaints" required></textarea>
            </div>

            <div class="form-group">
                <label>Factors - Increasing / Decreasing Symptoms *</label>
                <textarea class="textarea-box"  name="factors" placeholder="Mention factors affecting symptoms" required></textarea>
            </div>

            <div class="form-group">
                <label>Previous Illness History *</label>
                <textarea class="textarea-box"  name="illness_history"  placeholder="Describe previous illnesses" required></textarea>
            </div>

            <div class="form-group">
                <label>Any Surgical History? *</label><br>
                <div class="radio-group">
                    <input type="radio" name="surgery" id="surgeryYes" value="Yes" required>
                    <label for="surgeryYes">Yes</label>

                    <input type="radio" name="surgery" id="surgeryNo" value="No" checked>
                    <label for="surgeryNo">No</label>
                </div>
            </div>

            <div class="form-group">
                <label>Family Medical History *</label>
                <textarea class="textarea-box"  name="family_history" placeholder="Mention any hereditary conditions" required></textarea>
            </div>
        </div>

        <!-- Collapsible Routine Section -->
        <div class="section-header" onclick="toggleSection('routine', 'arrow3')">
            <span>Routine</span>
            <span id="arrow3">?</span>
        </div>

        <div class="form-content" id="routine">
            <div class="form-group">
                <label>Wake up *</label><br>
                <input type="radio" name="wakeup" value="Before Sunrise" required> Before Sunrise
                <input type="radio" name="wakeup" value="After Sunrise"> After Sunrise
            </div>

            <div class="form-group">
                <label>Exercise? *</label><br>
                <input type="radio" name="exercise" value="Daily" required> Daily
                <input type="radio" name="exercise" value="Sometimes"> Sometimes
                <input type="radio" name="exercise" value="Never"> Never
            </div>

            <div class="form-group">
                <label>Type of Job *</label><br>
                <input type="radio" name="jobtype" value="Sitting Job" required> Sitting Job
                <input type="radio" name="jobtype" value="Stressful"> Stressful
                <input type="radio" name="jobtype" value="In hot surrounding"> In hot surrounding
                <input type="radio" name="jobtype" value="Shift Duty"> Shift Duty
                <input type="radio" name="jobtype" value="Night Duty"> Night Duty
                <input type="radio" name="jobtype" value="Travelling Job"> traveling Job
                <input type="radio" name="jobtype" value="House Work"> House Work
                <input type="radio" name="jobtype" value="Continuously in Front of PC/Laptop"> Continuously in Front of PC/Laptop
            </div>

            <div class="form-group">
                <label>Your Appetite? *</label><br>
                <input type="radio" name="appetite" value="Good Appetite" required> Good Appetite
                <input type="radio" name="appetite" value="No feeling of Appetite"> No Feeling of Appetite
                <input type="radio" name="appetite" value="Sometimes Good Sometimes no feeling of Appetite"> Sometimes Good Sometimes no feeling of Appetite
            </div>

            <div class="form-group">
                <label>Timing of Having Meal *</label><br>
                <input type="radio" name="mealtiming" value="Regular" required> Regular
                <input type="radio" name="mealtiming" value="Irregular"> Irregular
                <input type="radio" name="mealtiming" value="Only after feeling of Appetite"> Only after feeling of Appetite
                <input type="radio" name="mealtiming" value="Scheduled as per time"> Scheduled as per time
                <input type="radio" name="mealtiming" value="Other"> Other
            </div>

            <div class="form-group">
                <label>Do you have breakfast? *</label><br>
                <select class="select-box" name="breakfast" required>
                    <option value="">Please Select</option>
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                    <option value="Sometimes">Sometimes</option>
                </select>
            </div>

            <div class="form-group">
                <label>Breakfast Timing *</label><br>
                <input type="radio" name="breakfasttiming" value="Morning" required> Morning
                <input type="radio" name="breakfasttiming" value="Approx Afternoon time"> Approx Afternoon time
            </div>

            <div class="form-group">
                <label>Do you feel hungry at breakfast? *</label><br>
                <input type="radio" name="hungrybreakfast" value="Yes" > Yes
                <input type="radio" name="hungrybreakfast" value="No"> No
            </div>
           
            <div class="form-group">
                <label>Timing of LUNCH *</label><br>
                <select class="select-box" name="lunchtiming" required>
                    <option value="">Please Select</option>
                    <option value="10:00AM-11:00AM">10:00AM-11:00AM</option>
                    <option value="11:00AM-12:00PM">11:00AM-12:00PM</option>
                    <option value="12:00PM-02:00PM">12:00PM-02:00PM</option>
                    <option value="BEFORE 10:00AM">BEFORE 10:00AM</option>
                    <option value="AFTER 02:00PM">AFTER 02:00PM</option>
                </select>
            </div>
            <div class="form-group">
                <label>Timing of Dinner *</label><br>
                <select class="select-box" name="dinnertiming" required>
                    <option value="">Please Select</option>
                    <option value="Before Sunset">Before Sunset</option>
                    <option value="07:00PM-09:00PM">07:00PM-09:00PM</option>
                    <option value="09:00PM-10:00PM">09:00PM-10:00PM</option>
                    <option value="10:00PM onwards">10:00PM onwards</option>
                    <option value="Very Irregular">Very Irregular</option>
                </select>
            </div>

            <div class="form-group">
                <label>Bad Habits *</label><br>
                <input type="radio" name="badhabits" value="Cigarette"> Cigarette
                <input type="radio" name="badhabits" value="Tobacco"> Tobacco
                <input type="radio" name="badhabits" value="Alcohol"> Alcohol
                <input type="radio" name="badhabits" value="Gutkha"> Gutkha
                <input type="radio" name="badhabits" value="None"> None
            </div>

            <div class="form-group">
                <label>Details about Bad Habits (Quantity, How Many Times, etc.)</label>
                <textarea class="textarea-box" name="badhabitdetails"></textarea>
            </div>

            <div class="form-group">
                <label>Maximum Consumption of *</label><br>
                <input type="radio" name="foodpreference" value="Sweet Food"> Sweet Food
                <input type="radio" name="foodpreference" value="Salty Food"> Salty Food
                <input type="radio" name="foodpreference" value="Sour Food"> Sour Food
                <input type="radio" name="foodpreference" value="Pungent Food"> Pungent Food
                <input type="radio" name="foodpreference" value="Stringent Food"> Stringent Food
                <input type="radio" name="foodpreference" value="Bitter Food"> Bitter Food
            </div>
        </div>
       
        <!-- Collapsible Daily Routine Section -->
        <div class="section-header" onclick="toggleSection('dailyRoutine', 'arrow4')">
            <span>Daily Routine</span>
            <span id="arrow4">?</span>
        </div>

        <div class="form-content" id="dailyRoutine">
           
           
            <!-- Bowel Habits -->
            <div class="form-group">
                <label>Bowel Habits *</label>
                <table border="1">
                    <tr>
                        <th></th>
                        <th>Yes</th>
                        <th>No</th>
                        <th>Sometimes</th>
                    </tr>
                    <tr>
                        <td>Do you visit toilet daily?</td>
                        <td><input type="radio" name="toilet"></td>
                        <td><input type="radio" name="toilet"></td>
                        <td><input type="radio" name="toilet"></td>
                    </tr>
                    <tr>
                        <td>Do you have feeling of Defecation?</td>
                        <td><input type="radio" name="defecation"></td>
                        <td><input type="radio" name="defecation"></td>
                        <td><input type="radio" name="defecation"></td>
                    </tr>
                 
                    <tr>
                        <td>Do you need Tea / Coffee / other things for Sensation?</td>
                        <td><input type="radio" name="tea" value="yes"></td>
                        <td><input type="radio" name="tea" value="no"></td>
                        <td><input type="radio" name="tea" value="sometimes"></td>
                    </tr>
                </table>
            </div>
           
            <!-- Nature of Stool -->
            <div class="form-group">
    <label>Nature of Stool *</label><br>
    <input type="radio" name="stoolnature" value="Solid"> Solid
    <input type="radio" name="stoolnature" value="Semisolid"> Semisolid
    <input type="radio" name="stoolnature" value="Watery"> Watery
    <input type="radio" name="stoolnature" value="Sticky"> Sticky
    <input type="radio" name="stoolnature" value="Yellowish"> Yellowish
    <input type="radio" name="stoolnature" value="Brownish"> Brownish
    <input type="radio" name="stoolnature" value="Dark Yellowish"> Dark Yellowish
    <input type="radio" name="stoolnature" value="Greenish"> Greenish
    <input type="radio" name="stoolnature" value="With Blood"> With Blood
</div>
           
            <!-- Urine Frequency -->
<div class="form-group">
    <label>Urine Frequency *</label><br>
    <input type="radio" name="urine" value="2-3"> 2-3 times in 24 Hrs.<br>
    <input type="radio" name="urine" value="4-6"> 4-6 times in 24 Hrs.<br>
    <input type="radio" name="urine" value="more_8"> More than 8 times in 24 Hrs.<br>
    <input type="radio" name="urine" value="day_only"> More in day time & not during night.<br>
    <input type="radio" name="urine" value="sometimes_night"> Sometimes during night also.<br>
    <input type="radio" name="urine" value="always_night"> Always during Night also<br>
    <input type="radio" name="urine" value="other"> Other<br>
</div>
           
           <!-- Sweating -->
    <div class="form-group">
        <label>Sweating / Perspiration *</label>
        <select  class="select-box" name="sweating" required>
            <option value="">Please Select</option>
            <option value="Excessive">Excessive</option>
            <option value="Normal">Normal</option>
            <option value="Less">Less</option>
        </select>
    </div>
           
             <!-- Sleep -->
    <div class="form-group">
        <label>About Your Sleep *</label><br>
        <input type="radio" name="sleep" value="Sound sleep in Night"> Sound sleep in Night
        <input type="radio" name="sleep" value="Breaking Sleep"> Breaking Sleep
        <input type="radio" name="sleep" value="Other"> Other
    </div>
           
           <!-- Afternoon Sleep -->
    <div class="form-group">
        <label>Do you have afternoon sleep after lunch? *</label><br>
        <input type="radio" name="afternoon_sleep" value="Yes"> Yes
        <input type="radio" name="afternoon_sleep" value="No"> No
        <input type="radio" name="afternoon_sleep" value="Sometimes"> Sometimes
    </div>
           
            <!-- Stress Level -->
            <div class="form-group">
                <label>Stress Level *</label><br>
                <div style="display: flex; gap: 10px;">
                    <div class="stress-circle">1</div>
                    <div class="stress-circle">2</div>
                    <div class="stress-circle">3</div>
                    <div class="stress-circle">4</div>
                    <div class="stress-circle">5</div>
                    <div class="stress-circle">6</div>
                    <div class="stress-circle">7</div>
                    <div class="stress-circle">8</div>
                    <div class="stress-circle">9</div>
                    <div class="stress-circle">10</div>
                </div>
                  <input type="number" name="stress_level" min="1" max="10" required>
   
            </div>
        </div>

        <!-- Gynaecology - Fields for Female Patients Only -->
        <div class="section-header" onclick="toggleSection('Gynaecology', 'arrow5')">
            <span>Gynaecology - Fields for Female Patients Only</span>
            <span id="arrow5">?</span>
        </div>
       
        <div class="form-content" id="Gynaecology">
           <div class="form-group">
        <h3 class="font-bold">Your Menstrual Cycle</h3>
        <label><input type="radio" name="menstrual_cycle" value="3 Days / After 28 Days" required> 3 Days / After 28 Days</label><br>
        <label><input type="radio" name="menstrual_cycle" value="Less than 3 Days / After 28 Days"> Less than 3 Days / After 28 Days</label><br>
        <label><input type="radio" name="menstrual_cycle" value="4-6 Days / After 28 Days"> 4-6 Days / After 28 Days</label><br>
        <label><input type="radio" name="menstrual_cycle" value="3-5 Days / After more than 30 days"> 3-5 Days / After more than 30 days</label><br>
        <label><input type="radio" name="menstrual_cycle" value="3-5 Days / Before 28 Days"> 3-5 Days / Before 28 Days</label><br>
        <label><input type="radio" name="menstrual_cycle" value="Other"> Other</label><br>
    </div>

            <h3 class="font-bold mt-4">Complaints During / Before / After Menstruation</h3>
            <textarea class="border w-full p-2 rounded" name="complaints2" rows="3"></textarea>

            <h3 class="font-bold mt-4">Obstetric History</h3>
            <textarea class="border w-full p-2 rounded" name="obstetric_history" rows="3"></textarea>

            <h3 class="font-bold mt-4">Any history of abortion / miscarriage?</h3>
            <label><input type="radio" name="abortion_history" onclick="toggleAbortionCount(true)"> Yes</label>
            <label><input type="radio" name="abortion_history" onclick="toggleAbortionCount(false)"> No</label>

            <div id="abortionCount" class="hidden mt-2">
                <h3 class="font-bold">How many times?</h3>
                <div class="flex items-center space-x-2">
                    <button type="button" onclick="decreaseCount()" class="bg-red-500 text-white px-3 py-1 rounded">-</button>
                    <span id="count" class="text-lg font-bold">0</span>
                    <button type="button" onclick="increaseCount()" class="bg-green-500 text-white px-3 py-1 rounded">+</button>
                </div>
                   <input type="hidden" name="abortion_count" id="abortion_count" value="0">
   
            </div>
        </div>

        <!-- Finalize your submission -->
        <div class="section-header" onclick="toggleSection('finalizeSection', 'arrowFinalize')">
            <span>Finalize your Submission</span>
            <span id="arrowFinalize">?</span>
        </div>
       
        <div class="form-content" id="finalizeSection">
            <h3 class="font-bold">Did you take ayurvedic medicines for this / other illness?</h3>
            <label><input type="radio" name="ayurvedic_medicine" onclick="toggleMedicineDetails(true)"> Yes</label>
            <label><input type="radio" name="ayurvedic_medicine" onclick="toggleMedicineDetails(false)"> No</label>
           
            <div id="medicineDetails" class="hidden mt-2">
                <h3 class="font-bold">If yes, give details with medicines</h3>
                <textarea class="border w-full p-2 rounded" name="medicine_detail"  rows="3"></textarea>
            </div>

         
            <div class="captcha-container">
                <label for="captchaInput">Type the word as shown in the image *</label>
                <div id="captcha" class="captcha-box"></div>
                <button type="button" class="refresh-button" onclick="generateCaptcha()">? Refresh</button>
                <input type="text" id="captchaInput"  class="input-box" placeholder="Enter CAPTCHA" required>
                <button type="button"  class="submit-btn" onclick="validateForm()">Submit</button>
                <p id="captchaMessage"></p>
            </div>
           
        </div>
         <div>
             <table>
                  <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="SUBMIT" name="btnSubmit" />
                    <input type="reset" value="RESET" />
                </td>
            </tr>
                </table>
            </div>
    </form>
    <p id="successMessage" class="success-message" style="display:none;"></p>
</div>

<script>
    let captchaText = ""; // Simulated captcha text
    function toggleSection(sectionId, arrowId) {
        let section = document.getElementById(sectionId);
        let arrow = document.getElementById(arrowId);
       
        if (section.style.display === "none" || section.style.display === "") {
            section.style.display = "block";
            arrow.innerHTML = "?";
        } else {
            section.style.display = "none";
            arrow.innerHTML = "?";
        }
    }

    document.querySelectorAll('.stress-circle').forEach(circle => {
        circle.addEventListener('click', function() {
            document.querySelectorAll('.stress-circle').forEach(c => c.classList.remove('selected'));
            this.classList.add('selected');
        });
    });

    function toggleAbortionCount(show) {
        document.getElementById('abortionCount').classList.toggle('hidden', !show);
    }

    function increaseCount() {
        let countElement = document.getElementById('count');
        countElement.innerText = parseInt(countElement.innerText) + 1;
    }

    function decreaseCount() {
        let countElement = document.getElementById('count');
        let currentCount = parseInt(countElement.innerText);
        if ( currentCount > 0) {
            countElement.innerText = currentCount - 1;
        }
    }

    function toggleMedicineDetails(show) {
        document.getElementById('medicineDetails').classList.toggle('hidden', !show);
    }

   function generateCaptcha() {
        const words = ["expert", "verify", "secure", "check", "random", "captcha", "dwuvw", "v2iy1", "76fduq9"];
        captchaText = words[Math.floor(Math.random() * words.length)];
        document.getElementById("captcha").innerText = captchaText;
    }
 

     function validateCaptcha() {
        const userInput = document.getElementById("captchaInput").value;
        const message = document.getElementById("captchaMessage");

        if (userInput.toLowerCase() === captchaText.toLowerCase()) {
            message.innerHTML = "<span style='color:green;'>CAPTCHA verified successfully!</span>";
            return true;
        } else {
            message.innerHTML = "<span style='color:red;'>Incorrect CAPTCHA. Try again.</span>";
            generateCaptcha();
            return false;
        }
    }

    function validateForm() {
        const form = document.getElementById('consultationForm');
        const isCaptchaValid = validateCaptcha();
        const isFormValid = form.checkValidity();
        const errorMessages = form.querySelectorAll('.error-message');

        // Clear previous error messages
        errorMessages.forEach(msg => msg.remove());

        if (isCaptchaValid && isFormValid) {
            document.getElementById('successMessage').innerText = "Form submitted successfully";
            document.getElementById('successMessage').style.display = "block";
        } else {
            // Scroll to the first invalid field and show error message
            for (let element of form.elements) {
                if (!element.checkValidity()) {
                    element.focus();
                    const errorMessage = document.createElement('div');
                    errorMessage.className = 'error-message';
                    errorMessage.innerText = "This field is required";
                    element.parentNode.insertBefore(errorMessage, element.nextSibling);
                    break; // Stop after the first invalid field
                }
            }
            document.getElementById('successMessage').innerText = "";
            document.getElementById('successMessage').style.display = "none";
        }
    }

    window.onload = generateCaptcha;
</script>
<footer class="footer">
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>
</body>
</html>

<%
    if (request.getParameter("btnSubmit") != null) {
         
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");

            // Retrieve form data
            String prefix = request.getParameter("prefix_name");
            String firstName = request.getParameter("firstname");
            String middleName = request.getParameter("middlename");
            String lastName = request.getParameter("lastname");
            String birthdate = request.getParameter("birthdate");
            String gender = request.getParameter("gender");
            String address1 = request.getParameter("address1");
            String address2 = request.getParameter("address2");
            String city = request.getParameter("city");
            String state = request.getParameter("state_province");
            String zip = request.getParameter("zip");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String occupation = request.getParameter("occupation");
            String weight = request.getParameter("weight");
            String complaints = request.getParameter("complaints");
            String factors = request.getParameter("factors");
            String illnessHistory = request.getParameter("illness_history");
            String surgery = request.getParameter("surgery");
            String familyHistory = request.getParameter("family_history");
            String wakeUp = request.getParameter("wakeup");
            String exercise = request.getParameter("exercise");

            String jobType = request.getParameter("jobtype");
           
            String appetite = request.getParameter("appetite");
            String mealTiming = request.getParameter("mealtiming");
            String breakfast = request.getParameter("breakfast");
            String breakfastTiming = request.getParameter("breakfasttiming");
            String hungryBreakfast = request.getParameter("hungrybreakfast");
            String lunchTiming = request.getParameter("lunchtiming");
            String dinnerTiming = request.getParameter("dinnertiming");

            String badHabit = request.getParameter("badhabits");
           

            String foodPreference = request.getParameter("foodpreference");
           
            String badHabitDetails = request.getParameter("badhabitdetails");
            String toilet = request.getParameter("toilet");
            String defecation = request.getParameter("defecation");
            String tea = request.getParameter("tea");
            // Handling multiple selected checkboxes for "Nature of Stool"
            String stoolNature = request.getParameter("stoolnature");
           
            String urineFrequency = request.getParameter("urine");
           
            String sweating = request.getParameter("sweating");
            String sleep = request.getParameter("sleep");
            String afternoonSleep = request.getParameter("afternoon_sleep");
            String stressLevel = request.getParameter("stress_level");

           
            String menstrualCycle = request.getParameter("menstrual_cycle");
            // Handle null values (if user did not select an option)
           
            String complaints2 = request.getParameter("complaints2");
            String obstetricHistory = request.getParameter("obstetric_history");
            String abortionHistory = request.getParameter("abortion_history");
            String abortionCount = request.getParameter("abortion_count");
           String tookMedicine = request.getParameter("ayurvedic_medicine");
            String medicineDetails = request.getParameter("medicine_details");
           
            String sql = "INSERT INTO AV.ONLINE_CONSULTATION (prefix_name, firstname, middlename, lastname, "
                        + "birthdate, gender, address1, address2, city, state_province, zip, phone, email, occupation,"
                        + " weight, complaints, factors, illness_history,surgery, family_history,wakeup, exercise, jobtype, appetite, "
                        + "mealtiming,breakfast, breakfasttiming, hungrybreakfast, lunchtiming, dinnertiming,"
                        + " badhabits,badhabitdetails,foodpreference,toilet, defecation, tea,stoolnature,urine,sweating,"
                        + " sleep, afternoon_sleep, stress_level,menstrual_cycle,complaints2,obstetric_history, abortion_history, "
                        + "abortion_count,ayurvedic_medicine, medicine_details) "
                        + "VALUES (?,?, ?, ?, ?,?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?,?,?,?,?, ?, ?,"
                        + " ?,?,?,?, ?, ?, ?,?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?,?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, prefix);
                pstmt.setString(2, firstName);
                pstmt.setString(3, middleName);
                pstmt.setString(4, lastName);
                pstmt.setString(5, birthdate);
                pstmt.setString(6, gender);
                pstmt.setString(7, address1);
                pstmt.setString(8, address2);
                pstmt.setString(9, city);
                pstmt.setString(10, state);
                pstmt.setString(11, zip);
                pstmt.setString(12, phone);
                pstmt.setString(13, email);
                pstmt.setString(14, occupation);
                pstmt.setString(15, weight);
                pstmt.setString(16, complaints);
                pstmt.setString(17, factors);
                pstmt.setString(18, illnessHistory);
                pstmt.setString(19, surgery);
                pstmt.setString(20, familyHistory);
                pstmt.setString(21, wakeUp);
                pstmt.setString(22, exercise);
                pstmt.setString(23, jobType);
                pstmt.setString(24, appetite);
                pstmt.setString(25, mealTiming);
                pstmt.setString(26, breakfast);
                pstmt.setString(27, breakfastTiming);
                pstmt.setString(28, hungryBreakfast);
                pstmt.setString(29, lunchTiming);
                pstmt.setString(30, dinnerTiming);
                pstmt.setString(31, badHabit);
                pstmt.setString(32, badHabitDetails);
                pstmt.setString(33, foodPreference);

                pstmt.setString(34, toilet);
                pstmt.setString(35, defecation);
                pstmt.setString(36, tea);
                pstmt.setString(37, stoolNature);
                pstmt.setString(38, urineFrequency);
                pstmt.setString(39, sweating);
                pstmt.setString(40, sleep);
                pstmt.setString(41, afternoonSleep);
                pstmt.setInt(42, Integer.parseInt(stressLevel));
                pstmt.setString(43, menstrualCycle);
                pstmt.setString(44, complaints2);
                pstmt.setString(45, obstetricHistory);
                pstmt.setString(46, abortionHistory);
                pstmt.setInt(47, Integer.parseInt(abortionCount));
                pstmt.setString(48, tookMedicine);
                pstmt.setString(49, medicineDetails);
               
             
                int rowsInserted = pstmt.executeUpdate();

                   

            if (rowsInserted > 0) {
                out.println("<script>");
                out.println("alert('Data saved successfully!');");
                out.println("window.location.href = 'screen1.html';"); // Redirect using JavaScript
                out.println("</script>");
            } else {
                out.println("<h3>Error: Unable to submit your request. Please try again.</h3>");
            }
                }
           
           
        catch (Exception e) {
        e.printStackTrace(); // Log the full stack trace
        out.println("Error: " + e.getMessage());
        }
 }
%>