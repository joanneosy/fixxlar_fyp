<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

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
<%@page import="util.Settings"%>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>Urgency Settings</h2>
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
                                                    Settings settings = new Settings();
                                                    HashMap<String, JsonObject> messages = settings.retrieveAllSettings(staffId, token);
                                                    Iterator it = messages.entrySet().iterator();
                                                    while (it.hasNext()) {
                                                        Map.Entry pair = (Map.Entry) it.next();
                                                        String setting = (String) pair.getKey();
                                                        String[] arr = setting.split(",");
                                                        int settingId = Integer.parseInt(arr[0]);
                                                        String settingName = arr[1];
                                                        JsonObject value = (JsonObject) pair.getValue();
                                                        //out.println(settingName + "<br>");
                                                        Set<Entry<String, JsonElement>> entrySet = value.entrySet();
                                                        for (Map.Entry<String, JsonElement> entry : entrySet) {
                                                           String status = entry.getKey();
                                                           status = status.substring(0, 1).toUpperCase() + status.substring(1);

                                                %>
                                                <div class="form-group">
                                                    <label for="input01" class="col-sm-4 control-label" 
                                                           title="Urgency count" ><%=status%></label>         

                                                    <div class="col-sm-8">
                                                        <input type="number" min="1" class="form-control" id="input01" name="<%=settingName + "," + entry.getKey() %>" value="<%=entry.getValue().getAsInt()%>">
                                                    </div>                                       
                                                </div>
                                                
                                               <% 
                                                    }//for
                                                    }//while
                                                        
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


        <script>

            //initialize file upload button function
            $(document)
                    .on('change', '.btn-file :file', function () {
                        var input = $(this),
                                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                                label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                        input.trigger('fileselect', [numFiles, label]);
                    });


            $(function () {

                //load wysiwyg editor
                $('#input06').summernote({
                    toolbar: [
                        //['style', ['style']], // no style button
                        ['style', ['bold', 'italic', 'underline', 'clear']],
                        ['fontsize', ['fontsize']],
                        ['color', ['color']],
                        ['para', ['ul', 'ol', 'paragraph']],
                        ['height', ['height']],
                                //['insert', ['picture', 'link']], // no insert buttons
                                //['table', ['table']], // no table button
                                //['help', ['help']] //no help button
                    ],
                    height: 137   //set editable area's height
                });

                //chosen select input
                $(".chosen-select").chosen({disable_search_threshold: 10});

                //initialize datepicker
                $('#datepicker').datetimepicker({
                    icons: {
                        time: "fa fa-clock-o",
                        date: "fa fa-calendar",
                        up: "fa fa-arrow-up",
                        down: "fa fa-arrow-down"
                    }
                });

                $("#datepicker").on("dp.show", function (e) {
                    var newtop = $('.bootstrap-datetimepicker-widget').position().top - 45;
                    $('.bootstrap-datetimepicker-widget').css('top', newtop + 'px');
                });

                //initialize colorpicker
                $('#colorpicker').colorpicker();

                $('#colorpicker').colorpicker().on('showPicker', function (e) {
                    var newtop = $('.dropdown-menu.colorpicker.colorpicker-visible').position().top - 45;
                    $('.dropdown-menu.colorpicker.colorpicker-visible').css('top', newtop + 'px');
                });

                //initialize colorpicker RGB
                $('#colorpicker-rgb').colorpicker({
                    format: 'rgb'
                });

                $('#colorpicker-rgb').colorpicker().on('showPicker', function (e) {
                    var newtop = $('.dropdown-menu.colorpicker.colorpicker-visible').position().top - 45;
                    $('.dropdown-menu.colorpicker.colorpicker-visible').css('top', newtop + 'px');
                });

                //initialize file upload button
                $('.btn-file :file').on('fileselect', function (event, numFiles, label) {

                    var input = $(this).parents('.input-group').find(':text'),
                            log = numFiles > 1 ? numFiles + ' files selected' : label;

                    console.log(log);

                    if (input.length) {
                        input.val(log);
                    } else {
                        if (log)
                            alert(log);
                    }

                });

                // Initialize colorpalette
                $('#event-colorpalette').colorPalette({
                    colors: [['#428bca', '#5cb85c', '#5bc0de', '#f0ad4e', '#d9534f', '#ff4a43', '#22beef', '#a2d200', '#ffc100', '#cd97eb', '#16a085', '#FF0066', '#A40778', '#1693A5']]
                }).on('selectColor', function (e) {
                    var data = $(this).data();

                    $(data.returnColor).val(e.color);
                    $(this).parents(".input-group").css("border-bottom-color", e.color);
                });

            })


        </script>

        
    </body>
</html>
