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
                        <h2><i class="fa fa-file-o" style="line-height: 48px;padding-left: 2px;"></i> Add Workshop</h2>
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
                                            <h1><strong>Add</strong> Workshop</h1>
                                        </div>
                                        <!-- /tile header -->
                                        <div class="tile-body">
                                            <%                                                String email = (String) request.getAttribute("email");
                                                if (email == null || email.equals("null")) {
                                                    email = "";
                                                }
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

                                                String website = (String) request.getAttribute("website");
                                                if (website == null || website.equals("null")) {
                                                    website = "";
                                                }

                                                String description = (String) request.getAttribute("description");
                                                if (description == null || description.equals("null")) {
                                                    description = "";
                                                }
//                                                String openingHour = request.getAttribute("");
//                                                String[] daysAndTime = null;
//
//                                                if (openingHour.equals("null")) {
//                                                    openingHour = "";
//                                                } else {
//                                                    //Each string in this format: Monday-0900-1800
//                                                    daysAndTime = openingHour.split(",");
//                                                }
//                                                String openingHourFormat = request.getAttribute("");
//                                                if (openingHourFormat.equals("null")) {
//                                                    openingHourFormat = "";
//                                                }
                                                String contact = (String) request.getAttribute("contact");
                                                if (contact == null || contact.equals("null")) {
                                                    contact = "";
                                                }
                                                String contact2 = (String) request.getAttribute("contact2");
                                                if (contact2 == null || contact2.equals("null")) {
                                                    contact2 = "";
                                                }
                                                String location = (String) request.getAttribute("location");
                                                if (location == null || location.equals("null")) {
                                                    location = "";
                                                }
                                                String brandsCarried = (String) request.getAttribute("brandsCarried");
                                                if (brandsCarried == null || brandsCarried.equals("null")) {
                                                    brandsCarried = "";
                                                }
                                                String category = (String) request.getAttribute("category");
                                                if (category == null || category.equals("null")) {
                                                    category = "";
                                                }
                                                String remark = (String) request.getAttribute("remark");
                                                if (remark == null || remark.equals("null")) {
                                                    remark = "";
                                                }

                                                String[] specializeArr = (String[]) request.getAttribute("specializeArr");
                                                if (specializeArr == null || specializeArr.length == 0) {
                                                    specializeArr = new String[0];
                                                }
                                                String[] categoryArr = (String[]) request.getAttribute("categoryArr");
                                                if (categoryArr == null || categoryArr.length == 0) {
                                                    categoryArr = new String[0];
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

                                                String wsStaffName = (String) request.getAttribute("wsStaffName");
                                                if (wsStaffName == null || wsStaffName.equals("null")) {
                                                    wsStaffName = "";
                                                }
                                                String wsStaffHpNo = (String) request.getAttribute("wsStaffHpNo");
                                                if (wsStaffHpNo == null || wsStaffHpNo.equals("null")) {
                                                    wsStaffHpNo = "";
                                                }
                                                String wsStaffEmail = (String) request.getAttribute("wsStaffEmail");
                                                if (wsStaffEmail == null || wsStaffEmail.equals("null")) {
                                                    wsStaffEmail = "";
                                                }
                                                String password = (String) request.getAttribute("password");
                                                if (password == null || password.equals("null")) {
                                                    password = "";
                                                }
                                                String confirmPassword = (String) request.getAttribute("confirmPassword");
                                                if (confirmPassword == null || confirmPassword.equals("null")) {
                                                    confirmPassword = "";
                                                }
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
                                            <form class="form-horizontal" role="form" action="AddWorkshop" method="POST">

                                                <div class="form-group">
                                                    <label for="input01" class="col-sm-2 control-label">Workshop Name</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" name="name" value="<%=name%>" required/>
                                                    </div>

                                                    <label for="input02" class="col-sm-2 control-label">Contact Number</label>
                                                    <div class="col-sm-4">
                                                        <input type="number" class="form-control" id="input02" name="contact" value="<%=contact%>" required/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Alt. Contact</label>
                                                    <div class="col-sm-4">
                                                        <input type="number" class="form-control" id="input03" name="contact2" value="<%=contact2%>" required/>
                                                    </div>

                                                    <label for="input04" class="col-sm-2 control-label">Address</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="input04" name="address" value="<%=address%>" required/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input05" class="col-sm-2 control-label">Postal Code</label>
                                                    <div class="col-sm-4">
                                                        <input type="number" class="form-control" id="input05" name="postalCode" value="<%=postalCode%>" required/>
                                                    </div>

                                                    <label for="input06" class="col-sm-2 control-label">Website</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="input06" name="website" value="<%=website%>">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Brands Carried</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=brandsCarried%>" name="brandsCarried" value="<%=brandsCarried%>" required/>
                                                    </div>

                                                    <label for="input03" class="col-sm-2 control-label">Remarks</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" value="<%=remark%>" name="remark" value="<%=remark%>">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Location</label>
                                                    <div class="col-sm-4">
                                                        <select class="chosen-select chosen-transparent form-control" id="input07" name="location" required/>
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
                                                        <input type="text" class="form-control" value="<%=email%>" name="email" value="<%=email%>" required/>
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
                                                    <div class="col-sm-3">

                                                        <select multiple class="chosen-select chosen-transparent form-control" id="" name="specialize">
                                                            <%
                                                                Workshop ws = wsDAO.retrieveWorkshop(user.getShopId(), user.getStaffId(), user.getToken());
                                                                ArrayList<String> carBrands = wsDAO.retrieveAllCarBrands(user.getStaffId(), user.getToken());
                                                                for (String s : carBrands) {
                                                                    if (Arrays.asList(specializeArr).contains(s)) {
                                                                        out.println("<option selected>" + s + "</option>");
                                                                    } else {
                                                                        out.println("<option>" + s + "</option>");
                                                                    }
                                                                }

                                                            %>
                                                        </select>

                                                    </div>
                                                    <div class="col-sm-3">
                                                        <select multiple class="chosen-select chosen-transparent form-control" id="" name="category" required/>
                                                            <%                                                                //categoryArr = category.split(",");
                                                                if (Arrays.asList(categoryArr).contains("Maintenance")) {
                                                                    out.println("<option selected>Maintenance</option>");
                                                                } else {
                                                                    out.println("<option>Maintenance</option>");
                                                                }

                                                                if (Arrays.asList(categoryArr).contains("Car Grooming")) {
                                                                    out.println("<option selected>Car Grooming</option>");
                                                                } else {
                                                                    out.println("<option>Car Grooming</option>");
                                                                }

                                                                if (Arrays.asList(categoryArr).contains("Tyre/Wheel Service")) {
                                                                    out.println("<option selected>Tyre/Wheel Service</option>");
                                                                } else {
                                                                    out.println("<option>Tyre/Wheel Service</option>");
                                                                }

                                                                if (Arrays.asList(categoryArr).contains("Air Conditioning")) {
                                                                    out.println("<option selected>Air Conditioning</option>");
                                                                } else {
                                                                    out.println("<option>Air Conditioning</option>");
                                                                }

                                                                if (Arrays.asList(categoryArr).contains("Battery")) {
                                                                    out.println("<option selected>Battery</option>");
                                                                } else {
                                                                    out.println("<option>Battery</option>");
                                                                }

                                                                if (Arrays.asList(categoryArr).contains("Others")) {
                                                                    out.println("<option selected>Others/option>");
                                                                } else {
                                                                    out.println("<option>Others</option>");
                                                                }
                                                            %>
                                                            <!--<option>Maintenence1</option>
                                                            <option>Car Grooming1</option>
                                                            <option>Tyre/Wheel Service1</option>
                                                            <option>Air Conditioning1</option>
                                                            <option>Battery1</option>
                                                            <option>Others1</option>-->
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
                                                <div class="form-group">
                                                    <h3><label class="col-sm-6">Add Workshop Master Account</label></h3>
                                                </div>
                                                <div class="form-group">
                                                    <label for="input01" class="col-sm-2 control-label">Name</label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="input01" name="staffName" value="<%=wsStaffName%>" required/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input02" class="col-sm-2 control-label">Email</label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="input02" name="staffEmail" value="<%=wsStaffEmail%>" required/>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="input03" class="col-sm-2 control-label">Password</label>
                                                    <div class="col-sm-8">
                                                        <input type="password" class="form-control" id="input03" name="password" value="<%=password%>" required/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input04" class="col-sm-2 control-label">Confirm Password</label>
                                                    <div class="col-sm-8">
                                                        <input type="password" class="form-control" id="input04" name="confirmPassword" value="<%=confirmPassword%>" required/>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="input05" class="col-sm-2 control-label">Handphone Number</label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="input05" name="staffHpNo" value="<%=wsStaffHpNo%>" required/>
                                                    </div>
                                                </div>

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


            $(function () {

                //chosen select input
                $(".chosen-select").chosen({disable_search_threshold: 10});

            })


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
