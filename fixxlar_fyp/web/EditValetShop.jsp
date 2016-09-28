<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="dao.ValetShopDAO"%>
<%@page import="entity.ValetShop"%>
<%@page import="dao.ValetShopDAO"%>
<%@page import="java.util.Arrays"%>
<%@page import="entity.Workshop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.WorkshopDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Settings</title>
        <jsp:include page="include/head.jsp"/>

    </head>
    <body class="bg-3">
        <!-- Wrap all page content here -->
        <div id="wrap">
            <!-- Make page fluid -->
            <div class="row">
                <div class="mask"><div id="loader"></div></div>
                <!-- Page content -->
                <div id="content" class="col-md-12">

                    <%--<jsp:include page="include/topbar.jsp"/>--%>
                    <%@include file="include/topbar.jsp"%>
                    <!-- page header -->
                    <div class="pageheader">
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Edit Valet Shop</h2>
                        <!--<a href="AddWorshop.jsp" class="btn btn-primary btn-lg pull-right margin-top-15"  role="button">Submit</a>-->
                    </div>
                    <!-- /page header -->
                    <!-- content main container -->
                    <div class="main">
                        <div class="row">

                            <!-- col 12 -->
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <!-- tile -->
                                    <section class="tile color transparent-black">
                                        <!-- tile header -->
                                        <div class="tile-header">
                                            <h1><strong>Edit</strong> Valet Shop</h1>
                                        </div>
                                        <!-- /tile header -->
                                        <div class="tile-body">
                                            <%
                                                ValetShopDAO vDAO = new ValetShopDAO();
                                                int valetId = Integer.parseInt(request.getParameter("id"));
                                                ValetShop valet = vDAO.retrieveValetShop(user.getStaffId(), user.getToken(), valetId);

                                                String name = valet.getName();
                                                if (name == null || name.equals("null")) {
                                                    name = "";
                                                }

                                                String vAddress = valet.getAddress();
                                                String address = "";
                                                String postalCode = "";
                                                if (vAddress != null && !(vAddress.equals(""))) {
                                                    address = vAddress.substring(0, vAddress.lastIndexOf(" "));
                                                    postalCode = vAddress.substring(vAddress.lastIndexOf(" ") + 1);
                                                }
                                                String email = valet.getEmail();
                                                if (email == null || email.equals("null")) {
                                                    email = "";
                                                }
                                                double revenueShare = valet.getRevenueShare();

                                                int noEmployees = valet.getNoOfEmployees();

                                                String openingHour = valet.getOpeningHours();
                                                String[] daysAndTime = null;

                                                if (openingHour == null || openingHour.equals("null")) {
                                                    openingHour = "";
                                                } else {
                                                    //Each string in this format: Monday-0900-1800
                                                    daysAndTime = openingHour.split(",");
                                                }
                                            %>
                                            <%
                                                ArrayList<String> msg = (ArrayList<String>) request.getAttribute("fail");
                                                if (msg != null && msg.size() > 0) {
                                            %>
                                            <div class="alert alert-danger">
                                                <ul>
                                                    <%
                                                        for (String error : msg) {
                                                    %>
                                                    <li><%=error%></li>
                                                        <%
                                                            }
                                                        %>
                                                </ul>
                                            </div>
                                            <%
                                                }
                                            %>
                                            <form class="form-horizontal" role="form" action="EditValetServlet" method="POST">

                                                <div class="form-group">
                                                    <label for="input01" class="col-sm-2 control-label">Valet Name</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" name="name" value="<%=name%>" />
                                                    </div>

                                                    <label for="input02" class="col-sm-2 control-label">Address</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="input02" name="address" value="<%=address%>">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Postal Code</label>
                                                    <div class="col-sm-4">
                                                        <input type="number" class="form-control" id="input03" name="postalCode" value="<%=postalCode%>">
                                                    </div>

                                                    <label for="input04" class="col-sm-2 control-label">Email</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="input04" name="email" value="<%=email%>">
                                                    </div>


                                                </div>

                                                <div class="form-group">
                                                    <label for="input05" class="col-sm-2 control-label">No Employees</label>
                                                    <div class="col-sm-4">
                                                        <input type="number" class="form-control" id="input05" name="noEmployees" value="<%=noEmployees%>">
                                                    </div>

                                                    <label for="input06" class="col-sm-2 control-label">Revenue Share</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="input06" name="revenueShare" value="<%=revenueShare%>">
                                                    </div>
                                                </div>

                                                <input type="hidden" class="form-control" value="<%=valetId%>" name="id">

                                                <div class="form-group">
                                                    <h3><label class="col-sm-6">Operating Hours (Open - Close)</label></h3>
                                                </div>   

                                                <%                                                    //create hours arraylist
                                                    //iterate through every day for operating hours fields
                                                    ArrayList<String> hours = new ArrayList<String>();
                                                    hours.add("Closed");
                                                    hours.add("0000");
                                                    hours.add("0100");
                                                    hours.add("0200");
                                                    hours.add("0300");
                                                    hours.add("0400");
                                                    hours.add("0500");
                                                    hours.add("0600");
                                                    hours.add("0700");
                                                    hours.add("0800");
                                                    hours.add("0900");
                                                    hours.add("1000");
                                                    hours.add("1100");
                                                    hours.add("1200");
                                                    hours.add("1300");
                                                    hours.add("1400");
                                                    hours.add("1500");
                                                    hours.add("1600");
                                                    hours.add("1700");
                                                    hours.add("1800");
                                                    hours.add("1900");
                                                    hours.add("2000");
                                                    hours.add("2100");
                                                    hours.add("2200");
                                                    hours.add("2300");

                                                    int label = 11;
                                                %>
                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Monday</label>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="mondayOpen">
                                                            <%                                                                //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
                                                                String[] openCloseTimings = daysAndTime[0].split("-");
                                                                for (int i = 0; i < hours.size(); i++) {
                                                                    String hour = hours.get(i);
                                                                    if (openCloseTimings[1].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }
                                                            %>
                                                        </select>

                                                    </div>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="mondayClose">
                                                            <%
                                                                for (int i = 0; i < hours.size(); i++) {
                                                                    String hour = hours.get(i);
                                                                    if (openCloseTimings[2].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }
                                                            %>


                                                        </select>
                                                    </div>
                                                </div>  

                                                <%
                                                    ArrayList<String> days = new ArrayList<String>();
                                                    days.add("Monday");
                                                    days.add("Tuesday");
                                                    days.add("Wednesday");
                                                    days.add("Thursday");
                                                    days.add("Friday");
                                                    days.add("Saturday");
                                                    days.add("Sunday");
                                                    days.add("Holiday");
                                                    days.add("Holiday Eve");

                                                    ArrayList<String> paramList = new ArrayList<String>();
//                                                    paramList.add("mondayOpen");
//                                                    paramList.add("mondayClose");
                                                    paramList.add("tuesdayOpen");
                                                    paramList.add("tuesdayClose");
                                                    paramList.add("wednesdayOpen");
                                                    paramList.add("wednesdayClose");
                                                    paramList.add("thursdayOpen");
                                                    paramList.add("thursdayClose");
                                                    paramList.add("fridayOpen");
                                                    paramList.add("fridayClose");
                                                    paramList.add("saturdayOpen");
                                                    paramList.add("saturdayClose");
                                                    paramList.add("sundayOpen");
                                                    paramList.add("sundayClose");
                                                    paramList.add("phOpen");
                                                    paramList.add("phClose");
                                                    paramList.add("phEveOpen");
                                                    paramList.add("phEveClose");
                                                    int z = 0;
                                                    for (int i = 1; i < days.size(); i++) {
                                                %>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label"><%=days.get(i)%></label>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" name="<%=paramList.get(z)%>">
                                                            <%
                                                                z++;
                                                                //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
                                                                openCloseTimings = daysAndTime[i].split("-");
                                                                for (int j = 0; j < hours.size(); j++) {
                                                                    String hour = hours.get(j);
                                                                    if (openCloseTimings[1].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" name="<%=paramList.get(z)%>">
                                                            <%
                                                                z++;
                                                                for (int j = 0; j < hours.size(); j++) {
                                                                    String hour = hours.get(j);
                                                                    if (openCloseTimings[2].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </div>  

                                                <%                                                    }//end of for loop for operating days
                                                %>
                                                <div class="form-group form-footer">
                                                    <div class="col-sm-offset-5 col-sm-8">
                                                        <button type="submit" class="btn btn-primary">Submit</button>
                                                        <button type="reset" class="btn btn-default">Reset</button>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                        <!--End of Tile Body-->
                                    </section>
                                    <!-- /tile body -->

                                    <!-- tile -->

                                </div>
                                <!--End of first col 6-->

                            </div>

                        </div>
                        <!--end of col-->
                    </div>
                    <!-- row end-->
                </div>
                <!-- content main container end-->
            </div>
            <!-- Page content end-->
        </div>
        <!-- Make page fluid end-->

        <!-- Wrap all page content end -->

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/bootstrap-dropdown-multilevel.js"></script>
        <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
        <script type="text/javascript" src="js/jquery.mmenu.min.js"></script>
        <script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
        <script type="text/javascript" src="js/jquery.nicescroll.min.js"></script>
        <script type="text/javascript" src="js/jquery.blockUI.js"></script>

        <script type="text/javascript" src="js/ColReorderWithResize.js"></script>
        <script type="text/javascript" src="js/chosen.jquery.min.js"></script>
        <script src="js/minimal.min.js"></script>



        <!--Form Error Handling-->
        <script>
            $(function () {
                $("#workshopForm").submit(function () {
                    var inputVal = $("#inputExample").val();
                    $(document).trigger("clear-alert-id.example");
                    if (inputVal.length < 1) {
                        $(document).trigger("set-alert-id-example", [
                            {
                                message: "Please enter the workshop name",
                                priority: "error"
                            },
                        ]);
                    }
                });
            });



        </script>
    </body>
</html>
