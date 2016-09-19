/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import entity.Customer;
import entity.ValetRequest;
import entity.Vehicle;
import entity.WebUser;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

/**
 *
 * @author Joanne
 */
public class ValetRequestDAO {
    private final String USER_AGENT = "Mozilla/5.0";

    public HashMap<Integer, ValetRequest> retrieveValetRequestsForDriver(int staffId, String token, int status) throws SQLException, ParseException, UnsupportedEncodingException, IOException {
        HashMap<Integer, ValetRequest> vrs = new HashMap<Integer, ValetRequest>();
        String url = "http://119.81.43.85/erp/valet_request/get_all_requests_for_driver";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("status", status + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonElement oElement = jobj.get("payload");
        if (oElement.isJsonNull()) {
            return vrs;
        }
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("valet_requests");
        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("request_id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = qrObj.get("service_type");
            int serviceType = 0;
            if (!attElement.isJsonNull()) {
                serviceType = attElement.getAsInt();
            }
            attElement = qrObj.get("pick_up_address");
            String pickUpAddress = "";
            if (!attElement.isJsonNull()) {
                pickUpAddress = attElement.getAsString();
            }
            attElement = qrObj.get("pick_up_longitude");
            double pickUpLongitude = 0.0;
            if (!attElement.isJsonNull()) {
                pickUpLongitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("pick_up_latitude");
            double pickUpLatitude = 0.0;
            if (!attElement.isJsonNull()) {
                pickUpLatitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("drop_off_address");
            String dropOffAddress = "";
            if (!attElement.isJsonNull()) {
                dropOffAddress = attElement.getAsString();
            }
            attElement = qrObj.get("drop_off_latitude");
            double dropOffLongitude = 0.0;
            if (!attElement.isJsonNull()) {
                dropOffLongitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("drop_off_longitude");
            double dropOffLatitude = 0.0;
            if (!attElement.isJsonNull()) {
                dropOffLatitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("scheduled_pick_up_time");
            Timestamp scheduledPickUpTime = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            scheduledPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                scheduledPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            }
            
            attElement = qrObj.get("actual_pick_up_time");
            Timestamp actualPickUpTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            actualPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                actualPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            }
            
            attElement = qrObj.get("completed_time");
            Timestamp completedTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            completedTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                completedTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("request_status");
            int requestStatus = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                requestStatus = attElement.getAsInt();
            }

            attElement = qrObj.get("price");
            double price = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                price = attElement.getAsDouble();
            }
            
            attElement = qrObj.get("offer_id");
            int offerId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerId = attElement.getAsInt();
            }            

            attElement = qrObj.get("vehicle_id");
            int vehicleId = 0;
            if (!attElement.isJsonNull()) {
                vehicleId = attElement.getAsInt();
            }

            attElement = qrObj.get("car_make");
            String carMake = "";
            if (!attElement.isJsonNull()) {
                carMake = attElement.getAsString();
            }

            attElement = qrObj.get("car_model");
            String carModel = "";
            if (!attElement.isJsonNull()) {
                carModel = attElement.getAsString();
            }

            attElement = qrObj.get("car_year_manufactured");
            int carYear = 0;
            if (!attElement.isJsonNull()) {
                carYear = attElement.getAsInt();
            }

            attElement = qrObj.get("car_plate_number");
            String carPlate = "";
            if (!attElement.isJsonNull()) {
                carPlate = attElement.getAsString();
            }

            attElement = qrObj.get("car_color");
            String carColor = "";
            if (!attElement.isJsonNull()) {
                carColor = attElement.getAsString();
            }

            attElement = qrObj.get("car_type_of_control_of_car");
            String carControl = "";
            if (!attElement.isJsonNull()) {
                carControl = attElement.getAsString();
            }

            attElement = qrObj.get("customer_id");
            int customerId = 0;
            if (!attElement.isJsonNull()) {
                customerId = attElement.getAsInt();
            }

            attElement = qrObj.get("customer_name");
            String customerName = "";
            if (!attElement.isJsonNull()) {
                customerName = attElement.getAsString();
            }

            attElement = qrObj.get("customer_email");
            String customerEmail = "";
            if (!attElement.isJsonNull()) {
                customerEmail = attElement.getAsString();
            }

            attElement = qrObj.get("customer_mobile_number");
            String customerHpNo = "";
            if (!attElement.isJsonNull()) {
                customerHpNo = attElement.getAsString();
            }
            
            attElement = qrObj.get("valet_driver_id");
            int valetDriverId = 0;
            if (!attElement.isJsonNull()) {
                valetDriverId = attElement.getAsInt();
            }

            attElement = qrObj.get("valet_driver_name");
            String valetDriverName = "";
            if (!attElement.isJsonNull()) {
                valetDriverName = attElement.getAsString();
            }

            attElement = qrObj.get("valet_driver_email");
            String valetDriverEmail = "";
            if (!attElement.isJsonNull()) {
                valetDriverEmail = attElement.getAsString();
            }

            attElement = qrObj.get("valet_driver_handphone");
            String valetDriverHpNo = "";
            if (!attElement.isJsonNull()) {
                valetDriverHpNo = attElement.getAsString();
            }

            Vehicle vehicle = new Vehicle(vehicleId, carMake, carModel, carYear, carPlate, customerId, carColor, carControl);
            Customer customer = new Customer(customerId, customerEmail, customerName, customerHpNo);    
            WebUser valetDriver = new WebUser(valetDriverId, valetDriverEmail, 0, 0, "", 0, valetDriverName, valetDriverHpNo, 0);
            ValetRequest vr = new ValetRequest(id, vehicle, customer, serviceType, valetDriver, pickUpAddress, pickUpLatitude, pickUpLongitude, dropOffAddress, 
            dropOffLatitude, dropOffLongitude, scheduledPickUpTime, actualPickUpTime, completedTime, price, offerId, requestStatus);
            vrs.put(i, vr);
        }
        return vrs;
    }
    
    public HashMap<Integer, ValetRequest> retrieveAllValetRequest(int staffId, String token, int status) throws SQLException, ParseException, UnsupportedEncodingException, IOException {
        HashMap<Integer, ValetRequest> vrs = new HashMap<Integer, ValetRequest>();
        String url = "http://119.81.43.85/erp/valet_request/get_all_requests";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("status", status + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonElement oElement = jobj.get("payload");
        if (oElement.isJsonNull()) {
            return vrs;
        }
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("valet_requests");
//        int arrSize = arr.size();
//        if (arrSize > 20) {
//            arrSize = 20;
//        }
//        for (int i = 0; i < arrSize; i++) {
        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("request_id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = qrObj.get("service_type");
            int serviceType = 0;
            if (!attElement.isJsonNull()) {
                serviceType = attElement.getAsInt();
            }
            attElement = qrObj.get("pick_up_address");
            String pickUpAddress = "";
            if (!attElement.isJsonNull()) {
                pickUpAddress = attElement.getAsString();
            }
            attElement = qrObj.get("pick_up_longitude");
            double pickUpLongitude = 0.0;
            if (!attElement.isJsonNull()) {
                pickUpLongitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("pick_up_latitude");
            double pickUpLatitude = 0.0;
            if (!attElement.isJsonNull()) {
                pickUpLatitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("drop_off_address");
            String dropOffAddress = "";
            if (!attElement.isJsonNull()) {
                dropOffAddress = attElement.getAsString();
            }
            attElement = qrObj.get("drop_off_latitude");
            double dropOffLongitude = 0.0;
            if (!attElement.isJsonNull()) {
                dropOffLongitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("drop_off_longitude");
            double dropOffLatitude = 0.0;
            if (!attElement.isJsonNull()) {
                dropOffLatitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("scheduled_pick_up_time");
            Timestamp scheduledPickUpTime = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            scheduledPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                scheduledPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            }
            
            attElement = qrObj.get("actual_pick_up_time");
            Timestamp actualPickUpTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            actualPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                actualPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            }
            
            attElement = qrObj.get("completed_time");
            Timestamp completedTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            completedTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                completedTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("request_status");
            int requestStatus = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                requestStatus = attElement.getAsInt();
            }

            attElement = qrObj.get("price");
            double price = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                price = attElement.getAsDouble();
            }
            
            attElement = qrObj.get("offer_id");
            int offerId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerId = attElement.getAsInt();
            }            

            attElement = qrObj.get("vehicle_id");
            int vehicleId = 0;
            if (!attElement.isJsonNull()) {
                vehicleId = attElement.getAsInt();
            }

            attElement = qrObj.get("car_make");
            String carMake = "";
            if (!attElement.isJsonNull()) {
                carMake = attElement.getAsString();
            }

            attElement = qrObj.get("car_model");
            String carModel = "";
            if (!attElement.isJsonNull()) {
                carModel = attElement.getAsString();
            }

            attElement = qrObj.get("car_year_manufactured");
            int carYear = 0;
            if (!attElement.isJsonNull()) {
                carYear = attElement.getAsInt();
            }

            attElement = qrObj.get("car_plate_number");
            String carPlate = "";
            if (!attElement.isJsonNull()) {
                carPlate = attElement.getAsString();
            }

            attElement = qrObj.get("car_color");
            String carColor = "";
            if (!attElement.isJsonNull()) {
                carColor = attElement.getAsString();
            }

            attElement = qrObj.get("car_type_of_control_of_car");
            String carControl = "";
            if (!attElement.isJsonNull()) {
                carControl = attElement.getAsString();
            }

            attElement = qrObj.get("customer_id");
            int customerId = 0;
            if (!attElement.isJsonNull()) {
                customerId = attElement.getAsInt();
            }

            attElement = qrObj.get("customer_name");
            String customerName = "";
            if (!attElement.isJsonNull()) {
                customerName = attElement.getAsString();
            }

            attElement = qrObj.get("customer_email");
            String customerEmail = "";
            if (!attElement.isJsonNull()) {
                customerEmail = attElement.getAsString();
            }

            attElement = qrObj.get("customer_mobile_number");
            String customerHpNo = "";
            if (!attElement.isJsonNull()) {
                customerHpNo = attElement.getAsString();
            }
            
            attElement = qrObj.get("valet_driver_id");
            int valetDriverId = 0;
            if (!attElement.isJsonNull()) {
                valetDriverId = attElement.getAsInt();
            }

            attElement = qrObj.get("valet_driver_name");
            String valetDriverName = "";
            if (!attElement.isJsonNull()) {
                valetDriverName = attElement.getAsString();
            }

            attElement = qrObj.get("valet_driver_email");
            String valetDriverEmail = "";
            if (!attElement.isJsonNull()) {
                valetDriverEmail = attElement.getAsString();
            }

            attElement = qrObj.get("valet_driver_handphone");
            String valetDriverHpNo = "";
            if (!attElement.isJsonNull()) {
                valetDriverHpNo = attElement.getAsString();
            }

            Vehicle vehicle = new Vehicle(vehicleId, carMake, carModel, carYear, carPlate, customerId, carColor, carControl);
            Customer customer = new Customer(customerId, customerEmail, customerName, customerHpNo);    
            WebUser valetDriver = new WebUser(valetDriverId, valetDriverEmail, 0, 0, "", 0, valetDriverName, valetDriverHpNo, 0);
            ValetRequest vr = new ValetRequest(id, vehicle, customer, serviceType, valetDriver, pickUpAddress, pickUpLatitude, pickUpLongitude, dropOffAddress, 
            dropOffLatitude, dropOffLongitude, scheduledPickUpTime, actualPickUpTime, completedTime, price, offerId, requestStatus);
            vrs.put(i, vr);
        }
        return vrs;
    }

    public ValetRequest retrieveValetRequest(int staffId, String token, int requestId) throws SQLException, ParseException, UnsupportedEncodingException, IOException {
        ValetRequest vr = null;
        String url = "http://119.81.43.85/erp/valet_request/get_request_by_id";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("request_id", requestId + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonElement oElement = jobj.get("payload");
        JsonObject oObj = null;
        if (oElement.isJsonNull()) {
            return vr;
        }
        oObj = oElement.getAsJsonObject().getAsJsonObject("valet_request");
        JsonElement attElement = oObj.get("request_id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = oObj.get("service_type");
            int serviceType = 0;
            if (!attElement.isJsonNull()) {
                serviceType = attElement.getAsInt();
            }
            attElement = oObj.get("pick_up_address");
            String pickUpAddress = "";
            if (!attElement.isJsonNull()) {
                pickUpAddress = attElement.getAsString();
            }
            attElement = oObj.get("pick_up_longitude");
            double pickUpLongitude = 0.0;
            if (!attElement.isJsonNull()) {
                pickUpLongitude = attElement.getAsDouble();
            }

            attElement = oObj.get("pick_up_latitude");
            double pickUpLatitude = 0.0;
            if (!attElement.isJsonNull()) {
                pickUpLatitude = attElement.getAsDouble();
            }

            attElement = oObj.get("drop_off_address");
            String dropOffAddress = "";
            if (!attElement.isJsonNull()) {
                dropOffAddress = attElement.getAsString();
            }
            attElement = oObj.get("drop_off_latitude");
            double dropOffLongitude = 0.0;
            if (!attElement.isJsonNull()) {
                dropOffLongitude = attElement.getAsDouble();
            }

            attElement = oObj.get("drop_off_longitude");
            double dropOffLatitude = 0.0;
            if (!attElement.isJsonNull()) {
                dropOffLatitude = attElement.getAsDouble();
            }

            attElement = oObj.get("scheduled_pick_up_time");
            Timestamp scheduledPickUpTime = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            scheduledPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                scheduledPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            }
            
            attElement = oObj.get("actual_pick_up_time");
            Timestamp actualPickUpTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            actualPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                actualPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            }
            
            attElement = oObj.get("completed_time");
            Timestamp completedTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            completedTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                completedTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = oObj.get("request_status");
            int requestStatus = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                requestStatus = attElement.getAsInt();
            }

            attElement = oObj.get("price");
            double price = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                price = attElement.getAsDouble();
            }
            
            attElement = oObj.get("offer_id");
            int offerId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerId = attElement.getAsInt();
            }            

            attElement = oObj.get("vehicle_id");
            int vehicleId = 0;
            if (!attElement.isJsonNull()) {
                vehicleId = attElement.getAsInt();
            }

            attElement = oObj.get("car_make");
            String carMake = "";
            if (!attElement.isJsonNull()) {
                carMake = attElement.getAsString();
            }

            attElement = oObj.get("car_model");
            String carModel = "";
            if (!attElement.isJsonNull()) {
                carModel = attElement.getAsString();
            }

            attElement = oObj.get("car_year_manufactured");
            int carYear = 0;
            if (!attElement.isJsonNull()) {
                carYear = attElement.getAsInt();
            }

            attElement = oObj.get("car_plate_number");
            String carPlate = "";
            if (!attElement.isJsonNull()) {
                carPlate = attElement.getAsString();
            }

            attElement = oObj.get("car_color");
            String carColor = "";
            if (!attElement.isJsonNull()) {
                carColor = attElement.getAsString();
            }

            attElement = oObj.get("car_type_of_control_of_car");
            String carControl = "";
            if (!attElement.isJsonNull()) {
                carControl = attElement.getAsString();
            }

            attElement = oObj.get("customer_id");
            int customerId = 0;
            if (!attElement.isJsonNull()) {
                customerId = attElement.getAsInt();
            }

            attElement = oObj.get("customer_name");
            String customerName = "";
            if (!attElement.isJsonNull()) {
                customerName = attElement.getAsString();
            }

            attElement = oObj.get("customer_email");
            String customerEmail = "";
            if (!attElement.isJsonNull()) {
                customerEmail = attElement.getAsString();
            }

            attElement = oObj.get("customer_mobile_number");
            String customerHpNo = "";
            if (!attElement.isJsonNull()) {
                customerHpNo = attElement.getAsString();
            }
            
            attElement = oObj.get("valet_driver_id");
            int valetDriverId = 0;
            if (!attElement.isJsonNull()) {
                valetDriverId = attElement.getAsInt();
            }

            attElement = oObj.get("valet_driver_name");
            String valetDriverName = "";
            if (!attElement.isJsonNull()) {
                valetDriverName = attElement.getAsString();
            }

            attElement = oObj.get("valet_driver_email");
            String valetDriverEmail = "";
            if (!attElement.isJsonNull()) {
                valetDriverEmail = attElement.getAsString();
            }

            attElement = oObj.get("valet_driver_handphone");
            String valetDriverHpNo = "";
            if (!attElement.isJsonNull()) {
                valetDriverHpNo = attElement.getAsString();
            }
            
            Vehicle vehicle = new Vehicle(vehicleId, carMake, carModel, carYear, carPlate, customerId, carColor, carControl);
            Customer customer = new Customer(customerId, customerEmail, customerName, customerHpNo);    
            WebUser valetDriver = new WebUser(valetDriverId, valetDriverEmail, 0, 0, "", 0, valetDriverName, valetDriverHpNo, 0);
            vr = new ValetRequest(id, vehicle, customer, serviceType, valetDriver, pickUpAddress, pickUpLatitude, pickUpLongitude, dropOffAddress, 
            dropOffLatitude, dropOffLongitude, scheduledPickUpTime, actualPickUpTime, completedTime, price, offerId, requestStatus);
        return vr;
    }

    public String acceptRequest(int staffId, String token, int requestId) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/valet_request/accept_request";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("request_id", requestId + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }

        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }
    
    public String driverOTWToPickUpPoint(int staffId, String token, int requestId) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/valet_request/driver_otw_to_pickup_point";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("request_id", requestId + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }

        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }
    
    public String driverReachedPickUpPoint(int staffId, String token, int requestId) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/valet_request/driver_reached_pickup_point";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("request_id", requestId + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }

        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }
    
    public String driverOTWToDropOffPoint(int staffId, String token, int requestId) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/valet_request/driver_otw_to_dropoff_point";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("request_id", requestId + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }

        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }
    
    public String completeRequest(int staffId, String token, int requestId) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/valet_request/complete_request";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("request_id", requestId + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }

        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }
    
    public static void main (String[] args) throws SQLException, ParseException, IOException {
        //retrieveValetRequestsForDriver(50, "588c6ff8caa34ff22fd1a51e1eb647ad74269cf9a9d892f6658b83d858fe4bb9c386f3593044ecad5cdb5320297fda2e1997705ec933da95956a01af919498a59c104e5f0a93c7a6464f4ce7f0bb75a2ba5247a1199d9ae855961643498671864cd6f8b72bbab1a01d33c0f0cb23cb5fb45b922f74339029d0b3caac8f71426feebbeeeb1ac9bf6feabd00cb90f05a84fc1d5ef664e69accb90ea945f27683a401e2693b59554d53ec7238846acef82ccfe3e450ec5b40e18ca5f71a804226ca18fefe9b94a07507dc4ebd149ec1ae82b8600ec291241e29e828537861c57a31749e51430e49727b9eb7211df87e8ee89dc496f57ef440d0f1226093a4767d8461c914e78d1b2782cbb08741d2d62f484a95abc12038e74601144a9939d10a0b28c30b479f9be9645489ea8ec761016dc6a0605dcdadde8a1eb5bd1708fabbaa4bb114f1de8114e4ff13ab083c5771baab596189a946431a316626e4b7dd367e8809847070564a9ede74a118de025b5310451062e9fe4146fce3d6f2441dc85c63e710ab71f48537d6bd41f8e6926a741efb424eb085090bdcdffff64a4b99bbf6fbb8a96e833b0474dfa6aa1ae6b5c23358768521e97ed695618030f65da71375b7dc5098a069690892be33ad6cc9ea0b2435cef6a5fcd52e6fb7c3890c2b58120fbbb757e5fd2e29249aebbc033489f3ab837726b04ec23f7e492f76b6c530", 1);
        //retrieveAllValetRequest(1, "8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c", 2);
        //retrieveValetRequest(50, "588c6ff8caa34ff22fd1a51e1eb647ad74269cf9a9d892f6658b83d858fe4bb9c386f3593044ecad5cdb5320297fda2e1997705ec933da95956a01af919498a59c104e5f0a93c7a6464f4ce7f0bb75a2ba5247a1199d9ae855961643498671864cd6f8b72bbab1a01d33c0f0cb23cb5fb45b922f74339029d0b3caac8f71426feebbeeeb1ac9bf6feabd00cb90f05a84fc1d5ef664e69accb90ea945f27683a401e2693b59554d53ec7238846acef82ccfe3e450ec5b40e18ca5f71a804226ca18fefe9b94a07507dc4ebd149ec1ae82b8600ec291241e29e828537861c57a31749e51430e49727b9eb7211df87e8ee89dc496f57ef440d0f1226093a4767d8461c914e78d1b2782cbb08741d2d62f484a95abc12038e74601144a9939d10a0b28c30b479f9be9645489ea8ec761016dc6a0605dcdadde8a1eb5bd1708fabbaa4bb114f1de8114e4ff13ab083c5771baab596189a946431a316626e4b7dd367e8809847070564a9ede74a118de025b5310451062e9fe4146fce3d6f2441dc85c63e710ab71f48537d6bd41f8e6926a741efb424eb085090bdcdffff64a4b99bbf6fbb8a96e833b0474dfa6aa1ae6b5c23358768521e97ed695618030f65da71375b7dc5098a069690892be33ad6cc9ea0b2435cef6a5fcd52e6fb7c3890c2b58120fbbb757e5fd2e29249aebbc033489f3ab837726b04ec23f7e492f76b6c530", 2);
        //acceptRequest(50, "588c6ff8caa34ff22fd1a51e1eb647ad74269cf9a9d892f6658b83d858fe4bb9c386f3593044ecad5cdb5320297fda2e1997705ec933da95956a01af919498a59c104e5f0a93c7a6464f4ce7f0bb75a2ba5247a1199d9ae855961643498671864cd6f8b72bbab1a01d33c0f0cb23cb5fb45b922f74339029d0b3caac8f71426feebbeeeb1ac9bf6feabd00cb90f05a84fc1d5ef664e69accb90ea945f27683a401e2693b59554d53ec7238846acef82ccfe3e450ec5b40e18ca5f71a804226ca18fefe9b94a07507dc4ebd149ec1ae82b8600ec291241e29e828537861c57a31749e51430e49727b9eb7211df87e8ee89dc496f57ef440d0f1226093a4767d8461c914e78d1b2782cbb08741d2d62f484a95abc12038e74601144a9939d10a0b28c30b479f9be9645489ea8ec761016dc6a0605dcdadde8a1eb5bd1708fabbaa4bb114f1de8114e4ff13ab083c5771baab596189a946431a316626e4b7dd367e8809847070564a9ede74a118de025b5310451062e9fe4146fce3d6f2441dc85c63e710ab71f48537d6bd41f8e6926a741efb424eb085090bdcdffff64a4b99bbf6fbb8a96e833b0474dfa6aa1ae6b5c23358768521e97ed695618030f65da71375b7dc5098a069690892be33ad6cc9ea0b2435cef6a5fcd52e6fb7c3890c2b58120fbbb757e5fd2e29249aebbc033489f3ab837726b04ec23f7e492f76b6c530", 4);
        //completeRequest(50, "588c6ff8caa34ff22fd1a51e1eb647ad74269cf9a9d892f6658b83d858fe4bb9c386f3593044ecad5cdb5320297fda2e1997705ec933da95956a01af919498a59c104e5f0a93c7a6464f4ce7f0bb75a2ba5247a1199d9ae855961643498671864cd6f8b72bbab1a01d33c0f0cb23cb5fb45b922f74339029d0b3caac8f71426feebbeeeb1ac9bf6feabd00cb90f05a84fc1d5ef664e69accb90ea945f27683a401e2693b59554d53ec7238846acef82ccfe3e450ec5b40e18ca5f71a804226ca18fefe9b94a07507dc4ebd149ec1ae82b8600ec291241e29e828537861c57a31749e51430e49727b9eb7211df87e8ee89dc496f57ef440d0f1226093a4767d8461c914e78d1b2782cbb08741d2d62f484a95abc12038e74601144a9939d10a0b28c30b479f9be9645489ea8ec761016dc6a0605dcdadde8a1eb5bd1708fabbaa4bb114f1de8114e4ff13ab083c5771baab596189a946431a316626e4b7dd367e8809847070564a9ede74a118de025b5310451062e9fe4146fce3d6f2441dc85c63e710ab71f48537d6bd41f8e6926a741efb424eb085090bdcdffff64a4b99bbf6fbb8a96e833b0474dfa6aa1ae6b5c23358768521e97ed695618030f65da71375b7dc5098a069690892be33ad6cc9ea0b2435cef6a5fcd52e6fb7c3890c2b58120fbbb757e5fd2e29249aebbc033489f3ab837726b04ec23f7e492f76b6c530", 4);
    }
}
