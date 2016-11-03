<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="dao.ValetShopDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.Workshop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.WorkshopDAO"%>
<%@include file="ProtectWorkshop.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8" />
        <title>Profile</title>
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
                        <!--<div class="col-md-6">-->
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>Workshop Profile Page</h2>
                        <!--</div>-->

                        <!--<div class="col-md-6">-->
                        <%if (user.getStaffType() == 1) {%>
                        <a href="EditProfile.jsp" type="button" class="btn btn-primary">Edit Profile</a>
                        <%}%>
                        <!--</div>-->
                    </div>
                    <!-- /page header -->
                    <%
                        String msg = (String) session.getAttribute("success");
                        if (msg != null && msg.length() > 0 && !(msg.equals("null"))) {
                    %>
                    <div class="alert alert-success"><%=msg%></div>
                    <%
                            session.setAttribute("success", "");
                        }
                    %>


                    <%
                        int staffID = user.getStaffId();
                        String phone_number = user.getHandphone();
                        String user_name = user.getName();
                        String user_email = user.getEmail();
                        Workshop ws = wsDAO.retrieveWorkshop(user.getShopId(), user.getStaffId(), user.getToken());
                        String workshop_name = ws.getName();
                        String address = ws.getAddress();
                        String wsAddress = address.substring(0, address.lastIndexOf(" "));
                        String wsPostal = address.substring(address.lastIndexOf(" ") + 1);
                        String wsLocation = ws.getLocation();
                        String wsWebsite = ws.getWebsite();
                        String wsContact = ws.getContact();
                        String wsCsontact2 = ws.getContact2();
                        String wsBrands = ws.getBrandsCarried();
                        String wsDescription = ws.getDescription();
                        String wsSpecialize = ws.getSpecialize();
                        String wsOpenHr = ws.getOpeningHour();
                        String wsOpenHrFormat = ws.getOpeningHourFormat();
                        //String[] wsOpeningHr = wsOpenHr.split(",");
                        String wsCategory = ws.getCategory();


                    %>
                    <!-- content main container -->
                    <div class="main">
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">

                                <div class="col-md-6">
                                    <section class="tile">
                                        <div class="tile-header">
                                            <h1><strong>Particulars</strong></h1>
                                        </div>

                                        <div class="tile-widget">

                                            <div class="row">

                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="name">Name</label>
                                                    <input type="text" class="form-control" id="username" value="<%=workshop_name%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="address">Address</label>
                                                    <input type="text" class="form-control" value="<%=wsAddress%>" readonly>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Postal Code</label>
                                                    <input type="text" class="form-control" value="<%=wsPostal%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Location</label>
                                                    <input type="text" class="form-control" value="<%=wsLocation%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Website</label>
                                                    <input type="text" class="form-control" value="<%=wsWebsite%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Contact</label>
                                                    <input type="text" class="form-control" value="<%=wsContact%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Alt. Contact</label>
                                                    <input type="text" class="form-control" value="<%=wsCsontact2%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Brands Carried</label>
                                                    <input type="text" class="form-control" value="<%=wsBrands%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Description</label>
                                                    <textarea rows="5" class="form-control" value="" readonly><%=wsDescription%></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end tile widget-->
                                    </section>
                                </div>

                                <div class="col-md-6">

                                    <section class="tile">
                                        <div class="tile-header">
                                            <h1><strong>Opening Hours (24hrs)</strong></h1>
                                        </div>


                                        <div class="tile-widget">
                                            <%=wsOpenHr%>
                                        </div>
                                    </section>

                                    <section class="tile">
                                        <div class="tile-header">
                                            <h1><strong>Specialize</strong></h1>
                                        </div>

                                        <div class="tile-widget">
                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <!--<label for="postalCode">Specialise</label>-->
                                                    <input type="text" class="form-control" value="<%=wsSpecialize%>" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </section>

                                    <section class="tile">
                                        <div class="tile-header">
                                            <h1><strong>Category</strong></h1>
                                        </div>

                                        <div class="tile-widget">
                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">

                                                    <input type="text" class="form-control" value="<%=wsCategory%>" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </div>
                                <!--end row 6-->

                            </div>
                            <!--end col 12-->


                        </div>
                        <!--end row-->
                    </div>
                    <!--end main-->

                </div>
                <!-- End Page content -->
            </div>
            <!--End page fluid-->
        </div>
        <!--End page wrap-->
        <%-- scripts --%>
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
        <script type="text/javascript" src="js/jquery.animateNumbers.js"></script>
        <script type="text/javascript" src="js/jquery.videobackground.js"></script>
        <script type="text/javascript" src="js/jquery.blockUI.js"></script>
        <script type="text/javascript" src="js/jquery.bootpag.js"></script>
        <script type="text/javascript" src="js/jquery.tablesorter.js"></script>

        <script type="text/javascript" src="js/summernote.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/ColReorderWithResize.js"></script>
        <script type="text/javascript" src="js/dataTables.colVis.min.js"></script>
        <script type="text/javascript" src="js/ZeroClipboard.js"></script>
        <script type="text/javascript" src="js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script> 
        <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script> 
        <script type="text/javascript" src="js/chosen.jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery.jgrowl.min.js"></script> 
        <script type="text/javascript" src="js/intercom.js"></script> 
        <script src="js/minimal.min.js"></script>

        <script>
            intercom("<%=user_name%>", "<%=user_email%>",<%=staffID%>, "<%=phone_number%>", "<%=workshop_name%>", "<%=wsCategory%>", "<%=wsBrands%>");
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
    </body>
</html>