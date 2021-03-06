<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>
<%@page import="dao.ValetShopDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.WebUser"%>
<%@page import="dao.WebUserDAO"%>
<%@page import="dao.WorkshopDAO"%>
<%@page import="entity.Workshop"%>
<%@include file="ProtectWebUsers.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Employee</title>
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
                    <%                        String userType = (String) session.getAttribute("loggedInUserType");
                    %>
                    <%@include file="include/topbar.jsp"%>

                    <!-- page header -->
                    <div class="pageheader">
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Add Employee</h2>
                        <!--<a href="AddWorshop.jsp" class="btn btn-primary btn-lg pull-right margin-top-15"  role="button">Submit</a>-->
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
                                            <h1><strong>Add</strong> Employee</h1>
                                        </div>
                                        <!--end tile header-->

                                        <!-- /tile body -->
                                        <div class="tile-body">



                                            <form class="form-horizontal" role="form" action="AddEmployee" method="POST">
                                                <div class="form-group">
                                                    <label for="input01" class="col-sm-4 control-label">Name *</label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="input01" name="staffName" required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input08" class="col-sm-4 control-label">Email *</label>
                                                    <div class="col-sm-8">
                                                        <input type="email" class="form-control" id="input08" name="staffEmail" required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input02" class="col-sm-4 control-label">Driver License No *</label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="input02" name="licenseNo" required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-4 control-label">License Issue Date *</label>
                                                    <div class="col-sm-8">
                                                        <div class='input-group date' id='date'>
                                                            <!--<form id='' action="" role="form">-->
                                                            <input type='text' name="licenseIssue" class="form-control" />
                                                            <!--</form>-->

                                                            <span class="input-group-addon">
                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input04" class="col-sm-4 control-label">Phone Number *</label>
                                                    <div class="col-sm-8">
                                                        <input type="number" class="form-control" id="input04" name="staffHpNo" required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input05" class="col-sm-4 control-label">Password *</label>
                                                    <div class="col-sm-8">
                                                        <input type="password" class="form-control" id="input05" name="password" required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input06" class="col-sm-4 control-label">Confirm Password *</label>
                                                    <div class="col-sm-8">
                                                        <input type="password" class="form-control" id="input06" name="confirmPassword" required>
                                                    </div>
                                                </div>

<!--                                                <div class="form-group">
                                                    <label for="input07" class="col-sm-4 control-label">Type of Employee</label>
                                                    <div class="col-sm-8">
                                                        <input type="radio" name="type" value="2"> Master 
                                                        <input type="radio" name="type" value="3" checked> Normal
                                                    </div>
                                                </div>-->

                                                <!--form footer for submit-->
                                                <div class="form-group form-footer">
                                                    <div class="col-sm-offset-4 col-sm-8">
                                                        <button type="submit" class="btn btn-primary">Submit</button>
                                                        <button type="reset" class="btn btn-default">Reset</button>
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
                <!-- End Page content -->
            </div>
            <!--End page fluid-->
        </div>
        <!--End page wrap-->
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
    </body>
</html>