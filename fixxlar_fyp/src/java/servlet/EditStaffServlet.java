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
import java.text.ParseException;
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
 * @author Joanne
 */
@WebServlet(name = "EditStaffServlet", urlPatterns = {"/EditStaff"})
public class EditStaffServlet extends HttpServlet {

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String handphone = request.getParameter("handphone").trim();
        String licenseNo = request.getParameter("licenseNo");
        String licenseIssue = request.getParameter("licenseIssue");

        WebUserDAO uDAO = new WebUserDAO();

        HttpSession session = request.getSession(true);
        WebUser loggedInUser = (WebUser) session.getAttribute("loggedInUser");
        int staffId = loggedInUser.getStaffId();
        String token = loggedInUser.getToken();
        int staffType = loggedInUser.getStaffType();

        WebUser editUser = uDAO.retrieveUser(staffId, token, id);
        int editUserType = editUser.getUserType();
        int editUserStaffType = editUser.getStaffType();
        Validation validation = new Validation();
        ArrayList<String> errMsgArr = validation.validateExistingEmployee(handphone);
        String errMsg = "";
        if (errMsgArr.size() != 0) {
            request.setAttribute("errMsgArr", errMsgArr);
            RequestDispatcher view = request.getRequestDispatcher("EditEmployee.jsp?id=" + id);
            view.forward(request, response);
        } else {
            //Workshop Staff
            if (editUserType == 1) {
                //Master Workshop Staff
                if (editUserStaffType == 1) {
                    errMsg = uDAO.updateMasterWorkshopStaff(staffId, token, name, email, handphone, id);
                    //Normal Workshop Staff
                } else if (editUserStaffType == 2) {
                    errMsg = uDAO.updateNormalWorkshopStaff(staffId, token, name, email, handphone, id);
                }

                //Fixir Admin
            } else if (editUserType == 2) {
                //Super Fixir Admin
                if (editUserStaffType == 1) {
                    errMsg = uDAO.updateSuperAdmin(staffId, token, name, email, handphone, id);
                    //Master Fixir Admin
                } else if (editUserStaffType == 2) {
                    errMsg = uDAO.updateMasterAdmin(staffId, token, name, email, handphone, id);
                    //Normal Fixir Admin
                } else if (editUserStaffType == 3) {
                    errMsg = uDAO.updateNormalAdmin(staffId, token, name, email, handphone, id);
                }
                //Valet Staff
            } else if (editUserType == 4) {
                //Master Valet Staff
                if (editUserStaffType == 1) {
                    errMsg = uDAO.updateMasterValet(staffId, token, name, email, handphone, id);
                    //Normal Valet Staff
                } else if (editUserStaffType == 2) {
                    errMsg = uDAO.updateNormalValet(staffId, token, name, email, handphone, id, licenseNo, licenseIssue);
                }
            }
        }

        if (errMsg.equals("")) {
            session.setAttribute("success", "Employee successfully edited! (ID:" + id + ")");
//                request.setAttribute("errMsg", "Employee successfully edited!");
//                RequestDispatcher view = request.getRequestDispatcher("ViewEmployees.jsp?id=" + id);
            String url = "";
            if (editUserType == 4) {
                url = "Valet_Employees.jsp";
            } else {
                url = "ViewEmployees.jsp";
            }
            response.sendRedirect(url);
//                view.forward(request, response);
        } else {
            request.setAttribute("errMsg", errMsg);
            RequestDispatcher view = request.getRequestDispatcher("EditEmployee.jsp?id=" + id);
            view.forward(request, response);
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
            Logger.getLogger(EditStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(EditStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
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
