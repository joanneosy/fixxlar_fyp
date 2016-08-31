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
 * @author Joanne
 */
@WebServlet(name = "AddMasterWorkshopStaffServlet", urlPatterns = {"/AddMasterWorkshopStaff"})
public class AddMasterWorkshopStaffServlet extends HttpServlet {

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
        String wsStaffName = request.getParameter("staffName");
        String wsStaffHpNo = request.getParameter("staffHpNo");
        String wsStaffEmail = request.getParameter("staffEmail");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String test = request.getParameter("workshopId");
        int wsId = Integer.parseInt(request.getParameter("workshopId"));

        Validation validation = new Validation();
        String hpValid = validation.isValidMobileContact(wsStaffHpNo);
        String pwValid = validation.isValidPassword(password, confirmPassword);
        if (hpValid != null && hpValid.length() > 0) {
            err.add(hpValid);
        }
        if (pwValid != null && pwValid.length() > 0) {
            err.add(pwValid);
        }

        if (err.size() > 0) {
            request.setAttribute("workshopId", wsId);
            request.setAttribute("errMsg", err);
            request.setAttribute("wsStaffName", wsStaffName);
            request.setAttribute("wsStaffHpNo", wsStaffHpNo);
            request.setAttribute("wsStaffEmail", wsStaffEmail);
            request.setAttribute("password", password);
            request.setAttribute("confirmPassword", confirmPassword);
            RequestDispatcher view = request.getRequestDispatcher("AddWorkshopMasterAccount.jsp");
            view.forward(request, response);
        } else {
            HttpSession session = request.getSession(true);
            WebUser user = (WebUser) session.getAttribute("loggedInUser");
            int staffId = user.getStaffId();
            String token = user.getToken();
            WebUserDAO uDAO = new WebUserDAO();
            String isSuccess = uDAO.addMasterWorkshopStaff(staffId, token, wsStaffName, wsStaffEmail, wsStaffHpNo, wsId, password);
            if (isSuccess.length() == 0) {
                session.setAttribute("success", "Master Workshop Staff added successfully for workshop ID " + wsId);
//                RequestDispatcher view = request.getRequestDispatcher("ViewWorkshop.jsp");
//                view.forward(request, response);
                response.sendRedirect("ViewWorkshop.jsp");
            } else {
                err.add(isSuccess + "(Workshop ID: " + wsId + ")");
                request.setAttribute("workshopId", wsId);
                request.setAttribute("errMsg", err);
                request.setAttribute("wsStaffName", wsStaffName);
                request.setAttribute("wsStaffHpNo", wsStaffHpNo);
                request.setAttribute("wsStaffEmail", wsStaffEmail);
                request.setAttribute("password", password);
                request.setAttribute("confirmPassword", confirmPassword);
                RequestDispatcher view = request.getRequestDispatcher("AddWorkshopMasterAccount.jsp");
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
