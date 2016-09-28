<%-- 
    Document   : View Request
    Created on : May 5, 2016, 10:00:14 AM
    Author     : joanne.ong.2014
--%>

<%@page import="dao.ValetShopDAO"%>
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
<%@include file="ProtectWorkshop.jsp"%>
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
        <%            String successChangePasswordMsg = (String) request.getAttribute("successChangePasswordMsg");
            if (successChangePasswordMsg != null) {
                out.println(successChangePasswordMsg + "<br/><br/>");
            }
            QuotationRequestDAO qDAO = new QuotationRequestDAO();
//            HashMap<Integer, Integer> statusSize = qDAO.retrieveStatusSize(user.getStaffId(), user.getToken(), 0, 0, "", "requested_datetime", "desc");
//            int newSize = statusSize.get(0);
//            int sendFinalSize = statusSize.get(1);
//            int finalAcceptSize = statusSize.get(2);
//            int newService = statusSize.get(2);
//            int completedService = statusSize.get(3);
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
                <%--<jsp:include page="include/topbar.jsp"/>--%>


                <!-- Top and leftbar end -->

                <!-- Page content -->
                <div id="content" class="col-md-12">

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
                        <%
                            String success = (String) session.getAttribute("isSuccess");
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
                                                        </ul>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                        <!-- /tile widget -->


                                        <!-- tile body -->
                                        <div class="tile-body no-vpadding" id="pageRefresh">
                                            <div class="tab-content">
                                                <%                                                    Workshop ws = wsDAO.retrieveWorkshop(user.getShopId(), user.getStaffId(), user.getToken());

                                                    int wsID = ws.getId();
                                                    String workshop_name = ws.getName();
                                                    String categories = ws.getCategory();
                                                    String brands_carried = ws.getBrandsCarried();
                                                    int i = 1;
                                                    qDAO = new QuotationRequestDAO();
                                                    HashMap<Integer, QuotationRequest> qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 1, "requested_datetime", "desc");


                                                %>



                                                <div class="tab-pane fade active in" id="New" >
                                                    <div class="table-responsive">
                                                        <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                            <thead>
                                                                <tr>
                                                                    <th class="sortable">Date</th>
                                                                    <th class="sortable">Time</th>
                                                                    <th class="sortable">Service Type</th>
                                                                    <th class="sortable">Pickup Location</th>
                                                                    <th class="sortable">Dropoff Location</th>
                                                                    <th class="sortable">Vehicle Transmission</th>
                                                                    <th class="sortable">More Info</th>
                                                                    <th></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <!--Loop per new request-->
                                                                <%                                                                    Iterator it = qList.entrySet().iterator();
                                                                    while (it.hasNext()) {
                                                                        Map.Entry pair = (Map.Entry) it.next();
                                                                        QuotationRequest qr = (QuotationRequest) pair.getValue();
                                                                        int id = qr.getId();
                                                                        Timestamp timeStamp = qr.getRequestedDate();
                                                                        String dateTime = "01-01-1990 00:00:00";
                                                                        if (timeStamp != null) {
                                                                            dateTime = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(timeStamp);
                                                                        }
                                                                        String serviceName = qr.getName();

                                                                        String address = qr.getAddress();
                                                                        String serviceAmenities = qr.getAmenities();
                                                                        String serviceDescription = qr.getDescription();
                                                                        String serviceDetails = qr.getDetails();
                                                                        int serviceId = qr.getId();
                                                                        String serviceMileage = qr.getMileage();
                                                                        String carPhoto = qr.getPhotos();
                                                                        int serviceStatus = qr.getOffer().getStatus();
                                                                        String serviceUrgency = qr.getUrgency();

                                                                        Customer cust = qr.getCustomer();
                                                                        String custName = cust.getName();
                                                                        String custEmail = cust.getEmail();
                                                                        String custPhone = cust.getHandphone();
                                                                        int userID = cust.getId();

                                                                        Vehicle vehicle = qr.getVehicle();
                                                                        String carPlate = vehicle.getPlateNumber();
                                                                        String carModel = vehicle.getModel();
                                                                        String carMake = vehicle.getMake();
                                                                        int carYear = vehicle.getYear();
                                                                        String carColor = vehicle.getColour();
                                                                        String carControl = vehicle.getControl();


                                                                %>
                                                                <tr>
                                                                    <td><% out.print(serviceId);%></td>
                                                                    <td><% out.print(dateTime);%></td>
                                                                    <td><% out.print(custName);%></td>
                                                                    <td><% out.print(carPlate);%></td>
                                                                    <td><% out.print(carModel);%></td>
                                                                    <td><% out.print(serviceName);%></td>
                                                                    <!--Picture Attachment-->
                                                                    <!--<td class="text-center"><a href="<% out.print("#myModal" + i);%>" id="myBtn" data-toggle="modal"><img src="images/file.png"/></a></td>-->

                                                                    <!-- Modal -->
                                                            <div class="modal fade" id="<% out.print("myModal" + i);%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                                <!--<div class="modal-dialog-img">-->
                                                                <div class="modal-content">
                                                                    <!--<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>-->
                                                                    <div class="modal-header">
                                                                        <h4 class="modal-title"><% out.print(carMake + " " + carModel + " - " + carYear);%></h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <img class="img-responsive"src="<%//="http://119.81.43.85/uploads/" + carPhoto%>"/>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button class="btn btn-default" data-dismiss="modal">Close</button>
                                                                    </div>
                                                                </div> <!--/.modal-content -->
                                                            </div> <!--/.modal-dialog -->
                                                    </div> <!--/.modal -->

                                                    <% i++; %>
                                                    <!--Quote-->
                                                    <!--<td class="text-center"><button class="btn btn-default btn-xs md-trigger" data-modal="<% out.print("myModal" + i);%>" id="quoteBtn" type="button" onclick="subscribe(<%=serviceId%>, <%=wsID%>, <%=userID%>, '<%=custName%>', '<%=chatToken%>', 'log<%=serviceId%>');"><span>Quote</span></button></td>-->
                                                    <td class="text-center"><a data-modal="<% out.print("myModal" + i);%>" class="md-trigger"><img src="images/file.png"/></a></td>

                                                    <!-- Modal -->
                                                    <div class="md-modal md-effect-13 md-slategray colorize-overlay " id="<% out.print("myModal" + i);%>">

                                                        <div class="md-content">
                                                            <!--<div>-->
                                                            <!--                                                            <div class="col-xs-6">
                                                                                                                            <h4 class="modal-title">New Request - <% out.print(custName);%></h4>
                                                                                                                        </div>
                                                                                                                        <div class="col-xs-6 text-right">
                                                                                                                            <h4 class="modal-title"><%=dateTime%></h4>
                                                                                                                        </div>-->
                                                            <!--</div>-->
                                                            <!--<div>-->
                                                            <div class='col-xs-12'>

                                                                <div class="col-xs-12">
                                                                    <h3>Vehicle Details</h3>
                                                                </div>
                                                                <div>
                                                                    <div class="col-xs-6">
                                                                        <p><b>Customer Name: </b><br><% out.print(custName);%></p>
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
                                                                        <p><b>Service Type: </b><% out.print(carPlate);%></p>
                                                                    </div>
                                                                    <div class="col-xs-12">
                                                                        <p><b>Pick Up Address: </b><% out.print(carMake + " " + carModel);%></p>
                                                                    </div>
                                                                    <p></p>
                                                                    <div class="col-xs-12">
                                                                        <p><b>Drop Off Address: </b><% out.print(carYear);%></p>
                                                                    </div>
                                                                    <div class="col-xs-12">
                                                                        <p><b>Scheduled Date: </b>><% out.print(carControl);%></p>
                                                                    </div> 
                                                                    <div class="col-xs-12">
                                                                        <p><b>Scheduled Time: </b><% out.print(carColor);%></p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-xs-12">
                                                                <button class="md-close btn btn-default">Close</button>
                                                            </div>

                                                        </div> <!--/.modal-content -->
                                                    </div> <!--/.modal -->
                                                    <td><button class="btn btn-default btn-xs">Accept</button></td>
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
                                                                qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 2, "requested_datetime", "desc");
                                                                it = qList.entrySet().iterator();
                                                                while (it.hasNext()) {
                                                                    Map.Entry pair = (Map.Entry) it.next();
                                                                    QuotationRequest qr = (QuotationRequest) pair.getValue();
                                                                    int id = qr.getId();
                                                                    Timestamp timeStamp = qr.getRequestedDate();
                                                                    String dateTime = "01-01-1990 00:00:00";
                                                                    if (timeStamp != null) {
                                                                        dateTime = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(timeStamp);
                                                                    }
                                                                    String serviceName = qr.getName();

                                                                    String address = qr.getAddress();
                                                                    String serviceAmenities = qr.getAmenities();
                                                                    String serviceDescription = qr.getDescription();
                                                                    String serviceDetails = qr.getDetails();
                                                                    int serviceId = qr.getId();
                                                                    String serviceMileage = qr.getMileage();
                                                                    String carPhoto = qr.getPhotos();
                                                                    int serviceStatus = qr.getOffer().getStatus();
                                                                    String serviceUrgency = qr.getUrgency();
                                                                    int topicId = qr.getChatTopicId();

                                                                    Customer cust = qr.getCustomer();
                                                                    String custName = cust.getName();
                                                                    String custEmail = cust.getEmail();
                                                                    String custPhone = cust.getHandphone();
                                                                    int userID = cust.getId();

                                                                    Vehicle vehicle = qr.getVehicle();
                                                                    String carPlate = vehicle.getPlateNumber();
                                                                    String carModel = vehicle.getModel();
                                                                    String carMake = vehicle.getMake();
                                                                    int carYear = vehicle.getYear();
                                                                    String carColor = vehicle.getColour();
                                                                    String carControl = vehicle.getControl();

                                                                    Offer offer = qr.getOffer();
                                                                    double minPrice = offer.getInitialMinPrice();
                                                                    String min = minPrice + "0";
                                                                    double maxPrice = offer.getInitialMaxPrice();
                                                                    String max = maxPrice + "0";
                                                                    int offerId = offer.getId();
                                                                    double diagnosticPrice = offer.getDiagnosticPrice();
                                                                    String diagnostic = diagnosticPrice + "0";

                                                            %>
                                                            <tr>
                                                                <td><% out.print(dateTime);%></td>
                                                                <td><% out.print(custName);%></td>
                                                                <td><% out.print(carPlate);%></td>
                                                                <td><% out.print(carModel);%></td>


                                                                <!--Quote-->
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
                                                                            <p><b>Customer Name: </b><br><% out.print(custName);%></p>
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
                                                                            <p><b>Service Type: </b><% out.print(carPlate);%></p>
                                                                        </div>
                                                                        <div class="col-xs-12">
                                                                            <p><b>Pick Up Address: </b><% out.print(carMake + " " + carModel);%></p>
                                                                        </div>
                                                                        <p></p>
                                                                        <div class="col-xs-12">
                                                                            <p><b>Drop Off Address: </b><% out.print(carYear);%></p>
                                                                        </div>
                                                                        <div class="col-xs-12">
                                                                            <p><b>Scheduled Date: </b>><% out.print(carControl);%></p>
                                                                        </div> 
                                                                        <div class="col-xs-12">
                                                                            <p><b>Scheduled Time: </b><% out.print(carColor);%></p>
                                                                        </div>
                                                                        <div class="col-xs-12">
                                                                            <p><b>ID: </b><% out.print(id);%></p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-12">
                                                                    <button class="md-close btn btn-default">Close</button>
                                                                </div>

                                                            </div> <!--/.modal-content -->
                                                        </div> <!--/.modal -->
                                                        <% i++; %>
                                                        <td class="text-center"><button class="btn btn-default btn-xs md-trigger" data-modal="<% out.print("myModal" + i);%>" type="button">Complete</button></td>
                                                        <!-- Modal -->
                                                        <div class="md-modal md-effect-13 md-slategray colorize-overlay" id="<% out.print("myModal" + i);%>">
                                                            <%
                                                                if (true) { //2 WAY
                                                            %>
                                                            <div class="md-content">
                                                                <div class='col-xs-12'>

                                                                    <div class="col-xs-12">
                                                                        <h3>Job Completion</h3><p>
                                                                    </div>
                                                                    <div>
                                                                        <div class="col-xs-12">
                                                                            <!--<p><b>Customer Name: </b><br><% out.print(custName);%></p>-->
                                                                            <div class="text-center">Your next pickup time is on</div>
                                                                            <p>
                                                                        </div>
                                                                        <div class="col-xs-12">
                                                                            <h4 class="text-center">1400Hrs</h4>
                                                                        </div>
                                                                        <div class="col-xs-12">
                                                                            <h4 class="text-center">31 Aug 2016</h4>
                                                                            <p>
                                                                            <!--<p><b>Color: </b><br><% out.print(carColor);%></p>-->
                                                                        </div>      
                                                                        <div class="col-xs-12">
                                                                            <div class="text-center">Would you be available to continue with this job?</div>
                                                                        </div>      
                                                                    </div>
                                                                    <!--</div>-->
                                                                </div>
                                                                <div class="col-xs-12">
                                                                    <div class="col-xs-6">
                                                                        <button class="btn btn-blue">Accept</button>
                                                                    </div>
                                                                    <div class="col-xs-6">
                                                                        <button class="btn btn-blue">Reject</button>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-12">
                                                                    <button class="md-close btn btn-default">Close</button>
                                                                </div>

                                                            </div> <!--/.modal-content -->
                                                            <%
                                                            } else {//1 WAY
                                                            %>
                                                            <div class="md-content">
                                                                <div class='col-xs-12'>

                                                                    <div class="col-xs-12">
                                                                        <h3>Job Completion</h3><p>
                                                                    </div>
                                                                    <div>
                                                                        <div class="col-xs-12">
                                                                            <!--<p><b>Customer Name: </b><br><% out.print(custName);%></p>-->
                                                                            <div class="text-center"><h4>Do you want to complete your job?</h4></div>
                                                                            <p>
                                                                        </div>
                                                                        <div class="col-xs-12">
                                                                            <div class="text-center">Your job confirmation will be sent to the user once you complete the job.</div>
                                                                        </div>   
                                                                    </div>
                                                                    <!--</div>-->
                                                                </div>
                                                                <div class="col-xs-12">
                                                                    <div class="col-xs-12">
                                                                        <button class="btn btn-blue">Complete</button>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-12">
                                                                    <button class="md-close btn btn-default">Close</button>
                                                                </div>

                                                            </div> <!--/.modal-content -->

                                                            <%
                                                                }
                                                            %>
                                                        </div> <!--/.modal -->
                                                        </tr>

                                                        <%
                                                                i++;
                                                            }
                                                        %>
                                                        <div class="md-overlay1"></div>

                                                        </tbody>

                                                    </table>
                                                </div>
                                            </div><!--Waiting_for_Response-->



                                        </div>
                                        <!--tab-content-->


                                </div>
                                <!-- /tile body -->


                                <!-- tile footer -->
                                <div class="tile-footer bg-transparent-white-2 rounded-bottom-corners">
                                    <div class="row">  

                                        <div class="col-sm-4">
                                            <!--                                                <div class="input-group table-options">
                                                                                                <select class="chosen-select form-control">
                                                                                                    <option>Bulk Action</option>
                                                                                                    <option>Delete Selected</option>
                                                                                                    <option>Copy Selected</option>
                                                                                                    <option>Archive Selected</option>
                                                                                                </select>
                                                                                                <span class="input-group-btn">
                                                                                                    <button class="btn btn-default" type="button">Apply</button>
                                                                                                </span>
                                                                                            </div>-->
                                        </div>

                                        <div class="col-sm-4 text-center">
                                            <!--                                    <small class="inline table-options paging-info">showing 1-3 of 24 items</small>-->
                                        </div>

                                        <div class="col-sm-4 text-right sm-center" id="paginationTab" style="display:none">
                                            <ul class="pagination pagination-xs nomargin pagination-custom">
                                                <li class="disabled"><a href="#"><i class="fa fa-angle-double-left"></i></a></li>
                                                <li class="active"><a href="#">1</a></li>
                                                <li><a href="#">2</a></li>
                                                <li><a href="#">3</a></li>
                                                <li><a href="#">4</a></li>
                                                <li><a href="#">5</a></li>
                                                <li><a href="#"><i class="fa fa-angle-double-right"></i></a></li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
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
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script> 
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script> 
    <script type="text/javascript" src="js/classie.js"></script> 
    <script type="text/javascript" src="js/modalEffects.js"></script> 
    <script type="text/javascript" src="js/jquery.jgrowl.min.js"></script> 
    <script data-require="realtime-framework@2.1.0" data-semver="2.1.0" src="//messaging-public.realtime.co/js/2.1.0/ortc.js"></script>
    <script type="text/javascript" src="js/chat.js"></script> 
    <script type="text/javascript" src="js/intercom.js"></script> 

    <script src="js/minimal.min.js"></script>



    <script>
        $(function () {
            // Initialize card flip
            $('.card.hover').hover(function () {
                $(this).addClass('flip');
            }, function () {
                $(this).removeClass('flip');
            });
            //         sortable table
            $('.table.table-sortable th.sortable').click(function () {
                var o = $(this).hasClass('sort-asc') ? 'sort-desc' : 'sort-asc';
                $('th.sortable').removeClass('sort-asc').removeClass('sort-desc');
                $(this).addClass(o);
            });
            //todo's
            $('#todolist li label').click(function () {
                $(this).toggleClass('done');
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
            $('#example4').DataTable();
            $('#example5').DataTable();
        });</script>
    <script>
        intercom("<%=user_name%>", "<%=user_email%>",<%=staffID%>, "<%=phone_number%>", "<%=workshop_name%>", "<%=categories%>", "<%=brands_carried%>");
    </script>
    <script>
            $(window).load(function () {
                $.ajax({
                    type: 'POST',
                    url: 'http://119.81.43.85/erp/ws_notification/retrieve_notifications_by_shop',
                    crossDomain: true,
                    data: {
                        "token": "<%=user.getToken()%>",
                        "staff_id": "<%=user.getStaffId()%>",
                        "shop_id": "<%=user.getShopId()%>"
                    },
                    dataType: 'json',
                    success: function (data) {
                        console.log(data);
                        $.each(data.payload.notifications, function () {
                            var notification = $(this).attr('actual_message');
                            $.jGrowl(notification, {sticky: true});
                        });
                    },
                    error: function () {
                    }
                });
            });
        </script>
</html>
