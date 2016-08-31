<%-- 
    Document   : EditWorkshop
    Created on : Jun 3, 2016, 3:39:11 PM
    Author     : Joanne
--%>

<%@page import="entity.CarBrand"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="dao.WorkshopDAO"%>
<%@page import="entity.Workshop"%>
<%@include file="ProtectAdmin.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8" />
        <title>Edit Workshop</title>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Edit Profile</h2>
                        <!--<a href="AddWorshop.jsp" class="btn btn-primary btn-lg pull-right margin-top-15"  role="button">Submit</a>-->
                    </div>
                    <!-- /page header -->
                    <%
                        ArrayList<String> msg = (ArrayList<String>) request.getAttribute("fail");
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
                    <!-- content main container -->
                    <div class="main">
                        <%
                            int wsId = Integer.parseInt(request.getParameter("id"));
                            Workshop ws = wsDAO.retrieveWorkshop(wsId, user.getStaffId(), user.getToken());
                            String email = ws.getEmail();
                            if (email.equals("null")) {
                                email = "";
                            }
                            String name = ws.getName();
                            if (name.equals("null")) {
                                name = "";
                            }

                            String address = ws.getAddress();
                            String postalCode = "";
                            if (address.equals("null")) {
                                address = "";
                            } else {
                                postalCode = address.substring(address.lastIndexOf(" ") + 1);
                                address = address.substring(0, address.lastIndexOf(" "));
                            }

                            String website = ws.getWebsite();
                            if (website.equals("null")) {
                                website = "";
                            }

                            String description = ws.getDescription();
                            if (description.equals("null")) {
                                description = "";
                            }
                            String openingHour = ws.getOpeningHour();
                            String[] daysAndTime = null;

                            if (openingHour.equals("null")) {
                                openingHour = "";
                            } else {
                                //Each string in this format: Monday-0900-1800
                                daysAndTime = openingHour.split(",");
                            }
                            String openingHourFormat = ws.getOpeningHourFormat();
                            if (openingHourFormat.equals("null")) {
                                openingHourFormat = "";
                            }
                            String contact = ws.getContact();
                            if (contact.equals("null")) {
                                contact = "";
                            }
                            String contact2 = ws.getContact2();
                            if (contact2.equals("null")) {
                                contact2 = "";
                            }
                            String location = ws.getLocation();
                            if (location.equals("null")) {
                                location = "";
                            }
                            String brandsCarried = ws.getBrandsCarried();
                            if (brandsCarried.equals("null")) {
                                brandsCarried = "";
                            }
                            String category = ws.getCategory();
                            if (category.equals("null")) {
                                category = "";
                            }
                            String remark = ws.getRemark();
                            if (remark.equals("null")) {
                                remark = "";
                            }
                            int status = ws.getStatus();
                            String[] carBrandsID = ws.getSpecialize().split(",");
                            ArrayList<String> carBrands = wsDAO.retrieveAllCarBrands(user.getStaffId(), user.getToken());

                        %>
                        <div class="row">

                            <!-- col 12 -->
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <!-- tile -->
                                    <section class="tile color transparent-black">
                                        <!-- tile header -->
                                        <div class="tile-header">
                                            <h1><strong>Edit</strong> <%=ws.getName()%></h1>
                                        </div>
                                        <!-- /tile header -->
                                        <div class="tile-body">
                                            <form class="form-horizontal" role="form" action="EditWorkshop" method="POST">

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Workshop Name</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=name%>" name="name">
                                                    </div>

                                                    <label for="input03" class="col-sm-2 control-label">Contact Number</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=contact%>" name="contact">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Alt. Contact</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=contact2%>" name="contact2">
                                                    </div>

                                                    <label for="input03" class="col-sm-2 control-label">Address</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=address%>" name="address">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Postal Code</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=postalCode%>" name="postalCode">
                                                    </div>

                                                    <label for="input03" class="col-sm-2 control-label">Website</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=website%>" name="website">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Brands Carried</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=brandsCarried%>" name="brandsCarried">
                                                    </div>

                                                    <label for="input03" class="col-sm-2 control-label">Remarks</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=remark%>" name="remark">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Location</label>
                                                    <div class="col-sm-4">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="location">
                                                            <%
                                                                if (location.equals("West")) {
                                                                    out.println("<option value=\"West\" selected>West</option>");
                                                                } else {
                                                                    out.println("<option value=\"West\">West</option>");
                                                                }

                                                                if (location.equals("North")) {
                                                                    out.println("<option value=\"North\" selected>North</option>");
                                                                } else {
                                                                    out.println("<option value=\"North\">North</option>");
                                                                }

                                                                if (location.equals("South")) {
                                                                    out.println("<option value=\"South\" selected>South</option>");
                                                                } else {
                                                                    out.println("<option value=\"South\">South</option>");
                                                                }

                                                                if (location.equals("Central")) {
                                                                    out.println("<option value=\"Central\" selected>Central</option>");
                                                                } else {
                                                                    out.println("<option value=\"Central\">Central</option>");
                                                                }

                                                                if (location.equals("East")) {
                                                                    out.println("<option value=\"East\" selected>East</option>");
                                                                } else {
                                                                    out.println("<option value=\"East\">East</option>");
                                                                }
                                                            %> 

                                                        </select>
                                                    </div> 
                                                    <label for="input03" class="col-sm-2 control-label">Email</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=email%>" name="email">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input05" class="col-sm-2 control-label">Description</label>
                                                    <div class="col-sm-10">
                                                        <textarea class="form-control" rows="5" name="description"><%=description%></textarea>
                                                    </div>

                                                </div>

                                                <div class="form-group">
                                                    <h3><label class="col-sm-6">Operating Hours (Open - Close)</label></h3>
                                                    <h3><label class="col-sm-3">Specialize</label></h3>
                                                    <h3><label class="col-sm-3">Category</label></h3>
                                                </div>   

                                                <input type="hidden" class="form-control" value="<%=wsId%>" name="id">

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


                                                %>
                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Monday</label>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="mondayOpen">
                                                            <%                                                                //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
                                                                String[] openCloseTimings = daysAndTime[0].split("-");
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
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="mondayClose">
                                                            <%
                                                                for (int i = 0; i < hours.size(); i++) {
                                                                    String hour = hours.get(i);
                                                                    if (openCloseTimings[2].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }
                                                            %>


                                                        </select>
                                                    </div>
                                                    <div class="col-sm-3">

                                                        <select multiple class="chosen-select chosen-transparent form-control" id="input08" name="specialize">
                                                            <%
                                                                for (String s : carBrands) {
                                                                    if (Arrays.asList(carBrandsID).contains(s)) {
                                                                        out.println("<option selected>" + s + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + s + "</option>");
                                                                    }
                                                                }
                                                            %>
                                                        </select>


                                                    </div>
                                                    <div class="col-sm-3">
                                                        <select multiple class="chosen-select chosen-transparent form-control" id="input08" name="category">

                                                            <%
                                                                String[] categories = category.split(",");

                                                                if (Arrays.asList(categories)
                                                                        .contains("Maintenance")) {
                                                                    out.println("<option selected>Maintenance</option>");
                                                                } else {
                                                                    out.println("<option>Maintenance</option>");
                                                                }

                                                                if (Arrays.asList(categories)
                                                                        .contains("Car Grooming")) {
                                                                    out.println("<option selected>Car Grooming1</option>");
                                                                } else {
                                                                    out.println("<option>Car Grooming</option>");
                                                                }

                                                                if (Arrays.asList(categories)
                                                                        .contains("Tyre/Wheel Service")) {
                                                                    out.println("<option selected>Tyre/Wheel Service</option>");
                                                                } else {
                                                                    out.println("<option>Tyre/Wheel Service</option>");
                                                                }

                                                                if (Arrays.asList(categories)
                                                                        .contains("Air Conditioning")) {
                                                                    out.println("<option selected>Air Conditioning</option>");
                                                                } else {
                                                                    out.println("<option>Air Conditioning</option>");
                                                                }

                                                                if (Arrays.asList(categories)
                                                                        .contains("Battery")) {
                                                                    out.println("<option selected>Battery</option>");
                                                                } else {
                                                                    out.println("<option>Battery</option>");
                                                                }

                                                                if (Arrays.asList(categories)
                                                                        .contains("Others")) {
                                                                    out.println("<option selected>Others/option>");
                                                                } else {
                                                                    out.println("<option>Others</option>");
                                                                }
                                                            %>
                                                        </select>

                                                    </div>
                                                </div>  

                                                <%                                                    ArrayList<String> days = new ArrayList<String>();

                                                    days.add(
                                                            "Monday");
                                                    days.add(
                                                            "Tuesday");
                                                    days.add(
                                                            "Wednesday");
                                                    days.add(
                                                            "Thursday");
                                                    days.add(
                                                            "Friday");
                                                    days.add(
                                                            "Saturday");
                                                    days.add(
                                                            "Sunday");
                                                    days.add(
                                                            "Holiday");
                                                    days.add(
                                                            "Holiday Eve");

                                                    ArrayList<String> paramList = new ArrayList<String>();
//                                                    paramList.add("mondayOpen");
//                                                    paramList.add("mondayClose");

                                                    paramList.add(
                                                            "tuesdayOpen");
                                                    paramList.add(
                                                            "tuesdayClose");
                                                    paramList.add(
                                                            "wednesdayOpen");
                                                    paramList.add(
                                                            "wednesdayClose");
                                                    paramList.add(
                                                            "thursdayOpen");
                                                    paramList.add(
                                                            "thursdayClose");
                                                    paramList.add(
                                                            "fridayOpen");
                                                    paramList.add(
                                                            "fridayClose");
                                                    paramList.add(
                                                            "saturdayOpen");
                                                    paramList.add(
                                                            "saturdayClose");
                                                    paramList.add(
                                                            "sundayOpen");
                                                    paramList.add(
                                                            "sundayClose");
                                                    paramList.add(
                                                            "phOpen");
                                                    paramList.add(
                                                            "phClose");
                                                    paramList.add(
                                                            "phEveOpen");
                                                    paramList.add(
                                                            "phEveClose");
                                                    int z = 0;
                                                    for (int i = 1;
                                                            i < days.size();
                                                            i++) {
                                                %>
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label"><%=days.get(i)%></label>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="<%=paramList.get(z)%>">
                                                            <%
                                                                z++;
                                                                //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
                                                                openCloseTimings = daysAndTime[i].split("-");
                                                                for (int j = 0; j < hours.size(); j++) {
                                                                    String hour = hours.get(j);
                                                                    if (openCloseTimings[1].equals(hour)) {
                                                                        out.println("<option selected>" + hour + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + hour + "</option>");
                                                                    }
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="<%=paramList.get(z)%>">
                                                            <%
                                                                z++;
                                                                for (int j = 0; j < hours.size(); j++) {
                                                                    String hour = hours.get(j);
                                                                    if (openCloseTimings[2].equals(hour)) {
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

                                                <%
                                                    }//end of for loop for operating days
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
        <script src="https://code.jquery.com/jquery.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/bootstrap-dropdown-multilevel.js"></script>
        <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
        <script type="text/javascript" src="js/jquery.mmenu.min.js"></script>
        <script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
        <script type="text/javascript" src="js/jquery.nicescroll.min.js"></script>
        <script type="text/javascript" src="js/jquery.animateNumbers.js"></script>
        <script type="text/javascript" src="js/jquery.videobackground.js"></script>
        <script type="text/javascript" src="js/jquery.blockUI.js"></script>

        <script src="js/summernote.min.js"></script>

        <script src="js/chosen.jquery.min.js"></script>

        <script src="js/moment-with-langs.min.js"></script>
        <script src="js/bootstrap-datetimepicker.js"></script>

        <script src="js/bootstrap-colorpicker.min.js"></script>

        <script src="js/bootstrap-colorpalette.js"></script>

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
