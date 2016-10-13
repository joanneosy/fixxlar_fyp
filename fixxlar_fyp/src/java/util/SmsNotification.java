/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.net.*;
import java.io.*;

/**
 *
 * @author Desmond
 */
public class SmsNotification {
    String uniqueLink = "<insert link here>"; //extract unique link for customer here
    
    public void smsForAccept(String custName, String mobileNo){
        try {
            // Construct data
            String data = "";
            /*
             * Note the suggested encoding for certain parameters, notably
             * the username, password and especially the message.  ISO-8859-1
             * is essentially the character set that we use for message bodies,
             * with a few exceptions for e.g. Greek characters.  For a full list,
             * see:  http://developer.bulksms.com/eapi/submission/character-encoding/
             */
            data += "un=" + URLEncoder.encode("desmondsuperman", "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode("desmond1234", "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode(mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", a valet driver has been assigned to you. Kindly click on the link to view: ", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid=FIXIR";

            // Send data
            // Please see the FAQ regarding HTTPS (port 443) and HTTP (port 80/5567)
            URL url = new URL("http://isms.com.my/isms_send.php");

            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
            wr.write(data);
            wr.flush();

            // Get the response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = rd.readLine()) != null) {
                // Print the response output...
                System.out.println(line);
            }
            wr.close();
            rd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }  
    }
    
    public void smsForStart(String custName, String mobileNo){
        try {
            // Construct data
            String data = "";
            /*
             * Note the suggested encoding for certain parameters, notably
             * the username, password and especially the message.  ISO-8859-1
             * is essentially the character set that we use for message bodies,
             * with a few exceptions for e.g. Greek characters.  For a full list,
             * see:  http://developer.bulksms.com/eapi/submission/character-encoding/
             */
            data += "un=" + URLEncoder.encode("desmondsuperman", "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode("desmond1234", "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode(mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", your valet driver is now on his way to pick up your vehicle at your designated location.", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid=FIXIR";

            // Send data
            // Please see the FAQ regarding HTTPS (port 443) and HTTP (port 80/5567)
            URL url = new URL("http://isms.com.my/isms_send.php");

            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
            wr.write(data);
            wr.flush();

            // Get the response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = rd.readLine()) != null) {
                // Print the response output...
                System.out.println(line);
            }
            wr.close();
            rd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }  
    }
    
    public void smsForReached(String custName, String mobileNo){
        try {
            // Construct data
            String data = "";
            /*
             * Note the suggested encoding for certain parameters, notably
             * the username, password and especially the message.  ISO-8859-1
             * is essentially the character set that we use for message bodies,
             * with a few exceptions for e.g. Greek characters.  For a full list,
             * see:  http://developer.bulksms.com/eapi/submission/character-encoding/
             */
            data += "un=" + URLEncoder.encode("desmondsuperman", "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode("desmond1234", "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode(mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", your valet driver has just arrived at the designated pick-up location. Kindly hand your vehicle keys to him to proceed. Thank you.", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid=FIXIR";

            // Send data
            // Please see the FAQ regarding HTTPS (port 443) and HTTP (port 80/5567)
            URL url = new URL("http://isms.com.my/isms_send.php");

            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
            wr.write(data);
            wr.flush();

            // Get the response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = rd.readLine()) != null) {
                // Print the response output...
                System.out.println(line);
            }
            wr.close();
            rd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }  
    }
    
    public void smsForLeavingToWorkshop(String custName, String mobileNo){
        try {
            // Construct data
            String data = "";
            /*
             * Note the suggested encoding for certain parameters, notably
             * the username, password and especially the message.  ISO-8859-1
             * is essentially the character set that we use for message bodies,
             * with a few exceptions for e.g. Greek characters.  For a full list,
             * see:  http://developer.bulksms.com/eapi/submission/character-encoding/
             */
            data += "un=" + URLEncoder.encode("desmondsuperman", "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode("desmond1234", "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode(mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", your valet driver is now on his way to the workshop of your choice.", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid=FIXIR";

            // Send data
            // Please see the FAQ regarding HTTPS (port 443) and HTTP (port 80/5567)
            URL url = new URL("http://isms.com.my/isms_send.php");

            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
            wr.write(data);
            wr.flush();

            // Get the response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = rd.readLine()) != null) {
                // Print the response output...
                System.out.println(line);
            }
            wr.close();
            rd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }  
    }
    
    public void smsForArrivingAtWorkshop(String custName, String mobileNo){
        try {
            // Construct data
            String data = "";
            /*
             * Note the suggested encoding for certain parameters, notably
             * the username, password and especially the message.  ISO-8859-1
             * is essentially the character set that we use for message bodies,
             * with a few exceptions for e.g. Greek characters.  For a full list,
             * see:  http://developer.bulksms.com/eapi/submission/character-encoding/
             */
            data += "un=" + URLEncoder.encode("desmondsuperman", "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode("desmond1234", "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode(mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", your vehicle has arrived at the workshop. Thank you for opting for our valet services. Have a good day ahead!", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid=FIXIR";

            // Send data
            // Please see the FAQ regarding HTTPS (port 443) and HTTP (port 80/5567)
            URL url = new URL("http://isms.com.my/isms_send.php");

            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
            wr.write(data);
            wr.flush();

            // Get the response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = rd.readLine()) != null) {
                // Print the response output...
                System.out.println(line);
            }
            wr.close();
            rd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }  
    }
}
