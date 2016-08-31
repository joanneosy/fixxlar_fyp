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
                                            <h1><strong>View Completed Request Quotations</strong></h1>
                                        </div>
                                        <!-- /tile header -->

                                        <!-- tile body -->
                                        <div class="tile-body no-vpadding" id="pageRefresh">
                                            <div class="tab-content">
                                                <%                                                   
                                                    int i = 1;
                                                    qDAO = new QuotationRequestDAO();
                                                    //HashMap<Integer, QuotationRequest> qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 1, "requested_datetime", "desc");
                                                    HashMap<Integer, QuotationRequest> qList = qDAO.retrieveQuotationRequestsWithoutOffer(user.getStaffId(), user.getToken());
                                                    int staffId = user.getStaffId();
                                                    String token = user.getToken();
                                                    
                                                    HashMap<Integer, Integer> completedRequestCount = qDAO.retrieveNumberOfCompletedRequests(staffId, token);
                                                %>
                                                <div class="tab-pane fade active in" id="New" >
                                                    <div class="table-responsive">
                                                        <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                            <thead>
                                                                <tr>
                                                                    <th class="sortable">Workshop Name</th>
                                                                    <th class="sortable">Completed Requests</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <!--Loop every workshop-->
                                                                <%
                                                                    ArrayList<Workshop> wsList = wsDAO.retrieveAllWorkshops(staffId, token);
                                                                    for (Workshop workshop : wsList) {
                                                                        //get workshop user
                                                                        int wsId = workshop.getId();
                                                                        int newRequests = completedRequestCount.get(wsId);
            
                                                                %>
                                                                <tr>
                                                                    <td><center><%=workshop.getName()%></center></td>
                                                                    <!--<td><center><button type="button" class="btn btn-block btn-primary">5</button></center></td>-->
                                                                    <td><a class="btn btn-block btn-primary" href="Admin_View_Individual_Request.jsp?wsId=<%=wsId %>" name="wsId" ><%=newRequests %></a></td>
                                                                </tr>
                                                            <%

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
