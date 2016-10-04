<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="dao.ValetShopDAO"%>
<%@page import="java.util.Arrays"%>
<%@page import="entity.Workshop"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.WorkshopDAO"%>
<%@include file="ProtectWorkshop.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8" />
        <title>Edit Profile</title>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Edit Workshop Profile</h2>
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
                        <div class="row">

                            <!-- col 12 -->
                            <div class="col-md-12">
                                <div class="col-md-12">
                                    <!-- tile -->
                                    <section class="tile color transparent-black">
                                        <!-- tile header -->
                                        <div class="tile-header">
                                        </div>
                                        <%
                                            Workshop ws = wsDAO.retrieveWorkshop(user.getShopId(), user.getStaffId(), user.getToken());
                                            int wsId = user.getShopId();
                                            int staffID = user.getStaffId();
                                            String token = user.getToken();
                                            String phone_number = user.getHandphone();
                                            String user_name = user.getName();
                                            String user_email = user.getEmail();

                                            String email = ws.getEmail();
                                            String address = ws.getAddress();
                                            String workshop_name = ws.getName();
                                            String wsAddress = address.substring(0, address.lastIndexOf(" "));
                                            String wsPostal = address.substring(address.lastIndexOf(" ") + 1);
                                            String wsLocation = ws.getLocation();
                                            String wsWebsite = ws.getWebsite();
                                            String wsContact = ws.getContact();
                                            String wsCsontact2 = ws.getContact2();
                                            String wsBrands = ws.getBrandsCarried();
                                            String wsDescription = ws.getDescription();
                                            String wsSpecialize = ws.getSpecialize();
                                            String wsOpenHr = ws.getOpeningHourFormat();
                                            String[] daysAndTime = wsOpenHr.split(",");
                                            String wsCategory = ws.getCategory();
                                            String wsRemark = ws.getRemark();

                                            String[] carBrandsID = ws.getSpecialize().split(",");
                                            ArrayList<String> carBrands = wsDAO.retrieveAllCarBrands(user.getStaffId(), user.getToken());

                                        %>
                                        <!-- /tile header -->
                                        <div class="tile-body">
                                            <form class="form-horizontal" role="form" action="EditWorkshop" method="POST">

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Workshop Name</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=workshop_name%>" name="name">
                                                    </div>

                                                    <label for="input03" class="col-sm-2 control-label">Contact Number</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=wsContact%>" name="contact">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Alt. Contact</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=wsCsontact2%>" name="contact2">
                                                    </div>

                                                    <label for="input03" class="col-sm-2 control-label">Address</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=wsAddress%>" name="address">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Postal Code</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=wsPostal%>" name="postalCode">
                                                    </div>

                                                    <label for="input03" class="col-sm-2 control-label">Website</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=wsWebsite%>" name="website">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Brands Carried</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=wsBrands%>" name="brandsCarried">
                                                    </div>

                                                    <label for="input03" class="col-sm-2 control-label">Remarks</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=wsRemark%>" name="remark">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Location</label>
                                                    <div class="col-sm-4">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="location">
                                                            <%
                                                                if (wsLocation.equals("West")) {
                                                                    out.println("<option value=\"West\" selected>West</option>");
                                                                } else {
                                                                    out.println("<option value=\"West\">West</option>");
                                                                }

                                                                if (wsLocation.equals("North")) {
                                                                    out.println("<option value=\"North\" selected>North</option>");
                                                                } else {
                                                                    out.println("<option value=\"North\">North</option>");
                                                                }

                                                                if (wsLocation.equals("South")) {
                                                                    out.println("<option value=\"South\" selected>South</option>");
                                                                } else {
                                                                    out.println("<option value=\"South\">South</option>");
                                                                }

                                                                if (wsLocation.equals("Central")) {
                                                                    out.println("<option value=\"Central\" selected>Central</option>");
                                                                } else {
                                                                    out.println("<option value=\"Central\">Central</option>");
                                                                }

                                                                if (wsLocation.equals("East")) {
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
                                                        <textarea class="form-control" rows="5" name="description"><%=wsDescription%></textarea>
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
                                                            <%    //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
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
                                                                String[] categories = wsCategory.split(",");
                                                                if (Arrays.asList(categories).contains("Maintenance")) {
                                                                    out.println("<option selected>Maintenance</option>");
                                                                } else {
                                                                    out.println("<option>Maintenance</option>");
                                                                }

                                                                if (Arrays.asList(categories).contains("Car Grooming")) {
                                                                    out.println("<option selected>Car Grooming</option>");
                                                                } else {
                                                                    out.println("<option>Car Grooming</option>");
                                                                }

                                                                if (Arrays.asList(categories).contains("Tyre/Wheel Service")) {
                                                                    out.println("<option selected>Tyre/Wheel Service</option>");
                                                                } else {
                                                                    out.println("<option>Tyre/Wheel Service</option>");
                                                                }

                                                                if (Arrays.asList(categories).contains("Air Conditioning")) {
                                                                    out.println("<option selected>Air Conditioning</option>");
                                                                } else {
                                                                    out.println("<option>Air Conditioning</option>");
                                                                }

                                                                if (Arrays.asList(categories).contains("Battery")) {
                                                                    out.println("<option selected>Battery</option>");
                                                                } else {
                                                                    out.println("<option>Battery</option>");
                                                                }

                                                                if (Arrays.asList(categories).contains("Others")) {
                                                                    out.println("<option selected>Others</option>");
                                                                } else {
                                                                    out.println("<option>Others</option>");
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
        <script type="text/javascript" src="js/jquery.jgrowl.min.js"></script> 
        <script type="text/javascript" src="js/intercom.js"></script> 
        <script src="js/minimal.min.js"></script>
        
        <script>


            $(function () {

                //chosen select input
                $(".chosen-select").chosen({disable_search_threshold: 10});

            })


        </script>
        <script>
            intercom("<%=user_name%>", "<%=user_email%>",<%=staffID%>, "<%=phone_number%>", "<%=workshop_name%>", "<%=wsCategory%>", "<%=wsBrands%>");
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
</html>
