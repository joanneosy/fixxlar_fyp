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
    <body class="bg-1">

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

                <!-- Page content -->
                <div id="content" class="col-md-12">

                    <!-- page header -->
                    <div class="pageheader">


                        <h2><i class="fa fa-calendar-o" style="line-height: 48px;padding-left: 0;"></i> Calendar</h2>

                    </div>
                    <!-- /page header -->






                    <!-- content main container -->
                    <div class="main as-table">        



                        <div class="col-md-4 tile color transparent-black rounded-left-corners">
                            <div class="tile-body">

                                <div class="cal-options">

                                    <div class="date-info">
                                        <h2 class="text-center">
                                            <i class="fa fa-angle-left pull-left" id="cal-prev"></i>
                                            <span id="cal-current-date"></span>
                                            <i class="fa fa-angle-right pull-right" id="cal-next"></i>
                                        </h2>
                                        <h3 class="large-thin text-center" id="cal-current-day"></h3>
                                    </div>

                                    <div id="event-delete"><i class="fa fa-trash-o fa-4x"></i></div>                  

                                    <div id="external-events" class="events-wrapper">

                                        <h4 class="thin events">
                                            <strong>Draggable</strong> Events
                                            <a class="new-event pull-right" data-toggle="modal" href="#cal-new-event"><i class="fa fa-plus"></i></a>
                                        </h4>
                                        <div class="external-event" data-color="red">The Custom Event #1</div>
                                        <div class="external-event" data-color="cyan">The Custom Event #2</div>
                                        <div class="external-event" data-color="orange">The Custom Event #3</div>
                                        <div class="external-event" data-color="amethyst">The Custom Event #4</div>
                                        <div class="external-event" data-color="drank">The Custom Event #5</div>
                                        <div class="external-event">The Custom Event #6</div>

                                        <div class="checkbox check-transparent">
                                            <input type="checkbox" value="1" id="drop-remove">
                                            <label for="drop-remove">Remove after drop</label>
                                        </div>

                                    </div>

                                </div>

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
                                        <li><a href="#" id="change-view-today">Today</a></li>
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
                                        <h3 class="modal-title thin">Edit Event: <small class="text-muted"></small></h3>
                                    </div>
                                    <form role="form" parsley-validate>
                                        <div class="modal-body">

                                            <div class="form-group">
                                                <label class="control-label">Event title *</label>
                                                <input type="text" class="form-control" id="edit-event-title" name="event-title" parsley-trigger="change" parsley-required="true" parsley-minlength="4" parsley-validation-minlength="1">
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label">Color</label>
                                                <div class="input-group event-color">
                                                    <input type="text" class="form-control" id="edit-event-color" name="event-color" readonly="">
                                                    <div class="input-group-btn">
                                                        <button type="button" class="btn btn-greensea dropdown-toggle" data-toggle="dropdown"><i class="fa fa-tint"></i></button>
                                                        <ul class="dropdown-menu pull-right">
                                                            <li>
                                                                <div id="edit-event-colorpalette" data-return-color="#edit-event-color"></div>
                                                            </li>
                                                        </ul>
                                                    </div><!-- /btn-group -->
                                                </div><!-- /input-group -->
                                            </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-green" id="save-event">Save</button>
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




                <div id="mmenu" class="right-panel">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs nav-justified">
                        <li class="active"><a href="#mmenu-users" data-toggle="tab"><i class="fa fa-users"></i></a></li>
                        <li class=""><a href="#mmenu-history" data-toggle="tab"><i class="fa fa-clock-o"></i></a></li>
                        <li class=""><a href="#mmenu-friends" data-toggle="tab"><i class="fa fa-heart"></i></a></li>
                        <li class=""><a href="#mmenu-settings" data-toggle="tab"><i class="fa fa-gear"></i></a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="mmenu-users">
                            <h5><strong>Online</strong> Users</h5>

                            <ul class="users-list">

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/ici-avatar.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Ing. Imrich <strong>Kamarel</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Ulaanbaatar, Mongolia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="online">
                                    <div class="media">

                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/arnold-avatar.jpg" alt>
                                        </a>
                                        <span class="badge badge-red unread">3</span>

                                        <div class="media-body">
                                            <h6 class="media-heading">Arnold <strong>Karlsberg</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Bratislava, Slovakia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>

                                    </div>
                                </li>

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/peter-avatar.jpg" alt>

                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Peter <strong>Kay</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Kosice, Slovakia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/george-avatar.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">George <strong>McCain</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Prague, Czech Republic</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="busy">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar1.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Lucius <strong>Cashmere</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Wien, Austria</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="busy">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar2.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Jesse <strong>Phoenix</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Berlin, Germany</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                            </ul>

                            <h5><strong>Offline</strong> Users</h5>

                            <ul class="users-list">

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar4.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Dell <strong>MacApple</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Paris, France</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">

                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar5.jpg" alt>
                                        </a>

                                        <div class="media-body">
                                            <h6 class="media-heading">Roger <strong>Flopple</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Rome, Italia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>

                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar6.jpg" alt>

                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Nico <strong>Vulture</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Kyjev, Ukraine</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar7.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Bobby <strong>Socks</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Moscow, Russia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar8.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Anna <strong>Opichia</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Budapest, Hungary</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                            </ul>

                        </div>

                        <div class="tab-pane" id="mmenu-history">
                            <h5><strong>Chat</strong> History</h5>

                            <ul class="history-list">

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/ici-avatar.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Ing. Imrich <strong>Kamarel</strong></h6>
                                            <small>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="busy">
                                    <div class="media">

                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/arnold-avatar.jpg" alt>
                                        </a>
                                        <span class="badge badge-red unread">3</span>

                                        <div class="media-body">
                                            <h6 class="media-heading">Arnold <strong>Karlsberg</strong></h6>
                                            <small>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>

                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/peter-avatar.jpg" alt>

                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Peter <strong>Kay</strong></h6>
                                            <small>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit </small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                            </ul>

                        </div>

                        <div class="tab-pane" id="mmenu-friends">
                            <h5><strong>Friends</strong> List</h5>
                            <ul class="favourite-list">

                                <li class="online">
                                    <div class="media">

                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/arnold-avatar.jpg" alt>
                                        </a>
                                        <span class="badge badge-red unread">3</span>

                                        <div class="media-body">
                                            <h6 class="media-heading">Arnold <strong>Karlsberg</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Bratislava, Slovakia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>

                                    </div>
                                </li>

                                <li class="offline">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar8.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Anna <strong>Opichia</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Budapest, Hungary</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="busy">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/random-avatar1.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Lucius <strong>Cashmere</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Wien, Austria</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                                <li class="online">
                                    <div class="media">
                                        <a class="pull-left profile-photo" href="#">
                                            <img class="media-object" src="assets/images/ici-avatar.jpg" alt>
                                        </a>
                                        <div class="media-body">
                                            <h6 class="media-heading">Ing. Imrich <strong>Kamarel</strong></h6>
                                            <small><i class="fa fa-map-marker"></i> Ulaanbaatar, Mongolia</small>
                                            <span class="badge badge-outline status"></span>
                                        </div>
                                    </div>
                                </li>

                            </ul>
                        </div>

                        <div class="tab-pane pane-settings" id="mmenu-settings">
                            <h5><strong>Chat</strong> Settings</h5>

                            <ul class="settings">

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Show Offline Users</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-offline" checked="">
                                                <label class="onoffswitch-label" for="show-offline">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Show Fullname</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-fullname">
                                                <label class="onoffswitch-label" for="show-fullname">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">History Enable</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-history" checked="">
                                                <label class="onoffswitch-label" for="show-history">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Show Locations</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-location" checked="">
                                                <label class="onoffswitch-label" for="show-location">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Notifications</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-notifications">
                                                <label class="onoffswitch-label" for="show-notifications">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <div class="form-group">
                                        <label class="col-xs-8 control-label">Show Undread Count</label>
                                        <div class="col-xs-4 control-label">
                                            <div class="onoffswitch greensea">
                                                <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="show-unread" checked="">
                                                <label class="onoffswitch-label" for="show-unread">
                                                    <span class="onoffswitch-inner"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                            </ul>

                        </div><!-- tab-pane -->

                    </div><!-- tab-content -->
                </div>






            </div>
            <!-- Make page fluid-->




        </div>
        <!-- Wrap all page content end -->



        <section class="videocontent" id="video"></section>



        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://code.jquery.com/jquery.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
        <script type="text/javascript" src="js/jquery.mmenu.min.js"></script>
        <script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
        <script type="text/javascript" src="js/jquery.nicescroll.min.js"></script>
        <script type="text/javascript" src="js/jquery.animateNumbers.js"></script>
        <script type="text/javascript" src="js/jquery.videobackground.js"></script>
        <script type="text/javascript" src="js/jquery.blockUI.js"></script>
        <script src="js/jquery-ui-1.10.4.custom.min.js"></script>
        <script src="js/fullcalendar.min.js"></script>
        <script src="js/jquery.ui.touch-punch.min.js"></script>
        <script src="js/bootstrap-colorpalette.js"></script>
        <script src="js/parsley.min.js"></script>
        <script src="js/minimal.min.js"></script>

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
                    editable: true,
                    droppable: true,
                    drop: function (date, allDay) {
                        var copiedEventObject = {
                            title: $(this).text(),
                            start: date,
                            allDay: allDay,
                            color: $(this).css('border-left-color')
                        };
                        $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
                        // is the "remove after drop" checkbox checked?
                        if ($('#drop-remove').is(':checked')) {
                            // if so, remove the element from the "Draggable Events" list
                            $(this).remove();
                        }
                    },
                    eventClick: function (calEvent, jsEvent, view) {

                        var editModal = $('#edit-event'),
                                eventTitle = calEvent.title,
                                eventColor = calEvent.color;

                        editModal.find('.modal-title small').text(eventTitle);
                        editModal.find('#edit-event-title').val(eventTitle);
                        editModal.find('#edit-event-color').css("border-bottom", '2px solid' + ' ' + eventColor).val(eventColor);
                        editModal.modal('show')

                        // Submitting save event form

                        $('#save-event').off('click')
                                .on('click', function (e) {
                                    e.preventDefault();

                                    var form = $(this).parents('form');

                                    if (form.parsley('isValid')) {

                                        calEvent.title = $('#edit-event-title').val();
                                        calEvent.color = $('#edit-event-color').val();
                                        $('#edit-event').modal('hide');
                                        $('#calendar').fullCalendar('updateEvent', calEvent);


                                    } else {

                                        $('#edit-event-title').focus();
                                        return false;

                                    }
                                });

                        // Remove event
                        $('#remove-event').off('click')
                                .on('click', function (e) {
                                    e.preventDefault();

                                    $('#calendar').fullCalendar('removeEvents', calEvent._id);
                                    $('#edit-event').modal('hide');
                                });
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
                });


                // Submitting new event form
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
                        $('.cal-options .date-info').removeClass('out')
                    }
                });

            })

        </script>
    </body>
</html>
