/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.ValetShopDAO;
import dao.WebUserDAO;
import dao.WorkshopDAO;
import entity.ValetShop;
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
 * @author User
 */
@WebServlet(name = "AddValetServlet", urlPatterns = {"/AddValet"})
public class AddValetServlet extends HttpServlet {

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
        String name = request.getParameter("name").trim();
        String address = request.getParameter("address").trim();
        String email = request.getParameter("email").trim();
        String postalCode = request.getParameter("postalCode").trim();
        String employees = request.getParameter("noEmployees").trim();
        int noEmployees = 0;
        if (!(employees.equals("")) && employees.length() > 0) {
            noEmployees = Integer.parseInt(employees);
        }
        String revenue = request.getParameter("revenueShare").trim();
        double revenueShare = 0.0;
        if (!(revenue.equals("")) && revenue.length() > 0) {
            revenueShare = Double.parseDouble(revenue);
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

//        String openingHourFormat = request.getParameter("openingHourFormat");
        double latitude = 0.0;
        double longitude = 0.0;

        String openingHourFormat = "";
        openingHourFormat = "Monday-" + mondayOpen + "-" + mondayClose + ","
                + "Tuesday-" + tuesdayOpen + "-" + tuesdayClose + ","
                + "Wednesday-" + wednesdayOpen + "-" + wednesdayClose + ","
                + "Thursday-" + thursdayOpen + "-" + thursdayClose + ","
                + "Friday-" + fridayOpen + "-" + fridayClose + ","
                + "Saturday-" + saturdayOpen + "-" + saturdayClose + ","
                + "Sunday-" + sundayOpen + "-" + sundayClose + ","
                + "Ph-" + phOpen + "-" + phClose + ","
                + "PhEve-" + phEveOpen + "-" + phEveClose;

        Validation validation = new Validation();
        ArrayList<String> errMsg = validation.validateValet(postalCode, openingHourFormat);

        String openingHour = openingHourFull;

        WebUserDAO uDAO = new WebUserDAO();
        ValetShopDAO vDAO = new ValetShopDAO();
        String[] latLong = vDAO.retrieveLatLong(address);
        if (latLong == null) {
            latLong = vDAO.retrieveLatLong("Singapore " + postalCode);
            if (latLong == null) {
                errMsg.add("Please enter a valid address.");
            }
        } else {
            latitude = Double.parseDouble(latLong[0]);
            longitude = Double.parseDouble(latLong[1]);
        }

        if (errMsg.size() == 0) {
            HttpSession session = request.getSession(true);
            WebUser user = (WebUser) session.getAttribute("loggedInUser");
            int staffId = user.getStaffId();
            String token = user.getToken();
            String err = vDAO.addShop(staffId, token, name, address + " " + postalCode, email, latitude, longitude, noEmployees, revenueShare, openingHour, openingHourFormat);
//            ArrayList<String> addErrMsg = vDAO.addValet(staffId, token, name, address + " " + postalCode, latitude, longitude, noEmployees, revenueShare, /*openingHourFormat,*/ openingHour);
//                        if (addErrMsg.size() == 0) {
            //                Workshop ws = wDAO.retrieveWorkshop(id, user.getStaffId(), user.getToken());
            //                int wsId = ws.getId();
            //                session.setAttribute("workshopId", wsId);
            if (err.length() == 0) {
                ValetShop valet = vDAO.retrieveValetShop(user.getStaffId(), user.getToken(), email);
                int valetId = valet.getId();
                session.setAttribute("valetId", valetId);
                session.setAttribute("success", name + " has been created!");
//                RequestDispatcher view = request.getRequestDispatcher("AddWorkshopMasterAccount.jsp");
//                view.forward(request, response);
                response.sendRedirect("AddValetMasterAccount.jsp");
            } else {
                request.setAttribute("errMsg", err);
                request.setAttribute("name", name);
                request.setAttribute("address", address);
                request.setAttribute("email", email);
                request.setAttribute("postalCode", postalCode);
                request.setAttribute("revenueShare", revenueShare);
                request.setAttribute("noEmployees", noEmployees);
                request.setAttribute("mondayOpen", mondayOpen);
                request.setAttribute("mondayClose", mondayClose);
                request.setAttribute("tuesdayOpen", tuesdayOpen);
                request.setAttribute("tuesdayClose", tuesdayClose);
                request.setAttribute("wednesdayOpen", wednesdayOpen);
                request.setAttribute("wednesdayClose", wednesdayClose);
                request.setAttribute("thursdayOpen", thursdayOpen);
                request.setAttribute("thursdayClose", thursdayClose);
                request.setAttribute("fridayOpen", fridayOpen);
                request.setAttribute("fridayClose", fridayClose);
                request.setAttribute("saturdayOpen", saturdayOpen);
                request.setAttribute("saturdayClose", saturdayClose);
                request.setAttribute("sundayOpen", sundayOpen);
                request.setAttribute("sundayClose", sundayClose);
                request.setAttribute("phOpen", phOpen);
                request.setAttribute("phClose", phClose);
                request.setAttribute("phEveOpen", phEveOpen);
                request.setAttribute("phEveClose", phEveClose);
                RequestDispatcher view = request.getRequestDispatcher("AddValetShop.jsp");
                view.forward(request, response);
            }
        } else {
            request.setAttribute("errMsg", errMsg);
            request.setAttribute("name", name);
            request.setAttribute("address", address);
            request.setAttribute("postalCode", postalCode);
            request.setAttribute("email", email);
            request.setAttribute("revenueShare", revenueShare);
            request.setAttribute("noEmployees", noEmployees);
            request.setAttribute("mondayOpen", mondayOpen);
            request.setAttribute("mondayClose", mondayClose);
            request.setAttribute("tuesdayOpen", tuesdayOpen);
            request.setAttribute("tuesdayClose", tuesdayClose);
            request.setAttribute("wednesdayOpen", wednesdayOpen);
            request.setAttribute("wednesdayClose", wednesdayClose);
            request.setAttribute("thursdayOpen", thursdayOpen);
            request.setAttribute("thursdayClose", thursdayClose);
            request.setAttribute("fridayOpen", fridayOpen);
            request.setAttribute("fridayClose", fridayClose);
            request.setAttribute("saturdayOpen", saturdayOpen);
            request.setAttribute("saturdayClose", saturdayClose);
            request.setAttribute("sundayOpen", sundayOpen);
            request.setAttribute("sundayClose", sundayClose);
            request.setAttribute("phOpen", phOpen);
            request.setAttribute("phClose", phClose);
            request.setAttribute("phEveOpen", phEveOpen);
            request.setAttribute("phEveClose", phEveClose);
            RequestDispatcher view = request.getRequestDispatcher("AddValetShop.jsp");
            view.forward(request, response);
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
            Logger.getLogger(AddValetServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AddValetServlet.class.getName()).log(Level.SEVERE, null, ex);
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
