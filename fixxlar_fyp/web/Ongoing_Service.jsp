<%-- 
    Document   : View Request
    Created on : May 5, 2016, 10:00:14 AM
    Author     : joanne.ong.2014
--%>

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
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page import="dao.QuotationRequestDAO"%>
<%@page import="entity.WebUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectWorkshop.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8" />
        <title>Service</title>
        <jsp:include page="include/head.jsp"/>
    </head>
    <body class="bg-3">
        <!--<h1>Welcome</h1>-->
        <%            String successChangePasswordMsg = (String) request.getAttribute("successChangePasswordMsg");
            if (successChangePasswordMsg != null) {
                out.println(successChangePasswordMsg + "<br/><br/>");
            }
            QuotationRequestDAO qDAO = new QuotationRequestDAO();
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
                <%--<jsp:include page="include/topbar.jsp"/>--%>
                <%@include file="include/topbar.jsp"%>
                <!-- Top and leftbar end -->

                <!-- Page content -->
                <div id="content" class="col-md-12">

                    <!-- page header -->
                    <div class="pageheader">

                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Request</h2>
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
                                    <div class="tile-body color transparent-black rounded-corners">

                                        <!-- cards -->
                                        <%@include file="include/flipcard.jsp"%>
                                        <!-- /cards -->
                                    </div>
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
                            } else if(fail != null && !(fail.equals("null")) && fail.length() > 0) {
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
                                            <h1><strong>View Service</strong></h1>
                                            <!--                                        <div class="search">
                                                                                        <input type="search" class="light-table-filter" data-table="order-table" placeholder="Filter">
                                                                                    </div>-->
                                            <div class="controls">
                                                <a href="#" class="minimize"><i class="fa fa-chevron-down"></i></a>
                                                <a href="#" class="refresh"><i class="fa fa-refresh"></i></a>
                                                <a href="#" class="remove"><i class="fa fa-times"></i></a>
                                            </div>
                                        </div>
                                        <!-- /tile header -->

                                        <!-- tile widget -->
                                        <div class="tile-widget bg-transparent-white-2">
                                            <div class="row">

                                                <div class="col-sm-12 col-xs-12 text-right">


                                                    <div class="btn-group btn-group-xs table-options desktopOnly">
                                                        <ul class="nav nav-pills tabpager">
                                                            <!--<li class="active"><a href="#New_Service" data-toggle="pill">New Service</a></li>-->
                                                            <li class="active"><a href="#Ongoing_Service" data-toggle="pill">Ongoing Service</a></li>
                                                            <li><a href="#Completed_Service" data-toggle="pill">Completed Service</a></li>
                                                        </ul>
                                                    </div>
                                                    <!--                                                    <div class="btn-group mobileOnly" style="float:right">
                                                                                                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" id='select'>
                                                                                                            Select <span class="caret"></span>
                                                                                                        </button>
                                                    
                                                                                                        <ul class="dropdown-menu" role="menu" >
                                                                                                            <li class="active"><a href="#New_Service" data-toggle="pill">New Service</a></li>
                                                                                                            <li><a href="#Ongoing_Service" data-toggle="pill">Ongoing Service</a></li>
                                                                                                            <li><a href="#Completed_Service" data-toggle="pill">Completed Service</a></li>
                                                                                                        </ul>
                                                                                                    </div>-->
                                                </div>


                                            </div>
                                        </div>
                                        <!-- /tile widget -->


                                        <!-- tile body -->
                                        <div class="tile-body no-vpadding">
                                            <div class="tab-content">
                                                <%                                                    Workshop ws = wsDAO.retrieveWorkshop(user.getShopId(), user.getStaffId(), user.getToken());
                                                    int wsID = ws.getId();
                                                    String workshop_name = ws.getName();
                                                    String categories = ws.getCategory();
                                                    String brands_carried = ws.getBrandsCarried();
                                                    int i = 1;
                                                    qDAO = new QuotationRequestDAO();
                                                    HashMap<Integer, QuotationRequest> qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 6, "requested_datetime", "desc");

                                                %>

                                                <div class="tab-pane fade active in" id="Ongoing_Service" >
                                                    <div class="table-responsive">
                                                        <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                            <thead>
                                                                <tr>
                                                                    <th class="sortable">ID</th>
                                                                    <th class="sortable">DateTime</th>
                                                                    <th class="sortable">Name</th>
                                                                    <th class="sortable">No. Plate</th>
                                                                    <th class="sortable">Car Model</th>
                                                                    <th class="sortable">Services</th>
                                                                    <!--                                                                    <th>Attachment</th>-->
                                                                    <th>Complete Service</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="contents">
                                                                <!--Loop per new request-->
                                                                <%                                                                    qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 6, "requested_datetime", "desc");
                                                                    Iterator it = qList.entrySet().iterator();
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
                                                                        double afinalPrice = offer.getFinalPrice();
                                                                        String finalPrice = afinalPrice + "0";
                                                                        Timestamp dt = offer.getEstCompletionTime();
                                                                        String estTime = "01-01-1990 00:00:00";
                                                                        if (timeStamp != null) {
                                                                            estTime = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(dt);
                                                                        }
                                                                        int offerId = offer.getId();

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
                                                                <div class="modal-dialog-img">
                                                                    <div class="modal-content">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                                        <div class="modal-header">
                                                                            <h4 class="modal-title"><% out.print(carMake + " " + carModel + " - " + carYear);%></h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <img class="img-responsive"src="<%="http://119.81.43.85/uploads/" + carPhoto%>"/>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                            <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                                                                        </div>
                                                                    </div> <!--/.modal-content--> 
                                                                </div><!-- /.modal-dialog -->
                                                            </div><!-- /.modal -->
                                                            <% i++;%>

                                                            <!--Quote-->
                                                            <td class="text-center"><button class="btn btn-default btn-xs md-trigger" data-modal="<% out.print("myModal" + i);%>" id="quoteBtn" type="button" onclick="subscribe(<%=serviceId%>, <%=wsID%>, <%=userID%>, '<%=custName%>', '<%=chatToken%>', 'log<%=serviceId%>');"><span>More Info</span></button></td>


                                                            <!-- Modal -->
                                                            <div class="md-modal md-effect-13 md-slategray colorize-overlay md-chat" id="<% out.print("myModal" + i);%>">

                                                                <div class="md-content">
                                                                    <!--<div>-->
                                                                    <div class="col-xs-6">
                                                                        <h4 class="modal-title">Ongoing Service - <% out.print(custName);%></h4>
                                                                    </div>
                                                                    <div class="col-xs-6 text-right">
                                                                        <h4 class="modal-title"><%=dateTime%></h4>
                                                                    </div>
                                                                    <!--</div>-->
                                                                    <!--<div>-->
                                                                    <div class='col-xs-6'>

                                                                        <div class="col-xs-12">
                                                                            <h3>Service Details</h3>
                                                                        </div>
                                                                        <div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Service Request: </b><br><% out.print(serviceName);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Urgency: </b><br><% out.print(serviceUrgency);%></p>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Service Description: </b><br><% out.print(serviceDescription);%></p>
                                                                            </div>      
                                                                        </div>
                                                                        <!--</div>-->
                                                                        <div>
                                                                            <div class="col-xs-12">
                                                                                <h3>Car Details</h3>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>License Plate: </b><br><% out.print(carPlate);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Vehicle Model: </b><br><% out.print(carMake + " " + carModel);%></p>
                                                                            </div>
                                                                            <p></p>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Vehicle Year: </b><br><% out.print(carYear);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Vehicle Type: </b><br><% out.print(carControl);%></p>
                                                                            </div> 
                                                                            <div class="col-xs-6">
                                                                                <p><b>Vehicle Color: </b><br><% out.print(carColor);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Mileage: </b><br><% out.print(serviceMileage);%></p>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-xs-6">
                                                                            <form action="CompleteService">
                                                                                <input type="hidden" name="id" value="<%=offerId%>"/>
                                                                                <input type="submit" class="btn btn-primary" value="Complete Service"></button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-6">
                                                                        <section class="tile transparent">
                                                                            <!-- tile header -->
                                                                            <div class="tile-header color bg-transparent-black-5 rounded-corners">
                                                                                <h5>Chat</h5>
                                                                                <div class="hidden ct" id=""><div class="hidden chatTopic" id="<%=topicId%>"></div>
                                                                            </div>
                                                                            <!-- /tile header -->
                                                                            <!-- tile body -->
                                                                            <div class="tile-body transparent nopadding">

                                                                                <div class="chat-content" id="chat-content">

                                                                                    <ul class="chat-list" id="log<%=serviceId%>"></ul><!-- Chat Message Enters Here-->


                                                                                </div>
                                                                            </div>
                                                                            <!-- /tile body -->




                                                                            <!-- tile footer -->
                                                                            <div class="tile-footer transparent nopadding">

                                                                                <div class="chat-reply" id="chat-reply">
                                                                                    <!--<textarea placeholder="Post a reply..." class="form-control"></textarea>-->
                                                                                    <textarea placeholder="Write a message..." class="form-control msgInput" id="msgInput<%=i%>" onfocus="clearElement('#msgInput')"></textarea>
                                                                                    <div class="btn-group btn-group-sm">
                                                                                        <!--<button type="button" class="btn btn-transparent-white"><i class="fa fa-paperclip"></i> Add Files</button>-->
                                                                                        <!--<button type="button" class="btn btn-transparent-white last-in-group"><i class="fa fa-camera"></i> Add Photos</button>-->
                                                                                        <button type="button" class="btn btn-transparent-white last pull-right sendMsg" id="<%=serviceId%>-<%=wsName%>-<%=shopID%>-<%=staffID%>-<%=token%>" onclick='prepareMsg()'>Send message</button>
                                                                                        <!--                                                <div class="checkbox check-transparent pull-right">
                                                                                                                                            <input type="checkbox" value="1" id="send-by-enter">
                                                                                                                                            <label for="send-by-enter">Press Enter to send</label>
                                                                                                                                        </div>-->
                                                                                    </div>
                                                                                </div>

                                                                            </div>
                                                                            <!-- /tile footer -->


                                                                        </section>
                                                                    </div>
                                                                    <div class="col-xs-12">
                                                                        <button class="md-close btn btn-default">Close</button>
                                                                    </div>
                                                                </div> <!--/.modal-content -->
                                                            </div> <!--/.modal -->
                                                            </tr>

                                                            <%
                                                                    i++;
                                                                }
                                                            %>
                                                            <div class="md-overlay"></div>
                                                            </tbody>

                                                        </table>
                                                    </div>
                                                </div><!--Ongoing Service-->

                                                <div class="tab-pane fade" id="Completed_Service" >
                                                    <div class="table-responsive">
                                                        <table id="example2" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                            <thead>
                                                                <tr>
                                                                    <th class="sortable">DateTime</th>
                                                                    <th class="sortable">Name</th>
                                                                    <th class="sortable">No. Plate</th>
                                                                    <th class="sortable">Services</th>
                                                                    <!--<th class="sortable">Email</th>-->
                                                                    <th class="sortable">Phone</th>
                                                                    <!--<th>Attachment</th>-->
                                                                    <th>More Info</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="contents">
                                                                <!--Loop per new request-->
                                                                <%
                                                                    qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 7, "requested_datetime", "desc");
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
                                                                        double finalPrice = offer.getFinalPrice();


                                                                %>
                                                                <tr>
                                                                    <td><% out.print(dateTime);%></td>
                                                                    <td><% out.print(custName);%></td>
                                                                    <td><% out.print(carPlate);%></td>
                                                                    <td><% out.print(serviceName);%></td>
                                                                    <td><% out.print(custPhone);%></td>
                                                                    <!--Picture Attachment-->
                                                                    <!--<td class="text-center"><a href="<% out.print("#myModal" + i);%>" id="myBtn" data-toggle="modal"><img src="images/file.png"/></a></td>-->

                                                                    <!-- Modal -->
                                                            <div class="modal fade" id="<% out.print("myModal" + i);%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                                <div class="modal-dialog-img">
                                                                    <div class="modal-content">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                                        <div class="modal-header">
                                                                            <h4 class="modal-title"><% out.print(carMake + " " + carModel + " - " + carYear);%></h4>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <img class="img-responsive"src="<%="http://119.81.43.85/uploads/" + carPhoto%>"/>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                            <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                                                                        </div>
                                                                    </div> <!--/.modal-content--> 
                                                                </div><!-- /.modal-dialog -->
                                                            </div><!-- /.modal -->
                                                            <% i++; %>
                                                            <!--Quote-->
                                                            <td class="text-center"><button class="btn btn-default btn-xs md-trigger" data-modal="<% out.print("myModal" + i);%>" id="quoteBtn" type="button" onclick="subscribe(<%=serviceId%>, <%=wsID%>, <%=userID%>, '<%=custName%>', '<%=chatToken%>', 'log<%=serviceId%>');"><span>Quote</span></button></td>

                                                            <!-- Modal -->
                                                            <div class="md-modal md-effect-13 md-slategray colorize-overlay " id="<% out.print("myModal" + i);%>">

                                                                <div class="md-content">
                                                                    <!--<div>-->
                                                                    <div class="col-xs-6">
                                                                        <h4 class="modal-title">Completed Service - <% out.print(custName);%></h4>
                                                                    </div>
                                                                    <div class="col-xs-6 text-right">
                                                                        <h4 class="modal-title"><%=dateTime%></h4>
                                                                    </div>
                                                                    <!--</div>-->
                                                                    <!--<div>-->
                                                                    <div class='col-xs-12'>

                                                                        <div class="col-xs-12">
                                                                            <h3>Service Details</h3>
                                                                        </div>
                                                                        <div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Service Request: </b><br><% out.print(serviceName);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Urgency: </b><br><% out.print(serviceUrgency);%></p>
                                                                            </div>
                                                                            <div class="col-xs-12">
                                                                                <p><b>Service Description: </b><br><% out.print(serviceDescription);%></p>
                                                                            </div>      
                                                                        </div>
                                                                        <!--</div>-->
                                                                        <div>
                                                                            <div class="col-xs-12">
                                                                                <h3>Car Details</h3>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>License Plate: </b><br><% out.print(carPlate);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Vehicle Model: </b><br><% out.print(carMake + " " + carModel);%></p>
                                                                            </div>
                                                                            <p></p>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Vehicle Year: </b><br><% out.print(carYear);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Vehicle Type: </b><br><% out.print(carControl);%></p>
                                                                            </div> 
                                                                            <div class="col-xs-6">
                                                                                <p><b>Vehicle Color: </b><br><% out.print(carColor);%></p>
                                                                            </div>
                                                                            <div class="col-xs-6">
                                                                                <p><b>Mileage: </b><br><% out.print(serviceMileage);%></p>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-xs-12">
                                                                            Agreed Amount: $<%=finalPrice%>
                                                                        </div>
                                                                    </div>
                                                                    <div class='col-xs-6'></div>
                                                                    <div class="col-xs-12">
                                                                        <button class="md-close btn btn-default">Close</button> 
                                                                    </div>

                                                                </div> <!--/.modal-content -->
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
                                                </div><!--Completed Service-->





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
                                                                $(function () {

                                                                    var contentHeight = $('#content').height();
                                                                    var chatInboxHeight = contentHeight - 178;
                                                                    var chatContentHeight = contentHeight - 178 - 200;
                                                                    var setChatHeight = function () {
                                                                        $('#chat-inbox').css('height', chatInboxHeight);
                                                                        $('#chat-content').css('height', chatContentHeight);
                                                                    };
                                                                    setChatHeight();
                                                                    $(window).resize(function () {
                                                                        contentHeight = $('#content').height();
                                                                        chatInboxHeight = contentHeight - 178;
                                                                        chatContentHeight = contentHeight - 178 - 200;
                                                                        setChatHeight();
                                                                    });
                                                                    $("#chat-inbox").niceScroll({
                                                                        cursorcolor: '#000000',
                                                                        zindex: 999999,
                                                                        bouncescroll: true,
                                                                        cursoropacitymax: 0.4,
                                                                        cursorborder: '',
                                                                        cursorborderradius: 0,
                                                                        cursorwidth: '5px'
                                                                    });
                                                                    $("#chat-content").niceScroll({
                                                                        cursorcolor: '#000000',
                                                                        zindex: 999999,
                                                                        bouncescroll: true,
                                                                        cursoropacitymax: 0.4,
                                                                        cursorborder: '',
                                                                        cursorborderradius: 0,
                                                                        cursorwidth: '5px'
                                                                    });
                                                                    $('#chat-inbox .chat-actions > span').tooltip({
                                                                        placement: 'top',
                                                                        trigger: 'hover',
                                                                        html: true,
                                                                        container: 'body'
                                                                    });
                                                                    $('#initialize-search').click(function () {
                                                                        $('#chat-search').toggleClass('active').focus();
                                                                    });
                                                                    $(document).click(function (e) {
                                                                        if (($(e.target).closest("#initialize-search").attr("id") != "initialize-search") && $(e.target).closest("#chat-search").attr("id") != "chat-search") {
                                                                            $('#chat-search').removeClass('active');
                                                                        }
                                                                    });
                                                                    $(window).mouseover(function () {
                                                                        $("#chat-inbox").getNiceScroll().resize();
                                                                        $("#chat-content").getNiceScroll().resize();
                                                                    });
                                                                });</script>
    <!--        <script>
                $(function () {
    
                    //check all checkboxes
                    $('table thead input[type="checkbox"]').change(function () {
                        $(this).parents('table').find('tbody input[type="checkbox"]').prop('checked', $(this).prop('checked'));
                    });
    
                    // sortable table
                    $('.table.table-sortable1 th.sortable').click(function () {
                        var o = $(this).hasClass('sort-asc') ? 'sort-desc' : 'sort-asc';
                        $(this).parents('table').find('th.sortable').removeClass('sort-asc').removeClass('sort-desc');
                        $(this).addClass(o);
                    });
    
                    //chosen select input
                    $(".chosen-select").chosen({disable_search_threshold: 10});
    
                    //check toggling
                    $('.check-toggler').on('click', function () {
                        $(this).toggleClass('checked');
                    });
                });
    
            </script>-->
    <script>
        //        $(function(){
        //            $('.table.table-sortable1 th.sortable').click(function () {
        //                var o = $(this).hasClass('sort-asc') ? 'sort-desc' : 'sort-asc';
        //                $(this).parents('table').find('th.sortable').removeClass('sort-asc').removeClass('sort-desc');
        //                $(this).addClass(o);
        //            });
        //        });


    </script>
    <script>
        $(document).ready(function ()
        {
            //        $("#myTable1").tablesorter({
            //            sortList: [[0,0],[1,0]]
            //        });
            //        $("#myTable2").tablesorter({
            //            sortList: [[0,0],[1,0]]
            //        });
            //        $("#myTable3").tablesorter({
            //            sortList: [[0,0],[1,0]]
            //        });
            //        $("#myTable4").tablesorter({
            //            sortList: [[0,0],[1,0]]
            //        });
            //        $("#myTable5").tablesorter({
            //            sortList: [[0,0],[1,0]]
            //        });
            //        $("#myTable1").tablesorter();
            //        $("#myTable2").tablesorter();
            //        $("#myTable3").tablesorter();
            //        $("#myTable4").tablesorter();
            //        $("#myTable5").tablesorter();
        }
        );</script>
    <script>         //Script to load tab and data based on the href #
        $(window).load(function () {
            var url = document.URL;
            if (url.includes('#')) {
                url = url.substring(url.indexOf('#'));
                console.log(url);
            }
            $('.nav-pills li a').each(function () {
                var link = $(this).attr("href");
                console.log(link);
                if (link === url) {
                    $(this).parent().siblings().removeClass('active');
                    $(this).parent().addClass('active');
                }
            });
            url = url.substring(1);
            console.log(url);
            $(".tab-pane").each(function () {
                var tab = $(this).attr('id');
                if (tab === url) {
                    $(this).siblings().removeClass('active in');
                    $(this).addClass('active in');
                }
            });
        });</script>
    <script>
        $('.dropdown-menu li').on('click', function () {
            $(this).siblings().removeClass('active');
            var link = $(this).text();
            document.getElementById("select").innerHTML = link + " <span class='caret'></span>";
        });</script>
    <script>
        (function (document) {
            'use strict';
            var LightTableFilter = (function (Arr) {

                var _input;
                function _onInputEvent(e) {
                    _input = e.target;
                    var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
                    Arr.forEach.call(tables, function (table) {
                        Arr.forEach.call(table.tBodies, function (tbody) {
                            Arr.forEach.call(tbody.rows, _filter);
                        });
                    });
                }

                function _filter(row) {
                    var text = row.textContent.toLowerCase(), val = _input.value.toLowerCase();
                    row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';
                }

                return {
                    init: function () {
                        var inputs = document.getElementsByClassName('light-table-filter');
                        Arr.forEach.call(inputs, function (input) {
                            input.oninput = _onInputEvent;
                        });
                    }
                };
            })(Array.prototype);
            document.addEventListener('readystatechange', function () {
                if (document.readyState === 'complete') {
                    LightTableFilter.init();
                }
            });
        })(document);</script>
    <script>
        //    var acc = document.getElementsByClassName("accordion");
        //    var i;
        //
        //    for (i = 0; i < acc.length; i++) {
        //        acc[i].onclick = function () {
        //            this.classList.toggle("active");
        //        this.nextElementSibling.classList.toggle("show");
        //        }
        //    }
    </script>
    <script type="text/javascript">
//        function displaymsg() {
//            var msg = '<%=session.getAttribute("isSuccess")%>';
//            if (msg != "null") {
//                //                function alertName(msg) {
//                alert(msg);
//                //            }
//            }
//        <%session.setAttribute("isSuccess", "null");%>
//        }
    </script> 
    <!--<script type="text/javascript"> window.onload = alertName;</script>-->
    <script type="text/JavaScript">
        function timedRefresh(timeoutPeriod) {
        setTimeout("location.reload(true);",timeoutPeriod);
        } 
        //    window.onload = timedRefresh(300000);
    </script>
    <script>
        function start() {
            timedRefresh(300000);
            displaymsg();
        }
        window.onload = start;</script>
    <script>
        $("#accordion > li > span").click(function () {
            $(this).toggleClass("active").next('div').slideToggle(250)
                    .closest('li').siblings().find('span').removeClass('active').next('div').slideUp(250);
        });</script>
    <script>
        //    $(document).ready(function () {
        //        $(".tabpager").tabpager({
        ////  maximum visible items
        //            items: 5,
        //// CSS class for tabbed content
        //            contents: 'contents',
        //// transition speed
        //            time: 300,
        //// text for previous button
        //            previous: '&laquo;Prev',
        //// text for next button
        //            next: 'Next&raquo;',
        //// initial tab
        //            start: 1,
        //// top or bottom
        //            position: 'bottom',
        //// scrollable
        //            scroll: true
        //        });
        //    });

    </script>
    <script>
        $(document).ready(function () {
            $('#example').DataTable();
            $('#example2').DataTable();
            $('#example3').DataTable();
            $('#example4').DataTable();
            $('#example5').DataTable();
        });</script>
    <script>
        function subscribe(requestID, wsID, userID, custName, chatToken, log) {
//                event.preventDefault();
            $("#" + log).html("");
//                $(this).parent().siblings().children().removeClass("active").remove;
//                $(this).addClass("active").removeClass("unread");
//                var uid = this.id;
//                var arr = uid.split("-");
//                var topicId = arr[0];
//                var userId = arr[1];
//                var userName = arr[2];
//                var shopID = arr[3];
//                $("#chatHead li h3").html(userName);
            $.ajax({
                type: 'POST',
                url: 'http://119.81.43.85/chat/retrive_chat_history',
                crossDomain: true,
                data: {
                    "type_of_message": "2",
                    "no_of_message_display": "20",
                    "driver_id": userID,
                    "token": "<%=token%>",
                    "staff_id": "<%=staffID%>",
                    "service_id": requestID
                },
                dataType: 'json',
                success: function (data) {
//                        $.each(data.items, function(i,item)){
//                            console.log(i + ": " + item);
//                        }
                    console.log(data);
                    if (data.is_success == true) {
                        var msg = data.payload.chat_message;
                        for (i = msg.length - 1; i >= 0; i--) {
                            console.log(msg[i].message);
                            if (msg[i].type == "0") {
                                var time = msg[i].modified.substring(0, msg[i].modified.lastIndexOf(":"));
                                $("#" + log).html($("#" + log).html() + '<li class="message sent" id="' + msg[i].topic_id + '"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">You</a> <span class="time">' + time + '</span></p>' + msg[i].message + '</div></div></li>');
                            } else {
                                $("#" + log).html($("#" + log).html() + '<li class="message receive" id="' + msg[i].topic_id + '"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">' + custName + '</a> <span class="time">' + time + '</span></p>' + msg[i].message + '</div></div></li>');
                            }
                        }
                        if (msg.length > 0 && msg[0].topic_id != 0) {
                            $(".md-show").find(".ct").html('<div class="hidden chatTopic" id="' + msg[0].topic_id + '"></div>');
                        } else {
                            $(".md-show").find(".ct").html('<div class="hidden chatTopic" id="0"></div>');
                        }
                    }
                    subscribeChat(requestID, wsID, custName, chatToken, log);
                },
                error: function () {
                    alert("fail");
                }
            });
        }
//            if (sender != "Web") {
//                $("#log").html('<li class="message sent"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="assets/images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">John Douey</a> <span class="time">' + time + '</span></p>' + message + '</div></div></li>' + $("#log").html());
//            } else {
//                $("#log").html('<li class="message receive"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="assets/images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">John Douey</a> <span class="time">' + time + '</span></p>' + message + '</div></div></li>' + $("#log").html());
//
//            }
    </script>
    <script>
        $(function () {
            $(".msgInput").keypress(function (e) {
                if (e.which == 13) {
                    prepareMsg();
                    e.preventDefault();
                }
            });
        });

    </script>
    <script>
//        $(".sendMsg").click(function () {
//            prepareMsg();
//        });
    </script>
    <script>
        function prepareMsg() {
            var ele = $(".md-show").find(".sendMsg");
            var msgDetails = ele[0].id;
//            var elem = ele.prevObject[0].context;
//            var msgDetails = ele[0].id;
            var detailsArr = msgDetails.split("-");
            var serviceId = detailsArr[0];
            var wsName = detailsArr[1];
            var wsId = detailsArr[2];
            var staffId = detailsArr[3];
            var token = detailsArr[4];
            var firstMsg = true;
            var topicID = 0;
            var chatTopic = $(".md-show").find(".chatTopic");
            topicID = chatTopic[0].id;
            console.log(topicID);
            var chat = $(".md-show").find(".chat-list > li");
            var msg = $(".md-show").find(".msgInput");
            var msgInput = msg[0].id;
            if (chat.length > 0) {
                firstMsg = false;
//                var topic = chat[0];
//                topicID = topic.id;
            }
            sendMsg(serviceId, wsName, wsId, staffId, token, topicID, firstMsg, msgInput);
        }
    </script>
    <script>
        intercom("<%=user_name%>", "<%=user_email%>",<%=staffID%>, "<%=phone_number%>", "<%=workshop_name%>", "<%=categories%>", "<%=brands_carried%>");
    </script>
</html>
