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
<%@include file="ProtectValet.jsp"%>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>Valet Profile Page</h2>
                        <!--</div>-->



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

                    <!-- content main container -->
                    <div class="main">
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">

                                <section class="tile">
                                    <div class="tile-header">
                                        <h1><strong>Profile Picture</strong></h1>
                                        <a href="EditValetProfile.jsp" type="button" class="center btn btn-primary">Edit Profile</a>
                                        
                                    </div>

                                    <div class="tile-widget">

                                        <div class="row">
                                            <div class="col-md-12 center" id="image">

                                            </div>
                                        </div>

                                    </div>
                                    <!--end tile widget-->
                                </section>

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
            $(document).ready(function () {
                $.ajax({
                    type: 'POST',
                    url: 'http://119.81.43.85/erp/user/get_profile_picture',
                    crossDomain: true,
                    data: {
                        "token": "<%=user.getToken()%>",
                        "staff_id": "<%=user.getStaffId()%>"
                    },
                    dataType: 'json',
                    success: function (data) {
                        var picture = data.payload.profile_picture;
//                        console.log(picture);
                        var image = '<img class="img-thumbnail-small"src="http://119.81.43.85/uploads/' + picture + '"/>';
                        $("#image").html(image);
                    },
                    error: function () {
                    }
                });
            });
        </script>
    </body>
</html>