<%-- 
    Document   : View Request
    Created on : May 5, 2016, 10:00:14 AM
    Author     : joshua
--%>

<%@page import="entity.Setting"%>
<%@page import="dao.ValetShopDAO"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Set"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="dao.SettingDAO"%>
<%@page import="dao.NotificationDAO"%>
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
    </head>

    <body class="bg-3">
        <!--<h1>Welcome</h1>-->
        <%            QuotationRequestDAO qDAO = new QuotationRequestDAO();
//            HashMap<Integer, Integer> statusSize = qDAO.retrieveStatusSize(user.getStaffId(), user.getToken(), 0, 0, "", "requested_datetime", "desc");
//            int newSize = statusSize.get(0);
//            int sendFinalSize = statusSize.get(1);
//            int finalAcceptSize = statusSize.get(2);
//            int newService = statusSize.get(2);
//            int completedService = statusSize.get(3);


        %>

        <!-- Preloader -->
        <div class="mask"><div id="loader"></div></div>
        <!--/Preloader -->

        <!-- Wrap all page content here -->
        <div id="wrap">
            <!-- Make page fluid -->
            <div class="row">
                <!-- Top and leftbar -->
                <%--<jsp:include file="include/topbar.jsp"/>--%>
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

                        <h2><i class="fa fa-tachometer" style="line-height: 48px;padding-left: 2px;"></i>Dashboard<span>// Overview of Workshop New Requests</span></h2>
                    </div>
                    <!-- /page header -->

                    <!-- content main container -->
                    <div class="main">
                        <!-- row -->
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">
                                <section class="tile transparent">                             
                                    <!-- tile body -->
                                    <div class="tile-body color transparent-black rounded-corners">
                                        <!-- cards -->
                                        <%@include file="include/admin_flipcard.jsp"%>
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
                                            <h1><strong>View New Request Quotations</strong></h1>
                                        </div>
                                        <!-- /tile header -->

                                        <!-- tile body -->
                                        <div class="tile-body no-vpadding" id="pageRefresh">
                                            <div class="tab-content">
                                                <%                                                    int i = 1;
                                                    qDAO = new QuotationRequestDAO();
                                                    //HashMap<Integer, QuotationRequest> qList = qDAO.retrieveAllQuotationRequests(user.getStaffId(), user.getToken(), 0, 1, "requested_datetime", "desc");
                                                    HashMap<Integer, QuotationRequest> qList = qDAO.retrieveQuotationRequestsWithoutOffer(user.getStaffId(), user.getToken());
                                                    int staffId = user.getStaffId();
                                                    int shopId = user.getShopId();
                                                    String token = user.getToken();

                                                    HashMap<Integer, Integer> newRequestCount = qDAO.retrieveNumberOfNewRequests(staffId, token);
                                                %>
                                                <%
                                                    String errMsg = (String) request.getAttribute("errMsg");
                                                    if (errMsg != null) {
                                                        out.print(errMsg);
                                                    }
                                                %>
                                                <div class="tab-pane fade active in" id="New" >
                                                    <div class="table-responsive">
                                                        <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                            <thead>
                                                                <tr>
                                                                    <th class="sortable">Workshop Name</th>
                                                                    <th class="sortable">New Requests</th>
                                                                    <th>Urgency</th>
                                                                    <th>Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <!--Loop every workshop-->
                                                                <%
                                                                    ArrayList<Workshop> wsList = wsDAO.retrieveAllWorkshops(staffId, token);
                                                                    NotificationDAO nDAO = new NotificationDAO();
                                                                    HashMap<Integer, String> messages = nDAO.retrieveNotificationMessages(staffId, token);
                                                                    Iterator it = messages.entrySet().iterator();
                                                                    SettingDAO sDAO = new SettingDAO();
                                                                    int urgent = 0;
                                                                    int moderate = 0;
                                                                    int low = 0;
                                                                    for (int j = 1; j < 4; j++) {
                                                                        Setting setting = sDAO.retrieveSettingById(staffId, token, j);
                                                                        String s = setting.getName();
                                                                        if (s.equals("High")) {
                                                                            urgent = Integer.parseInt(setting.getValue());

                                                                        }
                                                                        if (s.equals("Medium")) {
                                                                            moderate = Integer.parseInt(setting.getValue());

                                                                        }
                                                                        if (s.equals("Low")) {
                                                                            low = Integer.parseInt(setting.getValue());

                                                                        }
                                                                    }
                                                                    
                                                                    for (Workshop workshop : wsList) {
                                                                        //get workshop user
                                                                        int wsId = workshop.getId();
                                                                        int newRequests = newRequestCount.get(wsId);
                                                                        String workshopName = workshop.getName();
                                                                        if (newRequests > 0) {


                                                                %>
                                                                <tr>
                                                                    <td><center><%=workshop.getName()%></center></td>
                                                            <!--<td><center><button type="button" class="btn btn-block btn-primary">5</button></center></td>-->
                                                            <td><a class="btn btn-block btn-primary" href="Admin_View_Individual_Request.jsp?wsId=<%=wsId%>" name="wsId" ><%=newRequests%></a></td>

                                                            <%
                                                                if (newRequests <= low) {
                                                            %>

                                                            <td><center><button type="button" class="btn btn-block btn-greensea disabled">Low</button></center></td>
                                                            <!--<center><input type="submit" value="Remind"class="btn btn-default"></center>-->
                                                            <% } else if (newRequests > low && newRequests <= moderate) { %>
                                                            <td><center><button type="button" class="btn btn-block btn-warning disabled">Moderate</button></center></td>
                                                                <% } else { %> 
                                                            <td><center><button type="button" class="btn btn-block btn-danger disabled">Urgent</button></center></td>

                                                            <% }%>
                                                            <td><button type="button" class="btn btn-default btn-block" data-toggle="modal" data-target="#exampleModal<%=wsId%>" data-whatever="@mdo">REMIND</button></td>

                                                            <!--POPUP REMINDER DIALOG-->
                                                            <div class="modal fade" id="exampleModal<%=wsId%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                                                                <div class="modal-dialog" role="document">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                                <!--<input type="hidden" name="customizedMessage" value="You have <%=newRequests%> new requests. Please respond asap.">-->
                                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
                                                                            <h4 class="modal-title" id="exampleModalLabel">Reminder Message for <%=workshopName%></h4>
                                                                        </div>
                                                                        <form  action="AddNotification" method="GET" id="form1">
                                                                            <div class="modal-body">
                                                                                <!--<input type="hidden" name="messageId" value="0">-->
                                                                                <input type="hidden" name="workshopId" value="<%=wsId%>">
                                                                                <!--                                                                                        <div class="form-group col-sm-4 col-md-4">
                                                                                <label for="recipient-name" class="control-label">Recipient:</label>
                                                                                                                                                  <input type="text" class="form-control" id="recipient-name">
                                                                                                                                              </div>-->
                                                                                <select name="messageId">
                                                                                    <option value="0">Customise Message</option>
                                                                                    <%
                                                                                        while (it.hasNext()) {
                                                                                            Map.Entry pair = (Map.Entry) it.next();
                                                                                            int messageId = (Integer) pair.getKey();
                                                                                            String message = (String) pair.getValue();

                                                                                            out.println("<option value=\"" + messageId + "\">" + message + "</option>");
                                                                                        }
                                                                                    %>    
                                                                                </select>
                                                                                <div class="form-group">
                                                                                    <label for="message-text" class="control-label">Message:</label>
                                                                                    <textarea class="form-control" id="message-text" name="customizedMessage"></textarea>
                                                                                </div>
                                                                            </div>


                                                                            <div class="modal-footer">
                                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                                <button type="submit" class="btn btn-primary">Send message</button>
                                                                            </div>
                                                                        </form>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!--/POPUP REMINDER DIALOG-->
                                                            <!--<button onclick="remind()" type="submit" form="form1" value="Submit">Submit</button>-->


                                                            </tr>
                                                            <%
                                                                    }
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
        </div>


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
        <script>
            $(window).load(function () {
                $.ajax({
                    type: 'POST',
                    url: 'http://119.81.43.85/erp/ws_notification/retrieve_notifications_by_shop',
                    crossDomain: true,
                    data: {
                        "token": "<%=token%>",
                        "staff_id": "<%=staffId%>",
                        "shop_id": "<%=shopId%>"
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
    </body>

</html>
