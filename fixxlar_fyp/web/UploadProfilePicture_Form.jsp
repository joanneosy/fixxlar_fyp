<%-- 
    Document   : UploadProfilePicture_Form
    Created on : Nov 11, 2016, 2:45:08 PM
    Author     : Joanne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Upload profile pic yo!</h1>
        <%

            String errMsg = (String) session.getAttribute("isSuccess");
            if (errMsg != null && errMsg.length() > 0) {
                out.println(errMsg);
                session.removeAttribute("isSuccess");
            }
        %>
        <form action="UploadProfilePicture" method="post" enctype="multipart/form-data">
            Photo: <input type="file" name="file" required/><br/>
            <input type="submit" value="Update Profile Picture" /> 
        </form>
    </body>
</html>
