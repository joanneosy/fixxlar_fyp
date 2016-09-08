<%-- 
    Document   : AdminSettings
    Created on : 3 Aug, 2016, 12:26:26 PM
    Author     : Joshymantou
--%>

<%@page import="java.util.HashMap"%>
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
        <title>Profile</title>
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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i>Profile Page</h2>
                        <a href="EditProfile.jsp" type="button" class="btn btn-primary margin-bottom-20 col-md-offset-8">Edit Profile</a>
                    </div>
                    <!-- /page header -->
                    <%
                        String msg = (String) session.getAttribute("success");
                        if (msg != null && msg.length() > 0 && !(msg.equals("null"))) {
                    %>
                    <div class="alert alert-success"><%=msg%></div>
                    <%
                        session.setAttribute("success","");
                        }
                    %>


                    <%
                        int staffID = user.getStaffId();
                        String phone_number = user.getHandphone();
                        String user_name = user.getName();
                        String user_email = user.getEmail();
                        Workshop ws = wsDAO.retrieveWorkshop(user.getShopId(), user.getStaffId(), user.getToken());
                        String workshop_name = ws.getName();
                        String address = ws.getAddress();
                        String wsAddress = address.substring(0, address.lastIndexOf(" "));
                        String wsPostal = address.substring(address.lastIndexOf(" ") + 1);
                        String wsLocation = ws.getLocation();
                        String wsWebsite = ws.getWebsite();
                        String wsContact = ws.getContact();
                        String wsCsontact2 = ws.getContact2();
                        String wsBrands = ws.getBrandsCarried();
                        String wsDescription = ws.getDescription();
                        String wsSpecialize = ws.getSpecialize();
                        String wsOpenHr = ws.getOpeningHour();
                        //String[] wsOpeningHr = wsOpenHr.split(",");
                        String wsCategory = ws.getCategory();


                    %>
                    <!-- content main container -->
                    <div class="main">
                        <div class="row">
                            <!-- col 12 -->
                            <div class="col-md-12">

                                <div class="col-md-6">
                                    <section class="tile">
                                        <div class="tile-header">
                                            <h1><strong>Particulars</strong></h1>
                                        </div>

                                        <div class="tile-widget">

                                            <div class="row">

                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="name">Name</label>
                                                    <input type="text" class="form-control" id="username" value="<%=wsName%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="address">Address</label>
                                                    <input type="text" class="form-control" value="<%=wsAddress%>" readonly>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Postal Code</label>
                                                    <input type="text" class="form-control" value="<%=wsPostal%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Location</label>
                                                    <input type="text" class="form-control" value="<%=wsLocation%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Website</label>
                                                    <input type="text" class="form-control" value="<%=wsWebsite%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Contact</label>
                                                    <input type="text" class="form-control" value="<%=wsContact%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Alt. Contact</label>
                                                    <input type="text" class="form-control" value="<%=wsCsontact2%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Brands Carried</label>
                                                    <input type="text" class="form-control" value="<%=wsBrands%>" readonly>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <label for="postalCode">Description</label>
                                                    <textarea rows="5" class="form-control" value="" readonly><%=wsDescription%></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <!--end tile widget-->
                                    </section>
                                </div>

                                <div class="col-md-6">
                                    <section class="tile">
                                        <div class="tile-header">
                                            <h1><strong>Stripe Account</strong></h1>
                                        </div>

                                        <div class="tile-widget">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group col-sm-6">
                                                        <label for="postalCode">Stripe Username</label>
                                                        <input type="text" class="form-control" value="ABC@stripe" readonly>
                                                    </div>

                                                    <div class="form-group col-sm-6">
                                                        <label for="postalCode">Password</label>
                                                        <input type="password" class="form-control" value="ABC@stripe" readonly>
                                                    </div>
                                                </div>
                                                <!--end inner col 12-->
                                            </div>
                                            <!--end row-->
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-offset-5">
                                                <!--<a href="RegisterStripe.jsp" type="button" class="btn btn-primary btn-sm">Register</a>-->

                                            </div>
                                        </div>
                                    </section>

                                    <section class="tile">
                                        <div class="tile-header">
                                            <h1><strong>Opening Hours (24hrs)</strong></h1>
                                        </div>


                                        <div class="tile-widget">
                                            <%
                                                /*
                                                 HashMap<String, String> openingMap = new HashMap<String, String>();
                                                 for(int x = 1; x < wsOpeningHr.length; x++) {
                                                 String openHr = wsOpeningHr[x];
                                                 String day = openHr.substring(0, openHr.indexOf("-"));
                                                 String startEnd = openHr.substring(openHr.indexOf("-") + 1);
                                                 if(openingMap.get(startEnd) == null){
                                                 openingMap.put(startEnd, day);
                                                 }
                                                 }*/
                                                ArrayList<String> compiled = new ArrayList<String>();
                                                //Monday-0900-1800
                                                String[] daysAndTime = wsOpenHr.split(",");
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
                                                }
//                                                ArrayList<String> hourList = new ArrayList<String>();
//                                                String day = wsOpeningHr[0].substring(0, wsOpeningHr[0].indexOf("-"));
//                                                String startEnd = wsOpeningHr[0].substring(wsOpeningHr[0].indexOf("-") + 1);
//                                                for (int x = 1; x < wsOpeningHr.length; x++) {
//                                                    String openHr = wsOpeningHr[x];
//                                                    String day2 = openHr.substring(0, openHr.indexOf("-"));
//                                                    String startEnd2 = openHr.substring(openHr.indexOf("-") + 1);
//                                                    if (startEnd.equals(startEnd2)) {
//                                                        day = day + "-" + day2;
//                                                    } else {
//                                                        day = day + ":" + startEnd;
//                                                        hourList.add(day);
//                                                        day = day2;
//                                                        startEnd = startEnd2;
//                                                    }
//                                                    if (x == wsOpeningHr.length - 1) {
//                                                        day = day + ":" + startEnd2;
//                                                        hourList.add(day);
//                                                    }
//                                                }
//                                                for (String x : hourList) {
//                                                    out.println(x);
//                                                }
                                            %>
                                            <!--                                            <div class="row">
                                                                                            <div class="col-md-12">
                                                                                                <div class="form-group col-sm-6">
                                                                                                    <label for="postalCode">Mon - Fri </label>
                                                                                                    <input type="text" class="form-control" value="<%//=wsOpeningHr%>" readonly>
                                                                                                </div>
                                            
                                                                                                <div class="form-group col-sm-6">
                                                                                                    <label for="postalCode">Sat & Sun </label>
                                                                                                    <input type="text" class="form-control" value="0900hrs to 1600hrs" readonly>
                                                                                                </div>
                                            
                                                                                            </div>
                                                                                        </div>-->

                                            <!--                                            <div class="row">
                                                                                            <div class="col-md-12">
                                                                                                <div class="form-group col-sm-6">
                                                                                                    <label for="postalCode">Public Holidays & Eve </label>
                                                                                                    <input type="text" class="form-control" value="0900hrs to 1400hrs" readonly>
                                                                                                </div>
                                            
                                                                                                <div class="form-group col-sm-6">
                                                                                                    <label for="postalCode">Closed On</label>
                                                                                                    <input type="text" class="form-control" value="Wednesdays" readonly>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>-->
                                        </div>
                                    </section>

                                    <section class="tile">
                                        <div class="tile-header">
                                            <h1><strong>Specialize</strong></h1>
                                        </div>

                                        <div class="tile-widget">
                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">
                                                    <!--<label for="postalCode">Specialise</label>-->
                                                    <input type="text" class="form-control" value="<%=wsSpecialize%>" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </section>

                                    <section class="tile">
                                        <div class="tile-header">
                                            <h1><strong>Category</strong></h1>
                                        </div>

                                        <div class="tile-widget">
                                            <div class="row">
                                                <div class="form-group col-sm-offset-1 col-sm-10">

                                                    <input type="text" class="form-control" value="<%=wsCategory%>" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </div>
                                <!--end row 6-->

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
        <%-- scripts --%>
        <jsp:include page="include/scripts.jsp"/>
        <script type="text/javascript" src="js/jquery.jgrowl.min.js"></script> 
        <script type="text/javascript" src="js/intercom.js"></script> 
        <script>
            $(document).ready(function ()
            {
                $("#myTable1").tablesorter();
                $("#myTable2").tablesorter();
                $("#myTable3").tablesorter();
                $("#myTable4").tablesorter();
                $("#myTable5").tablesorter();

            }
            );
        </script>
        <script>
            //Script to load tab and data based on the href #
            $(window).load(function () {
                var url = document.URL;
                if (url.includes('#')) {
                    url = url.substring(url.indexOf('#'));
                    console.log(url);
                }
                $('.nav-pills li a').each(function () {
                    var link = $(this).attr("href");
                    console.log(link);
                    if (link === url) {
                        $(this).parent().siblings().removeClass('active');
                        $(this).parent().addClass('active');
                    }
                });
                url = url.substring(1);
                console.log(url);

                $(".tab-pane").each(function () {
                    var tab = $(this).attr('id');
                    if (tab === url) {
                        $(this).siblings().removeClass('active in');
                        $(this).addClass('active in');
                    }
                });
            });


        </script>
        <script>
            $('.dropdown-menu li').on('click', function () {
                $(this).siblings().removeClass('active');
                var link = $(this).text();
                document.getElementById("select").innerHTML = link + " <span class='caret'></span>";
            });

        </script>
        <script>
            (function (document) {
                'use strict';

                var LightTableFilter = (function (Arr) {

                    var _input;

                    function _onInputEvent(e) {
                        _input = e.target;
                        var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
                        Arr.forEach.call(tables, function (table) {
                            Arr.forEach.call(table.tBodies, function (tbody) {
                                Arr.forEach.call(tbody.rows, _filter);
                            });
                        });
                    }

                    function _filter(row) {
                        var text = row.textContent.toLowerCase(), val = _input.value.toLowerCase();
                        row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';
                    }

                    return {
                        init: function () {
                            var inputs = document.getElementsByClassName('light-table-filter');
                            Arr.forEach.call(inputs, function (input) {
                                input.oninput = _onInputEvent;
                            });
                        }
                    };
                })(Array.prototype);

                document.addEventListener('readystatechange', function () {
                    if (document.readyState === 'complete') {
                        LightTableFilter.init();
                    }
                });

            })(document);
        </script>
        <script>
            //    var acc = document.getElementsByClassName("accordion");
            //    var i;
            //
            //    for (i = 0; i < acc.length; i++) {
            //        acc[i].onclick = function () {
            //            this.classList.toggle("active");
            //            this.nextElementSibling.classList.toggle("show");
            //        }
            //    }
        </script>
        <script type="text/javascript">
            function displaymsg() {
                var msg = '<%=session.getAttribute("isSuccess")%>';
                if (msg != "null") {
                    //                function alertName(msg) {
                    alert(msg);
                    //                }
                }
            <%session.setAttribute("isSuccess", "null");%>
            }
        </script> 
        <!--<script type="text/javascript"> window.onload = alertName;</script>-->
        <script type="text/JavaScript">
            function timedRefresh(timeoutPeriod) {
            setTimeout("location.reload(true);",timeoutPeriod);
            } 
            //    window.onload = timedRefresh(300000);
        </script>
        <script>
            function start() {
                timedRefresh(300000);
                displaymsg();
            }
            window.onload = start;
        </script>
        <script>
            $("#accordion > li > span").click(function () {
                $(this).toggleClass("active").next('div').slideToggle(250)
                        .closest('li').siblings().find('span').removeClass('active').next('div').slideUp(250);
            });

        </script>
        <script>
            $(document).ready(function () {
                $(".tabpager").tabpager({
                    //  maximum visible items
                    items: 5,
                    // CSS class for tabbed content
                    contents: 'contents',
                    // transition speed
                    time: 300,
                    // text for previous button
                    previous: '&laquo;Prev',
                    // text for next button
                    next: 'Next&raquo;',
                    // initial tab
                    start: 1,
                    // top or bottom
                    position: 'bottom',
                    // scrollable
                    scroll: true
                });
            });

        </script>
        <script>
            intercom("<%=user_name%>", "<%=user_email%>",<%=staffID%>, "<%=phone_number%>", "<%=workshop_name%>", "<%=wsCategory%>", "<%=wsBrands%>");
        </script>
    </body>
</html>