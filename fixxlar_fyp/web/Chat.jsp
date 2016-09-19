<%-- 
    Document   : Chat
    Created on : Aug 4, 2016, 3:57:28 PM
    Author     : User
--%>

<%@page import="dao.ValetShopDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.Chat"%>
<%@page import="dao.ChatDAO"%>
<%@page import="dao.WorkshopDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="ProtectWorkshop.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Hello Workshop</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8" />

        <link rel="icon" type="image/ico" href="assets/images/favicon.ico" />
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/animate.css">
        <link type="text/css" rel="stylesheet" media="all" href="css/jquery.mmenu.all.css" />
        <link rel="stylesheet" href="css/jquery.videobackground.css">
        <link rel="stylesheet" href="css/bootstrap-checkbox.css">
        <link rel="stylesheet" href="css/bootstrap-dropdown-multilevel.css">
        <!--<link rel="stylesheet" href="css/chat.css" />-->

        <link href="css/minimal.css" rel="stylesheet">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="bg-1">
        <%            ChatDAO chatDAO = new ChatDAO();
            String token = user.getToken();
            int staffID = user.getStaffId();
        %>

        <!-- Preloader -->
        <div class="mask"><div id="loader"></div></div>
        <!--/Preloader -->

        <!-- Wrap all page content here -->
        <div id="wrap">




            <!-- Make page fluid -->
            <div class="row">

                <!-- Top and side nav bar -->
                <%--<jsp:include page="include/topbar.jsp"/>--%>
                <%@include file="include/topbar.jsp"%>
                <!-- Top and side nav bar -->










                <!-- Page content -->
                <div id="content" class="col-md-12 chat">









                    <!-- page header -->
                    <div class="pageheader">


                        <h2><i class="fa fa-comments" style="line-height: 48px;padding-left: 0;"></i> Chat <span></span></h2>


<!--                        <div class="breadcrumbs">
                            <ol class="breadcrumb">
                                <li>You are here</li>
                                <li><a href="index.html">Minimal</a></li>
                                <li><a href="#">Example Pages</a></li>
                                <li class="active">Chat</li>
                            </ol>
                        </div>-->


                    </div>
                    <!-- /page header -->






                    <!-- content main container -->
                    <div class="main">        



                        <!-- row -->
                        <div class="row">


                            <div class="col-lg-4 col-md-5 col-sm-6">


                                <!-- tile -->
                                <section class="tile transparent">


                                    <!-- tile header -->
                                    <div class="tile-header color bg-transparent-black-5 rounded-top-corners">
                                        <ul class="chat-nav main-nav inline">
                                            <li><h3><strong>Inbox</strong></h3></li>
<!--                                            <li class="pull-right">
                                                <button type="button" class="btn btn-transparent-white btn-sm dropdown-toggle" data-toggle="dropdown">
                                                    More <i class="fa fa-caret-down"></i>
                                                </button>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li><a href="#">Action</a></li>
                                                    <li><a href="#">Another action</a></li>
                                                    <li><a href="#">Something else here</a></li>
                                                    <li class="divider"></li>
                                                    <li><a href="#">Separated link</a></li>
                                                </ul>
                                            </li>-->
                                        </ul>
                                    </div>
                                    <!-- /tile header -->


                                    <!-- tile body -->
                                    <div class="tile-body color transparent-black rounded-bottom-corners nopadding">

                                        <ul class="chat-inbox" id="chat-inbox">
                                            <!--<li><input type="text" class="form-control" placeholder="Search..."></li>-->
                                            <%                                                HashMap<Integer, Chat> chatMap = chatDAO.getChatList(user.getStaffId(), user.getToken());
                                                Iterator it = chatMap.entrySet().iterator();
                                                int z = 1;
                                                while (it.hasNext()) {
                                                    Map.Entry pair = (Map.Entry) it.next();
                                                    Chat chat = (Chat) pair.getValue();
                                                    int id = chat.getId();
                                                    int service_id = chat.getService_id();
                                                    int user_id = chat.getUser_id();
                                                    int shop_id = chat.getShop_id();
                                                    String last_message = chat.getLast_message();
                                                    Timestamp timeStamp = chat.getModified();
                                                    String modified = "01-01-1990 00:00:00";
                                                    if (timeStamp != null) {
                                                        modified = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(timeStamp);
                                                    }
                                                    timeStamp = chat.getDeleted_at();
                                                    String deleted_at = "01-01-1990 00:00:00";
                                                    if (timeStamp != null) {
                                                        deleted_at = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(timeStamp);
                                                    }
                                                    timeStamp = chat.getCreated();
                                                    String created = "01-01-1990 00:00:00";
                                                    if (timeStamp != null) {
                                                        created = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(timeStamp);
                                                    }
                                                    String user_name = chat.getUser_name();
                                                    String[] msg = last_message.split(":");
                                                    if (msg[0].equals("0")) {
                                                        last_message = "You: " + msg[1];
                                                    } else {
                                                        last_message = user_name + ": " + msg[1];
                                                    }
                                            %>

                                            <li>
                                                <a href="#" class="<%if(z == 1){%>active<%}%> chatNav" id="<%=user_id%>-<%=user_name%>">
                                                    <div class="media">
                                                        <div class="pull-left">
                                                            <img class="media-object img-circle" src="assets/images/ici-avatar.jpg">
                                                        </div>
                                                        <div class="media-body">
                                                            <p class="media-heading"><%=user_name%> <span class="time"><%=modified%></span></p>
                                                            <span class="message"><%=last_message%></span>
                                                            <div class="chat-actions">
<!--                                                                <span class="mark-unread" title="Mark as unread"><i class="fa fa-circle-o"></i></span> 
                                                                <span class="archive" title="Archive"><i class="fa fa-times"></i></span>-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                            <%
                                            z++;
                                                }
                                            %>
                                        </ul>
                                    </div>
                                    <!-- /tile body -->


                                </section>
                                <!-- /tile -->


                            </div>


                            <div class="col-lg-8 col-md-7 col-sm-6">


                                <!-- tile -->
                                <section class="tile transparent">


                                    <!-- tile header -->
                                    <div class="tile-header color bg-transparent-black-5 rounded-corners">
                                        <ul class="chat-nav side-nav inline" id="chatHead">
                                            <li><h3><strong></strong></h3></li>
<!--                                            <li class="pull-right">
                                                <div class="btn-group btn-group-sm">
                                                    <button type="button" class="btn btn-transparent-white"><i class="fa fa-plus"></i> New Message</button>
                                                    <button type="button" class="btn btn-transparent-white dropdown-toggle" data-toggle="dropdown">
                                                        <i class="fa fa-cog"></i> Actions <i class="fa fa-caret-down"></i>
                                                    </button>
                                                    <ul class="dropdown-menu" role="menu">
                                                        <li><a href="#">Action</a></li>
                                                        <li><a href="#">Another action</a></li>
                                                        <li><a href="#">Something else here</a></li>
                                                        <li class="divider"></li>
                                                        <li><a href="#">Separated link</a></li>
                                                    </ul>
                                                    <input type="text" class="form-control input-sm" placeholder="Search..." id="chat-search">
                                                    <button type="button" class="btn btn-transparent-white" id="initialize-search"><i class="fa fa-search"></i></button>
                                                </div>
                                            </li>-->
                                        </ul>
                                    </div>
                                    <!-- /tile header -->


                                    <!-- tile body -->
                                    <div class="tile-body transparent nopadding">

                                        <div class="chat-content" id="chat-content">

                                            <ul class="chat-list" id="log"></ul><!-- Chat Message Enters Here-->


                                        </div>

                                    </div>
                                    <!-- /tile body -->




                                    <!-- tile footer -->
                                    <div class="tile-footer transparent nopadding">

                                        <div class="chat-reply" id="chat-reply">
                                            <!--<textarea placeholder="Post a reply..." class="form-control"></textarea>-->
                                            <textarea placeholder="Write a message..." class="form-control" id="msgInput" onfocus="clearElement('#msgInput')"></textarea>
                                            <div class="btn-group btn-group-sm">
                                                <!--<button type="button" class="btn btn-transparent-white"><i class="fa fa-paperclip"></i> Add Files</button>-->
                                                <!--<button type="button" class="btn btn-transparent-white last-in-group"><i class="fa fa-camera"></i> Add Photos</button>-->
                                                <button type="button" class="btn btn-transparent-white last pull-right" onclick="sendMsg()">Send message</button>
                                                <!--                                                <div class="checkbox check-transparent pull-right">
                                                                                                    <input type="checkbox" value="1" id="send-by-enter">
                                                                                                    <label for="send-by-enter">Press Enter to send</label>
                                                                                                </div>-->
                                            </div>
                                        </div>

                                    </div>
                                    <!-- /tile footer -->


                                </section>
                                <!-- /tile -->



                            </div>


                        </div>
                        <!-- /row -->




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
        <script src="js/bootstrap-dropdown-multilevel.js"></script>
        <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js?lang=css&amp;skin=sons-of-obsidian"></script>
        <script type="text/javascript" src="js/jquery.mmenu.min.js"></script>
        <script type="text/javascript" src="js/jquery.sparkline.min.js"></script>
        <script type="text/javascript" src="js/jquery.nicescroll.min.js"></script>
        <script type="text/javascript" src="js/jquery.animateNumbers.js"></script>
        <script type="text/javascript" src="js/jquery.videobackground.js"></script>
        <script type="text/javascript" src="js/jquery.blockUI.js"></script>
        <script data-require="realtime-framework@2.1.0" data-semver="2.1.0" src="//messaging-public.realtime.co/js/2.1.0/ortc.js"></script>
        <script src="js/chat.js"></script>

        <script src="js/minimal.min.js"></script>

        <script>
                                                    $(function () {

                                                        var contentHeight = $('#content').height();
                                                        var chatInboxHeight = contentHeight - 178;
                                                        var chatContentHeight = contentHeight - 178 - 200;

                                                        var setChatHeight = function () {
                                                            $('#chat-inbox').css('height', chatInboxHeight);
                                                            $('#chat-content').css('height', chatContentHeight);
                                                        };

                                                        setChatHeight();

                                                        $(window).resize(function () {
                                                            contentHeight = $('#content').height();
                                                            chatInboxHeight = contentHeight - 178;
                                                            chatContentHeight = contentHeight - 178 - 200;

                                                            setChatHeight();
                                                        });

                                                        $("#chat-inbox").niceScroll({
                                                            cursorcolor: '#000000',
                                                            zindex: 999999,
                                                            bouncescroll: true,
                                                            cursoropacitymax: 0.4,
                                                            cursorborder: '',
                                                            cursorborderradius: 0,
                                                            cursorwidth: '5px'
                                                        });

                                                        $("#chat-content").niceScroll({
                                                            cursorcolor: '#000000',
                                                            zindex: 999999,
                                                            bouncescroll: true,
                                                            cursoropacitymax: 0.4,
                                                            cursorborder: '',
                                                            cursorborderradius: 0,
                                                            cursorwidth: '5px'
                                                        });

                                                        $('#chat-inbox .chat-actions > span').tooltip({
                                                            placement: 'top',
                                                            trigger: 'hover',
                                                            html: true,
                                                            container: 'body'
                                                        });

                                                        $('#initialize-search').click(function () {
                                                            $('#chat-search').toggleClass('active').focus();
                                                        });

                                                        $(document).click(function (e) {
                                                            if (($(e.target).closest("#initialize-search").attr("id") != "initialize-search") && $(e.target).closest("#chat-search").attr("id") != "chat-search") {
                                                                $('#chat-search').removeClass('active');
                                                            }
                                                        });

                                                        $(window).mouseover(function () {
                                                            $("#chat-inbox").getNiceScroll().resize();
                                                            $("#chat-content").getNiceScroll().resize();
                                                        });

                                                    })

        </script>
        <script>
            $(function () {
                $("#msgInput").keypress(function (e) {
                    if (e.which == 13) {
                        sendMsg();
                        e.preventDefault();
                    }
                });
            });

        </script>
        <!--        <script>
                    $("#sendMsg").click(function () {
                        $.ajax({
                            type: 'POST',
                            url: 'http://119.81.43.85/chat/send_chat_message',
                            crossDomain: true,
                            data: {
                                "channel_name": "Chat:Workshop:1:354",
                                "topic_id": "2",
                                "staff_id": "31",
                                "token": "786f7aefa6d9299dfd84f61f1cd42dd5d84fa8c549da87bc63f2d95372c664a2c9bf6e09c16da6393cc84d8578431f9a9ab3d33424810e28d06feeec62b30924a60bffd021ae86069a052c150c99547876c225814d471bdb3857eb1c708b7105cb72c6a02699a85cd284cb9f89098b8c263017c9f3272287668a2098c1de80a268a430c24318fb92867b3ce0edff88579f29cd6997558b11ecebe423818eb1d5b8e037a5515d6f0ac4ffc8cbbdd34023ec2440fd6c036511899c9325be80df56941fe1b5685fe4ee7214a2a6ce1a06fae528ddffd10bc8b2a8d725c25207070fc8c033d2695ccbba1b2e6261e0fbe938a3ab8193f410a5d306144716fe991f0ddaa6032653a3d453e7365e791bd908247c664bf3114b3bbad3d30b834c27f4dcc9705bb89fbbdf060b2afc585e969f10b89a99ab1c8a6e37e16c15d5c9ad72341d2c09c68c008623e99bd6f796ef428524714cc12235080cb2cca33d10b8432491a9766babb55eb533a3c14d8c2974f1364fd51f86f61934c91af95c89edbedc0bb605fa8cc03cc52179984daee998939e964d9e92506369e2f792f91c50dc4a9e83b3629e3d9da509790f5e408fa3f282f9dae1b14b35fb846dace1e3d41b015fb81792b6ca0f5d338fbcfe3e27d97d7f0ede817a74f53ce6d7e532690ca8ac203f592b2bd4acec86212128447484436af9deea8e7fa6262159531693a16a7d",
                                "message": "0:354:Hello from web"
                            },
                            dataType: 'json',
                            success: function () {
                                alert("SUCCESS!");
                            },
                            error: function () {
                                alert("ERROR!");
                            }
                        });
                    });
                </script>-->
        <script>
            $('.chatNav').click(function (event) {
//                event.preventDefault();
                $("#log").html("");
                $(this).parent().siblings().children().removeClass("active").remove;
                $(this).addClass("active").removeClass("unread");
                var uid = this.id;
                var user_id = uid.substring(0, uid.indexOf("-"));
                var userName = uid.substring(uid.indexOf("-") + 1);
                $("#chatHead li h3").html(userName)
                $.ajax({
                    type: 'POST',
                    url: 'http://119.81.43.85/chat/retrive_chat_history',
                    crossDomain: true,
                    data: {
                        "type_of_message": "1",
                        "no_of_message_display": "20",
                        "driver_id": user_id,
                        "token": "<%=token%>",
                        "staff_id": "<%=staffID%>"
                    },
                    dataType: 'json',
                    success: function (data) {
//                        $.each(data.items, function(i,item)){
//                            console.log(i + ": " + item);
//                        }
//                        console.log(data);
                        var msg = data.payload.chat_message;
                        for(i = msg.length-1; i >= 0; i--){
//                            console.log(msg[i].message);
                            if(msg[i].type == "0"){
                                $("#log").html('<li class="message sent"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="assets/images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">You</a> <span class="time">' + msg[i].modified + '</span></p>' + msg[i].message + '</div></div></li>' + $("#log").html());
                            } else{
                                $("#log").html('<li class="message receive"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="assets/images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">'+userName+'</a> <span class="time">' + msg[i].modified + '</span></p>' + msg[i].message + '</div></div></li>' + $("#log").html());
                            }
                        }
                    },
                    error: function () {
                        alert("fail");
                    }
                });
            });
//            if (sender != "Web") {
//                $("#log").html('<li class="message sent"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="assets/images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">John Douey</a> <span class="time">' + time + '</span></p>' + message + '</div></div></li>' + $("#log").html());
//            } else {
//                $("#log").html('<li class="message receive"><div class="media"><div class="pull-left user-avatar"><img class="media-object img-circle" src="assets/images/profile-photo.jpg"></div><div class="media-body"><p class="media-heading"><a href="#">John Douey</a> <span class="time">' + time + '</span></p>' + message + '</div></div></li>' + $("#log").html());
//
//            }
        </script>
    </body>
</html>
