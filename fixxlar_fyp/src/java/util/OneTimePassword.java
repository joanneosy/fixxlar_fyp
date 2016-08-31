/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import entity.SMS;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Joanne
 */
public class OneTimePassword {
    
    public String generateOTP() {
        StringBuilder generatedToken = new StringBuilder();
        
        try {
            SecureRandom number = SecureRandom.getInstance("SHA1PRNG");
            for (int i = 0; i < 6; i++) {
                generatedToken.append(number.nextInt(9));
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return generatedToken.toString();
    }
    
    public void storeOTP(int userID, int workshopID, int serviceID, String hashOTP) {

//        Connection conn = null;
//        PreparedStatement pstmt = null;
//
//        try {
//            conn = ConnectionManager.getConnection();
//            pstmt = null;
//            pstmt = conn.prepareStatement("INSERT INTO otp VALUES (" + userID + "," + workshopID + "," + serviceID + ",'" + hashOTP + "');");
//            pstmt.executeUpdate();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            ConnectionManager.close(conn, pstmt);
//        }
    } 
}
