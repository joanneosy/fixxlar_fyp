<%-- 
    Document   : View Request
    Created on : May 5, 2016, 10:00:14 AM
    Author     : joanne.ong.2014
--%>


<%@page import="entity.ValetRequest"%>
<%@page import="entity.ValetShop"%>
<%@page import="dao.ValetShopDAO"%>
<%@page import="dao.ValetRequestDAO"%>
<%@page import="entity.Offer"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="entity.Vehicle"%>
<%@page import="entity.Customer"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="dao.VehicleDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="entity.QuotationRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.WebUserDAO"%>
<%@page import="dao.QuotationRequestDAO"%>
<%@page import="entity.WebUser"%>
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectValet.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8" />
        <title>Request</title>
        <jsp:include page="include/head.jsp"/>
    </head>

    <body class="bg-3">
        <!--<h1>Welcome</h1>-->
        <%            ValetRequestDAO vrDAO = new ValetRequestDAO();
            int shopID = user.getShopId();
            String token = user.getToken();
            int staffID = user.getStaffId();
            String chatToken = user.getChatToken();
            String phone_number = user.getHandphone();
            String user_name = user.getName();
            String user_email = user.getEmail();

        %>

        <!-- Preloader -->
        <div class="mask"><div id="loader"></div></div>
        <!--/Preloader -->

        <!-- Wrap all page content here -->
        <div id="wrap">
            <!-- Make page fluid -->
            <div class="row">
                <!-- Top and leftbar -->
                <%@include file="include/topbar.jsp"%>


                <!-- Top and leftbar end -->

                <!-- Page content -->
                <div id="content" class="col-md-12">
                    <%            String successChangePasswordMsg = (String) session.getAttribute("successChangePasswordMsg");
    if (successChangePasswordMsg != null && successChangePasswordMsg.length() > 0) {%>
                    <div class="alert alert-success"><%=successChangePasswordMsg%></div>
                    <%
                            session.setAttribute("successChangePasswordMsg", "");
                        }
                    %>
                    <!-- page header -->
                    <div class="pageheader">

                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Valet</h2>
                    </div>
                    <!-- /page header -->

                    <!-- content main container -->
                    <div class="main">
                        <!-- row -->
                        <div class="row">

                            <!-- col 12 -->
                            <div class="col-md-12">

                                <section class="tile transparent">
                                    <%--
                                    <!-- tile header -->
                                    <div class="tile-header transparent">
                                        <h1><strong>Today</strong> at a glance</h1>
                                        <div class="controls">
                                            <a href="#" class="minimize"><i class="fa fa-chevron-down"></i></a>
                                            <a href="#" class="refresh"><i class="fa fa-refresh"></i></a>
                                        </div>
                                    </div>
                                    <!-- /tile header -->
                                    --%>
                                    <!-- tile body -->
                                    <!--<div class="tile-body color transparent-black rounded-corners">-->

                                    <!-- cards -->
                                    <%--<%@include file="include/flipcard.jsp"%>--%>
                                    <!-- /cards -->
                                    <!--</div>-->
                                    <!-- /tile body -->
                                </section>
                                <!-- /tile -->
                            </div>
                            <!-- /col 12 -->        
                        </div>
                        <!-- /row -->
                        <%                            String success = (String) session.getAttribute("isSuccess");
                            String fail = (String) session.getAttribute("fail");
                            if (success != null && !(success.equals("null")) && success.length() > 0) {
                        %>
                        <div class="alert alert-success"><%=success%></div>
                        <%
                            session.setAttribute("isSuccess", "");
                        } else if (fail != null && !(fail.equals("null")) && fail.length() > 0) {
                        %>
                        <div class="alert alert-danger"><%=fail%></div>
                        <%
                                session.setAttribute("fail", "");
                            }
                        %>


                        <!-- content main container -->
                        <div class="main">




                            <!-- row -->
                            <div class="row">

                                <!-- col 12 -->
                                <div class="col-md-12">
                                    <!-- tile -->
                                    <section class="tile color transparent-white">



                                        <!-- tile header -->
                                        <div class="tile-header">
                                            <h1><strong>New Valet</strong></h1>
                                        </div>
                                        <!-- /tile header -->

                                        <!-- tile widget -->
                                        <div class="tile-widget bg-transparent-white-2">
                                            <div class="row">
                                                <div class="col-sm-12 col-xs-12 text-right">
                                                    <div class="btn-group btn-group-xs table-options desktopOnly">
                                                        <ul class="nav nav-pills tabpager">
                                                            <li class="active"><a href="#New" data-toggle="pill">New</a></li>
                                                            <li><a href="#Ongoing" data-toggle="pill">Ongoing</a></li>
                                                            <li><a href="#Completed" data-toggle="pill">Completed</a></li>
                                                        </ul>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                        <!-- /tile widget -->


                                        <!-- tile body -->
                                        <div class="tile-body no-vpadding" id="pageRefresh">
                                            <div class="tab-content">
                                                <%
                                                    ValetShop vs = vsDAO.retrieveValetShop(user.getStaffId(), user.getToken(), user.getShopId());
//                                                    int wsID = vs.getId();
//                                                    String workshop_name = vs.getName();
                                                    int i = 1;
//                                                    HashMap<Integer, QuotationRequest> qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 1, "requested_datetime", "desc");
                                                    HashMap<Integer, ValetRequest> vList = vrDAO.retrieveValetRequestsForDriver(user.getStaffId(), user.getToken(), 1);


                                                %>



                                                <div class="tab-pane fade active in" id="New" >
                                                    <div class="table-responsive">
                                                        <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                            <thead>
                                                                <tr>
                                                                    <th class="sortable">ID</th>
                                                                    <th class="sortable">Scheduled DateTime</th>
                                                                    <th class="sortable">Service Type</th>
                                                                    <th class="sortable">Pickup Location</th>
                                                                    <th class="sortable">Dropoff Location</th>
                                                                    <th class="sortable">Vehicle Transmission</th>
                                                                    <th>More Info</th>
                                                                    <th></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <!--Loop per new request-->
                                                                <%                                                                    Iterator it = vList.entrySet().iterator();
                                                                    while (it.hasNext()) {
                                                                        Map.Entry pair = (Map.Entry) it.next();
                                                                        ValetRequest vr = (ValetRequest) pair.getValue();
                                                                        int id = vr.getId();
                                                                        Timestamp timeStamp = vr.getScheduledPickUpTime();
                                                                        String dateTime = "01-01-1990 00:00:00";
                                                                        if (timeStamp != null) {
                                                                            dateTime = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(timeStamp);
                                                                        }
                                                                        int serviceType = vr.getServiceType();
                                                                        String pickUpAddress = vr.getPickUpAddress();
                                                                        String dropOffAddress = vr.getDropOffAddress();

                                                                        Vehicle vehicle = vr.getVehicle();
                                                                        String carControl = vehicle.getControl();
                                                                        String carColor = vehicle.getColour();
                                                                        String carPlate = vehicle.getPlateNumber();

                                                                        Customer customer = vr.getCustomer();
                                                                        String customerName = customer.getName();
                                                                %>
                                                                <tr>
                                                                    <td><% out.print(id);%></td>
                                                                    <td><% out.print(dateTime);%></td>
                                                                    <td><% out.print(serviceType + " way");%></td>
                                                                    <td><% out.print(pickUpAddress);%></td>
                                                                    <td><% out.print(dropOffAddress);%></td>
                                                                    <td><% out.print(carControl);%></td>
                                                                    <!--Quote-->
                                                                    <td class="text-center"><a data-modal="<% out.print("myModal" + i);%>" class="md-trigger"><img src="images/file.png"/></a></td>

                                                                    <!-- Modal -->
                                                            <div class="md-modal md-effect-13 md-slategray colorize-overlay " id="<% out.print("myModal" + i);%>">

                                                                <div class="md-content">
                                                                    <div class='col-xs-12'>

                                                                        <div class="col-xs-12">
                                                                            <h3>Vehicle Details</h3>
                                                                        </div>
                                                                        <div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Customer Name: </b><br><% out.print(customerName);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Carplate Number: </b><br><% out.print(carPlate);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Color: </b><br><% out.print(carColor);%></p>
                                                                            </div>      
                                                                            <div class="col-xs-6">
                                                                                <p><b>Transmission: </b><br><% out.print(carControl);%></p>
                                                                            </div>      
                                                                        </div>
                                                                        <!--</div>-->
                                                                        <div>
                                                                            <div class="col-xs-12">
                                                                                <h3>Valet Details - Next Trip</h3>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Service Type: </b><% out.print(serviceType);%></p>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Pick Up Address: </b><% out.print(pickUpAddress);%></p>
                                                                            </div>
                                                                            <p></p>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Drop Off Address: </b><% out.print(dropOffAddress);%></p>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Scheduled Date: </b>><% out.print(dateTime);%></p>
                                                                            </div> 
                                                                            <!--                                                                    <div class="col-xs-12">
                                                                                                                                                    <p><b>Scheduled Time: </b><% out.print(carColor);%></p>
                                                                                                                                                </div>-->
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12">
                                                                        <button class="md-close btn btn-default">Close</button>
                                                                    </div>

                                                                </div> <!--/.modal-content -->
                                                            </div> <!--/.modal -->
                                                            <td>
                                                                <form action="AcceptValetRequestServlet" method="POST">
                                                                    <button type="submit" name="id" value="<%=id%>" class="btn btn-default btn-xs">Accept</button>
                                                                </form>
                                                            </td>
                                                            </tr>

                                                            <%
                                                                    i++;
                                                                }
                                                            %>

                                                            <div class="md-overlay"></div>
                                                            </tbody>

                                                        </table>
                                                    </div>
                                                </div><!--New-->

                                                <div class="tab-pane fade " id="Ongoing" >
                                                    <div class="table-responsive">
                                                        <table id="example2" class="table table-custom1 table-sortable" cellspacing="0" width="100%">    
                                                            <thead>
                                                                <tr>
                                                                    <th class="sortable">ID</th>
                                                                    <th class="sortable">Service Type</th>
                                                                    <th class="sortable">Current Pickup Location</th>
                                                                    <th class="sortable">Current Dropoff Location</th>
                                                                    <th class="sortable">Next Pickup Time</th>
                                                                    <th class="sortable">More Info</th>
                                                                    <th></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <!--Loop per new request-->
                                                                <%
                                                                    int[] statusArr = {2, 3, 4, 5};
                                                                    for (int stat : statusArr) {
                                                                        vList = vrDAO.retrieveValetRequestsForDriver(user.getStaffId(), user.getToken(), stat);
                                                                        it = vList.entrySet().iterator();
                                                                        while (it.hasNext()) {
                                                                            Map.Entry pair = (Map.Entry) it.next();
                                                                            ValetRequest vr = (ValetRequest) pair.getValue();
                                                                            int id = vr.getId();
                                                                            Timestamp timeStamp = vr.getScheduledPickUpTime();
                                                                            String dateTime = "-";
                                                                            if (timeStamp != null) {
                                                                                dateTime = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(timeStamp);
                                                                            }
                                                                            int serviceType = vr.getServiceType();
                                                                            String pickUpAddress = vr.getPickUpAddress();
                                                                            String dropOffAddress = vr.getDropOffAddress();
                                                                            Vehicle vehicle = vr.getVehicle();
                                                                            String carControl = vehicle.getControl();
                                                                            String carColor = vehicle.getColour();
                                                                            String carPlate = vehicle.getPlateNumber();

                                                                            Customer customer = vr.getCustomer();
                                                                            String customerName = customer.getName();

                                                                %>
                                                                <tr>
                                                                    <td><% out.print(id);%></td>
                                                                    <td><% out.print(serviceType + " way");%></td>
                                                                    <td><% out.print(pickUpAddress);%></td>
                                                                    <td><% out.print(dropOffAddress);%></td>
                                                                    <td><% out.print(dateTime);%></td>
                                                                    <td class="text-center"><a data-modal="<% out.print("myModal" + i);%>" class="md-trigger"><img src="images/file.png"/></a></td>


                                                                    <!-- Modal -->
                                                            <div class="md-modal md-effect-13 md-slategray colorize-overlay" id="<% out.print("myModal" + i);%>">

                                                                <div class="md-content">
                                                                    <div class='col-xs-12'>

                                                                        <div class="col-xs-12">
                                                                            <h3>Vehicle Details</h3>
                                                                        </div>
                                                                        <div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Customer Name: </b><br><% out.print(customerName);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Carplate Number: </b><br><% out.print(carPlate);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Color: </b><br><% out.print(carColor);%></p>
                                                                            </div>      
                                                                            <div class="col-xs-6">
                                                                                <p><b>Transmission: </b><br><% out.print(carControl);%></p>
                                                                            </div>      
                                                                        </div>
                                                                        <!--</div>-->
                                                                        <div>
                                                                            <div class="col-xs-12">
                                                                                <h3>Valet Details - Next Trip</h3>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Service Type: </b><% out.print(serviceType + " way");%></p>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Pick Up Address: </b><% out.print(pickUpAddress);%></p>
                                                                            </div>
                                                                            <p></p>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Drop Off Address: </b><% out.print(dropOffAddress);%></p>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Scheduled Date: </b><% out.print(dateTime);%></p>
                                                                            </div> 
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12">
                                                                        <button class="md-close btn btn-default">Close</button>
                                                                    </div>

                                                                </div> <!--/.modal-content -->
                                                            </div> <!--/.modal -->

                                                            <td>
                                                                <% if (stat == 2) {%>
                                                                <form action="StartValetServlet" method="POST">
                                                                    <button type="submit" name="id" value="<%=id%>" class="btn btn-default btn-xs">Start</button>
                                                                </form>
                                                                <%} else if (stat == 3) {%>
                                                                <form action="ValetPickupServlet" method="POST">
                                                                    <button type="submit" name="id" value="<%=id%>" class="btn btn-default btn-xs">Reached Pickup Point</button>
                                                                </form>
                                                                <%} else if (stat == 4) {%>
                                                                <form action="ValetOnTheWayServlet" method="POST">
                                                                    <button type="submit" name="id" value="<%=id%>" class="btn btn-default btn-xs">To Destination</button>
                                                                </form>
                                                                <%} else if (stat == 5) {%>
                                                                <form action="ValetDropoffServlet" method="POST">
                                                                    <button type="submit" name="id" value="<%=id%>" class="btn btn-default btn-xs">Destination Reached</button>
                                                                </form>
                                                                <%}%>

                                                            </td>

                                                            </tr>

                                                            <%
                                                                        i++;
                                                                    }
                                                                }
                                                            %>
                                                            <div class="md-overlay1"></div>

                                                            </tbody>

                                                        </table>
                                                    </div>
                                                </div><!--Ongoing-->

                                                <div class="tab-pane fade " id="Completed" >
                                                    <div class="table-responsive">
                                                        <table id="example3" class="table table-custom1 table-sortable" cellspacing="0" width="100%">    
                                                            <thead>
                                                                <tr>
                                                                    <th class="sortable">ID</th>
                                                                    <th class="sortable">Scheduled DateTime</th>
                                                                    <th class="sortable">Service Type</th>
                                                                    <th class="sortable">Pickup Location</th>
                                                                    <th class="sortable">Dropoff Location</th>
                                                                    <th>More Info</th>
                                                                    <th>Completed By</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <!--Loop per new request-->
                                                                <%
                                                                    vList = vrDAO.retrieveValetRequestsForDriver(user.getStaffId(), user.getToken(), 6);
                                                                    it = vList.entrySet().iterator();

                                                                    while (it.hasNext()) {
                                                                        Map.Entry pair = (Map.Entry) it.next();
                                                                        ValetRequest vr = (ValetRequest) pair.getValue();
                                                                        int id = vr.getId();
                                                                        Timestamp timeStamp = vr.getScheduledPickUpTime();
                                                                        String dateTime = "-";
                                                                        if (timeStamp != null) {
                                                                            dateTime = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(timeStamp);
                                                                        }
                                                                        int serviceType = vr.getServiceType();
                                                                        String pickUpAddress = vr.getPickUpAddress();
                                                                        String dropOffAddress = vr.getDropOffAddress();

                                                                        WebUser valetDriver = vr.getValetDriver();
                                                                        String valetName = valetDriver.getName();

                                                                        Vehicle vehicle = vr.getVehicle();
                                                                        String carControl = vehicle.getControl();
                                                                        String carColor = vehicle.getColour();
                                                                        String carPlate = vehicle.getPlateNumber();

                                                                        Customer customer = vr.getCustomer();
                                                                        String customerName = customer.getName();

                                                                %>
                                                                <tr>
                                                                    <td><% out.print(id);%></td>
                                                                    <td><% out.print(dateTime);%></td>
                                                                    <td><% out.print(serviceType);%></td>
                                                                    <td><% out.print(pickUpAddress);%></td>
                                                                    <td><% out.print(dropOffAddress);%></td>
                                                                    <td class="text-center"><a data-modal="<% out.print("myModal" + i);%>" class="md-trigger"><img src="images/file.png"/></a></td>


                                                                    <!-- Modal -->
                                                            <div class="md-modal md-effect-13 md-slategray colorize-overlay" id="<% out.print("myModal" + i);%>">

                                                                <div class="md-content">
                                                                    <div class='col-xs-12'>

                                                                        <div class="col-xs-12">
                                                                            <h3>Vehicle Details</h3>
                                                                        </div>
                                                                        <div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Customer Name: </b><br><% out.print(customerName);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Carplate Number: </b><br><% out.print(carPlate);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Color: </b><br><% out.print(carColor);%></p>
                                                                            </div>      
                                                                            <div class="col-xs-6">
                                                                                <p><b>Transmission: </b><br><% out.print(carControl);%></p>
                                                                            </div>      
                                                                        </div>
                                                                        <!--</div>-->
                                                                        <div>
                                                                            <div class="col-xs-12">
                                                                                <h3>Valet Details - Next Trip</h3>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Service Type: </b><% out.print(serviceType);%></p>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Pick Up Address: </b><% out.print(pickUpAddress);%></p>
                                                                            </div>
                                                                            <p></p>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Drop Off Address: </b><% out.print(dropOffAddress);%></p>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Scheduled Date: </b>><% out.print(dateTime);%></p>
                                                                            </div> 
                                                                            <!--                                                                    <div class="col-xs-12">
                                                                                                                                                    <p><b>Scheduled Time: </b><% out.print(carColor);%></p>
                                                                                                                                                </div>-->
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-12">
                                                                        <button class="md-close btn btn-default">Close</button>
                                                                    </div>

                                                                </div> <!--/.modal-content -->
                                                            </div> <!--/.modal -->
                                                            <td><% out.print(valetName);%></td>
                                                            </tr>


                                                            <%
                                                                    i++;
                                                                }
                                                            %>
                                                            <div class="md-overlay2"></div>

                                                            </tbody>

                                                        </table>
                                                    </div>
                                                </div><!--Complete-->

                                            </div>
                                            <!--tab-content-->


                                        </div>
                                        <!-- /tile body -->


                                        <!-- tile footer -->
                                        <!--                                <div class="tile-footer bg-transparent-white-2 rounded-bottom-corners">
                                                                            <div class="row"></div>
                                                                        </div>-->
                                        <!-- /tile footer -->




                                    </section>
                                    <!-- /tile -->






                                </div>
                                <!-- /col 12 -->



                            </div>
                            <!-- /row -->






                        </div>
                        <!-- /content container -->






                    </div>
                    <!-- Page content end -->




                    <!-- Right slider bar -->
                    <%--<jsp:include page="include/rightbar.jsp"/>--%>
                    <!-- Right slider bar -->






                </div>
                <!-- Make page fluid-->




            </div>
            <!-- Wrap all page content end -->



            <section class="videocontent" id="video"></section>

    </body>



    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://code.jquery.com/jquery.js"></script> 
    <!-- Include all compiled plugins (below), or include individual files as needed -->

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-dropdown-multilevel.js"></script>
    <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
    <script type="text/javascript" src="js/jquery.mmenu.min.js"></script>
    <script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
    <script type="text/javascript" src="js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="js/jquery.animateNumbers.js"></script>
    <script type="text/javascript" src="js/jquery.videobackground.js"></script>
    <script type="text/javascript" src="js/jquery.blockUI.js"></script>
    <!--<script type="text/javascript" src="js/sorttable.js"></script>-->
    <script src="js/minimal.min.js"></script>
    <!--<script type="text/javascript" src="js/jquery-latest.js"></script>--> 
    <script type="text/javascript" src="js/jquery.tablesorter.js"></script> 
    <script type="text/javascript" src="js/jquery.tabpager.min.js"></script> 
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script> 
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script> 
    <script type="text/javascript" src="js/classie.js"></script> 
    <script type="text/javascript" src="js/modalEffects.js"></script> 
    <script type="text/javascript" src="js/jquery.jgrowl.min.js"></script> 
    <script data-require="realtime-framework@2.1.0" data-semver="2.1.0" src="//messaging-public.realtime.co/js/2.1.0/ortc.js"></script>
    <script type="text/javascript" src="js/chat.js"></script> 
    <script type="text/javascript" src="js/intercom.js"></script> 


    <!--<script type="text/javascript" src="js/modalEffects.js"></script>--> 
    <!--    <script type="text/javascript" src="js/cssParser.js"></script> 
        <script type="text/javascript" src="js/css-filters-polyfill.js"></script> -->



    <script>
        $(function () {
            //         sortable table
            $('.table.table-sortable th.sortable').click(function () {
                var o = $(this).hasClass('sort-asc') ? 'sort-desc' : 'sort-asc';
                $('th.sortable').removeClass('sort-asc').removeClass('sort-desc');
                $(this).addClass(o);
            });
        });
    </script>
    <script>
        function start() {
            timedRefresh(300000);
            displaymsg();
        }
        window.onload = start;</script>
    <script>
        $(document).ready(function () {
            $('#example').DataTable();
            $('#example2').DataTable();
            $('#example3').DataTable();
        });
    </script>

</html>
