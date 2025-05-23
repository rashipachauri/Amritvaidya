<%--
    Document   : patientrec
    Created on : Feb 26, 2025, 10:01:46 PM
    Author     : HP
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Patients List</title>
        <style>
          body {
    font-family: 'Arial', sans-serif;
    background-color: white; /* Light blue background */
    margin: 0;
    padding: 20px;
   
   
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
h2 {
    text-align: center;
    color: #26547c;
    font-size: 34px;
    font-weight: bold;
    margin-bottom: 20px;
    text-transform: uppercase;
    letter-spacing: 1px;
    background: linear-gradient(to right, #06d6a0, #26547c);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

table {
    width: 90%;
    margin: auto;
    border-collapse: collapse;
    background: white;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    border-radius: 8px;
    overflow: hidden;
}

th, td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: center;
    font-size: 16px;
}

th {
    background-color:  #26547c; /* Bright greenish-blue */
    color: white;
    text-transform: uppercase;
    letter-spacing: 1px;
}

tr:nth-child(even) {
    background-color: #f1f9ff; /* Very light blue */
}

tr:hover {
    background-color: #d0efff; /* Slightly darker light blue */
    transition: 0.3s;
}

.btn {
    padding: 8px 15px;
    margin: 5px;
    border: none;
    cursor: pointer;
    border-radius: 6px;
    font-size: 14px;
    font-weight: bold;
    transition: background-color 0.3s, transform 0.2s;
}

.update-btn {
    background-color:  #06d6a0; /* Deep blue */
    color: white;
}

.update-btn:hover {
    background-color: #1b3c5a;
    transform: scale(1.05);
}

dele-btn {
    background-color: #f44336; /* Red */
    color: white;
}

.delete-btn:hover {
    background-color: #f44336;
    transform: scale(1.05);
}
.footer {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    background: linear-gradient(to right, #b2fefa, #0ed2f7);
    padding: 20px 15px;
    text-align: center;
    color: white;
    font-size: 15px;
    font-weight: bold;
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

        <h2>List of Patients</h2>
        <table>
            <tr>
                <th>Username</th>
                <th>Name</th>
                <th>Blood Group</th>
                <th>Gender</th>
                <th>DOB</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Update</th>
                <th>Delete</th>
            </tr>
            <footer class="footer">
       
    <p>© 2025 Amritavaidya. All Rights Reserved.</p>
</footer>


            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Amritavaidya", "av", "av");
                    stmt = conn.createStatement();

                    String query = "SELECT * FROM AV.PATIENT";
                    rs = stmt.executeQuery(query);
                    while (rs.next()) {
                        String username = rs.getString("USERNAME"); // Unique identifier
            %>
            <tr>
                <td><%= username %></td>
                <td><%= rs.getString("NAME") %></td>
                <td><%= rs.getString("BLOODGROUP") %></td>
                <td><%= rs.getString("GENDER") %></td>
                <td><%= rs.getString("DOB") %></td>
                <td><%= rs.getString("EMAIL") %></td>
                <td><%= rs.getString("CONTACTNUM") %></td>
               
                <!-- Update Button -->
                <td>
                    <form action="updatepatient.jsp" method="get">
                        <input type="hidden" name="username" value="<%= username %>">
                        <input type="submit" value="Update" class="btn update-btn">
                    </form>
                </td>
               
                <!-- Delete Button -->
                <td>
                    <form action="deletePatient.jsp" method="post">
                        <input type="hidden" name="username" value="<%= username %>">
                        <input type="submit" value="Delete" class="btn delete-btn" onclick="return confirm('Are you sure you want to delete this record?');">
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
    </body>
</html>