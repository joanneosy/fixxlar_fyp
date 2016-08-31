<%-- 
    Document   : logout
    Created on : May 6, 2016, 4:36:13 PM
    Author     : joanne.ong.2014
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.invalidate();
    response.sendRedirect("Login.jsp");
%>
