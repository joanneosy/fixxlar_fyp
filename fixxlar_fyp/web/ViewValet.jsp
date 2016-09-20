<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="dao.ValetShopDAO"%>
<%@page import="dao.ValetShopDAO"%>
<%@page import="entity.ValetShop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Valet</title>
        <jsp:include page="include/head.jsp"/>
        <link rel="stylesheet" href="js/dataTables.bootstrap.css">
        <link rel="stylesheet" href="js/ColVis.css">
        <link rel="stylesheet" href="js/TableTools.css">
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>All Valet</h2>
                        <%
                            String msg = (String) session.getAttribute("success");
                            if (msg != null && msg.length() > 0 && !(msg.equals("null"))) {
                        %>
                        <div class="alert alert-success"><%=msg%></div>
                        <%
                                session.setAttribute("success", "");
                            }
                            String error = (String) request.getAttribute("fail");
                            if(error != null && error.length() > 0 && !(error.equals("null"))){
                            %>
                            <div class="alert alert-danger"><%=error%></div>
                        <%
                            }
                        %>
                    </div>
                    <!-- /page header -->
                    <%                        ArrayList<ValetShop> allValet = (ArrayList<ValetShop>) request.getAttribute("valet");
                        if (allValet == null) {
                            ValetShopDAO vDAO = new ValetShopDAO();
                            allValet = vDAO.retrieveAllValetShops(user.getStaffId(), user.getToken());
                        }
                        if (allValet.size() == 0) {
                            out.println("No Valet found. Try again.<br/>");
                        } else {
                        }
                    %>

                    <!-- content main container -->
                    <div class="main">
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">
                                <!-- tile -->
                                <section class="tile color transparent-black">


                                    <div class="tile-body color transparent-black rounded-corners">
                                        <div class="col-md-12 col-md-offset-10" style="z-index: 2;">
                                            <a href="AddValetShop.jsp" class="btn btn-primary btn-sm" role="button">Add Valet Shop</a>
                                        </div>
                                        <div class="table-responsive">
                                            <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th class="sortable">ID</th>
                                                        <th class="sortable">Name</th>
                                                        <th class="sortable">Address</th>
                                                        <th>Opening Hours</th>
                                                        <th>No of Employees</th>
                                                        <th>Revenue Share</th>
                                                        <th>Edit/Remove</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (ValetShop valet : allValet) {
                                                            int idToDelete = valet.getId();
                                                            String name = valet.getName();
                                                            String vAddress = valet.getAddress();
                                                            String address = "";
                                                            String postal = "";
                                                            if(vAddress != null && !(vAddress.equals(""))) {
                                                                address = vAddress.substring(0, vAddress.lastIndexOf(" "));
                                                                postal = vAddress.substring(vAddress.lastIndexOf(" ") + 1);
                                                            }
                                                            String openingHr = valet.getOpeningHoursDisplay();
                                                            int noEmployees = valet.getNoOfEmployees();
                                                            double revShare = valet.getRevenueShare();
                                                    %>
                                                    <tr>
                                                        <td><%=idToDelete%></td>
                                                        <td><%=name%></td>
                                                        <td><%=address%></td>
                                                        <td><%=openingHr%></td>
                                                        <td><%=noEmployees%></td>
                                                        <td><%=revShare%></td>
                                                        <td>
                                                            <a href="EditValetShop.jsp?id=<%=idToDelete%>" class="btn btn-primary btn-xs" role="button">Edit</a>
                                                            <button class="btn btn-default btn-xs md-trigger" data-modal="<% out.print("myModal" + idToDelete);%>" type="button">Delete</button>
                                                            <!-- Modal -->
                                                            <div class="md-modal md-effect-13 md-slategray colorize-overlay" id="<% out.print("myModal" + idToDelete);%>">

                                                                <div class="md-content">

                                                                    <div class="col-xs-12">
                                                                        <h4>Are you sure you want to delete <%=name%>?</h4>
                                                                        <form class="form-horizontal" role="form" action="DeleteValetServlet" method="POST">
                                                                            <button type="submit" name="idToDelete" value="<%=idToDelete%>" class="btn btn-primary btn-sm">Delete</button>
                                                                        </form> 
                                                                    </div>
                                                                    <div class="col-xs-12">
                                                                        <button class="md-close btn btn-default">Close</button>
                                                                    </div>
                                                                </div> <!--/.modal-content -->
                                                            </div> <!--/.modal -->
                                                        </td>
                                                    </tr>

                                                    <%
                                                        }
                                                    %>
                                                <div class="md-overlay"></div>
                                                </tbody>
                                            </table>
                                        </div>   
                                        <!--end table responsive-->
                                    </div>
                                    <!--end tile body-->
                                </section>
                                <!--end section-->
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
    </body>
    <%-- scripts --%>
    <jsp:include page="include/scripts.jsp"/>
    <script src="js/chosen.jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script> 
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="js/classie.js"></script> 
    <script type="text/javascript" src="js/modalEffects.js"></script> 

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
</html>