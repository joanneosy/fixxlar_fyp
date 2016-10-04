<%-- 
    Document   : ChangePassword
    Created on : May 17, 2016, 5:17:18 PM
    Author     : Joanne
--%>

<%@page import="entity.WebUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@include file="ProtectWebUsers.jsp"%>--%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" type="image/ico" href="images/Logo.ico" />
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap-checkbox.css">
        <link rel="stylesheet" href="css/bootstrap-dropdown-multilevel.css">

        <link href="css/minimal.css" rel="stylesheet">
        <title>Change Password</title>
    </head>
    <body class="bg-1">
        <!-- Wrap all page content here -->
        <div id="wrap">
            <!-- Make page fluid -->
            <div class="row">
                <!-- Page content -->
                <div id="content" class="col-md-12 full-page login">


                    <div class="inside-block">
                        <img src="images/Logo.png" alt class="logo">
                        <h1>Change Password</h1>

                        <%                            String errMsg = (String) request.getAttribute("errMsg");
                            if (errMsg != null) {
                                out.println(errMsg);
                            }
                            WebUser user = (WebUser) session.getAttribute("loggedInUser");
//                            String userType = (String) session.getAttribute("loggedInUserType");
                            int userType = user.getUserType();
                            int staffType = user.getStaffType();
                        %>
                        <!--<a href = "ForgotPassword.jsp">Forgot Password</a><br/><br/>
                        <form action = "Authenticate.jsp" method= "post">
                            Email: <input type="email" name="email" required/><br/>
                            Password: <input type="password" name="password" required/><br/>
                            <input type="submit" value="Log In"/>
                        </form><br/>-->


                        <form id="form-signin" class="form-signin" action="ChangePassword" method="post">
                            <section>
                                <div class="input-group">
                                    <input type="password" class="form-control" name="oldPassword" placeholder="Old Password">
                                    <div class="input-group-addon"><i class="fa fa-key"></i></div>
                                </div>
                                <div class="input-group">
                                    <input type="password" class="form-control" name="newPassword" placeholder="New Password">
                                    <div class="input-group-addon"><i class="fa fa-key"></i></div>
                                </div>
                                <div class="input-group">
                                    <input type="password" class="form-control" name="confirmNewPassword" placeholder="Confirm Password">
                                    <div class="input-group-addon"><i class="fa fa-key"></i></div>
                                </div>
                            </section>
                            <section class="log-in">
                                <%
                                    String url = "";
                                    //Workshop
                                    if (userType == 1) {
                                        url = "New_Request.jsp";
                                    }
                                    //Admin
                                    if (userType == 2) {
                                        url = "Admin_Dashboard.jsp";
                                    }
                                    //Valet
                                    if (userType == 4) {
                                        //Master
                                        if (staffType == 1) {
                                            url = "ValetAdminDashboard.jsp";
                                            //Normal
                                        } else {
                                            url = "Valet.jsp";
                                        }
                                    }
                                %>
                                <a href="<%=url%>" class="btn btn-greensea">Home</a>
                                <input type="submit" class="btn btn-greensea" value="Reset Password"/>
                            </section>
                        </form>
                    </div>
                </div>
                <!-- /Page content -->  
            </div>
        </div>
        <!-- Wrap all page content end -->
    </body>
</html>