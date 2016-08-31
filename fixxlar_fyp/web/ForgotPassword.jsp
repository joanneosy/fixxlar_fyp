<%-- 
    Document   : ForgotPassword
    Created on : May 13, 2016, 9:12:35 AM
    Author     : Joanne
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Forgot Password</title>
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
                        <h1>Reset Password</h1>

                        <%
                            String errMsg = (String) request.getAttribute("errMsg");
                            if (errMsg != null) {
                                out.println(errMsg);
                            }
                        %>
                        <!--<a href = "ForgotPassword.jsp">Forgot Password</a><br/><br/>
                        <form action = "Authenticate.jsp" method= "post">
                            Email: <input type="email" name="email" required/><br/>
                            Password: <input type="password" name="password" required/><br/>
                            <input type="submit" value="Log In"/>
                        </form><br/>-->


                        <form id="form-signin" class="form-signin" action = "ForgotPassword" method= "post">
                            <section>
                                <div class="input-group">
                                    <input type="email" class="form-control" name="email" placeholder="email@domain.com">
                                    <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                </div>
                            </section>
                            <section class="log-in">
                                <a href="Login.jsp" class="btn btn-greensea">Back</a>
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
