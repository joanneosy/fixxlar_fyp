<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="java.util.Date"%>
<%@page import="entity.ValetStaff"%>
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
<%@include file="ProtectValetAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Valet Employees</title>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Employees</h2>
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
                                            <div class="col-md-offset-11">
                                                <!--<a href ="AddEmployee.jsp" type="button" class="btn btn-primary">Add Employee</a>-->
                                                <a href="Add_Valet_Employee.jsp" class="btn btn-primary btn-xs" role="button">Add Employee</a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /tile header -->
                                    <%
                                        int shopId = user.getShopId();
                                        String token = user.getToken();
                                        int staffId = user.getStaffId();
                                        String chatToken = user.getChatToken();
                                        String phone_number = user.getHandphone();
                                        String user_name = user.getName();
                                        String user_email = user.getEmail();
                                        WebUserDAO wuDAO = new WebUserDAO();
                                        HashMap<Integer, WebUser> dList = wuDAO.retrieveAllValetStaffByShop(staffId, token, shopId);

                                    %>
                                    <!-- tile body -->
                                    <div class="tile-body no-vpadding">
                                        <div class="table-responsive">
                                            <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th class="sortable">ID</th>
                                                        <th class="sortable">Name</th>
                                                        <th class="sortable">Phone Number</th>
                                                        <th class="sortable">Email</th>
                                                        <th class="sortable">License Number</th>
                                                        <th class="sortable">Issue Date</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%                                                        Iterator it = dList.entrySet().iterator();
                                                        //counter for delete id
                                                        int deleteCounter = 0;
                                                        while (it.hasNext()) {
                                                            Map.Entry pair = (Map.Entry) it.next();
                                                            WebUser driver = (WebUser) pair.getValue();
                                                            String email = driver.getEmail();
                                                            int idToDelete = driver.getStaffId();
                                                            String name = driver.getName();
                                                            String hp = driver.getHandphone();

                                                            ValetStaff valet = driver.getValetStaff();
                                                            String licenceNo = valet.getLicenseNumber();
                                                            Date licenceDate = valet.getLicenseIssueDate();

                                                    %>
                                                    <tr>
                                                        <td><%=idToDelete%></td>
                                                        <td><%=name%></td>
                                                        <td><%=hp%></td>                                                
                                                        <td><%=email%></td>                                                
                                                        <td><%=licenceNo%></td>                                                
                                                        <td><%=licenceDate%></td>                                                
                                                        <!--<td id="01"> <a href="#" class="btn btn-p1rimary btn-xs" role="button">Delete</a></td>-->

                                                        <!--<td><button onclick="remove(staffId)" class="btn btn-primary btn-xs" role="button">Delete</button></td>-->
                                                        <td>
                                                            <a href="EditEmployee.jsp?id=<%=idToDelete%>" name="idToDelete" class="btn btn-xs btn-primary" role="button">Edit</a>
                                                            <button class="btn btn-default btn-xs md-trigger" data-modal="<% out.print("myModal" + idToDelete);%>" type="button">Delete</button>


                                                        </td>
                                                        <!-- Modal -->
                                                <div class="md-modal md-effect-13 md-slategray colorize-overlay" id="<% out.print("myModal" + idToDelete);%>">

                                                    <div class="md-content">

                                                        <div class="col-xs-12">
                                                            <h4>Are you sure you want to delete <%=name%>?</h4>
                                                            <form class="form-horizontal" role="form" action="DeleteEmployee" method="POST">
                                                                <button type="submit" name="idToDelete" value="<%=idToDelete%>" class="btn btn-primary btn-sm">Delete</button>
                                                            </form>
                                                        </div>
                                                        <div class="col-xs-12">
                                                            <button class="md-close btn btn-default">Close</button>
                                                        </div>
                                                    </div> <!--/.modal-content -->
                                                </div> <!--/.modal -->

                                                </tr>
                                                <% }  %>

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
    <script>
        var user = "<%=userType%>";
        if (user === "Workshop") {
            intercom("<%=user_name%>", "<%=user_email%>",<%=staffId%>, "<%=phone_number%>", "<%=wsName%>", "", "");
        }
    </script>
</html>