<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Patient</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 0px;
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


        form {
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
    display: inline-block;
    text-align: left;
    width: 900px;
    animation: fadeIn 0.5s ease-in-out;
}
h2 {
    font-size: 42px;
    font-weight: bold;
    text-align: center;
    color: #26547c; /* Deep blue */
    text-transform: uppercase;
    letter-spacing: 2px;
    position: relative;
    padding-bottom: 15px;
    margin-bottom: 20px;
    font-family: "Poppins", sans-serif;
    background: linear-gradient(135deg, #06d6a0, #26547c);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

h2::after {
    content: "";
    width: 80px;
    height: 4px;
    background: linear-gradient(to right, #06d6a0, #26547c);
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    border-radius: 2px;
}


input, select {
    width: 100%;
    padding: 12px;
    margin: 12px 0;
    border: 2px solid #06d6a0;
    border-radius: 6px;
    font-size: 16px;
    transition: all 0.3s ease;
}

input:focus, select:focus {
    border-color: #26547c;
    box-shadow: 0 0 8px rgba(38, 84, 124, 0.3);
    outline: none;
}

input[disabled] {
    background-color: #e9e9e9;
    cursor: not-allowed;
}

.btn {
    background: linear-gradient(135deg, #06d6a0, #26547c);
    color: white;
    padding: 12px;
    border: none;
    cursor: pointer;
    width: 100%;
    border-radius: 6px;
    font-size: 18px;
    font-weight: bold;
    text-transform: uppercase;
    transition: all 0.3s ease-in-out;
}

.btn:hover {
    background: linear-gradient(135deg, #26547c, #06d6a0);
    transform: scale(1.05);
    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
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

       

<h2>Update Patient Details</h2>

<%
    String username = request.getParameter("username");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");
        String query = "SELECT * FROM AV.PATIENT WHERE USERNAME=?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next()) {
%>
        <form action="updatePatientProcess.jsp" method="post">
            <input type="hidden" name="username" value="<%= rs.getString("USERNAME") %>">
           
            <label>Name:</label>
            <input type="text" name="name" value="<%= rs.getString("NAME") %>" disabled>

            <label>Blood Group:</label>
            <select name="bloodgroup" required>
                <option value="A+" <%= rs.getString("BLOODGROUP").equals("A+") ? "selected" : "" %>>A+</option>
                <option value="A-" <%= rs.getString("BLOODGROUP").equals("A-") ? "selected" : "" %>>A-</option>
                <option value="B+" <%= rs.getString("BLOODGROUP").equals("B+") ? "selected" : "" %>>B+</option>
                <option value="B-" <%= rs.getString("BLOODGROUP").equals("B-") ? "selected" : "" %>>B-</option>
                <option value="AB+" <%= rs.getString("BLOODGROUP").equals("AB+") ? "selected" : "" %>>AB+</option>
                <option value="AB-" <%= rs.getString("BLOODGROUP").equals("AB-") ? "selected" : "" %>>AB-</option>
                <option value="O+" <%= rs.getString("BLOODGROUP").equals("O+") ? "selected" : "" %>>O+</option>
                <option value="O-" <%= rs.getString("BLOODGROUP").equals("O-") ? "selected" : "" %>>O-</option>
            </select>

            <label>Gender:</label>
            <input type="text" name="gender" value="<%= rs.getString("GENDER") %>" disabled>
           
            <label>DOB:</label>
            <input type="date" name="dob" value="<%= rs.getString("DOB") %>" disabled>
           
            <label>Email:</label>
            <input type="email" name="email" value="<%= rs.getString("EMAIL") %>" required>
           
            <label>Contact:</label>
            <input type="text" name="contact" value="<%= rs.getString("CONTACTNUM") %>" required>

            <input type="submit" value="Update" class="btn">
        </form>
            <footer class="footer">
       
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>

<%
        } else {
            out.println("<p>Patient not found!</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

</body>
</html>
