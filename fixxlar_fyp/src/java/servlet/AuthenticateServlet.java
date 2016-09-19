/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.ChatDAO;
import dao.QuotationRequestDAO;
import dao.WebUserDAO;
import entity.Chat;
import entity.WebUser;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "AuthenticateServlet", urlPatterns = {"/Authenticate"})
public class AuthenticateServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        String email = request.getParameter("email");
        String passwordEntered = request.getParameter("password");

        WebUserDAO dao = new WebUserDAO();
        WebUser user = dao.authenticateUser(email, passwordEntered);
        int staffType = user.getStaffType();
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            int userType = user.getUserType();
            if (userType == 1) {
                session.setAttribute("loggedInUserType", "Workshop");
                response.sendRedirect("New_Request.jsp");
            } else if (userType == 2) {
                session.setAttribute("loggedInUserType", "Admin");
                response.sendRedirect("Admin_Dashboard.jsp");
                return;
            } else if (userType == 3) {
                session.setAttribute("loggedInUserType", "Groomer");
                response.sendRedirect("Groomer.jsp");
            } else if (userType == 4 && staffType == 2) {
                session.setAttribute("loggedInUserType", "Valet");
                session.setAttribute("staffType", "Staff");
                response.sendRedirect("Valet.jsp");
            } else if (userType == 4 && staffType == 1) {
                session.setAttribute("loggedInUserType", "Valet");
                session.setAttribute("staffType", "Admin");
                response.sendRedirect("ValetAdminRequest.jsp");
            }

        } else {
            request.setAttribute("errMsg", "Invalid Email/Password");
            RequestDispatcher view = request.getRequestDispatcher("Login.jsp");
            view.forward(request, response);
            return;
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
        protected void doGet
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            try {
                processRequest(request, response);
            } catch (Exception ex) {
                Logger.getLogger(AuthenticateServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            try {
                processRequest(request, response);
            } catch (Exception ex) {
                Logger.getLogger(AuthenticateServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
