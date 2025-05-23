
<%@page contentType ="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv = "Content-Type" content=" text/html; charset=UTF-8 " >
        <title > Home Page </title>
    </head>
    <body bgcolor='pink'>
        <form name='f1'>
            <table>
                <tr>
                    <td colspan='12' align='centre' > 
                        AMRITAVAIDYA
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" value="Sign-In" name="btnLogin" />
                       <input type="submit" value="Sign-up" name="btnsign" />
                   
                    </td>
                   
                </tr>
               
              
            </table>
        </form>
    </body>
</html>
<%
    if (request.getParameter("btnLogin") != null) {
        try {
            response.sendRedirect("login.jsp");
          
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }
    if (request.getParameter("btnsign") != null) {
        try {
            response.sendRedirect("roleSelection.jsp");
  
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }
%>
