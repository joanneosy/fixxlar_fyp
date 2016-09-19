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

                <%
                    String successChangePasswordMsg = (String) request.getAttribute("successChangePasswordMsg");
                    if (successChangePasswordMsg != null) {
                        out.println(successChangePasswordMsg + "<br/><br/>");
                    }
                    QuotationRequestDAO qDAO = new QuotationRequestDAO();
                    int staffId = user.getStaffId();
                    String token = user.getToken();
                    int wsId = Integer.parseInt(request.getParameter("wsId"));
                    Workshop ws = wsDAO.retrieveWorkshop(wsId, staffId, token);
                    System.out.print(ws);
                    String workshopName = ws.getName();
                    
                    //get respective workshop's new requests
                    HashMap<Integer, QuotationRequest> wsNewRequests = qDAO.retrieveAllQuotationRequests(staffId, token, wsId, 1, "", "");


                %>
                <!-- Page content -->
                <div id="content" class="col-md-12">

                    <!-- page header -->
                    <div class="pageheader">

                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> New Workshop Requests</h2>
                    </div>
                    <!-- /page header -->

                    <!-- content main container -->
                    <div class="main">
                        <!-- row -->
                        <div class="row">

                            <!-- col 12 -->
                            <div class="col-md-12">

                                <section class="tile transparent">
                                    <!-- tile header -->
                                    <div class="tile-header transparent">
                                        <h1><strong><%=workshopName%></strong></h1>
                                    </div>
                                    <!-- /tile header -->

                                    <!-- tile body -->
                                    <div class="tile-body color transparent-black rounded-corners">
                                        <!-- cards -->
                                        <%@include file="include/admin_flipcard.jsp"%>
                                        <!-- cards -->                                  
                                    </div>
                                    <!-- /tile body -->
                                </section>
                                <!-- /tile -->
                            </div>
                            <!-- /col 12 -->        
                        </div>
                        <!-- /row -->

                        <!-- row -->
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">
                                <!-- tile -->
                                <section class="tile color transparent-white">
                                    <!-- tile header -->
                                    <div class="tile-header">
                                        <h1><strong>View Request</strong></h1>
                                        <div class="search">
                                            <input type="search" class="light-table-filter" data-table="order-table" placeholder="Filter">
                                        </div>
                                        <div class="controls">
                                            <a href="#" class="refresh"><i class="fa fa-refresh"></i></a>
                                        </div>
                                    </div>
                                    <!-- /tile header -->

                                    <!-- tile widget -->
                                    <div class="tile-widget bg-transparent-white-2">
                                        <div class="row">
                                            <div class="col-sm-12 col-xs-12 text-right">
                                                <div class="btn-group btn-group-xs table-options desktopOnly">
                                                    <ul class="nav nav-pills tabpager">
                                                        <li class="active"><a href="#New" data-toggle="pill">New Request</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /tile widget -->

                                    <!-- tile body -->
                                    <div class="tile-body no-vpadding" id="pageRefresh">
                                        <div class="tab-content">

                                            <div class="tab-pane fade active in" id="New" >
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
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <!--Loop per new request-->
                                                            <%                                                                    
                                                            Iterator it = wsNewRequests.entrySet().iterator();
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
                                                            </tr>
                                                            <% }%>
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
                                            <div class="col-sm-4 text-center">
                                                <small class="inline table-options paging-info">showing 1-3 of 24 items</small>
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
                    <!-- /main-->
                </div>
                <!-- Page content end -->
            </div>
            <!-- Make page fluid-->
        </div>
        <!-- Wrap all page content end -->
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
            //Script to load tab and data based on the href #
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
            });


        </script>
        <script>
            $('.dropdown-menu li').on('click', function () {
                $(this).siblings().removeClass('active');
                var link = $(this).text();
                document.getElementById("select").innerHTML = link + " <span class='caret'></span>";
            });

        </script>
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

            })(document);
        </script>
        <script>
            //    var acc = document.getElementsByClassName("accordion");
            //    var i;
            //
            //    for (i = 0; i < acc.length; i++) {
            //        acc[i].onclick = function () {
            //            this.classList.toggle("active");
            //            this.nextElementSibling.classList.toggle("show");
            //        }
            //    }
        </script>
        <script type="text/javascript">
            function displaymsg() {
                var msg = '<%=session.getAttribute("isSuccess")%>';
                if (msg != "null") {
                    //                function alertName(msg) {
                    alert(msg);
                    //                }
                }
            <%session.setAttribute("isSuccess", "null");%>
            }
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
            window.onload = start;
        </script>
        <script>
            $("#accordion > li > span").click(function () {
                $(this).toggleClass("active").next('div').slideToggle(250)
                        .closest('li').siblings().find('span').removeClass('active').next('div').slideUp(250);
            });

        </script>
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
            });
        </script>

    </body>
</html>
