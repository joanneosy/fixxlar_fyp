/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.WebUserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Joanne
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/ResetPassword"})
public class ResetPasswordServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

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
    // To handle the reset password link sent to the user
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        try {
//            //getParameter decode the URL, and hence replaces + with a space
//            //getQueryString return hashCode=.. and hence the need to substring to remove "hashCode"
//            String hashCode = request.getQueryString().substring(3);
//            ForgotPassword fp = new ForgotPassword();
//            String email = fp.verifyPwHashCode(hashCode);
//            
//            if (email != null) {
//                request.setAttribute("resetPasswordEmail", email);
//                RequestDispatcher view = request.getRequestDispatcher("ResetPassword.jsp");
//                view.forward(request, response);
//            } else {
//                request.setAttribute("errMsg", "Invalid Link");
//                RequestDispatcher view = request.getRequestDispatcher("ForgotPassword.jsp");
//                view.forward(request, response);
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
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
    // To handle the request after user keys in new password
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        if (password.equals(confirmPassword)) {
            try {
                WebUserDAO uDAO = new WebUserDAO();
                request.setAttribute("successResetPasswordMsg", "Log in with your new password!");
                RequestDispatcher view = request.getRequestDispatcher("Login.jsp");
                view.forward(request, response);

            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } else {
            request.setAttribute("errMsg", "Passwords do not match.");
            request.setAttribute("email", email);
            RequestDispatcher view = request.getRequestDispatcher("ResetPassword.jsp");
            view.forward(request, response);
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
