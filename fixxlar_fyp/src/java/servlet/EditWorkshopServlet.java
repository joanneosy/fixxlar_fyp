/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.WebUserDAO;
import dao.WorkshopDAO;
import entity.WebUser;
import entity.Workshop;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.Validation;

/**
 *
 * @author Joanne
 */
@WebServlet(name = "EditWorkshopServlet", urlPatterns = {"/EditWorkshop"})
public class EditWorkshopServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name").trim();
        String address = request.getParameter("address").trim();
        String postalCode = request.getParameter("postalCode").trim();
        String email = request.getParameter("email").trim();
        String[] specializeArr = request.getParameterValues("specialize");
        String description = request.getParameter("description").trim();

        String website = request.getParameter("website").trim();
        if (website.length() != 0) {
            if (!website.contains("http://") && !website.contains("https://")) {
                website = "http://" + website;
            }
        }

        String mondayOpen = request.getParameter("mondayOpen");
        String mondayClose = request.getParameter("mondayClose");
        String tuesdayOpen = request.getParameter("tuesdayOpen");
        String tuesdayClose = request.getParameter("tuesdayClose");
        String wednesdayOpen = request.getParameter("wednesdayOpen");
        String wednesdayClose = request.getParameter("wednesdayClose");
        String thursdayOpen = request.getParameter("thursdayOpen");
        String thursdayClose = request.getParameter("thursdayClose");
        String fridayOpen = request.getParameter("fridayOpen");
        String fridayClose = request.getParameter("fridayClose");
        String saturdayOpen = request.getParameter("saturdayOpen");
        String saturdayClose = request.getParameter("saturdayClose");
        String sundayOpen = request.getParameter("sundayOpen");
        String sundayClose = request.getParameter("sundayClose");
        String phOpen = request.getParameter("phOpen");
        String phClose = request.getParameter("phClose");
        String phEveOpen = request.getParameter("phEveOpen");
        String phEveClose = request.getParameter("phEveClose");

        String amondayOpen = convertTime(mondayOpen);
        String amondayClose = convertTime(mondayClose);
        String atuesdayOpen = convertTime(tuesdayOpen);
        String atuesdayClose = convertTime(tuesdayClose);
        String awednesdayOpen = convertTime(wednesdayOpen);
        String awednesdayClose = convertTime(wednesdayClose);
        String athursdayOpen = convertTime(thursdayOpen);
        String athursdayClose = convertTime(thursdayClose);
        String afridayOpen = convertTime(fridayOpen);
        String afridayClose = convertTime(fridayClose);
        String asaturdayOpen = convertTime(saturdayOpen);
        String asaturdayClose = convertTime(saturdayClose);
        String asundayOpen = convertTime(sundayOpen);
        String asundayClose = convertTime(sundayClose);
        String aphOpen = convertTime(phOpen);
        String aphClose = convertTime(phClose);
        String aphEveOpen = convertTime(phEveOpen);
        String aphEveClose = convertTime(phEveClose);

        ArrayList<String> days = new ArrayList<String>();
        days.add("Mon");
        days.add("Tues");
        days.add("Wed");
        days.add("Thurs");
        days.add("Fri");
        days.add("Sat");
        days.add("Sun");
        days.add("PHs");
        days.add("PH eve");
        ArrayList<String> open = new ArrayList<String>();
        open.add(amondayOpen);
        open.add(atuesdayOpen);
        open.add(awednesdayOpen);
        open.add(athursdayOpen);
        open.add(afridayOpen);
        open.add(asaturdayOpen);
        open.add(asundayOpen);
        open.add(aphOpen);
        open.add(aphEveOpen);
        ArrayList<String> close = new ArrayList<String>();
        close.add(amondayClose);
        close.add(atuesdayClose);
        close.add(awednesdayClose);
        close.add(athursdayClose);
        close.add(afridayClose);
        close.add(asaturdayClose);
        close.add(asundayClose);
        close.add(aphClose);
        close.add(aphEveClose);

        String startDay = "Mon";
        String endDay = "";
        String startOpen = open.get(0);
        String endOpen = "";
        String startClose = close.get(0);
        String endClose = "";
        String openingHourFull = "";
        String toAppend = "";

        for (int i = 1; i < days.size(); i++) {
            endOpen = open.get(i);
            endClose = close.get(i);
            if (i == days.size() - 1) {
                System.out.println("IN");
                endDay = days.get(i);
                if (startOpen.equals(endOpen) && startClose.equals(endClose)) {
                    toAppend = startOpen + " - " + startClose + " (" + startDay + " - " + endDay + ") ";
                } else {
                    toAppend = startOpen + " - " + startClose + " (" + startDay + ") ";
                    toAppend = toAppend + endOpen + " - " + endClose + " (" + endDay + ") ";
                }
                openingHourFull = openingHourFull + toAppend;
            } else if (startOpen.equals(endOpen) && startClose.equals(endClose)) {
                //Same start and end time
                endDay = days.get(i);
            } else {
                //New Record
                toAppend = startOpen + " - " + startClose + " (" + startDay + " - " + endDay + ") ";
                openingHourFull = openingHourFull + toAppend;
                startDay = days.get(i);
                startOpen = endOpen;
                startClose = endClose;
                endDay = "";
                endOpen = "";
                endClose = "";
            }
        }
        openingHourFull = openingHourFull.replace("Closed - Closed", "Closed");
        openingHourFull = openingHourFull.replace(" - )", ")");

        String openingHourFormat = "";
        openingHourFormat = "Mon-" + amondayOpen + "-" + amondayClose + ","
                + "Tues-" + atuesdayOpen + "-" + atuesdayClose + ","
                + "Wed-" + awednesdayOpen + "-" + awednesdayClose + ","
                + "Thurs-" + athursdayOpen + "-" + athursdayClose + ","
                + "Fri-" + afridayOpen + "-" + afridayClose + ","
                + "Sat-" + asaturdayOpen + "-" + asaturdayClose + ","
                + "Sun-" + asundayOpen + "-" + asundayClose + ","
                + "Ph-" + aphOpen + "-" + aphClose + ","
                + "PhEve-" + aphEveOpen + "-" + aphEveClose;

        ArrayList<String> compiled = new ArrayList<String>();
        //Monday-0900-1800
        String[] daysAndTime = openingHourFormat.split(",");
        //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
        String[] openCloseTimings = daysAndTime[0].split("-");
        String dayToCompare = openCloseTimings[0];
        String openToCompare = openCloseTimings[1];
        String closeToCompare = openCloseTimings[2];
        String toAdd = dayToCompare + "-" + dayToCompare + "-" + openToCompare + "-" + closeToCompare;
        String closeDays = "";

        for (int i = 1; i < daysAndTime.length - 2; i++) {
            openCloseTimings = daysAndTime[i].split("-");
            if (openCloseTimings[1].equals(openToCompare) && openCloseTimings[2].equals(closeToCompare)) {
                String[] toAddArr = toAdd.split("-");
                toAdd = toAddArr[0] + "-" + openCloseTimings[0] + "-" + openToCompare + "-" + closeToCompare;
            } else {
                String[] toAddArr = toAdd.split("-");
                //Closed-Closed
                if (toAddArr[2].equals("Closed")) {
                    closeDays += "," + toAddArr[0];
                } else //Saturday-Saturday
                {
                    if (toAddArr[0].equals(toAddArr[1])) {
                        toAdd = toAddArr[0] + ":" + toAddArr[2] + "-" + toAddArr[3];
                    } else {
                        toAdd = toAddArr[0] + "-" + toAddArr[1] + ":" + toAddArr[2] + "-" + toAddArr[3];
                    }

                    System.out.println(toAdd);
                    compiled.add(toAdd);
                }
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
                    closeDays += "," + toAddArr[0];
                } else //Saturday-Saturday
                {
                    if (toAddArr[0].equals(toAddArr[1])) {
                        toAdd = toAddArr[0] + ":" + toAddArr[2] + "-" + toAddArr[3];
                    } else {
                        toAdd = toAddArr[0] + "-" + toAddArr[1] + ":" + toAddArr[2] + "-" + toAddArr[3];
                    }
                }
                //compiled.add(toAdd);
            }
        }

        for (int i = 7; i < 9; i++) {
            toAdd = "";
            openCloseTimings = daysAndTime[i].split("-");
            //Closed-Closed
            if (openCloseTimings[2].equals("Closed")) {
                closeDays += "," + openCloseTimings[0];
            } else {
                toAdd = openCloseTimings[0] + ":" + openCloseTimings[1] + "-" + openCloseTimings[2];
                compiled.add(toAdd);
            }
        }
        if (closeDays.length() != 0) {
            compiled.add(";" + closeDays.substring(1));
        }

        String openingHour2 = "";
        for (int i = 0; i < compiled.size(); i++) {
            String add = compiled.get(i);
            String addCheck = "";
            if (i == compiled.size() - 1) {
                addCheck = compiled.get(i);
            } else {
                addCheck = compiled.get(i + 1);
            }
            if (String.valueOf(addCheck.charAt(0)).equals(";")) {
                openingHour2 += add;
            } else {
                openingHour2 += add + ",";
            }
        }

        String lastChar = String.valueOf(openingHour2.charAt(openingHour2.length() - 1));
        if (lastChar.equals(",")) {
            openingHour2 = openingHour2.substring(0, openingHour2.length() - 1);
        }

        openingHourFormat = openingHour2;

        String openingHourFormat2 = "";
        openingHourFormat2 = "Monday-" + mondayOpen + "-" + mondayClose + ","
                + "Tuesday-" + tuesdayOpen + "-" + tuesdayClose + ","
                + "Wednesday-" + wednesdayOpen + "-" + wednesdayClose + ","
                + "Thursday-" + thursdayOpen + "-" + thursdayClose + ","
                + "Friday-" + fridayOpen + "-" + fridayClose + ","
                + "Saturday-" + saturdayOpen + "-" + saturdayClose + ","
                + "Sunday-" + sundayOpen + "-" + sundayClose + ","
                + "Ph-" + phOpen + "-" + phClose + ","
                + "PhEve-" + phEveOpen + "-" + phEveClose;

        String openingHour = openingHourFull;

//        String openingHourFormat = request.getParameter("openingHourFormat");
        double latitude = 0.0;
        double longitude = 0.0;
        String contact = request.getParameter("contact").trim();
        String contact2 = request.getParameter("contact2").trim();
        String location = request.getParameter("location");
        String brandsCarried = request.getParameter("brandsCarried").trim();
        String[] categoryArr = request.getParameterValues("category");
        String remark = request.getParameter("remark").trim();

        Validation validation = new Validation();
        ArrayList<String> errMsg = validation.validateWorkshop(contact, contact2, postalCode, openingHourFormat2);

        String specialize = "";
        if (specializeArr == null) {
            errMsg.add("Please select at least one specilized car brand.");
        } else {
            specialize = specializeArr[0];
            for (int i = 1; i < specializeArr.length; i++) {
                specialize += "," + specializeArr[i];
            }
        }

        String category = "";
        if (categoryArr == null) {
            errMsg.add("Please select at least one category.");
        } else {
            category = categoryArr[0];
            for (int i = 1; i < categoryArr.length; i++) {
                category += "," + categoryArr[i];
            }
        }

        WorkshopDAO wDAO = new WorkshopDAO();
        String[] latLong = wDAO.retrieveLatLong(address);
        if (latLong == null) {
            latLong = wDAO.retrieveLatLong("Singapore " + postalCode);
            if (latLong == null) {
                errMsg.add("Please enter a valid address.");
            }
        } else {
            latitude = Double.parseDouble(latLong[0]);
            longitude = Double.parseDouble(latLong[1]);
        }

        HttpSession session = request.getSession(true);
        String userType = (String) session.getAttribute("loggedInUserType");
        if (errMsg.size() == 0) {

            WebUser user = (WebUser) session.getAttribute("loggedInUser");

            int staffId = user.getStaffId();
            String token = user.getToken();
            ArrayList<String> addErrMsg = wDAO.updateWorkshop(id, email, name, description, website, address + " " + postalCode, openingHour, openingHourFormat, openingHourFormat2,
                    latitude, longitude, contact, contact2, location, specialize, category, brandsCarried, remark, 1, staffId, token);
            if (addErrMsg.size() == 0) {
                session.setAttribute("success", name + " successfully edited!");
                String url = "ViewWorkshop.jsp";
//                RequestDispatcher view = request.getRequestDispatcher("ViewWorkshop.jsp");
                if (userType.equals("Workshop")) {
//                    view = request.getRequestDispatcher("Profile.jsp");
                    url = "Profile.jsp";
                }
//                view.forward(request, response);
                response.sendRedirect(url);
            } else {
                request.setAttribute("fail", addErrMsg);
                if (userType.equals("Admin")) {
                    RequestDispatcher view = request.getRequestDispatcher("EditWorkshop.jsp?id=" + id);
                    view.forward(request, response);
                } else if (userType.equals("Workshop")) {
                    RequestDispatcher view = request.getRequestDispatcher("EditProfile.jsp");
                    view.forward(request, response);
                }

            }
        } else {
            request.setAttribute("fail", errMsg);
            if (userType.equals("Admin")) {
                RequestDispatcher view = request.getRequestDispatcher("EditWorkshop.jsp?id=" + id);
                view.forward(request, response);
            } else if (userType.equals("Workshop")) {
                RequestDispatcher view = request.getRequestDispatcher("EditProfile.jsp");
                view.forward(request, response);
            }
        }
    }

    public String convertTime(String time) {
        if (time.equals("Closed")) {
            return time;
        }
        int iTime = Integer.parseInt(time);
        String newTime = "";
        if (iTime > 1200) {
            //afternoon
            newTime = iTime - 1200 + "";
            int index = newTime.lastIndexOf("00");
            if (index > 0) {
                newTime = newTime.substring(0, index) + "pm";
            } else {
                newTime = newTime.substring(0, newTime.length() - 2) + "." + newTime.substring(newTime.length() - 2) + "pm";
            }
        } else {
            //morning
            newTime = iTime + "";
            if (time.substring(0, 2).equals("00")) {
                newTime = "12" + time.substring(2);
            }
            int index = newTime.lastIndexOf("00");
            if (index > 0) {
                newTime = newTime.substring(0, index) + "am";
            } else {
                newTime = newTime.substring(0, newTime.length() - 2) + "." + newTime.substring(newTime.length() - 2) + "am";
            }

        }
        return newTime;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EditWorkshopServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EditWorkshopServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
