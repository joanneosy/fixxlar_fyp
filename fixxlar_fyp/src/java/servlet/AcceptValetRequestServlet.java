/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.ValetRequestDAO;
import entity.Customer;
import entity.ValetRequest;
import entity.WebUser;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.SmsNotification;

/**
 *
 * @author User
 */
@WebServlet(name = "AcceptValetRequestServlet", urlPatterns = {"/AcceptValetRequestServlet"})
public class AcceptValetRequestServlet extends HttpServlet {

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

        int request_id = Integer.parseInt(request.getParameter("id"));
        WebUser user = (WebUser) session.getAttribute("loggedInUser");
        int staffId = user.getStaffId();
        String token = user.getToken();
        ValetRequestDAO vrDAO = new ValetRequestDAO();
        String isSuccess = vrDAO.acceptRequest(staffId, token, request_id);
       
        //to retrieve valet request details + customer details for sms
       
        ValetRequest vr = vrDAO.retrieveValetRequest(staffId, token, request_id);
        Customer cust = vr.getCustomer();
        String handphone = cust.getHandphone();
        String custName = cust.getName();
          
                
        if (isSuccess.length() == 0) {
            session.setAttribute("isSuccess", "Accepted request for ID: " + request_id);
//            RequestDispatcher view = request.getRequestDispatcher("ViewRequest.jsp");
//            view.forward(request, response);
            //put send sms method here
            SmsNotification smsNotification = new SmsNotification();
            smsNotification.smsForAccept(custName, handphone);
            response.sendRedirect("Valet.jsp");
        } else {
            session.setAttribute("fail", isSuccess + "(ID: " + request_id + ")");
//            RequestDispatcher view = request.getRequestDispatcher("ViewRequest.jsp");
//            view.forward(request, response);
            response.sendRedirect("Valet.jsp");
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
            Logger.getLogger(AcceptValetRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(AcceptValetRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AcceptValetRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(AcceptValetRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
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
