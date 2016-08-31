/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.SMS;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Joanne
 */
public class SMSDao {

    public boolean sendSMS(SMS sms) {
        try {
            String recipient = sms.getRecipient();
            String message = sms.getMessage();
            String username = sms.getUsername();
            String password = sms.getPassword();
            String requestUrl = sms.getRequestUrl()
                    + "ID=" + URLEncoder.encode(username, "UTF-8")
                    + "&Password=" + URLEncoder.encode(password, "UTF-8")
                    + "&Mobile=" + URLEncoder.encode(recipient, "UTF-8")
                    + "&Type=A"
                    + "&Message=" + URLEncoder.encode(message, "UTF-8")
                    + "&OTP=true";
            URL url = new URL(requestUrl);
            HttpURLConnection uc = (HttpURLConnection) url.openConnection();
            if (uc.getResponseMessage().equals("OK")) {
                uc.disconnect();
                return true;
            } else {
                uc.disconnect();
                return false;
            }
        } catch (Exception ex) {
            return false;
        }
    }
}
