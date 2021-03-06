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
        <title>Request</title>
        <jsp:include page="include/head.jsp"/>
    </head>
    <style>
        #accordion {
            list-style: none;
            padding: 2px;
        }
        #accordion > li {
            display: block;
            list-style: none;
        }
        #accordion > li > span {
            display: block;
            color: #fff;
            margin: 4px 0;
            padding: 6px;
            background: url(images/expand_arrow.png) no-repeat 99.5% 6px #525252;
            background-size: 20px;
            font-weight: normal;
            cursor: pointer; font-size:16px
        }
        #accordion > li > div {
            list-style: none;
            padding: 6px;
            display: none; overflow:auto
        }
        #accordion > ul li {
            font-weight: normal;
            cursor: auto;
            padding: 0 0 0 7px;
        }
        #accordion a {
            text-decoration: none;
        }
        #accordion li > span:hover {
        }
        #accordion li > span.active {
            background: url(images/collapse-arrow.png) no-repeat 99.5% 6px #000;
            background-size: 20px
        }
        #accordion li > span:after {
            content: '\02795'; /* Unicode character for "plus" sign (+) */
            font-size: 13px;
            color: #fff;
            float: right;
            margin-left: 5px;

        }

        #accordion li > span.active:after {
            content: "\2796"; /* Unicode character for "minus" sign (-) */
        }

    </style>
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
//            HashMap<Integer, Integer> statusSize = qDAO.retrieveStatusSize(user.getStaffId(), user.getToken(), 0, 0, "", "requested_datetime", "desc");
//            int newSize = statusSize.get(0);
//            int sendFinalSize = statusSize.get(1);
//            int finalAcceptSize = statusSize.get(2);


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
                        <%    String success = (String) session.getAttribute("isSuccess");
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
                                            <h1><strong>View Request</strong></h1>
                                        </div>
                                        <!-- /tile header -->

                                        <!-- tile widget -->
                                        <div class="tile-widget bg-transparent-white-2">
                                            <div class="row">

                                                <div class="col-sm-12 col-xs-12 text-right">

                                                    <!--                                                <div class="btn-group btn-group-xs table-options">
                                                                                                        <button type="button active" class="btn btn-default" href="#New">New</button>
                                                                                                        <button type="button" class="btn btn-default" href="#Ongoing">Ongoing</button>
                                                                                                        <button type="button" class="btn btn-default" href="#Completed">Completed</button>
                                                                                                        <button type="button" class="btn btn-default" href="#All">All</button>
                                                                                                    </div>-->


                                                    <div class="btn-group btn-group-xs table-options desktopOnly">
                                                        <ul class="nav nav-pills tabpager">
                                                            <!--                                                            <li class="active"><a href="#New" data-toggle="pill">New Request</a></li>
                                                                                                                        <li><a href="#Waiting_for_Response" data-toggle="pill">Waiting for Response</a></li>-->
                                                            <li class="active"><a href="#Send_Final_Quote" data-toggle="pill">Send Final Quote</a></li>
                                                            <li><a href="#Awaiting_Final_Confirmation" data-toggle="pill">Awaiting Final Confirmation</a></li>
                                                            <!--
                                                                                                                                                                                    <li><a href="#Final_Quote_Accepted" data-toggle="pill">Final Quote Accepted</a></li>-->
                                                            <!--<li><a href="#All" data-toggle="pill">All</a></li>-->
                                                        </ul>
                                                    </div>
                                                    <!--                                                <div class="btn-group mobileOnly" style="float:right">
                                                                                                        <button type="button" class="btn btn-default dropdown-toggle " data-toggle="dropdown" id='select'>
                                                                                                            Select <span class="caret"></span>
                                                                                                        </button>
                                                    
                                                                                                        <ul class="dropdown-menu tabpager" id="requestDropdown" role="menu" >
                                                                                                            <li class="active"><a href="#New" data-toggle="pill">New Request</a></li>
                                                                                                            <li><a href="#Waiting_for_Response" data-toggle="pill">Waiting for Response</a></li>
                                                                                                            <li><a href="#Send_Final_Quote" data-toggle="pill">Send Final Quote</a></li>
                                                                                                            <li><a href="#Awaiting_Final_Confirmation" data-toggle="pill">Awaiting Final Confirmation</a></li>
                                                                                                            <li><a href="#Final_Quote_Accepted" data-toggle="pill">Final Quote Accepted</a></li>
                                                                                                            <li><a href="#All" data-toggle="pill">All</a></li>
                                                                                                        </ul>
                                                                                                    </div>-->
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
                                                    HashMap<Integer, QuotationRequest> qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 3, "requested_datetime", "desc");


                                                %>



                                                <div class="tab-pane fade active in" id="Send_Final_Quote" >
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
                                                                    <!--<th>Attachment</th>-->
                                                                    <th>Quote</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="contents">
                                                                <!--Loop per new request-->
                                                                <%                                                                    qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 3, "requested_datetime", "desc");
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
                                                                        String ownerNric = vehicle.getOwnerNric();
                                                                        String chassisNum = vehicle.getChassisNum();

                                                                        Offer offer = qr.getOffer();
                                                                        String driverInitialComment = offer.getDriverInitialComment();
                                                                        String wsInitialComment = offer.getWsInitialComment();
                                                                        double minPrice = offer.getInitialMinPrice();
                                                                        String min = minPrice + "0";
                                                                        double maxPrice = offer.getInitialMaxPrice();
                                                                        String max = maxPrice + "0";
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
                                                                    <!--<td  //class="text-center"><a href="<%// out.print("#myModal" + i);%>" id="myBtn" data-toggle="modal"><img src="images/file.png"/></a></td>-->

                                                                    <!-- Modal -->
                                                            <div class="modal fade" id="<% out.print("myModal" + i);%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

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
                                                    <div class="md-modal md-effect-13 md-slategray colorize-overlay" id="<% out.print("myModal" + i);%>">

                                                        <div class="md-content">
                                                            <!--<div>-->
                                                            <div class="col-xs-6">
                                                                <h4 class="modal-title">Send Final Quote - <% out.print(custName);%></h4>
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
                                                                    <div class="col-xs-12">
                                                                        <p><b>Service Request: </b><br><% out.print(serviceName);%></p>
                                                                    </div>
                                                                    <div class="col-xs-12">
                                                                        <p><b>Service Description: </b><br><% out.print(serviceDescription);%></p>
                                                                    </div>      
                                                                    <div class="col-xs-12">
                                                                        <p><b>Workshop Comment: </b><br><% out.print(wsInitialComment);%></p>
                                                                    </div>      
                                                                    <div class="col-xs-12">
                                                                        <p><b>Driver Comment: </b><br><% out.print(driverInitialComment);%></p>
                                                                    </div>      
                                                                </div>
                                                                <!--</div>-->
                                                                <div>
                                                                    <div class="col-xs-12">
                                                                        <h3>Car Details</h3>
                                                                    </div>
                                                                    <div class="col-xs-6">
                                                                        <p><b>Owner NRIC: </b><br><% out.print(ownerNric);%></p>
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
                                                                        <p><b>Chassis Number: </b><br><% out.print(chassisNum);%></p>
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
                                                                    <ul id="accordion">
                                                                        <li><span><b>Final Quotation Amount</b></span>
                                                                            <div class="panel">
                                                                                <form action="AddFinalQuotation" method="post">
                                                                                    <div class="col-xs-12">
                                                                                        Final Price: $ <input type="number" name="price" placeholder="<%=min%> - <%=max%>" required/>
                                                                                    </div>
                                                                                    <div class="col-xs-12">
                                                                                        <b>Remarks: </b><textarea class="form-control remarks customTextArea" id="comment" rows="5" name="comment" style="background-color: white"></textarea>
                                                                                    </div>
                                                                                    <input type="hidden" name="id" value="<%=offerId%>">
                                                                                    <input type="hidden" name="serviceId" value="<%=id%>">
                                                                                    <button type="submit" class="btn btn-primary">Submit Quote</button>
                                                                                </form>
                                                                            </div>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            <div class="col-xs-12">
                                                                <button class="md-close btn btn-default">Close</button>
                                                            </div>
                                                        </div><!-- /.modal-content -->
                                                    </div><!-- /.modal -->
                                                    </tr>

                                                    <%
                                                            i++;
                                                        }
                                                    %>
                                                    <div class="md-overlay"></div>
                                                    </tbody>

                                                    </table>
                                                </div>
                                            </div><!--Send Final Quote-->

                                            <div class="tab-pane fade " id="Awaiting_Final_Confirmation" >
                                                <div class="table-responsive">
                                                    <table id="example2" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                        <thead>
                                                            <tr>
                                                                <th class="sortable">ID</th>
                                                                <th class="sortable">DateTime</th>
                                                                <th class="sortable">Name</th>
                                                                <th class="sortable">No. Plate</th>
                                                                <th class="sortable">Car Model</th>
                                                                <th class="sortable">Services</th>
                                                                <!--<th>Attachment</th>-->
                                                                <th>Details</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody class="contents">
                                                            <!--Loop per new request-->
                                                            <%
                                                                qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 4, "requested_datetime", "desc");
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
                                                                    String ownerNric = vehicle.getOwnerNric();
                                                                    String chassisNum = vehicle.getChassisNum();

                                                                    Offer offer = qr.getOffer();
                                                                    String driverInitialComment = offer.getDriverInitialComment();
                                                                    String wsFinalComment = offer.getWsFinalComment();
                                                                    double afinalPrice = offer.getFinalPrice();
                                                                    String finalPrice = afinalPrice + "0";
                                                            %>
                                                            <tr>
                                                                <td><% out.print(serviceId);%></td>
                                                                <td><% out.print(dateTime);%></td>
                                                                <td><% out.print(custName);%></td>
                                                                <td><% out.print(carPlate);%></td>
                                                                <td><% out.print(carModel);%></td>
                                                                <td><% out.print(serviceName);%></td>
                                                                <!--Picture Attachment-->
                                                                <!--<td class="text-center"><a href="<%// out.print("#myModal" + i);%>" id="myBtn" data-toggle="modal"><img src="images/file.png"/></a></td>-->

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
                                                        <td class="text-center"><button class="btn btn-default btn-xs md-trigger" data-modal="<% out.print("myModal" + i);%>" id="quoteBtn" type="button" onclick="subscribe(<%=serviceId%>, <%=wsID%>, <%=userID%>, '<%=custName%>', '<%=chatToken%>', 'log<%=serviceId%>');"><span>More Info</span></button></td>

                                                        <!-- Modal -->
                                                        <div class="md-modal md-effect-13 md-slategray colorize-overlay" id="<% out.print("myModal" + i);%>">

                                                            <div class="md-content">
                                                                <!--<div>-->
                                                                <div class="col-xs-6">
                                                                    <h4 class="modal-title">Awaiting Final Confirmation - <% out.print(custName);%></h4>
                                                                </div>
                                                                <div class="col-xs-6 text-right">
                                                                    <h4 class="modal-title"><%=dateTime%></h4>
                                                                </div>
                                                                <!--</div>-->
                                                                <!--<div>-->
                                                                <div class="col-xs-12">
                                                                    <div class="col-xs-12">
                                                                        <h3>Service Details</h3>
                                                                    </div>
                                                                    <div>
                                                                        <div class="col-xs-12">
                                                                            <p><b>Service Request: </b><br><% out.print(serviceName);%></p>
                                                                        </div>
                                                                        <div class="col-xs-12">
                                                                            <p><b>Service Description: </b><br><% out.print(serviceDescription);%></p>
                                                                        </div>      
                                                                        <div class="col-xs-12">
                                                                            <p><b>Driver Comment: </b><br><% out.print(driverInitialComment);%></p>
                                                                        </div>      
                                                                        <div class="col-xs-12">
                                                                            <p><b>Workshop Comment: </b><br><% out.print(wsFinalComment);%></p>
                                                                        </div>      
                                                                    </div>
                                                                    <!--</div>-->
                                                                    <div>
                                                                        <div class="col-xs-12">
                                                                            <h3>Car Details</h3>
                                                                        </div>
                                                                        <div class="col-xs-6">
                                                                            <p><b>Owner NRIC: </b><br><% out.print(ownerNric);%></p>
                                                                        </div>
                                                                        <div class="col-xs-6">
                                                                            <p><b>License Plate: </b><br><% out.print(carPlate);%></p>
                                                                        </div>
                                                                        <div class="col-xs-6">
                                                                            <p><b>Vehicle Model: </b><br><% out.print(carMake + " " + carModel);%></p>
                                                                        </div>
                                                                        <div class="col-xs-6">
                                                                            <p><b>Vehicle Year: </b><br><% out.print(carYear);%></p>
                                                                        </div>
                                                                        <div class="col-xs-6">
                                                                            <p><b>Chassis Number: </b><br><% out.print(chassisNum);%></p>
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
                                                                        Final Quotation: $<%=finalPrice%>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xs-12">
                                                                    <button class="md-close btn btn-default">Close</button>
                                                                </div>
                                                                <!--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>-->
                                                            </div><!-- /.modal-content -->
                                                        </div><!-- /.modal -->
                                                        </tr>

                                                        <%
                                                                i++;
                                                            }
                                                        %>
                                                        <div class="md-overlay1"></div>
                                                        </tbody>

                                                    </table>
                                                </div>
                                            </div><!--Awaiting Final Confirmation-->

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

                                                            });


    </script>    
    <script>
        $("#accordion > li > span").click(function () {
            $(this).toggleClass("active").next('div').slideToggle(250)
                    .closest('li').siblings().find('span').removeClass('active').next('div').slideUp(250);
        });</script>
    <script>
        $(document).ready(function () {
            $('#example').DataTable();
            $('#example2').DataTable();
            $('#example3').DataTable();
            $('#example4').DataTable();
            $('#example5').DataTable();
        });
    </script>
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
