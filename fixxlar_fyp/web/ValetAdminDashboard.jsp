<%-- 
    Document   : View Request
    Created on : May 5, 2016, 10:00:14 AM
    Author     : joanne.ong.2014
--%>

<%@page import="entity.ValetRequest"%>
<%@page import="entity.ValetStaff"%>
<%@page import="dao.ValetRequestDAO"%>
<%@page import="dao.ValetShopDAO"%>
<%@page import="entity.ValetShop"%>
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
<%@include file="ProtectValetAdmin.jsp"%>
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
        <%            ValetRequestDAO vrDAO = new ValetRequestDAO();
            int shopId = user.getShopId();
            String token = user.getToken();
            int staffId = user.getStaffId();
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
    if (successChangePasswordMsg != null) {%>
                    <div class="alert alert-success"><%=successChangePasswordMsg%></div>
                    <%
                            session.setAttribute("successChangePasswordMsg", "");
                        }
                    %>
                    <!-- page header -->
                    <div class="pageheader">

                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>View Valet Requests</h2>
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

                                    <!--cards--> 
                                    <%--<%@include file="include/admin_flipcard.jsp"%>--%>
                                    <!--/cards--> 
                                    <!--</div>-->
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
                                            <h1><strong>Dashboard</strong></h1>
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
                                                            <li class="active"><a href="#Status" data-toggle="pill">Status</a></li>
                                                        </ul>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                        <!-- /tile widget -->


                                        <!-- tile body -->
                                        <div class="tile-body no-vpadding">
                                            <div class="tab-content">
                                                <%
                                                    WebUserDAO wuDAO = new WebUserDAO();
                                                    HashMap<Integer, WebUser> dList = wuDAO.retrieveAllValetStaffByShop(staffId, token, shopId);
                                                %>



                                                <div class="tab-pane fade active in" id="Status" >
                                                    <div class="table-responsive">
                                                        <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                            <thead>
                                                                <tr>
                                                                    <th class="sortable">Valet Name</th>
                                                                    <th class="sortable">Status</th>
                                                                    <th class="sortable">Contact</th>
                                                                    <th>More Info</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="contents">
                                                                <!--Loop per new request-->
                                                                <%
                                                                    int i = 1;
                                                                    Iterator it = dList.entrySet().iterator();
                                                                    while (it.hasNext()) {
                                                                        Map.Entry pair = (Map.Entry) it.next();
                                                                        WebUser driver = (WebUser) pair.getValue();

                                                                        String name = driver.getName();
                                                                        String handphone = driver.getHandphone();

                                                                        ValetStaff aDriver = driver.getValetStaff();
                                                                        Date licenseIssueDate = aDriver.getLicenseIssueDate();
                                                                        String licenseNumber = aDriver.getLicenseNumber();
                                                                        int statusNumber = aDriver.getStatus();
                                                                        String status = "";
                                                                        if (statusNumber == 1) {
                                                                            status = "Available";
                                                                        } else {
                                                                            status = "In Progress";

                                                                        }
                                                                        Customer customer = driver.getCustomer();
                                                                        String customerName = "";
                                                                        String carControl = "";
                                                                        String carPlate = "";
                                                                        String carColor = "";
                                                                        int serviceType = 0;
                                                                        String pickUpAddress = "";
                                                                        String dropOffAddress = "";
                                                                        String dateTime = "";
                                                                        if (statusNumber != 1) {
                                                                            customerName = customer.getName();

                                                                            Vehicle vehicle = driver.getVehicle();
                                                                            carControl = vehicle.getControl();
                                                                            carPlate = vehicle.getPlateNumber();
                                                                            carColor = vehicle.getColour();

                                                                            ValetRequest vr = driver.getValetRequest();
                                                                            serviceType = vr.getServiceType();
                                                                            pickUpAddress = vr.getPickUpAddress();
                                                                            dropOffAddress = vr.getDropOffAddress();
                                                                            dateTime = vr.getScheduledPickUpTime() + "";
                                                                        }

                                                                %>
                                                                <tr>
                                                                    <td><% out.print(name);%></td>
                                                                    <td><% out.print(status);%></td>
                                                                    <td><% out.print(handphone);%></td>
                                                                    <!--Quote-->
                                                                    <% if (statusNumber != 1) {%>
                                                                    <td class="text-center"><a data-modal="<% out.print("myModal" + i);%>" class="md-trigger"><img src="images/file.png"/></a></td>
                                                                            <% } else { %>
                                                                    <td></td>
                                                                    <%}%>
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
                                                            </tr>

                                                            <%
                                                                    i++;
                                                                }
                                                            %>

                                                            </tbody>

                                                        </table>
                                                    </div>
                                                </div><!--New-->






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
    <script type="text/javascript" src="js/moment.js"></script> 
    <script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script> 

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
        function start() {
            timedRefresh(300000);
            displaymsg();
        }
        window.onload = start;
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

    <!--DATETIME-->
    <script type="text/javascript">
        $(".date").each(function () {
            $(this).datetimepicker({
                format: 'YYYY-MM-DD HH:mm',
                minDate: new Date()
            });
        });
    </script>
    <!--DATETIME-->
</html>
