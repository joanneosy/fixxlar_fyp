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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
@WebServlet(name = "AddEmployeeServlet", urlPatterns = {"/AddEmployee"})
public class AddEmployeeServlet extends HttpServlet {

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
        String staffName = request.getParameter("staffName");
        String staffHpNo = request.getParameter("staffHpNo");
        String staffEmail = request.getParameter("staffEmail");
        String licenseNo = request.getParameter("licenseNo");
        String licenseIssue = request.getParameter("licenseIssue");

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        //Type of employee to be added
        String typeStr = request.getParameter("type");

        //Logged in user details
        HttpSession session = request.getSession(true);
        WebUser user = (WebUser) session.getAttribute("loggedInUser");
        int staffId = user.getStaffId();
        String token = user.getToken();
        int wsId = user.getShopId();
        String userType = (String) session.getAttribute("loggedInUserType");

        Validation validation = new Validation();
        ArrayList<String> errMsg = validation.validateNewEmployee(staffHpNo, password, confirmPassword);
        if (errMsg.size() != 0) {
            request.setAttribute("errMsgArr", errMsg);
            String url = "";
            if (userType.equals("Valet")) {
                url = "Add_Valet_Employee.jsp";

            } else {
                url = "AddEmployee.jsp";
            }
            RequestDispatcher view = request.getRequestDispatcher(url);
            view.forward(request, response);
        } else {
            int staffType = user.getStaffType();
            WebUserDAO uDAO = new WebUserDAO();
            String errorMsg = "";
            //check user and stafftype before calling respective add methods
            //if usertype == admin, check if stafftype for admin is super/master user, then we can add fixir staff. Normal fixir staff 
            //cannot add other fixir staff
            //if usertype == workshop, check if stafftype is master workshop or normal employee
            //if normal employee, it cannot add other employee.  
            if (userType.equals("Workshop")) {
                if (staffType == 1) {
                    errorMsg = uDAO.addNormalWorkshopStaff(staffId, token, staffName, staffEmail, staffHpNo, wsId, password);
                }
            }
            if (userType.equals("Admin")) {
                if (staffType == 1) {
                    if (typeStr == null || typeStr.length() == 0) {
                        errorMsg = "Please select employee type.";
                    } else {
                        int type = Integer.parseInt(typeStr);
                        if (type == 2) {
                            errorMsg = uDAO.addMasterAdmin(staffId, token, staffName, staffEmail, staffHpNo, password);
                        } else if (type == 3) {
                            errorMsg = uDAO.addNormalAdmin(staffId, token, staffName, staffEmail, staffHpNo, password);
                        }
                    }
                } else if (staffType == 2) {
                    errorMsg = uDAO.addNormalAdmin(staffId, token, staffName, staffEmail, staffHpNo, password);
                }
            }
            if (userType.equals("Valet")) {
                errorMsg = uDAO.addNormalValet(staffId, token, staffName, staffEmail, staffHpNo, password, wsId, licenseIssue, licenseNo);
            }

            if (errorMsg.isEmpty()) {
                session.setAttribute("success", staffName + " added!");
                String url = "";
                if (userType.equals("Valet")) {
                    url = "Valet_Employees.jsp";

                } else {
                    url = "ViewEmployees.jsp";
                }
                response.sendRedirect(url);
            } else {
                String url = "";
                if (userType.equals("Valet")) {
                    url = "Add_Valet_Employee.jsp";

                } else {
                    url = "AddEmployee.jsp";
                }
                request.setAttribute("workshopId", wsId);
                request.setAttribute("errMsg", errorMsg);
                RequestDispatcher view = request.getRequestDispatcher(url);
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
