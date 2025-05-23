<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Calendar" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Consultation Form</title>
    <style>
       
        body {
      font-family: 'Poppins', sans-serif;
      background: url('images/b5.jpg');
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }
        .container {
            width: 68%;
            margin: auto;
            padding: 30px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 4px solid #000000;
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

   
    label {
      font-weight: bold;
     
    }

   
    .form-group {
      margin-bottom: 15px;
       background: linear-gradient(135deg, #a8e6cf, #dcedc1, #b3e5fc);
    }

   
    .input-box, .textarea-box {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 16px;
      background-color: #f9f9f9; /* Pretty soft shade */
      transition: background-color 0.3s ease;
    }
    .input-box:focus, .textarea-box:focus {
      background-color: #66cdaa;
      outline: none;
    }

   
    .textarea-box {
      height: 60px;
      resize: vertical;
    }

   
    .radio-group {
      display: flex;
      gap: 15px;
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
      background-color: #91eae4;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 16px;
    }
    .select-box:focus {
      background-color: lightgray;
      outline: none;
    }

   
    .section-header {
      display: flex;
      justify-content: space-between;
      cursor: pointer;
      font-weight: bold;
      padding: 10px;
      border: 1px solid #ccc;
       background:  #91eae4;
      border-radius: 5px;
      margin-top: 20px;
    }

   
    .form-content {
      display: none;
      padding: 10px;
      border: 1px solid #bcb88a;
      margin-top: -1px;
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
      background: #fff380;
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

   
    .submit-btn {
      width: 100%;
      padding: 15px;
      font-size: 18px;
      background: linear-gradient(90deg, #4CAF50, #008CBA);
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-weight: bold;
      text-transform: uppercase;
    }
    .submit-btn:hover {
       background: linear-gradient(90deg, #4CAF50, #008CBA);
    }
  </style>
</head>
<body>
 
  <div class="outer-container">
 
    <div class="container">
   
      <div class="form-header">
       
       <img src="images/LOGO.png" alt="AmritaVaidya Logo">
        <h1>CONSULTATION FORM </h1>
      </div>

    <!-- Personal Information Section -->
    <form id="consultationForm">
        <div class="form-group">
            <label>Full Name *</label><br>
            <input type="text" class="input-box" placeholder="Prefix" required>
            <input type="text" class="input-box" placeholder="First Name" required>
            <input type="text" class="input-box" placeholder="Middle Name">
            <input type="text" class="input-box" placeholder="Last Name" required>
        </div>

        <div class="form-group">
            <label for="birthdate">Birth Date *</label><br>
            <input type="date" id="birthdate" class="input-box" required>
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
                <input type="text" class="input-box" placeholder="Street Address" required>
                <input type="text" class="input-box" placeholder="Street Address Line 2">
                <div class="row">
                    <input type="text" class="input-box" placeholder="City" required>
                    <input type="text" class="input-box " placeholder="State / Province" required>
                </div>
                <input type="text" class="input-box" placeholder="Postal / Zip Code" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="tel" class="input-box" placeholder="(000) 000-0000">
            </div>

            <div class="form-group">
                <label>E-mail *</label>
                <input type="email" class="input-box" placeholder="example@example.com" required>
            </div>

            <div class="form-group">
                <label>Occupation *</label>
                <select class="select-box" required>
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
                <input type="text" class="input-box" placeholder="Enter weight in KG" required>
            </div>

            <div class="form-group">
                <label>Main Complaints *</label>
                <textarea class="textarea-box" placeholder="Describe your main complaints" required></textarea>
            </div>

            <div class="form-group">
                <label>Factors - Increasing / Decreasing Symptoms *</label>
                <textarea class="textarea-box" placeholder="Mention factors affecting symptoms" required></textarea>
            </div>

            <div class="form-group">
                <label>Previous Illness History *</label>
                <textarea class="textarea-box" placeholder="Describe previous illnesses" required></textarea>
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
                <textarea class="textarea-box" placeholder="Mention any hereditary conditions" required></textarea>
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
                <input type="radio" name="wakeUp" value="Before Sunrise" required> Before Sunrise
                <input type="radio" name="wakeUp" value="After Sunrise"> After Sunrise
            </div>

            <div class="form-group">
                <label>Exercise? *</label><br>
                <input type="radio" name="exercise" value="Daily" required> Daily
                <input type="radio" name="exercise" value="Sometimes"> Sometimes
                <input type="radio" name="exercise" value="Never"> Never
            </div>

            <div class="form-group">
                <label>Type of Job *</label><br>
                <input type="checkbox" name="jobType" value="Sitting Job"> Sitting Job
                <input type="checkbox" name="jobType" value="Stressful"> Stressful
                <input type="checkbox" name="jobType" value="In hot surrounding"> In hot surrounding
                <input type="checkbox" name="jobType" value="Shift Duty"> Shift Duty
                <input type="checkbox" name="jobType" value="Night Duty"> Night Duty
                <input type="checkbox" name="jobType" value="Travelling Job"> Travelling Job
                <input type="checkbox" name="jobType" value="House Work"> House Work
                <input type="checkbox" name="jobType" value="Continuously in Front of PC/Laptop"> Continuously in Front of PC/Laptop
            </div>

            <div class="form-group">
                <label>Your Appetite? *</label><br>
                <input type="radio"name="appetite" value="Good Appetite" required> Good Appetite
                <input type="radio" name="appetite" value="No feeling of Appetite"> No Feeling of Appetite
                <input type="radio" name="appetite" value="Sometimes Good Sometimes no feeling of Appetite"> Sometimes Good Sometimes no feeling of Appetite
            </div>

            <div class="form-group">
                <label>Timing of Having Meal *</label><br>
                <input type="radio" name="mealTiming" value="Regular" required> Regular
                <input type="radio" name="mealTiming" value="Irregular"> Irregular
                <input type="radio" name="mealTiming" value="Only after feeling of Appetite"> Only after feeling of Appetite
                <input type="radio" name="mealTiming" value="Scheduled as per time"> Scheduled as per time
                <input type="radio" name="mealTiming" value="Other"> Other
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
                <input type="radio" name="breakfastTiming" value="Morning" required> Morning
                <input type="radio" name="breakfastTiming" value="Approx Afternoon time"> Approx Afternoon time
            </div>

            <div class="form-group">
                <label>Do you feel hungry at breakfast? *</label><br>
                <input type="radio" name="hungryBreakfast" value="Yes" required> Yes
                <input type="radio" name="hungryBreakfast" value="No"> No
            </div>
           
            <div class="form-group">
                <label>Timing of LUNCH *</label><br>
                <select class="select-box" name="lunchTiming" required>
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
                <select class="select-box" name="dinnerTiming" required>
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
                <input type="checkbox" name="badHabits" value="Cigarette"> Cigarette
                <input type="checkbox" name="badHabits" value="Tobacco"> Tobacco
                <input type="checkbox" name="badHabits" value="Alcohol"> Alcohol
                <input type="checkbox" name="badHabits" value="Gutkha"> Gutkha
                <input type="checkbox" name="badHabits" value="None"> None
            </div>

            <div class="form-group">
                <label>Details about Bad Habits (Quantity, How Many Times, etc.)</label>
                <textarea class="textarea-box" name="badHabitDetails"></textarea>
            </div>

            <div class="form-group">
                <label>Maximum Consumption of *</label><br>
                <input type="checkbox" name="foodPreference" value="Sweet Food"> Sweet Food
                <input type="checkbox" name="foodPreference" value="Salty Food"> Salty Food
                <input type="checkbox" name="foodPreference" value="Sour Food"> Sour Food
                <input type="checkbox" name="foodPreference" value="Pungent Food"> Pungent Food
                <input type="checkbox" name="foodPreference" value="Stringent Food"> Stringent Food
                <input type="checkbox" name="foodPreference" value="Bitter Food"> Bitter Food
            </div>
        </div>
       
        <!-- Collapsible Daily Routine Section -->
        <div class="section-header" onclick="toggleSection('dailyRoutine', 'arrow4')">
            <span>Daily Routine</span>
            <span id="arrow4">?</span>
        </div>

        <div class="form-content" id="dailyRoutine">
            <div class="form-group">
                <label>Daily Food Chart *</label>
                <table border="1">
                    <tr>
                        <th></th>
                        <th>Daily</th>
                        <th>Weekly</th>
                        <th>Sometime</th>
                        <th>Never</th>
                    </tr>
                    <tr>
                        <td>Hoteling</td>
                        <td><input type="radio" name="hoteling"></td>
                        <td><input type="radio" name="hoteling"></td>
                        <td><input type="radio" name="hoteling"></td>
                        <td><input type="radio" name="hoteling"></td>
                    </tr>
                    <tr>
                        <td>Chinese</td>
                        <td><input type="radio" name="chinese"></td>
                        <td><input type="radio" name="chinese"></td>
                        <td><input type="radio" name="chinese"></td>
                        <td><input type="radio" name="chinese"></td>
                    </tr>
                    <tr>
                        <td>Curd</td>
                        <td><input type="radio" name="curd"></td>
                        <td><input type="radio" name="curd"></td>
                        <td><input type="radio" name="curd"></td>
                        <td><input type="radio" name="curd"></td>
                    </tr>
                    <tr>
                        <td>Pickle</td>
                        <td><input type="radio" name="pickle"></td>
                        <td><input type="radio" name="pickle"></td>
                        <td><input type="radio" name="pickle"></td>
                        <td><input type="radio" name="pickle"></td>
                    </tr>
                    <tr>
                        <td>Papad</td>
                        <td><input type="radio" name="papad"></td>
                        <td><input type="radio" name="papad"></td>
                        <td><input type="radio" name="papad"></td>
                        <td><input type="radio" name="papad"></td>
                    </tr>
                    <tr>
                        <td>Flakes (Poha)</td>
                        <td><input type="radio" name="flakes"></td>
                        <td><input type="radio" name="flakes"></td>
                        <td><input type="radio" name="flakes"></td>
                        <td><input type="radio" name="flakes"></td>
                    </tr>
                    <tr>
                        <td>Fried Food</td>
                        <td><input type="radio" name="friedFood"></td>
                        <td><input type="radio" name="friedFood"></td>
                        <td><input type="radio" name="friedFood"></td>
                        <td><input type="radio" name="friedFood"></td>
                    </tr>
                    <tr>
                        <td>Sprouted Food</td>
                        <td><input type="radio" name="sproutedFood"></td>
                        <td><input type="radio" name="sproutedFood"></td>
                        <td><input type="radio" name="sproutedFood"></td>
                        <td><input type="radio" name="sproutedFood"></td>
                    </tr>
                    <tr>
                        <td>Bakery Products</td>
                        <td><input type="radio" name="bakeryProducts"></td>
                        <td><input type="radio" name="bakeryProducts"></td>
                        <td><input type="radio" name="bakeryProducts"></td>
                        <td><input type="radio" name="bakeryProducts"></td>
                    </tr>
                    <tr>
                        <td>Misal/Vada-paav/Samosa/Kachori etc.</td>
                        <td><input type="radio" name="misal"></td>
                        <td><input type="radio" name="misal"></td>
                        <td><input type="radio" name="misal"></td>
 <td><input type="radio" name="misal"></td>
                    </tr>
                    <tr>
                        <td>Fermented Food (Idli/ Dosa/Uttapa etc.)</td>
                        <td><input type="radio" name="fermentedFood"></td>
                        <td><input type="radio" name="fermentedFood"></td>
                        <td><input type="radio" name="fermentedFood"></td>
                        <td><input type="radio" name="fermentedFood"></td>
                    </tr>
                    <tr>
                        <td>Gram Food (Besan Atta Foods)</td>
                        <td><input type="radio" name="gramFood"></td>
                        <td><input type="radio" name="gramFood"></td>
                        <td><input type="radio" name="gramFood"></td>
                        <td><input type="radio" name="gramFood"></td>
                    </tr>
                    <tr>
                        <td>Bhel / Panipuri / Ragada pattis etc</td>
                        <td><input type="radio" name="bhel"></td>
                        <td><input type="radio" name="bhel"></td>
                        <td><input type="radio" name="bhel"></td>
                        <td><input type="radio" name="bhel"></td>
                    </tr>
                    <tr>
                        <td>Stale Food (Baansi Cheeze)</td>
                        <td><input type="radio" name="staleFood"></td>
                        <td><input type="radio" name="staleFood"></td>
                        <td><input type="radio" name="staleFood"></td>
                        <td><input type="radio" name="staleFood"></td>
                    </tr>
                    <tr>
                        <td>Milk Products</td>
                        <td><input type="radio" name="milkProducts"></td>
                        <td><input type="radio" name="milkProducts"></td>
                        <td><input type="radio" name="milkProducts"></td>
                        <td><input type="radio" name="milkProducts"></td>
                    </tr>
                    <tr>
                        <td>Sago (Saabudaanaa)</td>
                        <td><input type="radio" name="sago"></td>
                        <td><input type="radio" name="sago"></td>
                        <td><input type="radio" name="sago"></td>
                        <td><input type="radio" name="sago"></td>
                    </tr>
                    <tr>
                        <td>Fasting (Langhan / Upvaas)</td>
                        <td><input type="radio" name="fasting"></td>
                        <td><input type="radio" name="fasting"></td>
                        <td><input type="radio" name="fasting"></td>
                        <td><input type="radio" name="fasting"></td>
                    </tr>
                    <tr>
                        <td>Raw Food (Uncooked Food)</td>
                        <td><input type="radio" name="raw"></td>
                        <td><input type="radio" name="raw"></td>
                        <td><input type="radio" name="raw"></td>
                        <td><input type="radio" name="raw"></td>
                    </tr>
                    <tr>
                        <td>Nonveg</td>
                        <td><input type="radio" name="nonveg"></td>
                        <td><input type="radio" name="nonveg"></td>
                        <td><input type="radio" name="nonveg"></td>
                        <td><input type="radio" name="nonveg"></td>
                    </tr>
                </table>
            </div>
           
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
                    ```html
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
                <input type="checkbox"> Solid
                <input type="checkbox"> Semisolid
                <input type="checkbox"> Watery
                <input type="checkbox"> Sticky
                <input type="checkbox"> Yellowish
                <input type="checkbox"> Brownish
                <input type="checkbox"> Dark Yellowish
                <input type="checkbox"> Greenish
                <input type="checkbox"> With Blood
            </div>
           
            <!-- Urine Frequency -->
            <div class="form-group">
                <label>Urine Frequency *</label><br>
                <input type="radio" name="urine"> 2-3 times in 24 Hrs.<br>
                <input type="radio" name="urine"> 4-6 times in 24 Hrs.<br>
                <input type="radio" name="urine"> More than 8 times in 24 Hrs.<br>
                <input type="radio" name="urine"> More in day time & not during night.<br>
                <input type="radio" name="urine"> Sometimes during night also.<br>
                <input type="radio" name="urine"> Always during Night also<br>
                <input type="radio" name="urine"> Other<br>
            </div>
           
            <!-- Sweating / Perspiration -->
            <div class="form-group">
                <label>Sweating / Perspiration *</label>
                <select class="select-box" required>
                    <option value="">Please Select</option>
                    <option>Excessive</option>
                    <option>Normal</option>
                    <option>Less</option>
                </select>
            </div>
           
            <!-- Sleep -->
            <div class="form-group">
                <label>About Your Sleep *</label><br>
                <input type="radio" name="sleep"> Sound sleep in Night
                <input type="radio" name="sleep"> Breaking Sleep
                <input type="radio" name="sleep"> Other
            </div>
           
            <!-- Afternoon Sleep -->
            <div class="form-group">
                <label>Do you have afternoon sleep after lunch? *</label><br>
                <input type="radio" name="afternoon_sleep"> Yes
                <input type="radio" name="afternoon_sleep"> No
                <input type="radio" name="afternoon_sleep"> Sometimes
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
            </div>
        </div>

        <!-- Gynaecology - Fields for Female Patients Only -->
        <div class="section-header" onclick="toggleSection('Gynaecology', 'arrow5')">
            <span>Gynaecology - Fields for Female Patients Only</span>
            <span id="arrow5">?</span>
        </div>
       
        <div class="form-content" id="Gynaecology">
            <h3 class="font-bold">Your Menstrual Cycle</h3>
            <div class="form-group">
                <label><input type="radio" name="menstrual_cycle" required> 3 Days / After 28 Days</label>
                <label><input type="radio" name="menstrual_cycle"> Less than 3 Days / After 28 Days</label>
                <label><input type="radio" name="menstrual_cycle"> 4-6 Days / After 28 Days</label>
                <label><input type="radio" name="menstrual_cycle"> 3-5 Days / After more than  30 days</label>
                <label><input type="radio" name="menstrual_cycle"> 3-5 Days / Before 28 Days</label>
                <label><input type="radio" name="menstrual_cycle"> Other</label>
            </div>

            <h3 class="font-bold mt-4">Complaints During / Before / After Menstruation</h3>
            <textarea class="border w-full p-2 rounded" rows="3"></textarea>

            <h3 class="font-bold mt-4">Obstetric History</h3>
            <textarea class="border w-full p-2 rounded" rows="3"></textarea>

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
                <textarea class="border w-full p-2 rounded" rows="3"></textarea>
            </div>

            <h3 class="font-bold mt-4">Do you have any reports / scanned reports?</h3>
            <input type="file" class="border w-full p-2 rounded">

            <div class="captcha-container">
                <label for="captchaInput">Type the word as shown in the image *</label>
                <div id="captcha" class="captcha-box"></div>
                <button type="button" class="refresh-button" onclick="generateCaptcha()">? Refresh</button>
                <input type="text" id="captchaInput" class="input-box" placeholder="Enter CAPTCHA" required>
                <button type="button" class="submit-btn" onclick="validateForm()">Submit</button>
                <p id="captchaMessage"></p>
            </div>
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

</body>
</html>
