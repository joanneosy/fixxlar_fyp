<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="entity.Setting"%>
<%@page import="dao.ValetShopDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="dao.SettingDAO"%>
<%@page import="dao.WebUserDAO"%>
<%@page import="entity.WebUser"%>
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Urgency Settings</title>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>Settings</h2>
                        <!--<a href="AddWorshop.jsp" class="btn btn-primary btn-lg pull-right margin-top-15"  role="button">Submit</a>-->
                    </div>
                    <!-- /page header -->

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
                                            <h1><strong>Edit</strong> Urgency </h1>
                                        </div>
                                        <!--end tile header-->

                                        <!-- /tile body -->
                                        <div class="tile-body">
                                            <%
                                                ArrayList<String> msg = (ArrayList<String>) session.getAttribute("fail");
                                                if (msg != null && msg.size() > 0) {
                                                    for (String s : msg) {
                                                        out.println(s + "<br>");
                                                    }
                                                    session.removeAttribute("fail");
                                                }

                                                String success = (String) session.getAttribute("success");
                                                if (success != null && success.length() != 0) {
                                                    out.println(success);
                                                    session.removeAttribute("success");
                                                }
                                            %>
                                            <form class="form-horizontal" role="form" action="EditSettings" method="post">
                                                <%
                                                    String token = user.getToken();
                                                    int staffId = user.getStaffId();
                                                    SettingDAO sDAO = new SettingDAO();
                                                    ArrayList<Setting> settings = sDAO.retrieveAllSettings(staffId, token);
                                                    for (Setting s: settings) {
                                                        int settingId = s.getId();
                                                        String category = s.getCategory();
                                                        String name = s.getName();
                                                        String label = "";
                                                        if (category.equals(name)) {
                                                            label = category;
                                                        } else {
                                                            label = category + " (" + name + ")"; 
                                                        }
                                                        String value = s.getValue();

                                                %>
                                                <div class="form-group">
                                                    <label for="input01" class="col-sm-4 control-label" 
                                                           title="Urgency count" ><%=label%></label>         

                                                    <div class="col-sm-8">
                                                        <input type="text" min="1" class="form-control" id="input01" name="<%=settingId%>" value="<%=value%>">
                                                    </div>                                       
                                                </div>
                                                
                                               <% 
                                                    }//for
                                                        
                                               %>

<!--                                                <div class="form-group">
                                                    <label for="input02" class="col-sm-4 control-label">Moderate Count</label>
                                                    <div class="col-sm-8">
                                                        <input type="number" min="1" class="form-control" id="input02">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-4 control-label">Low Count</label>
                                                    <div class="col-sm-8">
                                                        <input type="number" min="1" class="form-control" id="input02">
                                                    </div>
                                                </div>-->

                                                <!--form footer for submit-->
                                                <div class="form-group form-footer">
                                                    <div class="col-sm-offset-4 col-sm-8">
                                                        <button type="submit" class="btn btn-primary" value="Edit">Submit</button>
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
        <script src="js/jquery.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
        <script type="text/javascript" src="js/jquery.mmenu.min.js"></script>
        <script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
        <script type="text/javascript" src="js/jquery.nicescroll.min.js"></script>
        <script type="text/javascript" src="js/jquery.animateNumbers.js"></script>
        <script type="text/javascript" src="js/jquery.blockUI.js"></script>
        <script src="js/minimal.min.js"></script>


        
    </body>
</html>
