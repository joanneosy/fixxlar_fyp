/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.QuotationRequestDAO;
import dao.WorkshopDAO;
import entity.Customer;
import entity.Offer;
import entity.QuotationRequest;
import entity.WebUser;
import entity.Workshop;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.SmsNotification;

/**
 *
 * @author Joanne
 */
@WebServlet(name = "AddEstimatedCompletionTimeServlet", urlPatterns = {"/AddEstimatedCompletionTime"})
public class AddEstimatedCompletionTimeServlet extends HttpServlet {

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
            throws ServletException, IOException, ParseException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
                
        HttpSession session = request.getSession(true);

        String estTimeStr = request.getParameter("dateTime");
        estTimeStr = estTimeStr + ":00";
        int offerId = Integer.parseInt(request.getParameter("id"));
//        Timestamp estTime = null;
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:00");
//        Date parsedDate = dateFormat.parse(estTimeStr);
//        String dt = new java.sql.Timestamp(parsedDate.getTime()) + "";
        WebUser user = (WebUser) session.getAttribute("loggedInUser");
        int staffId = user.getStaffId();
        String token = user.getToken();
        int workshopId = user.getShopId();
        QuotationRequestDAO qrDAO = new QuotationRequestDAO();
        
        
        //to retrieve request details + customer details + workshop details for sms
        Offer offer = qrDAO.retrieveOffer(staffId, token, offerId);
        int servId = offer.getServiceId();
        
        HashMap<Integer,QuotationRequest> qrMap = qrDAO.retrieveQuotationRequest(staffId, token, servId);
        Customer cust = qrMap.get(0).getCustomer();
        String handphone = cust.getHandphone();
        String custName = cust.getName();
        
        WorkshopDAO wsDAO = new WorkshopDAO();
        Workshop ws = wsDAO.retrieveWorkshop(workshopId, staffId, token);
        String workshopName = ws.getName();
        
        String isSuccess = qrDAO.addEstimatedCompletionTime(staffId, token, offerId, estTimeStr);
        //Error message? success message?
        if (isSuccess.length() == 0) {
            session.setAttribute("isSuccess", "Estimated completion time is: " + estTimeStr);
//            RequestDispatcher view = request.getRequestDispatcher("ManageService.jsp");
//            view.forward(request, response);
            SmsNotification smsNotification = new SmsNotification();
            smsNotification.smsForEstTimeCompletion(custName, handphone, workshopName, estTimeStr);
            response.sendRedirect("New_Service.jsp");
        } else {
            session.setAttribute("fail", isSuccess + "(ID: " + offerId + ")");
//            RequestDispatcher view = request.getRequestDispatcher("ManageService.jsp");
//            view.forward(request, response);
            response.sendRedirect("New_Service.jsp");
        }
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
        } catch (ParseException ex) {
            Logger.getLogger(AddEstimatedCompletionTimeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddEstimatedCompletionTimeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ParseException ex) {
            Logger.getLogger(AddEstimatedCompletionTimeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddEstimatedCompletionTimeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
