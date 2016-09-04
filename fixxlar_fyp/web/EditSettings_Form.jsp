<%-- 
    Document   : EditUrgency_Form
    Created on : Sep 3, 2016, 1:35:02 PM
    Author     : Joanne
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="util.Settings"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Settings</h1>
        <%      
            ArrayList<String> msg = (ArrayList<String>) session.getAttribute("fail");
            if (msg != null && msg.size() > 0) {
                for (String s: msg) {
                    out.println(s + "<br>");
                }
                session.removeAttribute("fail");
            }

            String success = (String) session.getAttribute("success");
            if (success != null && success.length() != 0) {
                out.println(success);
                session.removeAttribute("success");
            }
        %>
        <form action="EditSettings" method="post">
            <%             

                String token = user.getToken();
                int staffId = user.getStaffId();
                Settings settings = new Settings();
                HashMap<String, JsonObject> messages = settings.retrieveAllSettings(staffId, token);
                Iterator it = messages.entrySet().iterator();
                while (it.hasNext()) {
                    Map.Entry pair = (Map.Entry) it.next();
                    String setting = (String) pair.getKey();
                    String[] arr = setting.split(",");
                    int settingId = Integer.parseInt(arr[0]);
                    String settingName = arr[1];
                    JsonObject value = (JsonObject) pair.getValue();
                    out.println(settingName + "<br>");
                    Set<Entry<String, JsonElement>> entrySet = value.entrySet();
                    for (Map.Entry<String, JsonElement> entry : entrySet) {
                        out.println(entry.getKey() + ": ");
                        out.println("<input type=\"text\" name=\"" + settingName + "," + entry.getKey() + "\" value = " + entry.getValue().getAsInt() + "><br>");
                    }
                }


            %>
            <br>
            <input type="submit" value="Edit"><br>
        </form>
    </body>
</html>
