/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.CustomerDAO;
import dao.QuotationRequestDAO;
import dao.ValetRequestDAO;
import dao.WorkshopDAO;
import entity.Customer;
import entity.QuotationRequest;
import entity.ValetRequest;
import entity.WebUser;
import entity.Workshop;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
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
@WebServlet(name = "AddInitialQuotationServlet", urlPatterns = {"/AddInitialQuotation"})
public class AddInitialQuotationServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);

        int quotationRequestId = Integer.parseInt(request.getParameter("id"));
        double minPrice = Double.parseDouble(request.getParameter("minPrice"));
        double maxPrice = Double.parseDouble(request.getParameter("maxPrice"));
        String description = "";
        WebUser user = (WebUser) session.getAttribute("loggedInUser");
        int staffId = user.getStaffId();
        String token = user.getToken();
        int workshopId = user.getShopId();
        QuotationRequestDAO qrDAO = new QuotationRequestDAO();
        
        //to retrieve request details + customer details + workshop details for sms
        HashMap<Integer, QuotationRequest> qrMap = qrDAO.retrieveQuotationRequest(staffId, token, quotationRequestId);
        Customer cust = qrMap.get(0).getCustomer();
        String handphone = cust.getHandphone();
        String custName = cust.getName();
        
        WorkshopDAO wsDAO = new WorkshopDAO();
        Workshop ws = wsDAO.retrieveWorkshop(workshopId, staffId, token);
        String workshopName = ws.getName();
        
        String isSuccess = qrDAO.addInitialQuotation(staffId, token, quotationRequestId, workshopId, minPrice, maxPrice, description);
        //Error message? success message?
        if (isSuccess.length() == 0) {
            session.setAttribute("isSuccess", "Quoted $" + minPrice + "0 - $" + maxPrice + "0 for ID: " + quotationRequestId);
//            RequestDispatcher view = request.getRequestDispatcher("ViewRequest.jsp");
//            view.forward(request, response);
            SmsNotification smsNotification = new SmsNotification();
            smsNotification.smsForInitalQuotation(custName, handphone, workshopName, minPrice, maxPrice);
            response.sendRedirect("New_Request.jsp");
        } else {
            session.setAttribute("fail", isSuccess + "(ID: " + quotationRequestId + ")");
//            RequestDispatcher view = request.getRequestDispatcher("ViewRequest.jsp");
//            view.forward(request, response);
            response.sendRedirect("New_Request.jsp");
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
        } catch (SQLException ex) {
            Logger.getLogger(AddInitialQuotationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(AddInitialQuotationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(AddInitialQuotationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(AddInitialQuotationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
