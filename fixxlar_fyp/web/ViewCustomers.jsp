<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="dao.ValetShopDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.WebUser"%>
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page import="dao.WebUserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Fixir App Customers</title>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Customers</h2>
                        <!--<a href="AddWorshop.jsp" class="btn btn-primary btn-lg pull-right margin-top-15"  role="button">Submit</a>-->
                    </div>
                    <!-- /page header -->

                    <%
                        String msg = (String) session.getAttribute("success");
                        if (msg != null && msg.length() > 0) {
                    %>
                    <div class="alert alert-success"><%=msg%></div>
                    <%
                        session.setAttribute("success", "");
                    } else {
                        msg = (String) request.getAttribute("fail");
                        if (msg != null && msg.length() > 0) {
                    %>
                    <div class="alert alert-danger"><%=msg%></div>
                    <%
                            }
                        }
                    %>


                    <!-- content main container -->
                    <div class="main">
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">
                                <!-- tile -->
                                <section class="tile color transparent-black">

                                    <!-- tile header -->
                                    <div class="tile-header">
                                        <div class="col-md-12" style="z-index: 2;">
                                            
                                        </div>
                                    </div>
                                    <!-- /tile header -->
                      
                                    <!-- tile body -->
                                    <div class="tile-body no-vpadding">
                                        <div class="table-responsive">
                                            <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th class="sortable">Customer ID</th>
                                                        <th class="sortable">Name</th>
                                                        <th class="sortable">Email</th>
                                                        <th class="sortable">Handphone No.</th>
                                                        <th class="sortable">Service History</th>
                                                        <th>Edit/Delete</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    
                                                    <tr>
                                                        <td><</td>
                                                        <td>></td>
                                                        <td></td>
                                                        <td></td>                                                
                                                        <!--<td id="01"> <a href="#" class="btn btn-p1rimary btn-xs" role="button">Delete</a></td>-->

                                                        <!--<td><button onclick="remove(staffId)" class="btn btn-primary btn-xs" role="button">Delete</button></td>-->
                                                        <td>
                                                            <button class="btn btn-default btn-xs md-trigger" data-modal="<% out.print("myModal");%>" type="button">Delete</button>
                                                        </td>
                                               
                                                        <td>
                                                            <button type="button" disabled class="btn btn-primaryb btn-xs">Edit</button>
                                                            <button type="button" disabled class="btn btn-primaryb btn-xs">Delete </button>
                                                        </td>
                                                    </tr>                 
                                                

                                                
                                                    <div class="md-overlay"></div>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <!-- /tile body -->
                                </section>
                                <!--end tile-->
                            </div>
                            <!--end col 12-->
                        </div>
                        <!--end row-->
                    </div>
                    <!--end main container-->
                </div>
                <!-- End Page content -->
            </div>
            <!--End page fluid-->
        </div>
        <!--End page wrap-->
    </body>
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
    <script type="text/javascript" src="js/jquery.blockUI.js"></script>
    <script src="js/chosen.jquery.min.js"></script>
    <script src="js/moment-with-langs.min.js"></script>
    <script src="js/bootstrap-colorpalette.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script> 
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="js/classie.js"></script> 
    <script type="text/javascript" src="js/modalEffects.js"></script>
    <script type="text/javascript" src="js/intercom.js"></script> 
    <script src="js/minimal.min.js"></script>

    <script>
        $(document).ready(function () {
            $('#example').DataTable();
        });
    </script>
    <script>

        $(function () {

            //chosen select input
            $(".chosen-select").chosen({disable_search_threshold: 10});

            //         sortable table
            $('.table.table-sortable th.sortable').click(function () {
                var o = $(this).hasClass('sort-asc') ? 'sort-desc' : 'sort-asc';
                $('th.sortable').removeClass('sort-asc').removeClass('sort-desc');
                $(this).addClass(o);
            });

        })
    </script>
    <script>
        function remove(staffId) {
            $.post("url", function (data, status) {
                alert(data + " " + status);
            });
        }

    </script>
</html>