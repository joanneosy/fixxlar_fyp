/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.stripe.Stripe;
import com.stripe.exception.APIConnectionException;
import com.stripe.exception.AuthenticationException;
import com.stripe.exception.CardException;
import com.stripe.exception.InvalidRequestException;
import com.stripe.exception.RateLimitException;
import com.stripe.exception.StripeException;
import com.stripe.model.Account;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Joshymantou
 */
@WebServlet(name = "RegisterStripeServlet", urlPatterns = {"/RegisterStripe"})
public class RegisterStripeServlet extends HttpServlet {

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

        //get parameters
        ArrayList<String> errMsg = new ArrayList<>();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        //test key
        try {
            Stripe.apiKey = "sk_test_mzwWChaic4Q1JoBosXj4EWQl";
            Map<String, Object> accountParams = new HashMap<String, Object>();
            accountParams.put("managed", false);
            accountParams.put("country", "SG");
            accountParams.put("email", email);
            Account.create(accountParams);

        } catch (CardException e) {
            // Since it's a decline, CardException will be caught
            errMsg.add("Status is: " + e.getCode() + " , message is: " + e.getMessage());
//            System.out.println("Status is: " + e.getCode());
//            System.out.println("Message is: " + e.getMessage());
        } catch (RateLimitException e) {
        // Too many requests made to the API too quickly
            errMsg.add(e.getMessage());
        } catch (InvalidRequestException e) {
        // Invalid parameters were supplied to Stripe's API
            errMsg.add(e.getMessage());
        } catch (AuthenticationException e) {
        // Authentication with Stripe's API failed
            // (maybe you changed API keys recently)
            errMsg.add(e.getMessage());
        } catch (APIConnectionException e) {
        // Network communication with Stripe failed
            errMsg.add(e.getMessage());
        } catch (StripeException e) {
        // Display a very generic error to the user, and maybe send
            // yourself an email
            errMsg.add(e.getMessage());
        } catch (Exception e) {
        // Something else happened, completely unrelated to Stripe
            errMsg.add(e.getMessage());
        }
        
        if (errMsg.isEmpty()) {
                errMsg.add("A registration E-mail has been sent to your account: " + email);
                request.setAttribute("errMsg", errMsg);
                RequestDispatcher view = request.getRequestDispatcher("RegisterStripe.jsp");
                view.forward(request, response);
            } else {
                request.setAttribute("errMsg", errMsg);
                RequestDispatcher view = request.getRequestDispatcher("RegisterStripe.jsp");
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
