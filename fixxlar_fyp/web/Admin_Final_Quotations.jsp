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
<%@include file="ProtectAdmin.jsp"%>
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
                                        <%@include file="include/admin_flipcard.jsp"%>
                                        <!--                                        <div class="row cards">
                                        
                                                                                    <div class="card-container col-lg-2 col-sm-6 col-sm-12">
                                                                                        <div class="card card-redbrown hover">
                                                                                            <div class="front"> 
                                        
                                                                                                <div class="media">        
                                                                                                                                                                <span class="pull-left">
                                                                                                                                                                    <i class="fa fa-users media-object"></i>
                                                                                                                                                                </span>
                                        
                                                                                                    <div class="media-body">
                                                                                                        New Requests
                                                                                                        <h2 class="media-heading animate-number" data-value="<%//=newSize%>" data-animation-duration="1500">0</h2>
                                                                                                    </div>
                                                                                                </div> 
                                        
                                                                                            </div>
                                                                                            <div class="back">
                                                                                                <a href="New_Request.jsp">
                                                                                                    <i class="fa fa-bar-chart-o fa-4x"></i>
                                                                                                    <span>More Information</span>
                                                                                                </a>  
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                        
                                        
                                                                                    <div class="card-container col-lg-2 col-sm-6 col-sm-12">
                                                                                        <div class="card card-redbrown hover">
                                                                                            <div class="front">        
                                        
                                                                                                <div class="media">                  
                                                                                                                                                                <span class="pull-left">
                                                                                                                                                                    <i class="fa fa-shopping-cart media-object"></i>
                                                                                                                                                                </span>
                                        
                                                                                                    <div class="media-body">
                                                                                                        Send Final Quote
                                                                                                        <h2 class="media-heading animate-number" data-value="<%//=sendFinalSize%>" data-animation-duration="1500">0</h2>
                                                                                                    </div>
                                                                                                </div> 
                                        
                                                                                            </div>
                                                                                            <div class="back">
                                                                                                <a href="Send_Final_Quote.jsp">
                                                                                                    <i class="fa fa-bar-chart-o fa-4x"></i>
                                                                                                    <span>More Information</span>
                                                                                                </a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                        
                                        
                                        
                                                                                    <div class="card-container col-lg-2 col-sm-6 col-sm-12">
                                                                                        <div class="card card-redbrown hover">
                                                                                            <div class="front">        
                                        
                                                                                                <div class="media">
                                                                                                                                                                <span class="pull-left">
                                                                                                                                                                    <i class="fa fa-usd media-object"></i>
                                                                                                                                                                </span>
                                        
                                                                                                    <div class="media-body">
                                                                                                        Final Quote Accepted
                                                                                                        <h2 class="media-heading animate-number" data-value="<%//=finalAcceptSize%>" data-animation-duration="1500">0</h2>
                                                                                                    </div>
                                                                                                </div>
                                        
                                        
                                        
                                                                                            </div>
                                                                                            <div class="back">
                                                                                                <a href="Final_Quote_Accepted.jsp">
                                                                                                    <i class="fa fa-bar-chart-o fa-4x"></i>
                                                                                                    <span>More Information</span>
                                                                                                </a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="card-container col-lg-2 col-sm-6 col-sm-12">
                                                                                        <div class="card card-greensea hover">
                                                                                            <div class="front">        
                                        
                                                                                                <div class="media">
                                                                                                                                                                <span class="pull-left">
                                                                                                                                                                    <i class="fa fa-usd media-object"></i>
                                                                                                                                                                </span>
                                        
                                                                                                    <div class="media-body">
                                                                                                        New Service
                                                                                                        <h2 class="media-heading animate-number" data-value="<%//=finalAcceptSize%>" data-animation-duration="1500">0</h2>
                                                                                                    </div>
                                                                                                </div>
                                        
                                        
                                        
                                                                                            </div>
                                                                                            <div class="back">
                                                                                                <a href="New_Service.jsp">
                                                                                                    <i class="fa fa-bar-chart-o fa-4x"></i>
                                                                                                    <span>More Information</span>
                                                                                                </a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="card-container col-lg-2 col-sm-6 col-sm-12">
                                                                                        <div class="card card-greensea hover">
                                                                                            <div class="front">        
                                        
                                                                                                <div class="media">
                                                                                                                                                                <span class="pull-left">
                                                                                                                                                                    <i class="fa fa-usd media-object"></i>
                                                                                                                                                                </span>
                                        
                                                                                                    <div class="media-body">
                                                                                                        Completed Service
                                                                                                        <h2 class="media-heading animate-number" data-value="<%//=finalAcceptSize%>" data-animation-duration="1500">0</h2>
                                                                                                    </div>
                                                                                                </div>
                                        
                                        
                                        
                                                                                            </div>
                                                                                            <div class="back">
                                                                                                <a href="Completed_Service.jsp">
                                                                                                    <i class="fa fa-bar-chart-o fa-4x"></i>
                                                                                                    <span>More Information</span>
                                                                                                </a>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                        
                                                                                    <div class="card-container col-lg-2 col-sm-6 col-xs-12">
                                                                                        <div class="card1 card-slategray hover">
                                                                                            <div class="front"> 
                                        
                                                                                                <div class="media">                   
                                                                                                                                                                <span class="pull-left">
                                                                                                                                                                    <i class="fa fa-eye media-object"></i>
                                                                                                                                                                </span>
                                        
                                                                                                    <div class="media-body">
                                                                                                        Average Rating
                                                                                                        <h2 class="media-heading animate-number" data-value="4.2" data-animation-duration="1500">0</h2>
                                                                                                    </div>
                                                                                                </div> 
                                                                                            </div>
                                                                                                                                                <div class="back">
                                                                                                                                                    <a href="#">
                                                                                                                                                        <i class="fa fa-bar-chart-o fa-4x"></i>
                                                                                                                                                        <span>Check Summary</span>
                                                                                                                                                    </a>
                                                                                                                                                </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>-->
                                        <!-- /cards -->
                                    </div>
                                    <!-- /tile body -->
                                </section>
                                <!-- /tile -->
                            </div>
                            <!-- /col 12 -->        
                        </div>
                        <!-- /row -->






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
                                            <!--                                        <div class="search">
                                                                                        <input type="search" class="light-table-filter" data-table="order-table" placeholder="Filter">
                                                                                    </div>-->
                                            <!--                                            <div class="controls">
                                                                                            <a href="#" class="minimize"><i class="fa fa-chevron-down"></i></a>
                                                                                            <a href="#" class="refresh"><i class="fa fa-refresh"></i></a>
                                                                                            <a href="#" class="remove"><i class="fa fa-times"></i></a>
                                                                                        </div>-->
                                        </div>
                                        <!-- /tile header -->

                                        <!-- tile widget -->
                                        <div class="tile-widget bg-transparent-white-2">
                                            <div class="row">

                                                <!--                                            <div class="col-sm-2 col-xs-3">
                                                                                                <div class="search" id="requestSearch">
                                                                                                    <input type="search" class="light-table-filter" data-table="order-table" placeholder="Filter">
                                                                                                </div>
                                                                                                                                                <div class="input-group table-options">
                                                                                                                                                    <select class="chosen-select form-control">
                                                                                                                                                        <option>Bulk Action</option>
                                                                                                                                                        <option>Delete Selected</option>
                                                                                                                                                        <option>Copy Selected</option>
                                                                                                                                                        <option>Archive Selected</option>
                                                                                                                                                    </select>
                                                                                                                                                    <span class="input-group-btn">
                                                                                                                                                        <button class="btn btn-default" type="button">Apply</button>
                                                                                                                                                    </span>
                                                                                                                                                </div>
                                                                                            </div>-->

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
                                                                                                                        <li><a href="#Waiting_for_Response" data-toggle="pill">Waiting for Response</a></li>
                                                                                                                        <li><a href="#Send_Final_Quote" data-toggle="pill">Send Final Quote</a></li>
                                                                                                                        <li><a href="#Awaiting_Final_Confirmation" data-toggle="pill">Awaiting Final Confirmation</a></li>-->
                                                            <li class="active"><a href="#Final_Quote_Accepted" data-toggle="pill">Final Quote Accepted</a></li>
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
                                                <%                                                
                                                    int i = 1;
                                                    qDAO = new QuotationRequestDAO();
                                                    HashMap<Integer, QuotationRequest> qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 5, "requested_datetime", "desc");


                                                %>

                                                <div class="tab-pane fade active in" id="Final_Quote_Accepted" >
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
                                                                    <th>Details</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="contents">
                                                                <!--Loop per new request-->
                                                                <%                                                                    qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 5, "requested_datetime", "desc");
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

                                                                        Customer cust = qr.getCustomer();
                                                                        String custName = cust.getName();
                                                                        String custEmail = cust.getEmail();
                                                                        String custPhone = cust.getHandphone();

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
                                                                        </div>
                                                                    </div> <!--/.modal-content--> 
                                                                </div> <!--/.modal-dialog--> 
                                                            </div><!--/.modal--> 
                                                            <% i++; %>
                                                            <!--Quote-->
                                                            <td class="text-center"><button href="<% out.print("#myModal" + i);%>" class="btn btn-default btn-xs" data-toggle="modal" id="quoteBtn" type="button"><span>More Info</span></button></td>

                                                            <!-- Modal -->
                                                            <div class="modal fade" id="<% out.print("myModal" + i);%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                                <div class="modal-dialog">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                                            <div class="row">
                                                                                <div class="col-xs-6">
                                                                                    <h4 class="modal-title">Confirmed Request - <% out.print(custName);%></h4>
                                                                                </div>
                                                                                <div class="col-xs-6 text-right">
                                                                                    <h4 class="modal-title"><%=dateTime%></h4>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <!--                                                                            <div class="text-center">
                                                                                                                                                            <img class="img-thumbnail-small"src="<%="http://119.81.43.85/uploads/" + carPhoto%>"/>
                                                                                                                                                        </div>-->
                                                                            <div class="line-across"></div>
                                                                            <div class="row">
                                                                                <h4>Service Details</h4>
                                                                            </div>
                                                                            <div class="line-across"></div> 
                                                                            <div class="row">
                                                                                <div class="col-xs-6">
                                                                                    <b>Service Request: </b><br><% out.print(serviceName);%>
                                                                                </div>

                                                                                <div class="col-xs-6">
                                                                                    <b>Urgency: </b><br><% out.print(serviceUrgency);%>
                                                                                </div>
                                                                            </div>
                                                                            <p></p>
                                                                            <div class="row">
                                                                                <div class="col-xs-12">
                                                                                    <b>Service Description: </b><br><% out.print(serviceDescription);%>
                                                                                </div>
                                                                            </div>
                                                                            <div class="line-across"></div>
                                                                            <div class="row">
                                                                                <h4>Car Details</h4>
                                                                            </div>
                                                                            <div class="line-across"></div> 
                                                                            <div class="row">
                                                                                <div class="col-xs-6">
                                                                                    <p><b>License Plate: </b><br><% out.print(carPlate);%></p>
                                                                                </div>
                                                                                <div class="col-xs-6">
                                                                                    <p><b>Vehicle Model: </b><% out.print(carMake + " " + carModel);%></p>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-6">
                                                                                    <p><b>Vehicle Year: </b><% out.print(carYear);%></p>
                                                                                </div>
                                                                                <div class="col-xs-6">
                                                                                    <p><b>Vehicle Type: </b><% out.print(carControl);%></p>
                                                                                </div> 
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-6">
                                                                                    <p><b>Vehicle Color: </b><% out.print(carColor);%></p>
                                                                                </div>
                                                                                <div class="col-xs-6">
                                                                                    <p><b>Mileage: </b><% out.print(serviceMileage);%></p>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <div>
                                                                                <div class="quotation text-left">
                                                                                    Agreed Amount: $<%=finalPrice%>
                                                                                </div>
                                                                            </div>
                                                                            <div>
                                                                                <button type="button" class="btn btn-default">Chat</button>
                                                                            </div>
                                                                            <!--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>-->
                                                                        </div>
                                                                    </div><!-- /.modal-content -->
                                                                </div><!-- /.modal-dialog -->
                                                            </div><!-- /.modal -->
                                                            </tr>

                                                            <%
                                                                    i++;
                                                                }
                                                            %>

                                                            </tbody>

                                                        </table>
                                                    </div>
                                                </div><!--Final Quotation Accepted-->




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

                                                <!--                                                <div class="col-sm-4 text-right sm-center" id="paginationTab" style="display:none">
                                                                                                    <ul class="pagination pagination-xs nomargin pagination-custom">
                                                                                                        <li class="disabled"><a href="#"><i class="fa fa-angle-double-left"></i></a></li>
                                                                                                        <li class="active"><a href="#">1</a></li>
                                                                                                        <li><a href="#">2</a></li>
                                                                                                        <li><a href="#">3</a></li>
                                                                                                        <li><a href="#">4</a></li>
                                                                                                        <li><a href="#">5</a></li>
                                                                                                        <li><a href="#"><i class="fa fa-angle-double-right"></i></a></li>
                                                                                                    </ul>
                                                                                                </div>-->

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

    <script src="js/minimal.min.js"></script>


    <script>
        $(function () {
            // Initialize card flip
            $('.card.hover').hover(function () {
                $(this).addClass('flip');
            }, function () {
                $(this).removeClass('flip');
            });

            //sortable table
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
        window.onload = start;
    </script>
    <script>
        $("#accordion > li > span").click(function () {
            $(this).toggleClass("active").next('div').slideToggle(250)
                    .closest('li').siblings().find('span').removeClass('active').next('div').slideUp(250);
        });

    </script>
    <script>
        $(document).ready(function () {
            $('#example').DataTable();
            $('#example2').DataTable();
            $('#example3').DataTable();
            $('#example4').DataTable();
            $('#example5').DataTable();
        });
    </script>
</html>
