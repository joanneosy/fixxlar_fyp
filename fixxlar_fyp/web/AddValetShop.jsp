<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>


<%@page import="java.util.Arrays"%>
<%@page import="entity.Workshop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.WorkshopDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectAdmin.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Settings</title>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Add Valet Shop</h2>
                        <!--<a href="AddWorshop.jsp" class="btn btn-primary btn-lg pull-right margin-top-15"  role="button">Submit</a>-->
                    </div>
                    <!-- /page header -->

                    <!-- content main container -->
                    <div class="main">
                        <div class="row">

                            <!-- col 12 -->
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <!-- tile -->
                                    <section class="tile color transparent-black">
                                        <!-- tile header -->
                                        <div class="tile-header">
                                            <h1><strong>Add</strong> Valet Shop</h1>
                                        </div>
                                        <!-- /tile header -->
                                        <div class="tile-body">
                                            <%                                                
                                                String name = (String) request.getAttribute("name");
                                                if (name == null || name.equals("null")) {
                                                    name = "";
                                                }

                                                String address = (String) request.getAttribute("address");
                                                if (address == null || address.equals("null")) {
                                                    address = "";
                                                }
                                                String postalCode = (String) request.getAttribute("postalCode");
                                                if (postalCode == null || postalCode.equals("null")) {
                                                    postalCode = "";
                                                }

                                                String revenueShare = (String) request.getAttribute("revenueShare");
                                                if (revenueShare == null || revenueShare.equals("null")) {
                                                    revenueShare = "";
                                                }

                                                String noEmployees = (String) request.getAttribute("noEmployees");
                                                if (noEmployees == null || noEmployees.equals("null")) {
                                                    noEmployees = "";
                                                }

                                                String mondayOpen = (String) request.getAttribute("mondayOpen");
                                                if (mondayOpen == null || mondayOpen.equals("null")) {
                                                    mondayOpen = "";
                                                }
                                                String mondayClose = (String) request.getAttribute("mondayClose");
                                                if (mondayClose == null || mondayClose.equals("null")) {
                                                    mondayClose = "";
                                                }
                                                String tuesdayOpen = (String) request.getAttribute("tuesdayOpen");
                                                if (tuesdayOpen == null || tuesdayOpen.equals("null")) {
                                                    tuesdayOpen = "";
                                                }
                                                String tuesdayClose = (String) request.getAttribute("tuesdayClose");
                                                if (tuesdayClose == null || tuesdayClose.equals("null")) {
                                                    tuesdayClose = "";
                                                }
                                                String wednesdayOpen = (String) request.getAttribute("wednesdayOpen");
                                                if (wednesdayOpen == null || wednesdayOpen.equals("null")) {
                                                    wednesdayOpen = "";
                                                }
                                                String wednesdayClose = (String) request.getAttribute("wednesdayClose");
                                                if (wednesdayClose == null || wednesdayClose.equals("null")) {
                                                    wednesdayClose = "";
                                                }
                                                String thursdayOpen = (String) request.getAttribute("thursdayOpen");
                                                if (thursdayOpen == null || thursdayOpen.equals("null")) {
                                                    thursdayOpen = "";
                                                }
                                                String thursdayClose = (String) request.getAttribute("thursdayClose");
                                                if (thursdayClose == null || thursdayClose.equals("null")) {
                                                    thursdayClose = "";
                                                }
                                                String fridayOpen = (String) request.getAttribute("fridayOpen");
                                                if (fridayOpen == null || fridayOpen.equals("null")) {
                                                    fridayOpen = "";
                                                }
                                                String fridayClose = (String) request.getAttribute("fridayClose");
                                                if (fridayClose == null || fridayClose.equals("null")) {
                                                    fridayClose = "";
                                                }
                                                String saturdayOpen = (String) request.getAttribute("saturdayOpen");
                                                if (saturdayOpen == null || saturdayOpen.equals("null")) {
                                                    saturdayOpen = "";
                                                }
                                                String saturdayClose = (String) request.getAttribute("saturdayClose");
                                                if (saturdayClose == null || saturdayClose.equals("null")) {
                                                    saturdayClose = "";
                                                }
                                                String sundayOpen = (String) request.getAttribute("sundayOpen");
                                                if (sundayOpen == null || sundayOpen.equals("null")) {
                                                    sundayOpen = "";
                                                }
                                                String sundayClose = (String) request.getAttribute("sundayClose");
                                                if (sundayClose == null || sundayClose.equals("null")) {
                                                    sundayClose = "";
                                                }
                                                String phOpen = (String) request.getAttribute("phOpen");
                                                if (phOpen == null || phOpen.equals("null")) {
                                                    phOpen = "";
                                                }
                                                String phClose = (String) request.getAttribute("phClose");
                                                if (phClose == null || phClose.equals("null")) {
                                                    phClose = "";
                                                }
                                                String phEveOpen = (String) request.getAttribute("phEveOpen");
                                                if (phEveOpen == null || phEveOpen.equals("null")) {
                                                    phEveOpen = "";
                                                }
                                                String phEveClose = (String) request.getAttribute("phEveClose");
                                                if (phEveClose == null || phEveClose.equals("null")) {
                                                    phEveClose = "";
                                                }
                                                String[] openCloseTimings = {mondayOpen, mondayClose, tuesdayOpen, tuesdayClose, wednesdayOpen, wednesdayClose, thursdayOpen, thursdayClose, fridayOpen, fridayClose, saturdayOpen, saturdayClose, sundayOpen, sundayClose, phOpen, phClose, phEveOpen, phEveClose};

                                            %>
                                            <%                                                ArrayList<String> msg = (ArrayList<String>) request.getAttribute("errMsg");
                                                if (msg != null && msg.size() > 0) {
                                            %>
                                            <div class="alert alert-danger">
                                                <ul>
                                                    <%
                                                        for (String error : msg) {
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
                                            <form class="form-horizontal" role="form" action="AddValet" method="POST">

                                                <div class="form-group">
                                                    <label for="input01" class="col-sm-2 control-label">Valet Name</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" name="name" value="<%=name%>" />
                                                    </div>

                                                    <label for="input02" class="col-sm-2 control-label">Address</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="input02" name="address" value="<%=address%>">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Postal Code</label>
                                                    <div class="col-sm-4">
                                                        <input type="number" class="form-control" id="input03" name="postalCode" value="<%=postalCode%>">
                                                    </div>

                                                    <label for="input04" class="col-sm-2 control-label">No Employees</label>
                                                    <div class="col-sm-4">
                                                        <input type="number" class="form-control" id="input04" name="noEmployees" value="<%=noEmployees%>">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input05" class="col-sm-2 control-label">Revenue Share</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="input05" name="revenueShare" value="<%=revenueShare%>">
                                                    </div>
                                                </div>
                                                    
                                                <div class="form-group">
                                                    <h3><label class="col-sm-6">Operating Hours (Open - Close)</label></h3>
                                                </div>   

                                                <%                                                    //create hours arraylist
                                                    //iterate through every day for operating hours fields
                                                    ArrayList<String> hours = new ArrayList<String>();
                                                    hours.add("Closed");
                                                    hours.add("0000");
                                                    hours.add("0100");
                                                    hours.add("0200");
                                                    hours.add("0300");
                                                    hours.add("0400");
                                                    hours.add("0500");
                                                    hours.add("0600");
                                                    hours.add("0700");
                                                    hours.add("0800");
                                                    hours.add("0900");
                                                    hours.add("1000");
                                                    hours.add("1100");
                                                    hours.add("1200");
                                                    hours.add("1300");
                                                    hours.add("1400");
                                                    hours.add("1500");
                                                    hours.add("1600");
                                                    hours.add("1700");
                                                    hours.add("1800");
                                                    hours.add("1900");
                                                    hours.add("2000");
                                                    hours.add("2100");
                                                    hours.add("2200");
                                                    hours.add("2300");

                                                    int label = 11;
                                                %>
                                                <div class="form-group">
                                                    <label for="input11" class="col-sm-2 control-label">Monday</label>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="input11" name="mondayOpen">
                                                            <%
                                                                for (int i = 0; i < hours.size(); i++) {
                                                                    String hour = hours.get(i);
                                                                    if (openCloseTimings[0].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }
                                                            %>
                                                        </select>

                                                    </div>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="mondayClose">
                                                            <%
                                                                for (int i = 0; i < hours.size(); i++) {
                                                                    String hour = hours.get(i);
                                                                    if (openCloseTimings[1].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </div>  

                                                <%
                                                    ArrayList<String> days = new ArrayList<String>();
                                                    days.add("Monday");
                                                    days.add("Tuesday");
                                                    days.add("Wednesday");
                                                    days.add("Thursday");
                                                    days.add("Friday");
                                                    days.add("Saturday");
                                                    days.add("Sunday");
                                                    days.add("Holiday");
                                                    days.add("Holiday Eve");

                                                    ArrayList<String> paramList = new ArrayList<String>();
//                                                    paramList.add("mondayOpen");
//                                                    paramList.add("mondayClose");
                                                    paramList.add("tuesdayOpen");
                                                    paramList.add("tuesdayClose");
                                                    paramList.add("wednesdayOpen");
                                                    paramList.add("wednesdayClose");
                                                    paramList.add("thursdayOpen");
                                                    paramList.add("thursdayClose");
                                                    paramList.add("fridayOpen");
                                                    paramList.add("fridayClose");
                                                    paramList.add("saturdayOpen");
                                                    paramList.add("saturdayClose");
                                                    paramList.add("sundayOpen");
                                                    paramList.add("sundayClose");
                                                    paramList.add("phOpen");
                                                    paramList.add("phClose");
                                                    paramList.add("phEveOpen");
                                                    paramList.add("phEveClose");
                                                    int z = 0;
                                                    for (int i = 1; i < days.size(); i++) {
                                                %>
                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label"><%=days.get(i)%></label>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="" name="<%=paramList.get(z)%>">
                                                            <%
                                                                z++;
                                                                for (int j = 0; j < hours.size(); j++) {
                                                                    String hour = hours.get(j);
                                                                    if (openCloseTimings[i * 2].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="" name="<%=paramList.get(z)%>">
                                                            <%
                                                                z++;
                                                                for (int j = 0; j < hours.size(); j++) {
                                                                    String hour = hours.get(j);
                                                                    if (openCloseTimings[i * 2 + 1].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }

                                                            %>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-3">
                                                    </div>
                                                    <div class="col-sm-3">
                                                    </div>
                                                </div>  

                                                <%                                                    }//end of for loop for operating days
%>
                                                <div class="form-group form-footer">
                                                    <div class="col-sm-offset-5 col-sm-8">
                                                        <button type="submit" class="btn btn-primary">Submit</button>
                                                        <button type="reset" class="btn btn-default">Reset</button>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                        <!--End of Tile Body-->
                                    </section>
                                    <!-- /tile body -->

                                    <!-- tile -->

                                </div>
                                <!--End of first col 6-->

                            </div>

                        </div>
                        <!--end of col-->
                    </div>
                    <!-- row end-->
                </div>
                <!-- content main container end-->
            </div>
            <!-- Page content end-->
        </div>
        <!-- Make page fluid end-->

        <!-- Wrap all page content end -->

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

        <script type="text/javascript" src="js/ColReorderWithResize.js"></script>
        <script type="text/javascript" src="js/chosen.jquery.min.js"></script>
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
//                $('#input06').summernote({
//                    toolbar: [
//                        //['style', ['style']], // no style button
//                        ['style', ['bold', 'italic', 'underline', 'clear']],
//                        ['fontsize', ['fontsize']],
//                        ['color', ['color']],
//                        ['para', ['ul', 'ol', 'paragraph']],
//                        ['height', ['height']],
//                                //['insert', ['picture', 'link']], // no insert buttons
//                                //['table', ['table']], // no table button
//                                //['help', ['help']] //no help button
//                    ],
//                    height: 137   //set editable area's height
//                });

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

            });

        </script>

        <!--Form Error Handling-->
        <script>
            $(function () {
                $("#workshopForm").submit(function () {
                    var inputVal = $("#inputExample").val();
                    $(document).trigger("clear-alert-id.example");
                    if (inputVal.length < 1) {
                        $(document).trigger("set-alert-id-example", [
                            {
                                message: "Please enter the workshop name",
                                priority: "error"
                            },
                        ]);
                    }
                });
            });



        </script>
    </body>
</html>
