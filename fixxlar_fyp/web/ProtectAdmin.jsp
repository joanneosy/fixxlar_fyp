<%-- 
    Document   : protectAdmin
    Created on : May 6, 2016, 4:29:42 PM
    Author     : joanne.ong.2014
--%>

<%@page import="entity.WebUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    // check if user is authenticated
    WebUser user = (WebUser) session.getAttribute("loggedInUser");
    String userType = (String) session.getAttribute("loggedInUserType");
    int staffType = user.getStaffType();
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    } else if (userType.equals("Workshop")) {
        response.sendRedirect("New_Request.jsp");
    } else if (userType.equals("Groomer")) {
        response.sendRedirect("Groomer.jsp");
    } 

%>
