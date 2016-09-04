/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import entity.WebUser;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.Settings;

/**
 *
 * @author Joanne
 */
@WebServlet(name = "EditSettingsServlet", urlPatterns = {"/EditSettings"})
public class EditSettingsServlet extends HttpServlet {

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
            throws ServletException, IOException, UnsupportedEncodingException, ParseException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);
        WebUser user = (WebUser) session.getAttribute("loggedInUser");
        String token = user.getToken();
        int staffId = user.getStaffId();
        ArrayList<String> errorMessages = new ArrayList<String>();

        Settings settings = new Settings();
        HashMap<String, JsonObject> messages = settings.retrieveAllSettings(staffId, token);
        Iterator it = messages.entrySet().iterator();
        //To loop through all the settings available, and getParameter for the setting
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry) it.next();
            String setting = (String) pair.getKey();
            String[] arr = setting.split(",");
            int settingId = Integer.parseInt(arr[0]);
            String settingName = arr[1];
            JsonObject value = (JsonObject) pair.getValue();
            Set<Entry<String, JsonElement>> entrySet = value.entrySet();
            //JsonObject to update the database
            JsonObject obj = new JsonObject();
            for (Map.Entry<String, JsonElement> entry : entrySet) {
                String subCategory = entry.getKey();
                String subValue = request.getParameter(settingName + "," + subCategory);
                obj.addProperty(subCategory, subValue);
            }
            String errMsg = settings.editSetting(staffId, token, settingId, obj);
            if (errMsg.length() != 0) {
                errorMessages.add(errMsg);
            }
        }

        if (errorMessages.size() == 0) {
            session.setAttribute("success", "Settings Updated!");
//            RequestDispatcher view = request.getRequestDispatcher("ManageService.jsp");
//            view.forward(request, response);
            response.sendRedirect("EditSettings_Form.jsp");
        } else {
            session.setAttribute("fail", errorMessages);
//            RequestDispatcher view = request.getRequestDispatcher("ManageService.jsp");
//            view.forward(request, response);
            response.sendRedirect("EditSettings_Form.jsp");
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
            throws ServletException, IOException, UnsupportedEncodingException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(EditSettingsServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            throws ServletException, IOException, UnsupportedEncodingException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(EditSettingsServlet.class.getName()).log(Level.SEVERE, null, ex);
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
