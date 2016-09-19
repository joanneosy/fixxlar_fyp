<%@page import="dao.ValetShopDAO"%>
<%@page import="util.Settings"%>
<%@page import="entity.Offer"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="entity.Vehicle"%>
<%@page import="entity.Customer"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="dao.VehicleDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="entity.QuotationRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.WebUserDAO"%>
<%@page import="entity.Workshop"%>
<%@page import="dao.WorkshopDAO"%>
<%@page import="dao.QuotationRequestDAO"%>
<%@page import="entity.WebUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectWorkshop.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8" />
        <title>Schedule</title>
        <jsp:include page="include/head.jsp"/>

    </head>
    <body class="bg-3">
        <%            int shopID = user.getShopId();
            String token = user.getToken();
            int staffID = user.getStaffId();
            String chatToken = user.getChatToken();
            String phone_number = user.getHandphone();
            String user_name = user.getName();
            String user_email = user.getEmail();
        //            HashMap<Integer, Integer> statusSize = qDAO.retrieveStatusSize(user.getStaffId(), user.getToken(), 0, 0, "", "requested_datetime", "desc");
            //            int newSize = statusSize.get(0);
            //            int sendFinalSize = statusSize.get(1);
            //            int finalAcceptSize = statusSize.get(2);


        %>
        <!-- Preloader -->
        <div class="mask"><div id="loader"></div></div>
        <!--/Preloader -->

        <!-- Wrap all page content here -->
        <div id="wrap">




            <!-- Make page fluid -->
            <div class="row">
                <!-- Top and leftbar -->
                <%--<jsp:include page="include/topbar.jsp"/>--%>
                <%@include file="include/topbar.jsp"%>
                <!-- Top and leftbar end -->
                <%
                    Workshop ws = wsDAO.retrieveWorkshop(user.getShopId(), user.getStaffId(), user.getToken());
                    int wsID = ws.getId();
                    String workshop_name = ws.getName();
                    String categories = ws.getCategory();
                    String brands_carried = ws.getBrandsCarried();

                %>
                <!-- Page content -->
                <div id="content" class="col-md-12">

                    <!-- page header -->
                    <div class="pageheader">


                        <h2><i class="fa fa-calendar-o" style="line-height: 48px;padding-left: 0;"></i> Calendar</h2>

                    </div>
                    <!-- /page header -->
                    <%                        String success = (String) session.getAttribute("success");
                        String fail = (String) session.getAttribute("fail");
                        if (success != null && !(success.equals("null")) && success.length() > 0) {
                    %>
                    <div class="alert alert-success"><%=success%></div>
                    <%
                    } else if (fail != null && !(fail.equals("null")) && fail.length() > 0) {
                    %>
                    <div class="alert alert-danger"><%=fail%></div>
                    <%
                        }
                        session.setAttribute("success", "");
                        session.setAttribute("fail", "");
                    %>
                    <%
                        Settings setting = new Settings();
                        int capacity = setting.retrieveServiceCapacity(user.getStaffId(), user.getToken(), user.getShopId());

                    %>




                    <!-- content main container -->
                    <div class="main as-table">        



                        <div class="col-md-4 tile color transparent-black rounded-left-corners">
                            <div class="tile-body">
                                <form role="form" action="AddSchedule" method="POST">
                                    <div class="cal-options">

                                        <div class="date-info">
                                            <h2 class="text-center">
                                                <i class="fa fa-angle-left pull-left" id="cal-prev"></i>
                                                <span id="cal-current-date"></span>
                                                <i class="fa fa-angle-right pull-right" id="cal-next"></i>
                                            </h2>
                                            <h3 class="large-thin text-center" id="cal-current-day"></h3>
                                        </div>  
                                        <div class="line-across"></div>
                                        <div class="margin-top-15">
                                            <h4>BLOCK DATES</h4>
                                        </div>
                                        <div class="margin-top-15"></div>
                                        <div><b>Start Date & Time</b></div>
                                        <div class="form-group">
                                            <div class='input-group date' id='startdatetimepicker'>
                                                <!--<form id='' action="" role="form">-->
                                                <input type='text' name="startTime" class="form-control dt" readonly/>
                                                <!--</form>-->

                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div><b>End Date & Time</b></div>
                                        <div class="form-group">
                                            <div class='input-group date' id='enddatetimepicker'>
                                                <!--<form id='' action="" role="form">-->
                                                <input type='text' name="endTime" class="form-control dt" readonly/>
                                                <!--</form>-->

                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="checkbox">
                                            <input type="checkbox" name="fullDay" value="1" id="check">
                                            <label for="check"><span class='text-primary'>Entire Day</span></label>
                                        </div>
                                        <div>
                                            <button type="submit" class="btn btn-primary">Block</button>
                                        </div>
                                        <div class='margin-top-15'>
                                            <div>
                                                <h4>USERS PER SLOT</h4>
                                            </div>
                                            <input type='text' class='form-control' value='<%=capacity%>' readonly/>
                                            <a href='Settings.jsp'><span>Edit</span></a>

                                        </div>

                                    </div>
                                </form>

                            </div>
                        </div>



                        <div class="col-md-8 tile nopadding transparent">


                            <!-- tile widget -->
                            <div class="tile-widget nopadding color transparent-black rounded-top-right-corner">
                                <div class="cal-header">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a href="#" id="change-view-month" data-toggle="tab">Month</a></li>
                                        <li><a href="#" id="change-view-week" data-toggle="tab">Week</a></li>
                                        <li><a href="#" id="change-view-day" data-toggle="tab">Day</a></li>
                                        <!--<li><a href="#" id="change-view-today">Today</a></li>-->
                                    </ul>
                                    <!-- / Nav tabs -->
                                </div>
                            </div>
                            <!-- /tile widget -->


                            <div class="tile-body rounded-bottom-right-corner">                
                                <div id='calendar'></div>
                            </div>

                        </div>


                        <!-- modal --> 
                        <div class="modal fade" id="cal-new-event" tabindex="-1" role="dialog" aria-labelledby="new-event" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close</button>
                                        <h3 class="modal-title thin" id="new-event">Add New Event</h3>
                                    </div>
                                    <form role="form" id="add-event" parsley-validate>
                                        <div class="modal-body">

                                            <div class="form-group">
                                                <label class="control-label">Event title *</label>
                                                <input type="text" class="form-control" id="event-title" name="event-title" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-validation-minlength="1">
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label">Color</label>
                                                <div class="input-group event-color">
                                                    <input type="text" class="form-control" id="event-color" name="event-color" readonly="">
                                                    <div class="input-group-btn">
                                                        <button type="button" class="btn btn-greensea dropdown-toggle" data-toggle="dropdown"><i class="fa fa-tint"></i></button>
                                                        <ul class="dropdown-menu pull-right">
                                                            <li>
                                                                <div id="event-colorpalette" data-return-color="#event-color"></div>
                                                            </li>
                                                        </ul>
                                                    </div><!-- /btn-group -->
                                                </div><!-- /input-group -->
                                            </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-red" data-dismiss="modal" aria-hidden="true">Cancel</button>
                                            <button type="submit" class="btn btn-green">Add event</button>
                                        </div>
                                    </form>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->


                        <!-- modal event edit-->
                        <div class="modal fade" id="edit-event" tabindex="-1" role="dialog" aria-labelledby="new-event" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close</button>
                                        <h3 class="modal-title thin">View Event: <small class="text-muted"></small></h3>
                                    </div>
                                    <form role="form" parsley-validate>
                                        <div class="modal-body">

                                            <div class="form-group">
                                                <label class="control-label">Event title</label>
                                                <input type="text" class="form-control" id="edit-event-title" name="event-title" readonly="" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-validation-minlength="1">
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label">Start (YYYY-MM-DD HH:MM:SS)</label>
                                                <input type="text" class="form-control" id="edit-event-start" name="event-color" readonly="">
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">End (YYYY-MM-DD HH:MM:SS)</label>
                                                <input type="text" class="form-control" id="edit-event-end" name="event-color" readonly="">
                                            </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-red" data-dismiss="modal" aria-hidden="true" id="remove-event">Delete</button>
                                            <button class="btn btn-blue" data-dismiss="modal" aria-hidden="true">Cancel</button>
                                        </div>
                                    </form>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal event edit -->



                    </div>  
                    <!-- /content container -->






                </div>
                <!-- Page content end -->







            </div>
            <!-- Make page fluid-->




        </div>
        <!-- Wrap all page content end -->



        <section class="videocontent" id="video"></section>



        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-ui-1.10.4.custom.min.js"></script>
        <script src="js/minimal.min.js"></script>
        <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
        <script type="text/javascript" src="js/jquery.mmenu.min.js"></script>
        <script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
        <script type="text/javascript" src="js/jquery.nicescroll.min.js"></script>
        <script type="text/javascript" src="js/jquery.animateNumbers.js"></script>
        <script type="text/javascript" src="js/jquery.videobackground.js"></script>
        <script type="text/javascript" src="js/jquery.blockUI.js"></script>
        <script src="js/fullcalendar.min.js"></script>
        <script src="js/jquery.ui.touch-punch.min.js"></script>
        <script src="js/bootstrap-colorpalette.js"></script>
        <script src="js/parsley.min.js"></script>
        <script type="text/javascript" src="js/intercom.js"></script> 
        <script type="text/javascript" src="js/moment.js"></script> 
        <script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script> 

        <script>
            $(function () {

                // Initialize external events

                $('#external-events div.external-event').each(function () {

                    // Make events draggable using jQuery UI
                    $(this).draggable({
                        zIndex: 999,
                        revert: true,
                        revertDuration: 0,
                        drag: function () {
                            $('.cal-options .date-info').addClass('out')
                            $('.cal-options #event-delete').addClass('in')
                        },
                        stop: function () {
                            $('.cal-options .date-info').removeClass('out')
                            $('.cal-options #event-delete').removeClass('in')
                        }
                    });
                });
                // Initialize the calendar 

                $('#calendar').fullCalendar({
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay'
                    },
//                    editable: true,
//                    droppable: true,
//                    drop: function (date, allDay) {
//                        var copiedEventObject = {
//                            title: $(this).text(),
//                            start: date,
//                            allDay: allDay,
//                            color: $(this).css('border-left-color')
//                        };
//                        $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
////                        // is the "remove after drop" checkbox checked?
////                        if ($('#drop-remove').is(':checked')) {
////                            // if so, remove the element from the "Draggable Events" list
////                            $(this).remove();
////                        }
//                    },
                    eventClick: function (calEvent, jsEvent, view) {
                        console.log(calEvent);
                        var editModal = $('#edit-event'),
                                eventTitle = calEvent.title;
                        start = calEvent._start;
                        end = calEvent._end;
                        startT = start + "";
                        endT = start + "";
                        var start_time = start,
                                start = [start_time.getFullYear(), start_time.getMonth() + 1, start_time.getDate()].join('-') + " " +
                                startT.substring(startT.indexOf(":") - 2, startT.lastIndexOf(":") + 3);
                        var end_time = end,
                                end = [end_time.getFullYear(), end_time.getMonth() + 1, end_time.getDate()].join('-') + " " +
                                endT.substring(endT.indexOf(":") - 2, endT.lastIndexOf(":") + 3);
////                                eventColor = calEvent.color;
                        var status = calEvent.className[0];
                        console.log(start_time);
                        console.log(end_time);
                        if (status != 0) {
                            $("#remove-event").hide();
                        }
                        editModal.find('.modal-title small').text(eventTitle);
                        editModal.find('#edit-event-title').val(eventTitle);
                        editModal.find('#edit-event-start').val(start);
                        editModal.find('#edit-event-end').val(end);
//                        editModal.find('#edit-event-color').css("border-bottom", '2px solid' + ' ' + eventColor).val(eventColor);
                        editModal.modal('show')

                        // Submitting save event form

//                        $('#save-event').off('click')
//                                .on('click', function (e) {
//                                    e.preventDefault();
//                                    var form = $(this).parents('form');
//                                    if (form.parsley('isValid')) {
//
//                                        calEvent.title = $('#edit-event-title').val();
////                                        calEvent.color = $('#edit-event-color').val();
//                                        $('#edit-event').modal('hide');
//                                        $('#calendar').fullCalendar('updateEvent', calEvent);
//                                    } else {
//
//                                        $('#edit-event-title').focus();
//                                        return false;
//                                    }
//                                });
                        // Remove event
                        $('#remove-event').off('click')
                                .on('click', function (e) {
                                    e.preventDefault();
                                    $.ajax({
                                        url: 'http://119.81.43.85/erp/schedule/delete_schedule',
                                        type: 'POST',
                                        crossDomain: true,
                                        data: {
                                            "token": "<%=token%>",
                                            "staff_id": "<%=staffID%>",
                                            "schedule_id": calEvent._id
                                        },
                                        dataType: 'json',
                                        success: function (response) {
                                        }
                                    });
                                    $('#calendar').fullCalendar('removeEvents', calEvent._id);
                                    $('#edit-event').modal('hide');
                                });
                    },
//                    eventRender: function (event, element) {
////                        element.attr('href', 'javascript:void(0);');
//                        element.click(function () {
//                            $("#startTime").html(moment(event.start).format('MMM Do h:mm A'));
//                            $("#endTime").html(moment(event.end).format('MMM Do h:mm A'));
//                            $("#eventContent").dialog({modal: true, title: event.title, width: 350});
//                        });
//                    },
                    events: function (start, end, callback) {
                        var start_time = start,
                                start = [start_time.getFullYear(), start_time.getMonth() + 1, start_time.getDate()].join('-') +
                                " 00:00:00";
                        var end_time = end,
                                end = [end_time.getFullYear(), end_time.getMonth() + 1, end_time.getDate()].join('-') +
                                " 00:00:00";
                        console.log(start);
//                        console.log(start_time);
                        console.log(end);
//                        console.log(end_time);
                        $.ajax({
                            url: 'http://119.81.43.85/erp/schedule/retrieve_schedule',
                            type: 'POST',
                            crossDomain: true,
                            data: {
                                "token": "<%=token%>",
                                "staff_id": "<%=staffID%>",
                                "shop_id": "<%=shopID%>",
                                "start_time": start,
                                "end_time": end
                            },
                            dataType: 'json',
                            success: function (response) {
                                console.log(response);
                                var events = [];
                                $.each(response.events, function () {
                                    var fullday = $(this).attr('all_day');
                                    var allDay = false;
                                    if (fullday == "1") {
                                        allDay = true;
                                    }
                                    var service_id = $(this).attr('service_id');
                                    if (service_id == null) {
                                        service_id = "0";
                                    }
                                    events.push({
//                                        title: "Blocked",
                                        id: $(this).attr('id'),
                                        title: $(this).attr('title'),
                                        start: $(this).attr('start_time'), // will be parsed
                                        end: $(this).attr('end_time'), // will be parsed
                                        allDay: allDay,
                                        className: service_id

                                    });
                                });
                                callback(events);
                            }});
                    }
                });
                // Hide default header
                $('.fc-header').hide();
                // Show current date
                var currentDate = $('#calendar').fullCalendar('getDate');
                $('#cal-current-day').html($.fullCalendar.formatDate(currentDate, "dddd"));
                $('#cal-current-date').html($.fullCalendar.formatDate(currentDate, "MMM yyyy"));
                // Previous month action
                $('#cal-prev').click(function () {
                    $('#calendar').fullCalendar('prev');
                    currentDate = $('#calendar').fullCalendar('getDate');
                    $('#cal-current-day').html($.fullCalendar.formatDate(currentDate, "dddd"));
                    $('#cal-current-date').html($.fullCalendar.formatDate(currentDate, "MMM yyyy"));
                });
                // Next month action
                $('#cal-next').click(function () {
                    $('#calendar').fullCalendar('next');
                    currentDate = $('#calendar').fullCalendar('getDate');
                    $('#cal-current-day').html($.fullCalendar.formatDate(currentDate, "dddd"));
                    $('#cal-current-date').html($.fullCalendar.formatDate(currentDate, "MMM yyyy"));
                });
                // Change to month view
                $('#change-view-month').click(function () {
                    $('#calendar').fullCalendar('changeView', 'month');
                    // safari fix 
                    $('#content .main').fadeOut(0, function () {
                        setTimeout(function () {
                            $('#content .main').css({'display': 'table'});
                        }, 0);
                    });
                });
                // Change to week view
                $('#change-view-week').click(function () {
                    $('#calendar').fullCalendar('changeView', 'agendaWeek');
                    // safari fix 
                    $('#content .main').fadeOut(0, function () {
                        setTimeout(function () {
                            $('#content .main').css({'display': 'table'});
                        }, 0);
                    });
                });
                // Change to day view
                $('#change-view-day').click(function () {
                    $('#calendar').fullCalendar('changeView', 'agendaDay');
                    // safari fix 
                    $('#content .main').fadeOut(0, function () {
                        setTimeout(function () {
                            $('#content .main').css({'display': 'table'});
                        }, 0);
                    });
                });
                // Change to today view
                $('#change-view-today').click(function () {
                    $('#calendar').fullCalendar('today');
                    currentDate = $('#calendar').fullCalendar('getDate');
                    $('#cal-current-day').html($.fullCalendar.formatDate(currentDate, "dddd"));
                    $('#cal-current-date').html($.fullCalendar.formatDate(currentDate, "MMM yyyy"));
                });
                // Initialize colorpalette
                $('#event-colorpalette, #edit-event-colorpalette').colorPalette({
                    colors: [['#428bca', '#5cb85c', '#5bc0de', '#f0ad4e', '#d9534f', '#ff4a43', '#22beef', '#a2d200', '#ffc100', '#cd97eb', '#16a085', '#FF0066', '#A40778', '#1693A5', '#418bca', '#d9544f', '#3f4e62']]
                }).on('selectColor', function (e) {
                    var data = $(this).data();
                    $(data.returnColor).val(e.color);
                    $(this).parents(".input-group").find('input').css("border-bottom", '2px solid' + ' ' + e.color);
                });         // Submitting new event form
                $('#add-event').submit(function (e) {
                    e.preventDefault();
                    var form = $(this);
                    if (form.parsley('isValid')) {

                        var newEvent = $('<div class="external-event" data-color="' + $("#event-color").val() + '">' + $('#event-title').val() + '</div>');
                        newEvent.css({'border-left-color': $("#event-color").val() || "#717171"});
                        if ($('#external-events .external-event').length > 0) {
                            $('#external-events .external-event:last').after(newEvent);
                        } else {
                            $('#external-events .events').after(newEvent);
                        }
                        ;
                        $('#external-events .external-event:last').after(newEvent);
                        $('#external-events .external-event').draggable({
                            zIndex: 999,
                            revert: true,
                            revertDuration: 0,
                            drag: function () {
                                $('.cal-options .date-info').addClass('out')
                                $('.cal-options #event-delete').addClass('in')
                            },
                            stop: function () {
                                $('.cal-options .date-info').removeClass('out')
                                $('.cal-options #event-delete').removeClass('in')
                            }
                        });
                        form[0].reset();
                        $('#cal-new-event').modal('hide');
                    } else {

                        $('#event-title').focus();
                        return false;
                    }

                });
                // Event deleting function
                $('.cal-options #event-delete').droppable({
                    accept: "#external-events .external-event",
                    hoverClass: "active",
                    drop: function (event, ui) {
                        ui.draggable.remove();
                        $(this).removeClass("active in");
                        $('.cal-options .date-info').removeClass('out');
                        //remove ajax
                    }
                });
            })

        </script>
        <script>
            //check toggling
            $('#check').on('click', function () {
                $(this).toggleClass('checked');
            })
        </script>
        <!--DATETIME-->
        <script type="text/javascript">
            $(".date").each(function () {
                $(this).datetimepicker({
                    format: 'YYYY-MM-DD HH:mm',
                    minDate: new Date(),
                    sideBySide: true,
                    ignoreReadonly: true
                });
            });</script>
        <script>
            function submitdt(btnId, offerId) {

                var formId = btnId.substring(6);
                var hidden = "hidden" + offerId;
                document.getElementById(hidden).value = offerId;
                document.getElementById(formId).submit();
                console.log(formId);
                //        $(id).submit();
            }
        </script>
        <!--DATETIME-->
        <script>
            intercom("<%=user_name%>", "<%=user_email%>",<%=staffID%>, "<%=phone_number%>", "<%=workshop_name%>", "<%=categories%>", "<%=brands_carried%>");</script>
        <script>
            $(window).load(function () {
//                var monthYear = $("#cal-current-date").html();
                //                var month = monthYear.substring(0, monthYear.indexOf(" "));
//                var year = monthYear.substring(monthYear.indexOf(" ") + 1);
                //                var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                //                var index = monthNames.indexOf(month);
                //                month = index + 1;
                //                retrieveSchedule(month, year);
                //                
//                
//                $('.fc-button-prev span').click(function () {
//                    alert('prev is clicked, do something');
//                });
//
//                $('.fc-button-next span').click(function () {
//                    alert('nextis clicked, do something');
//                });
            });</script>
        <script>
            function retrieveSchedule(month, year) {

                $.ajax({
                    type: 'POST',
                    url: 'http://119.81.43.85/erp/schedule/retrieve_schedule',
                    crossDomain: true,
                    data: {
                        "token": "<%=token%>",
                        "staff_id": "<%=staffID%>",
                        "shop_id": "<%=shopID%>",
                        "month": month,
                        "year": year
                    },
                    dataType: 'json',
                    success: function (data) {
                        console.log("Y");
                        console.log(data);
                        if (data.is_success == true) {
                            var schedule = data.payload.schedule;
                            for (i = schedule.length - 1; i >= 0; i--) {
                                console.log(schedule[i].start_time);
                                console.log(schedule[i].end_time);
                                var start_dateTime = schedule[i].start_time;
                                var startDate = start_dateTime.substring(0, start_dateTime.indexOf(" "));
                                var startTime = start_dateTime.substring(start_dateTime.indexOf(" ") + 1);
                                startTime = startTime.substring(0, startTime.lastIndexOf(":"));
                                var end_dateTime = schedule[i].end_time;
                                var endDate = end_dateTime.substring(0, end_dateTime.indexOf(" "));
                                var endTime = end_dateTime.substring(end_dateTime.indexOf(" ") + 1);
                                var theDate = ".fc-day[data-date='" + startDate + "']";
                                var day = $(theDate).find(".fc-day-content").html('<span class="fc-time">' + startTime + '</span><span class="fc-title">Car Service</span>');
                            }
                        }
                    },
                    error: function () {
                        console.log("N");
                        console.log(data);
                    }
                });
            }
        </script>
    </body>
</html>
