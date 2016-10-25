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
public class SmsNotification { //for customers to receive
    String uniqueLink = ""; //extract unique link for customer here
    String username = "Fixir"; //bulksms username
    String password = "fixir2016"; //bulksms password
    String senderId = "FIXIR"; //sender's name appearing on customer's mobile phone
    String mobileTest = "90054906"; //REMEMBER TO CHANGE ALL MOBILETEST TO MOBILE NO IN THE CODES BELOW 
    //this is desmond's number^
    
    //user:Fixir  
    //pass:fixir2016
    
    
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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", a valet driver has been assigned to you.%0a%0aPlease login to view the valet request. Thank you.", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", your valet driver is now on his way to pick up your vehicle at your designated location.%0a%0aYou may proceed to login to track your valet progress.", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", your valet driver has just arrived at the designated pick-up location.%0a%0aPlease proceed to meet up with your valet driver.", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", your valet driver is now on his way to the workshop of your choice.", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", your vehicle has arrived at the workshop. Thank you for opting for our valet services. Please hold while our workshop diagnose the problem.", "ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
    
    public void smsForInitalQuotation(String custName, String mobileNo, String workshopName, double minPrice, double maxPrice){
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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", " + workshopName + " has replied to your quotation request:%0aMinimum: $" + minPrice + "%0aMaximum: $" + maxPrice,"ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
    
    public void smsForDiagnosticQuotation(String custName, String mobileNo, String workshopName, double diagnosticPrice){
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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", " + workshopName + " has replied to your quotation request:%0aDiagnostic Price: $" + diagnosticPrice,"ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
    
    public void smsForFinalQuotation(String custName, String mobileNo, String workshopName, double finalPrice){
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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", " + workshopName + " has replied with a final quotation of $" + finalPrice + "%0aPlease login to your account to accept. Thank you.","ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
    
    public void smsForEstTimeCompletion(String custName, String mobileNo, String workshopName, String estDateTime){
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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", " + workshopName + " has replied with an estimated date and time of completion:%0a" + estDateTime,"ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
    
    public void smsForCompletion(String custName, String workshopName, String mobileNo){
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
            data += "un=" + URLEncoder.encode(username, "ISO-8859-1");   //add username here
            data += "&pwd=" + URLEncoder.encode(password, "ISO-8859-1"); //add pw here
            data += "&dstno=" + URLEncoder.encode("65"+mobileNo, "ISO-8859-1");
            data += "&msg=" + URLEncoder.encode("Dear " + custName + ", your car servicing/repair with " + workshopName + " is completed.%0aPlease proceed to collect your vehicle from the workshop.","ISO-8859-1");
            data += uniqueLink;
            data += "&type=1";
            data += "&sendid="+senderId;

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
