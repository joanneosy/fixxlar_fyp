<%@page import="entity.WebUser"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Minimal 1.3 - Page Offline</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8" />

        <link rel="icon" type="image/ico" href="images/Logo.ico" />
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap-checkbox.css">
        <link rel="stylesheet" href="css/bootstrap-dropdown-multilevel.css">

        <link href="css/minimal.css" rel="stylesheet">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="bg-1">
        <%
            WebUser user = (WebUser) session.getAttribute("loggedInUser");
            String userType = (String) session.getAttribute("loggedInUserType");
            int staffType = user.getStaffType();
        %>

        <!-- Wrap all page content here -->
        <div id="wrap">

            <!-- Make page fluid -->
            <div class="row">

                <!-- Page content -->
                <div id="content" class="col-md-12 full-page error">




                    <div class="inside-block">

                        <img src="images/Logo.png" alt class="logo">

                        <h1 class="error">THE GENERAL <strong>SHUTDOWN</strong></h1>
                        <p class="lead bold"><span class="overline">Maintanance</span> or not? Doesn't matter we are up in a second, we have our coffee already!</p>
                        <p>relax and try it later</p>

                        <div class="controls">
                            <!--<button class="btn btn-cyan"><i class="fa fa-refresh"></i> Try Again</button>-->
                            <%
                                if (userType.equals("Admin")) {
                            %>
                            <a href="Admin_New_Request.jsp" class="btn btn-greensea"><i class="fa fa-home"></i> Return to home</a>
                            <%
                            } else if (userType.equals("Workshop")) {
                            %>
                            <a href="New_Request.jsp" class="btn btn-greensea"><i class="fa fa-home"></i> Return to home</a>
                            <%
                            } else {
                                if (staffType == 1) {
                            %>
                            <a href="Valet_Dashboard.jsp" class="btn btn-greensea"><i class="fa fa-home"></i> Return to home</a>
                            <%
                            } else {
                            %>
                            <a href="Valet.jsp" class="btn btn-greensea"><i class="fa fa-home"></i> Return to home</a>
                            <%
                                    }
                                }
                            %>
                            <!--<button class="btn btn-red"><i class="fa fa-envelope"></i> Contact Support</button>-->
                        </div>

                    </div>


                </div>
                <!-- /Page content --> 

            </div> 

        </div>
        <!-- Wrap all page content end -->
    </body>
</html>
