/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.WebUserDAO;
import entity.WebUser;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "AddMasterValetStaffServlet", urlPatterns = {"/AddMasterValetStaffServlet"})
public class AddMasterValetStaffServlet extends HttpServlet {

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

        ArrayList<String> err = new ArrayList<String>();
        String valetStaffName = request.getParameter("staffName");
        String valetStaffHpNo = request.getParameter("staffHpNo");
        String valetStaffEmail = request.getParameter("staffEmail");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        int valetId = Integer.parseInt(request.getParameter("valetId"));

        Validation validation = new Validation();
        String hpValid = validation.isValidMobileContact(valetStaffHpNo);
        String pwValid = validation.isValidPassword(password, confirmPassword);
        if (hpValid != null && hpValid.length() > 0) {
            err.add(hpValid);
        }
        if (pwValid != null && pwValid.length() > 0) {
            err.add(pwValid);
        }

        if (err.size() > 0) {
            request.setAttribute("valetId", valetId);
            request.setAttribute("errMsg", err);
            request.setAttribute("valetStaffName", valetStaffName);
            request.setAttribute("valetStaffHpNo", valetStaffHpNo);
            request.setAttribute("valetStaffEmail", valetStaffEmail);
            request.setAttribute("password", password);
            request.setAttribute("confirmPassword", confirmPassword);
            RequestDispatcher view = request.getRequestDispatcher("AddValetMasterAccount.jsp");
            view.forward(request, response);
        } else {
            HttpSession session = request.getSession(true);
            WebUser user = (WebUser) session.getAttribute("loggedInUser");
            int staffId = user.getStaffId();
            String token = user.getToken();
            WebUserDAO uDAO = new WebUserDAO();
            String isSuccess = uDAO.addMasterValet(staffId, token, valetStaffName, valetStaffEmail, valetStaffHpNo, password, valetId);
//            String isSuccess = uDAO.addMasterWorkshopStaff(staffId, token, wsStaffName, wsStaffEmail, wsStaffHpNo, wsId, password);
            if (isSuccess.length() == 0) {
                session.setAttribute("success", "Master Valet Staff added successfully for valet ID " + valetId);
//                RequestDispatcher view = request.getRequestDispatcher("ViewWorkshop.jsp");
//                view.forward(request, response);
                response.sendRedirect("ViewValet.jsp");
            } else {
                err.add(isSuccess + "(Valet ID: " + valetId + ")");
                request.setAttribute("valetId", valetId);
                request.setAttribute("errMsg", err);
                request.setAttribute("valetStaffName", valetStaffName);
                request.setAttribute("valetStaffHpNo", valetStaffHpNo);
                request.setAttribute("valetStaffEmail", valetStaffEmail);
                request.setAttribute("password", password);
                request.setAttribute("confirmPassword", confirmPassword);
                RequestDispatcher view = request.getRequestDispatcher("AddValetMasterAccount.jsp");
                view.forward(request, response);
            }
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
