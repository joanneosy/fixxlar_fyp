<%-- 
    Document   : UrgencyRemind_Form
    Created on : Sep 1, 2016, 2:18:37 PM
    Author     : Joanne
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.NotificationDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Reminder</h1>
        <form action="AddNotification" method="post">
            Please select a message: <select name="messageId">
                <option value="0">Customise Message</option>
                <%  
                    int workshopId = Integer.parseInt(request.getParameter("id"));
                    String token = user.getToken();
                    int staffId = user.getStaffId();
                    NotificationDAO nDAO = new NotificationDAO();
                    HashMap<Integer, String> messages = nDAO.retrieveNotificationMessages(staffId, token);
                    Iterator it = messages.entrySet().iterator();
                    while (it.hasNext()) {
                        Map.Entry pair = (Map.Entry) it.next();
                        int messageId = (Integer) pair.getKey();
                        String message = (String) pair.getValue();
                        out.println("<option value=\"" + messageId + "\">" + message + "</option>");
                    }
                %>
            </select><br>
            Customized Message: <input type="text" name="customizedMessage"><br>
            <input type="hidden" name="workshopId" value="<%=workshopId%>">
            <input type="submit" value="Remind"><br>
        </form>
    </body>
</html>
