/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.QuotationRequestDAO;
import dao.WorkshopDAO;
import entity.WebUser;
import entity.Workshop;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Joanne
 */
@WebServlet(name = "AddFinalQuotationServlet", urlPatterns = {"/AddFinalQuotation"})
public class AddFinalQuotationServlet extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession(true);

        int offerId = Integer.parseInt(request.getParameter("id"));
        int quotationRequestId = Integer.parseInt(request.getParameter("serviceId"));
        double price = Double.parseDouble(request.getParameter("price"));
        WebUser user = (WebUser) session.getAttribute("loggedInUser");
        int staffId = user.getStaffId();
        String token = user.getToken();
        QuotationRequestDAO qrDAO = new QuotationRequestDAO();
        String isSuccess = qrDAO.addFinalQuotation(staffId, token, offerId, price);
        //Error message? success message?
        if (isSuccess.length()==0) {
            session.setAttribute("isSuccess", "$" + price + "0 quoted as the final amount for ID: " + quotationRequestId);
//            RequestDispatcher view = request.getRequestDispatcher("ViewRequest.jsp?id=" + quotationRequestId);
//            view.forward(request, response);
            response.sendRedirect("Send_Final_Quote.jsp");
        } else {
            session.setAttribute("fail", isSuccess + "(ID: " + offerId + ")");
//            RequestDispatcher view = request.getRequestDispatcher("AddFinalQuotation.jsp?id=" + offerId);
//            view.forward(request, response);
            response.sendRedirect("Send_Final_Quote.jsp");
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
        processRequest(request, response);
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
        processRequest(request, response);
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
