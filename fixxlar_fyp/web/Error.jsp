<%@page import="entity.WebUser"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fixir - Page 500</title>
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

                        <h1 class="error">Error <strong>500</strong></h1>
                        <p class="lead"><span class="overline">Whoops</span>, a real big error here!</p>
                        <p>our code is broken :-(</p>

                        <div class="controls">
                            <%
                                WebUser user = (WebUser) session.getAttribute("loggedInUser");
                                int userType = user.getUserType();
                                int staffType = user.getStaffType();
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
