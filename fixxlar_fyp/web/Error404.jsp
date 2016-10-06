<%@page import="entity.WebUser"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fixir - Page 404</title>
        <jsp:include page="include/head.jsp"/>
    </head>
    <body class="bg-1">

        <!-- Wrap all page content here -->
        <div id="wrap">

            <!-- Make page fluid -->
            <div class="row">

                <!-- Page content -->
                <div id="content" class="col-md-12 full-page error">

                    <div class="inside-block">

                        <img src="images/Logo.png" alt class="logo">

                        <h1 class="error">Error <strong>404</strong></h1>
                        <p class="lead"><span class="overline">something's</span> not right here</p>
                        <p>the page you are looking for cannot be found</p>
                        <%
                            WebUser user = (WebUser) session.getAttribute("loggedInUser");
                            String url = "Login.jsp";
                                                        //Workshop
                            if (user != null) {
                            int userType = user.getUserType();
                                int staffType = user.getStaffType();
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
                            }
                        %>
                        <div class="controls">
                            <a href="#" class="btn btn-cyan"><i class="fa fa-refresh"></i> Try Again</a>
                            <a href="<%=url%>" class="btn btn-greensea"><i class="fa fa-home"></i> Return to home</a>
                            <!--<button class="btn btn-greensea"><i class="fa fa-home"></i> Return to home</button>-->
                            <a href="mailto:Admin@fixir.co?Subject=Fixir%20Support" target="_top" class="btn btn-red"><i class="fa fa-envelope"></i> Contact Support</a>
                        </div>

                    </div>


                </div>
                <!-- /Page content -->  

            </div>

        </div>
        <!-- Wrap all page content end -->

    </body>
</html>
