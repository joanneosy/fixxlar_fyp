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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Joshymantou
 */
@WebServlet(name = "DeleteEmployeeServlet", urlPatterns = {"/DeleteEmployee"})
public class DeleteEmployeeServlet extends HttpServlet {

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
       
        int idToDelete = Integer.parseInt(request.getParameter("idToDelete"));
        WebUserDAO uDAO = new WebUserDAO();
        
        
                
        HttpSession session = request.getSession(true);
        WebUser loggedInUser = (WebUser) session.getAttribute("loggedInUser");
        int staffId = loggedInUser.getStaffId();
        
        String token = loggedInUser.getToken();
        String url = "ViewEmployees.jsp";
//        WebUser editUser = uDAO.retrieveUser(staffId, token, idToDelete);
        int editUserType = loggedInUser.getUserType();
        int editUserStaffType = loggedInUser.getStaffType();
        String errMsg = "";
        
        //Workshop Staff
        if (editUserType == 1) {
            //Master Workshop Staff
            if (editUserStaffType == 1) {
                errMsg = uDAO.deleteStaff(staffId, token, idToDelete);
            //Normal Workshop Staff
            } else if (editUserStaffType == 2) {
                errMsg = "Normal workshop staff has no rights to delete other staff!";
            }
            
        //Fixir Admin
        } else if (editUserType == 2) {
            errMsg = uDAO.deleteStaff(staffId, token, idToDelete);
          
        } 
            
        //Valet 
         else if (editUserType == 4) {
            if (editUserStaffType == 1) {
                errMsg = uDAO.deleteStaff(staffId, token, idToDelete);
                url = "Valet_Employees.jsp";
            //Normal Valet Staff
            } else if (editUserStaffType == 2) {
                errMsg = "Normal valet staff has no rights to delete other staff!";
            }
        } 
        
        if (errMsg.equals("")) {
                session.setAttribute("success", "Employee successfully deleted!");
                response.sendRedirect(url);
//                RequestDispatcher view = request.getRequestDispatcher("ViewEmployees.jsp?id=" + idToDelete);
//                view.forward(request, response);
            } else {
                request.setAttribute("fail", errMsg);
                RequestDispatcher view = request.getRequestDispatcher(url + "?id=" + idToDelete);
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
