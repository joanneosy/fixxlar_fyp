<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="dao.ValetShopDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Workshops</title>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>All Workshops</h2>
                        <%
                            String msg = (String) session.getAttribute("success");
                            if (msg != null && msg.length() > 0 && !(msg.equals("null"))) {
                        %>
                        <div class="alert alert-success"><%=msg%></div>
                        <%
                                session.setAttribute("success", "");
                            }
                        %>
                    </div>
                    <!-- /page header -->
                    <%                        ArrayList<Workshop> allWorkshops = (ArrayList<Workshop>) request.getAttribute("workshops");
                        if (allWorkshops == null) {
                            WorkshopDAO wDAO = new WorkshopDAO();
                            allWorkshops = wDAO.retrieveAllWorkshops(user.getStaffId(), user.getToken());
                        }
                        if (allWorkshops.size() == 0) {
                            out.println("No workshop found. Try again.<br/>");
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
                                            <a href="AddWorkshop.jsp" class="btn btn-primary btn-sm" role="button">Add Workshop</a>
                                        </div>
                                        <div class="table-responsive">
                                            <table id="example" class="table table-custom1 table-sortable" cellspacing="0" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th class="sortable">ID</th>
                                                        <th class="sortable">Name</th>
                                                        <th class="sortable">Address</th>
                                                        <th class="sortable">Postal Code</th>
                                                        <th>Opening Hours</th>
                                                        <th>Contact</th>
                                                        <th>Alt. Contact</th>
                                                        <th>Category</th>
                                                        <th>Edit/Remove</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (Workshop ws : allWorkshops) {
                                                            int idToDelete = ws.getId();
                                                            String name = ws.getName();
                                                            String wsAddress = ws.getAddress();
                                                            String address = "";
                                                            String postal = "";
                                                            if(wsAddress != null && !(wsAddress.equals(""))) {
                                                                address = wsAddress.substring(0, wsAddress.lastIndexOf(" "));
                                                                postal = wsAddress.substring(wsAddress.lastIndexOf(" ") + 1);
                                                            }
                                                            String openingHr = ws.getOpeningHour();
                                                            String contact = ws.getContact();
                                                            String contact2 = ws.getContact2();
                                                            String category = ws.getCategory();
                                                    %>
                                                    <tr>
                                                        <td><%=idToDelete%></td>
                                                        <td><%=name%></td>
                                                        <td><%=address%></td>
                                                        <td><%=postal%></td>
                                                        <td><%=openingHr%>

                                                            <%
                                                           /*     ArrayList<String> compiled = new ArrayList<String>();
                                                                //Monday-0900-1800
                                                                String[] daysAndTime = openingHr.split(",");
                                                                //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
                                                                String[] openCloseTimings = daysAndTime[0].split("-");
                                                                String dayToCompare = openCloseTimings[0];
                                                                String openToCompare = openCloseTimings[1];
                                                                String closeToCompare = openCloseTimings[2];
                                                                String toAdd = dayToCompare + "-" + dayToCompare + "-" + openToCompare + "-" + closeToCompare;

                                                                for (int i = 1; i < daysAndTime.length - 2; i++) {
                                                                    openCloseTimings = daysAndTime[i].split("-");
                                                                    if (openCloseTimings[1].equals(openToCompare) && openCloseTimings[2].equals(closeToCompare)) {
                                                                        String[] toAddArr = toAdd.split("-");
                                                                        toAdd = toAddArr[0] + "-" + openCloseTimings[0] + "-" + openToCompare + "-" + closeToCompare;
                                                                    } else {
                                                                        String[] toAddArr = toAdd.split("-");
                                                                        //Closed-Closed
                                                                        if (toAddArr[2].equals("Closed")) {
                                                                            //Saturday-Saturday
                                                                            if (toAddArr[0].equals(toAddArr[1])) {
                                                                                toAdd = toAddArr[0] + ": Closed";
                                                                            } else {
                                                                                toAdd = toAddArr[0] + " to " + toAddArr[1] + ": Closed";
                                                                            }
                                                                        } else //Saturday-Saturday
                                                                        if (toAddArr[0].equals(toAddArr[1])) {
                                                                            toAdd = toAddArr[0] + ": " + toAddArr[2] + " - " + toAddArr[3];
                                                                        } else {
                                                                            toAdd = toAddArr[0] + " to " + toAddArr[1] + ": " + toAddArr[2] + " - " + toAddArr[3];
                                                                        }
                                                                        compiled.add(toAdd);
                                                                        dayToCompare = openCloseTimings[0];
                                                                        openToCompare = openCloseTimings[1];
                                                                        closeToCompare = openCloseTimings[2];
                                                                        toAdd = dayToCompare + "-" + dayToCompare + "-" + openToCompare + "-" + closeToCompare;
                                                                    }

                                                                    if (i == daysAndTime.length - 3) {
                                                                        String[] toAddArr = toAdd.split("-");
                                                                        //Closed-Closed
                                                                        if (toAddArr[2].equals("Closed")) {
                                                                            //Saturday-Saturday
                                                                            if (toAddArr[0].equals(toAddArr[1])) {
                                                                                toAdd = toAddArr[0] + ": Closed";
                                                                            } else {
                                                                                toAdd = toAddArr[0] + " to " + toAddArr[1] + ": Closed";
                                                                            }
                                                                        } else //Saturday-Saturday
                                                                        if (toAddArr[0].equals(toAddArr[1])) {
                                                                            toAdd = toAddArr[0] + ": " + toAddArr[2] + " - " + toAddArr[3];
                                                                        } else {
                                                                            toAdd = toAddArr[0] + " to " + toAddArr[1] + ": " + toAddArr[2] + " - " + toAddArr[3];
                                                                        }
                                                                        compiled.add(toAdd);
                                                                    }
                                                                }

                                                                for (int i = 7; i < 9; i++) {
                                                                    openCloseTimings = daysAndTime[i].split("-");
                                                                    //Closed-Closed
                                                                    if (openCloseTimings[2].equals("Closed")) {
                                                                        toAdd = openCloseTimings[0] + ": Closed";
                                                                    } else {
                                                                        toAdd = openCloseTimings[0] + ": " + openCloseTimings[1] + " - " + openCloseTimings[2];
                                                                    }
                                                                    compiled.add(toAdd);
                                                                }
                                                                for (String x : compiled) {
                                                                    out.println(x + "<br/>");
                                                                }*/ 
                                                            %>

                                                        </td>
                                                        <td><%=contact%></td>
                                                        <td><%=contact2%></td>
                                                        <td>
                                                            <%
                                                                String[] categoryArr = category.split(",");
                                                                for (String s : categoryArr) {
                                                                    out.println(s + "<br/>");
                                                                }
                                                            %>
                                                        </td>
                                                        <td>
                                                            <a href="EditWorkshop.jsp?id=<%=idToDelete%>" class="btn btn-primary btn-xs" role="button">Edit</a>
                                                            <button class="btn btn-default btn-xs md-trigger" data-modal="<% out.print("myModal" + idToDelete);%>" type="button">Delete</button>
                                                            <!-- Modal -->
                                                            <div class="md-modal md-effect-13 md-slategray colorize-overlay" id="<% out.print("myModal" + idToDelete);%>">

                                                                <div class="md-content">

                                                                    <div class="col-xs-12">
                                                                        <h4>Are you sure you want to delete <%=name%>?</h4>
                                                                        <form class="form-horizontal" role="form" action="DeleteWorkshop" method="POST">
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