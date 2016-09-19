/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.ValetShopDAO;
import dao.WorkshopDAO;
import entity.WebUser;
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
@WebServlet(name = "EditValetServlet", urlPatterns = {"/EditValetServlet"})
public class EditValetServlet extends HttpServlet {

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
        String employees = request.getParameter("noEmployees").trim();
        int noEmployees = 0;
        if (!(employees.equals(""))&& employees.length() > 0 ) {
            noEmployees = Integer.parseInt(employees);
        }
        String revenue = request.getParameter("revenueShare").trim();
        double revenueShare = 0.0;
        if (!(revenue.equals(""))&& revenue.length() > 0 ) {
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
        System.out.println(openingHourFull);
        
        

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
        
        String openingHour = openingHourFull;

//        String openingHourFormat = request.getParameter("openingHourFormat");
        
        double latitude = 0.0;
        double longitude = 0.0;

        Validation validation = new Validation();
        ArrayList<String> errMsg = validation.validateValet(postalCode, openingHourFormat);


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

        HttpSession session = request.getSession(true);
        String userType = (String) session.getAttribute("loggedInUserType");
        if (errMsg.size() == 0) {

            WebUser user = (WebUser) session.getAttribute("loggedInUser");

            int staffId = user.getStaffId();
            String token = user.getToken();
            ArrayList<String> addErrMsg = vDAO.updateValetShop(staffId, token, id, name, address + " " + postalCode, latitude, longitude, noEmployees, revenueShare, openingHour);
//            ArrayList<String> addErrMsg = vDAO.updateValet(id, name,address + " " + postalCode, openingHour,
//                    latitude, longitude, noEmployees, revenueShare, staffId, token);
            if (addErrMsg.size() == 0) {
                session.setAttribute("success", name + " successfully edited!");
                String url = "ViewValet.jsp";
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
                    RequestDispatcher view = request.getRequestDispatcher("EditValet.jsp?id=" + id);
                    view.forward(request, response);
                } else if (userType.equals("Workshop")) {
                    RequestDispatcher view = request.getRequestDispatcher("ViewValet.jsp");
                    view.forward(request, response);
                }

            }
        } else {
            request.setAttribute("fail", errMsg);
            if (userType.equals("Admin")) {
                RequestDispatcher view = request.getRequestDispatcher("EditValet.jsp?id=" + id);
                view.forward(request, response);
            } else if (userType.equals("Workshop")) {
                RequestDispatcher view = request.getRequestDispatcher("ViewValet.jsp");
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
            Logger.getLogger(EditValetServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(EditValetServlet.class.getName()).log(Level.SEVERE, null, ex);
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
