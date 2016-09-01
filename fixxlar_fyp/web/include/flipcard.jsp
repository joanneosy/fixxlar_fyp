<%--<%@page import="java.util.HashMap"%>--%>
<%
    HashMap<Integer, Integer> statusSize = qDAO.retrieveStatusSize(user.getStaffId(), user.getToken(), 0, 0, "", "requested_datetime", "desc");
    int newSize = statusSize.get(0);
    int sendFinalSize = statusSize.get(1);
    int finalAcceptSize = statusSize.get(2);
    int newServiceSize = statusSize.get(2) - statusSize.get(3);
    int ongoingServiceSize = statusSize.get(4);
    int rejectedSize = statusSize.get(4);
    String a="";
%>
<div class="row">
    <div class="col-lg-6 col-sm-18 col-sm-36"><h4>REQUEST</h4></div>
<!--    <div class="col-lg-2 col-sm-6 col-sm-12">3</div>
    <div class="col-lg-2 col-sm-6 col-sm-12">4</div>-->
    <div class="col-lg-4 col-sm-12 col-sm-24"><h4>SERVICE</h4></div>
    <!--<div class="col-lg-2 col-sm-6 col-sm-12"><h4>RATING</h4></div>-->
    <div class="col-lg-2 col-sm-6 col-sm-12"><h4>REJECTED</h4></div>
    
</div>
<div class="row cards">

    <div class="card-container col-lg-2 col-sm-6 col-sm-12">
        <div class="card card-redbrown hover" onclick="location.href='New_Request.jsp'">
            <div class="front card-custom"> 

                <div class="media">        
                    <span class="pull-left">
                        <i class="fa fa-list media-object"></i>
                    </span>

                    <div class="media-body">
                        New Requests
                        <h2 class="media-heading animate-number" data-value="<%=newSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div> 

            </div>
            <div class="back card-custom">
                <a href="New_Request.jsp">
                    <!--                                        <span class="pull-left">
                                                            </span>-->
                    <!--<i class="fa fa-info-circle"></i>-->
                    <span>More Information</span>
                </a>  
            </div>
        </div>
    </div>


    <div class="card-container col-lg-2 col-sm-6 col-sm-12">
        <div class="card card-redbrown hover" onclick="location.href='Send_Final_Quote.jsp'">
            <div class="front card-custom">        

                <div class="media">                  
                    <span class="pull-left">
                        <i class="fa fa-list media-object"></i>
                    </span>

                    <div class="media-body">
                        Send Final Quote
                        <h2 class="media-heading animate-number" data-value="<%=sendFinalSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div> 

            </div>
            <div class="back card-custom">
                <a href="Send_Final_Quote.jsp">
                    <!--<i class="fa fa-bar-chart-o fa-4x"></i>-->
                    <span>More Information</span>
                </a>
            </div>
        </div>
    </div>

    <div class="card-container col-lg-2 col-sm-6 col-sm-12" onclick="location.href='Final_Quote_Accepted.jsp'">
        <div class="card card-redbrown hover">
            <div class="front card-custom">        

                <div class="media">
                    <span class="pull-left">
                        <i class="fa fa-list media-object"></i>
                    </span>

                    <div class="media-body">
                        Final Quote Accepted
                        <h2 class="media-heading animate-number" data-value="<%=finalAcceptSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div>



            </div>
            <div class="back card-custom">
                <a href="Final_Quote_Accepted.jsp">
                    <!--<i class="fa fa-bar-chart-o fa-4x"></i>-->
                    <span>More Information</span>
                </a>
            </div>
        </div>
    </div>

    <div class="card-container col-lg-2 col-sm-6 col-sm-12" onclick="location.href='New_Service.jsp'">
        <div class="card card-greensea hover">
            <div class="front card-custom">        

                <div class="media">
                    <span class="pull-left">
                        <i class="fa fa-gear media-object"></i>
                    </span>

                    <div class="media-body">
                        New Service
                        <h2 class="media-heading animate-number" data-value="<%=newServiceSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div>



            </div>
            <div class="back card-custom">
                <a href="New_Service.jsp">
                    <!--<i class="fa fa-bar-chart-o fa-4x"></i>-->
                    <span>More Information</span>
                </a>
            </div>
        </div>
    </div>

    <div class="card-container col-lg-2 col-sm-6 col-sm-12" onclick="location.href='Ongoing_Service.jsp'">
        <div class="card card-greensea hover">
            <div class="front card-custom">        

                <div class="media">
                    <span class="pull-left">
                        <i class="fa fa-gear media-object"></i>
                    </span>

                    <div class="media-body">
                        Ongoing Service
                        <h2 class="media-heading animate-number" data-value="<%=ongoingServiceSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div>



            </div>
            <div class="back card-custom">
                <a href="Ongoing_Service.jsp">
                    <!--<i class="fa fa-bar-chart-o fa-4x"></i>-->
                    <span>More Information</span>
                </a>
            </div>
        </div>
    </div>
                    
    <div class="card-container col-lg-2 col-sm-6 col-sm-12" onclick="location.href='Rejected_Request.jsp'">
        <div class="card card-slategray hover">
            <div class="front card-custom">        

                <div class="media">
                    <span class="pull-left">
                        <i class="fa fa-trash-o media-object"></i>
                    </span>

                    <div class="media-body">
                        Rejected Requests
                        <h2 class="media-heading animate-number" data-value="<%=rejectedSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div>



            </div>
            <div class="back card-custom">
                <a href="Rejected_Request.jsp">
                    <!--<i class="fa fa-bar-chart-o fa-4x"></i>-->
                    <span>More Information</span>
                </a>
            </div>
        </div>
    </div>
                    
<!--    <div class="card-container col-lg-2 col-sm-6 col-sm-12" onclick="location.href='Rejected_Request.jsp'">
        <div class="card card-redbrown hover">
            <div class="front">        

                <div class="media">
                    <span class="pull-left">
                        <i class="fa fa-trash-o media-object"></i>
                    </span>

                    <div class="media-body">
                        Rejected Request
                        <h2 class="media-heading animate-number" data-value="<%//=rejectedSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div>



            </div>
            <div class="back">
                <a href="Rejected_Request.jsp">
                    <i class="fa fa-bar-chart-o fa-4x"></i>
                    <span>More Information</span>
                </a>
            </div>
        </div>
    </div>-->

<!--    <div class="card-container col-lg-2 col-sm-6 col-xs-12">
        <div class="card1 card-slategray hover">
            <div class="front"> 

                <div class="media">                   
                    <span class="pull-left">
                        <i class="fa fa-users media-object"></i>
                    </span>

                    <div class="media-body">
                        Average Rating
                        <h2 class="media-heading animate-number" data-value="4.2" data-animation-duration="1500">0</h2>
                    </div>
                </div> 
            </div>
        </div>
    </div>-->
</div>
