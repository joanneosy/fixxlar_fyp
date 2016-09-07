<%--<%@page import="java.util.HashMap"%>--%>
<%
    HashMap<Integer, Integer> statusSize = qDAO.retrieveStatusSize(user.getStaffId(), user.getToken(), 0, 0, "", "requested_datetime", "desc");
//    int newSize = statusSize.get(0);
//    int sendFinalSize = statusSize.get(1);
    int finalAcceptSize = statusSize.get(2);
    int newServiceSize = statusSize.get(2);
    int ongoingServiceSize = statusSize.get(3);
    
    HashMap<Integer, QuotationRequest> qzise = qDAO.retrieveQuotationRequestsWithoutOffer(user.getStaffId(), user.getToken());
    int newSize = qzise.size();
    HashMap<Integer, QuotationRequest> zsize = qDAO.retrieveCompletedQuotationRequests(user.getStaffId(), user.getToken());
    int sendFinalSize = zsize.size();
    
%>
<div class="row">
    <div class="col-lg-6 col-sm-18 col-sm-36"><h4>REQUEST</h4></div>
<!--    <div class="col-lg-2 col-sm-6 col-sm-12">3</div>
    <div class="col-lg-2 col-sm-6 col-sm-12">4</div>-->
    <div class="col-lg-4 col-sm-12 col-sm-24"><h4>Valet</h4></div>
    <!--<div class="col-lg-2 col-sm-6 col-sm-12"><h4>RATING</h4></div>-->
    
</div>
<div class="row cards">

    <div class="card-container col-lg-3 col-sm-6 col-sm-12">
        <div class="card card-redbrown hover" onclick="location.href='Admin_Dashboard.jsp'">
            <div class="front"> 

                <div class="media">        
                    <span class="pull-left">
                        <i class="fa fa-list media-object"></i>
                    </span>

                    <div class="media-body">
                        View New Quotations
                        <h2 class="media-heading animate-number" data-value="<%=newSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div> 

            </div>
            <div class="back">
                <a href="Admin_Dashboard.jsp">
                    <!--                                        <span class="pull-left">
                                                            </span>-->
                    <!--<i class="fa fa-info-circle"></i>-->
                    <span>More Information</span>
                </a>  
            </div>
        </div>
    </div>
 
    
    <div class="card-container col-lg-3 col-sm-6 col-sm-12">
        <div class="card card-redbrown hover" onclick="location.href='Admin_Final_Quote_Accepted.jsp'">
            <div class="front">        

                <div class="media">                  
                    <span class="pull-left">
                        <i class="fa fa-list media-object"></i>
                    </span>

                    <div class="media-body">
                        View Completed Quotations
                        <h2 class="media-heading animate-number" data-value="<%=sendFinalSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div> 

            </div>
            <div class="back">
                <a href="Admin_Final_Quote_Accepted.jsp">
                    <!--<i class="fa fa-bar-chart-o fa-4x"></i>-->
                    <span>More Information</span>
                </a>
            </div>
        </div>
    </div>

    <div class="card-container col-lg-3 col-sm-6 col-sm-12" onclick="location.href='Admin_New_Valet.jsp'">
        <div class="card card-greensea hover">
            <div class="front">        

                <div class="media">
                    <span class="pull-left">
                        <i class="fa fa-map-marker media-object"></i>
                    </span>

                    <div class="media-body">
                        New Valet Services
                        <h2 class="media-heading animate-number" data-value="<%=newServiceSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div>



            </div>
            <div class="back">
                <a href="Admin_New_Valet.jsp">
                    <!--<i class="fa fa-bar-chart-o fa-4x"></i>-->
                    <span>More Information</span>
                </a>
            </div>
        </div>
    </div>

    
    <div class="card-container col-lg-3 col-sm-6 col-sm-12" onclick="location.href='Admin_Completed_Valet.jsp'">
        <div class="card card-greensea hover">
            <div class="front">        

                <div class="media">
                    <span class="pull-left">
                        <i class="fa fa-map-marker media-object"></i>
                    </span>

                    <div class="media-body">
                        Completed Valet Services
                        <h2 class="media-heading animate-number" data-value="<%=ongoingServiceSize%>" data-animation-duration="1500">0</h2>
                    </div>
                </div>



            </div>
            <div class="back">
                <a href="Admin_Completed_Valet.jsp">
                    <!--<i class="fa fa-bar-chart-o fa-4x"></i>-->
                    <span>More Information</span>
                </a>
            </div>
        </div>
    </div>
    
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
