<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="entity.ValetStaff"%>
<%@page import="dao.ValetShopDAO"%>
<%@page import="dao.WebUserDAO"%>
<%@page import="entity.WebUser"%>
<%@page import="entity.Workshop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.WorkshopDAO"%>
<%@include file="ProtectWebUsers.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Workshops</title>
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
                    <%                        String userType = (String) session.getAttribute("loggedInUserType");

                        int id = Integer.parseInt(request.getParameter("id"));
                        WebUserDAO uDAO = new WebUserDAO();
                        WebUser userToEdit = uDAO.retrieveUser(user.getStaffId(), user.getToken(), id);
                        int editUserStaffType = userToEdit.getStaffType();
                        int editUserType = userToEdit.getUserType();
                        String email = userToEdit.getEmail();
                        if (email.equals("null")) {
                            email = "";
                        }

                        String name = userToEdit.getName();
                        if (name.equals("null")) {
                            name = "";
                        }

                        String handphone = userToEdit.getHandphone();
                        if (handphone.equals("null")) {
                            handphone = "";
                        }
                        String licenseNo = "";
                        String licenseIssue = "";
                        ValetStaff valet = userToEdit.getValetStaff();
                        if (valet != null) {
                            licenseNo = valet.getLicenseNumber();
                            licenseIssue = valet.getLicenseIssueDate() + "";
                        }
                    %>
                    <%@include file="include/topbar.jsp"%>
                    <!-- page header -->
                    <div class="pageheader">
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>Edit Employee</h2>
                    </div>
                    <!-- /page header -->
                    <%
                        String errMsg = (String) request.getAttribute("errMsg");
                        if (errMsg != null && errMsg.length() > 0) {
                    %>
                    <div class="alert alert-danger"><%=errMsg%></div>
                    <%
                        }

                        ArrayList<String> errMsgArr = (ArrayList<String>) request.getAttribute("errMsgArr");
                        if (errMsgArr != null && errMsgArr.size() > 0) {
                    %>
                    <div class="alert alert-danger">
                        <ul>
                            <%
                                for (String error : errMsgArr) {
                            %>
                            <li><%=error%></li>
                                <%
                                    }
                                %>
                        </ul>
                    </div>
                    <%
                        }
                    %>

                    <!-- content main container -->
                    <div class="main">
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">

                                <!-- 2nd container col 12-->
                                <div class="col-md-offset-2 col-md-6">
                                    <!-- tile -->
                                    <section class="tile color transparent-black">
                                        <div class="tile-header">
                                            <h1><strong>Edit</strong> Employee Profile</h1>
                                        </div>
                                        <!--end tile header-->

                                        <!-- /tile body -->
                                        <div class="tile-body">
                                            <form class="form-horizontal" role="form" action="EditStaff" method="POST">
                                                <div class="form-group">
                                                    <label for="input01" class="col-sm-4 control-label">Name *</label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="input01" name="name" value="<%=name%>" required>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="input02" class="col-sm-4 control-label">Email *</label>
                                                    <div class="col-sm-8">
                                                        <input type="email" class="form-control" id="input02" name="email" value="<%=email%>" required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-4 control-label">Handphone *</label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="input03" name="handphone" value="<%=handphone%>" required>
                                                    </div>
                                                </div>
                                                <%if (editUserType == 4 && editUserStaffType == 2) {%>
                                                <div class="form-group">
                                                    <label for="input04" class="col-sm-4 control-label">Driver License No *</label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="input04" name="licenseNo" value="<%=licenseNo%>" required>
                                                    </div>
                                                </div> 

                                                <div class="form-group">
                                                    <label for="input05" class="col-sm-4 control-label">License Issue Date *</label>
                                                    <div class="col-sm-8">
                                                        <div class='input-group date' id='date'>
                                                            <input type='text' name="licenseIssue" class="form-control" value="<%=licenseIssue%>" required/>
                                                            <span class="input-group-addon">
                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%
                                                    }
                                                %>



                                                <!--form footer for submit-->
                                                <div class="form-group form-footer">
                                                    <div class="col-sm-offset-4 col-sm-8">
                                                        <input type="hidden" name="id" value="<%=id%>"><br/>
                                                        <button type="submit" class="btn btn-primary"  value="Edit Employee">Submit</button>
                                                    </div>
                                                </div>
                                                <!--end form footer-->
                                            </form>
                                        </div>
                                        <!--end tile body-->


                                    </section>
                                    <!--end tile-->
                                </div>
                                <!--end 2nd container col 12-->
                            </div>
                            <!--end col 12-->
                        </div>
                        <!--end row-->
                    </div>
                    <!--end main container-->
                </div>
                <!--end page content-->
            </div>
            <!--end row-->
        </div>
        <!--end wrap-->
        <%-- scripts --%>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-ui-1.10.4.custom.min.js"></script>
        <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
        <script type="text/javascript" src="js/jquery.mmenu.min.js"></script>
        <script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
        <script type="text/javascript" src="js/jquery.nicescroll.min.js"></script>
        <script type="text/javascript" src="js/jquery.blockUI.js"></script>
        <script type="text/javascript" src="js/moment.js"></script> 
        <script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script> 
        <script type="text/javascript" src="js/jquery.jgrowl.min.js"></script> 
        <script src="js/minimal.min.js"></script>

        <script type="text/javascript">
            $(".date").each(function () {
                $(this).datetimepicker({
                    format: 'YYYY-MM-DD',
                    maxDate: new Date(),
                    ignoreReadonly: true
                });
            });
        </script>
        <script>
            function remove(staffId) {
                $.post("url", function (data, status) {
                    alert(data + " " + status);
                });
            }

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
    <!--end body-->
</html>
