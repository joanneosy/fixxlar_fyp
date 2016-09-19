<%-- 
    Document   : protect
    Created on : May 5, 2016, 9:39:58 AM
    Author     : joanne.ong.2014
--%>

<%@page import="entity.WebUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    // check if user is authenticated
    
    WebUser user = (WebUser) session.getAttribute("loggedInUser");
    String userType = (String)session.getAttribute("loggedInUserType");
    int staffType = user.getStaffType();
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    } else if (userType.equals("Admin")) {
        response.sendRedirect("Admin_Dashboard.jsp");
    } else if (userType.equals("Groomer")) {
        response.sendRedirect("Groomer.jsp");
    } else if (userType.equals("Workshop")) {
        response.sendRedirect("New_Request.jsp");
    } else if (userType.equals("Valet") && staffType == 2) {
        response.sendRedirect("Valet.jsp");
    }
           

%>


