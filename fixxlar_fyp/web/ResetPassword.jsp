<%-- 
    Document   : ResetPassword
    Created on : May 17, 2016, 3:12:43 PM
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
        <title>Reset Password</title>
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
       

            <form id="form-signin" class="form-signin" action = "ResetPassword" method= "post">
              <section>
                <div class="input-group">
                  <input type="password" class="form-control" name="password" placeholder="Password" required>
                  <div class="input-group-addon"><i class="fa fa-key"></i></div>
                </div>
                <div class="input-group">
                  <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm Password" required>
                  <div class="input-group-addon"><i class="fa fa-key"></i></div>
                </div>
                  <input type="hidden" name="email" value="<%=request.getAttribute("resetPasswordEmail")%>">
              </section>
              <section class="log-in">
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