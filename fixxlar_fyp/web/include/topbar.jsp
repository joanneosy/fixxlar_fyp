<%
    String wsName = "";
    WorkshopDAO wsDAO = new WorkshopDAO();
    if (userType.equals("Workshop")) {
        Workshop ws = wsDAO.retrieveWorkshop(user.getShopId(), user.getStaffId(), user.getToken());
        wsName = ws.getName();
    } else {
        wsName = "Fixir";
    }
%>
<div class="navbar navbar-default navbar-fixed-top navbar-transparent-black mm-fixed-top" role="navigation" id="navbar">



    <!-- Branding -->
    <div class="navbar-header col-md-2">
        <% if (userType.equals("Admin")) { %>
        <a class="navbar-brand" href="Admin_Dashboard.jsp">
            <!--<img src="images/Logo.ico"/>-->
        </a>
        <% } else { %>
        <a class="navbar-brand" href="New_Request.jsp">
            <!--<img src="images/Logo.ico"/>-->
        </a>
        <% }%>
        <div class="sidebar-collapse">
            <a href="#">
                <i class="fa fa-bars"></i>
            </a>
        </div>
    </div>
    <!-- Branding end -->


    <!-- .nav-collapse -->
    <div class="navbar-collapse">

        <!-- Page refresh -->
        <ul class="nav navbar-nav refresh">
            <li class="divided">
                <a href="#" class="page-refresh"><i class="fa fa-refresh"></i></a>
            </li>
        </ul>
        <!-- /Page refresh -->

        <!-- Quick Actions -->
        <ul class="nav navbar-nav quick-actions">

            <li class="dropdown divided user" id="current-user">
                <div class="profile-photo">
                    <!--<img src="./images/joshua.jpg" alt />-->
                </div>
                <a class="dropdown-toggle options" data-toggle="dropdown" href="#">
                    <%=wsName%><i class="fa fa-caret-down"></i>
                </a>

                <ul class="dropdown-menu arrow settings dropdown-menu-right" style="z-index: 9999;">

                    <%if (userType.equals("Workshop")) {
                    %>
                    <li>
                        <a href="Profile.jsp"><i class="fa fa-user"></i> Profile</a>
                    </li>
                    <%
                        }
                    %>
                    <li>
                        <a href="ChangePassword.jsp"><i class="fa fa-user"></i> Change Password</a>
                    </li>

                    <li class="divider"></li>

                    <li>
                        <a href="Logout.jsp"><i class="fa fa-power-off"></i> Logout</a>
                    </li>
                </ul>
            </li>

        </ul>
        <!-- /Quick Actions -->


        <%//if admin, include admin_leftbar
            if (userType.equals("Workshop")) { %>
                <%@include file="workshop_leftbar.jsp"%>
        <% } else { %>
                <%@include file="admin_leftbar.jsp"%>
        <% }%>
        <!--End Leftbar-->


    </div>
    <!--/.nav-collapse -->
</div>
