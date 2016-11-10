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
import entity.Offer;
import entity.QuotationRequest;
import entity.Vehicle;
import entity.Workshop;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
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
public class QuotationRequestDAO {

    private final String USER_AGENT = "Mozilla/5.0";

    public HashMap<Integer, Integer> retrieveStatusSize(int staffId, String token, int givenWsId, int givenStatus,
            String givenCarModel, String orderBy, String order) throws SQLException, UnsupportedEncodingException, IOException, ParseException {
        HashMap<Integer, Integer> statusSize = new HashMap<Integer, Integer>();
        int statusArr[] = {1, 3, 5, 9, 6, 8};
        for (int i = 0; i < statusArr.length; i++) {
            int sta = statusArr[i];
            String url = "http://119.81.43.85/erp/quotation_request/get_quotation_request_info";

            HttpClient client = new DefaultHttpClient();
            HttpPost post = new HttpPost(url);
            List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
            urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
            urlParameters.add(new BasicNameValuePair("token", token));
            urlParameters.add(new BasicNameValuePair("workshop_id", givenWsId + ""));
            urlParameters.add(new BasicNameValuePair("status", sta + ""));
            urlParameters.add(new BasicNameValuePair("order_by", orderBy));
            urlParameters.add(new BasicNameValuePair("asc_of_desc", order));
            urlParameters.add(new BasicNameValuePair("car_model", givenCarModel));
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
            JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("quotation_request_info");
            int arrSize = arr.size();
            statusSize.put(i, arrSize);//To be changed to the status
        }
        return statusSize;
    }

    //Retrieve a service using the service ID. If called by admin, it can contain more than one if more than one workshops gave offers. 
    public HashMap<Integer, QuotationRequest> retrieveQuotationRequest(int staffId, String token, int givenID) throws SQLException, ParseException, UnsupportedEncodingException, IOException {
        HashMap<Integer, QuotationRequest> allQuotationRequests = new HashMap<Integer, QuotationRequest>();
        String url = "http://119.81.43.85/erp/quotation_request/get_quotation_request_info_by_service_id";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("service_id", givenID + ""));

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("quotation_request_info");
        int arrSize = arr.size();
        if (arrSize > 20) {
            arrSize = 20;
        }
        for (int i = 0; i < arrSize; i++) {
//        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("service_id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = qrObj.get("service_name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = qrObj.get("service_details");
            String details = "";
            if (!attElement.isJsonNull()) {
                details = attElement.getAsString();
            }
            attElement = qrObj.get("service_description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = qrObj.get("service_mileage");
            String mileage = "";
            if (!attElement.isJsonNull()) {
                mileage = attElement.getAsString();
            }

            attElement = qrObj.get("service_urgency");
            String urgency = "";
            if (!attElement.isJsonNull()) {
                urgency = attElement.getAsString();
            }

            attElement = qrObj.get("service_address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }

            attElement = qrObj.get("service_longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("service_latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("service_amenities");
            String amenities = "";
            if (!attElement.isJsonNull()) {
                amenities = attElement.getAsString();
            }

            attElement = qrObj.get("service_photos");
            String photos = "";
            if (!attElement.isJsonNull()) {
                photos = attElement.getAsString();
            }

            attElement = qrObj.get("offer_id");
            int offerId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerId = attElement.getAsInt();
            }

            attElement = qrObj.get("offer_status");
            int offerStatus = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerStatus = attElement.getAsInt();
            }

            attElement = qrObj.get("quotation_min_price");
            double initialMinPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                initialMinPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("quotation_max_price");
            double initialMaxPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                initialMaxPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("diagnostic_price");
            double diagnosticPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                diagnosticPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("offer_final_price");
            double finalQuotationPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                finalQuotationPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("driver_initial_comment");
            String driverInitialComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                driverInitialComment = attElement.getAsString();
            }
            attElement = qrObj.get("ws_initial_comment");
            String wsInitialComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                wsInitialComment = attElement.getAsString();
            }
            attElement = qrObj.get("ws_final_comment");
            String wsFinalComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                wsFinalComment = attElement.getAsString();
            }

            attElement = qrObj.get("offer_est_complete_time");
            Timestamp estCompletionDateTime = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("requested_datetime");
            Timestamp requestDateTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            requestDateTime = new java.sql.Timestamp(parsedDate.getTime());
            if (!attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                requestDateTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("shop_id");
            int wsId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                wsId = attElement.getAsInt();
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

            attElement = qrObj.get("owner_nric");
            String ownerNric = "";
            if (attElement != null && !attElement.isJsonNull()) {
                ownerNric = attElement.getAsString();
            }
            
            attElement = qrObj.get("chassis_num");
            String chassisNum = "";
            if (attElement != null && !attElement.isJsonNull()) {
                chassisNum = attElement.getAsString();
            }

            attElement = qrObj.get("customer_mobile_number");
            String customerHpNo = "";
            if (!attElement.isJsonNull()) {
                customerHpNo = attElement.getAsString();
            }

            attElement = qrObj.get("service_category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }

            attElement = qrObj.get("service_rejection_times");
            int noOfRejections = 0;
            if (!attElement.isJsonNull()) {
                noOfRejections = attElement.getAsInt();
            }

            attElement = qrObj.get("chat_topic_id");
            int chatTopicId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                chatTopicId = attElement.getAsInt();
            }
            Vehicle vehicle = new Vehicle(vehicleId, carMake, carModel, carYear, carPlate, customerId, carColor, carControl, ownerNric,chassisNum);
            Customer customer = new Customer(customerId, customerEmail, customerName, customerHpNo);
            Offer offer = new Offer(offerId, id, wsId, offerStatus, initialMinPrice, initialMaxPrice, diagnosticPrice, finalQuotationPrice, estCompletionDateTime, wsInitialComment, wsFinalComment, driverInitialComment);

            QuotationRequest qr = new QuotationRequest(id, name, details, description, vehicle, mileage, urgency, amenities, latitude, longitude, address, photos,
                    requestDateTime, category, noOfRejections, wsId, customer, offer, chatTopicId);
            allQuotationRequests.put(i, qr);
        }
        return allQuotationRequests;
    }

    //Assuming get new requests first
    //Default: 1-4 status
    //Workshop: won't show cancelled request at all
    //Will only show cancelled request to Fixir admin
    public HashMap<Integer, QuotationRequest> retrieveAllQuotationRequests(int staffId, String token, int givenWsId, int givenStatus, String orderBy, String order) throws SQLException, UnsupportedEncodingException, IOException, ParseException {

        HashMap<Integer, QuotationRequest> allQuotationRequests = new HashMap<Integer, QuotationRequest>();
        String url = "http://119.81.43.85/erp/quotation_request/get_quotation_request_info";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("workshop_id", givenWsId + ""));
        urlParameters.add(new BasicNameValuePair("status", givenStatus + ""));
        urlParameters.add(new BasicNameValuePair("order_by", orderBy));
        urlParameters.add(new BasicNameValuePair("asc_of_desc", order));

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("quotation_request_info");
        int arrSize = arr.size();
        if (arrSize > 20) {
            arrSize = 20;
        }
        for (int i = 0; i < arrSize; i++) {
//        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("service_id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = qrObj.get("service_name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = qrObj.get("service_details");
            String details = "";
            if (!attElement.isJsonNull()) {
                details = attElement.getAsString();
            }
            attElement = qrObj.get("service_description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = qrObj.get("service_mileage");
            String mileage = "";
            if (!attElement.isJsonNull()) {
                mileage = attElement.getAsString();
            }

            attElement = qrObj.get("service_urgency");
            String urgency = "";
            if (!attElement.isJsonNull()) {
                urgency = attElement.getAsString();
            }

            attElement = qrObj.get("service_address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }

            attElement = qrObj.get("service_longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("service_latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("service_amenities");
            String amenities = "";
            if (!attElement.isJsonNull()) {
                amenities = attElement.getAsString();
            }

            attElement = qrObj.get("service_photos");
            String photos = "";
            if (!attElement.isJsonNull()) {
                photos = attElement.getAsString();
            }

            attElement = qrObj.get("offer_id");
            int offerId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerId = attElement.getAsInt();
            }

            attElement = qrObj.get("offer_status");
            int offerStatus = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerStatus = attElement.getAsInt();
            }

            attElement = qrObj.get("quotation_min_price");
            double initialMinPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                initialMinPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("quotation_max_price");
            double initialMaxPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                initialMaxPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("diagnostic_price");
            double diagnosticPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                diagnosticPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("offer_final_price");
            double finalQuotationPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                finalQuotationPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("driver_initial_comment");
            String driverInitialComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                driverInitialComment = attElement.getAsString();
            }
            attElement = qrObj.get("ws_initial_comment");
            String wsInitialComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                wsInitialComment = attElement.getAsString();
            }
            attElement = qrObj.get("ws_final_comment");
            String wsFinalComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                wsFinalComment = attElement.getAsString();
            }

            attElement = qrObj.get("offer_est_complete_time");
            Timestamp estCompletionDateTime = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("requested_datetime");
            Timestamp requestDateTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            requestDateTime = new java.sql.Timestamp(parsedDate.getTime());
            if (!attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                requestDateTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("shop_id");
            int wsId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                wsId = attElement.getAsInt();
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

            attElement = qrObj.get("owner_nric");
            String ownerNric = "";
            if (attElement != null && !attElement.isJsonNull()) {
                ownerNric = attElement.getAsString();
            }

            attElement = qrObj.get("chassis_num");
            String chassisNum = "";
            if (attElement != null && !attElement.isJsonNull()) {
                chassisNum = attElement.getAsString();
            }

            attElement = qrObj.get("customer_mobile_number");
            String customerHpNo = "";
            if (!attElement.isJsonNull()) {
                customerHpNo = attElement.getAsString();
            }

            attElement = qrObj.get("service_category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }

            attElement = qrObj.get("service_rejection_times");
            int noOfRejections = 0;
            if (!attElement.isJsonNull()) {
                noOfRejections = attElement.getAsInt();
            }

            attElement = qrObj.get("chat_topic_id");
            int chatTopicId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                chatTopicId = attElement.getAsInt();
            }

            Vehicle vehicle = new Vehicle(vehicleId, carMake, carModel, carYear, carPlate, customerId, carColor, carControl, ownerNric, chassisNum);
            Customer customer = new Customer(customerId, customerEmail, customerName, customerHpNo);
            Offer offer = new Offer(offerId, id, wsId, offerStatus, initialMinPrice, initialMaxPrice, diagnosticPrice, finalQuotationPrice, estCompletionDateTime, wsInitialComment, wsFinalComment, driverInitialComment);

            QuotationRequest qr = new QuotationRequest(id, name, details, description, vehicle, mileage, urgency, amenities, latitude, longitude, address, photos,
                    requestDateTime, category, noOfRejections, wsId, customer, offer, chatTopicId);
            allQuotationRequests.put(i, qr);
        }
        return allQuotationRequests;
    }

    public String completeService(int staffId, String token, int offerId) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/quotation_request/complete_service";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("offer_id", offerId + ""));

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

    public String addInitialQuotation(int staffId, String token, int quotationRequestId, int workshopId, double minPrice, double maxPrice, String description) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/quotation_request/save_offer";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("service_id", quotationRequestId + ""));
        urlParameters.add(new BasicNameValuePair("min_price", minPrice + ""));
        urlParameters.add(new BasicNameValuePair("max_price", maxPrice + ""));
        urlParameters.add(new BasicNameValuePair("description", description));
        urlParameters.add(new BasicNameValuePair("shop_id", workshopId + ""));

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

    public String addDiagnosticPrice(int staffId, String token, int quotationRequestId, int workshopId, double price, String description) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/quotation_request/save_offer";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("service_id", quotationRequestId + ""));
        urlParameters.add(new BasicNameValuePair("diagnostic_price", price + ""));
        urlParameters.add(new BasicNameValuePair("shop_id", workshopId + ""));
        urlParameters.add(new BasicNameValuePair("description", description));

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

    public String addFinalQuotation(int staffId, String token, int offerId, double price) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/quotation_request/add_final_quotation";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("final_quotation", price + ""));
        urlParameters.add(new BasicNameValuePair("offer_id", offerId + ""));

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

    public String addEstimatedCompletionTime(int staffId, String token, int offerId, String time) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/quotation_request/update_estimated_completion_time";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("offer_id", offerId + ""));
        urlParameters.add(new BasicNameValuePair("estimated_completion_time", time));

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

    public Offer retrieveOffer(int staffId, String token, int offerId) throws SQLException, ParseException, UnsupportedEncodingException, IOException {
        Offer offer = null;
        String url = "http://119.81.43.85/quotation_request/retrieve_min_max_quotation_or_diagnostic_price";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("offer_id", offerId + ""));

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
            return offer;
        }

        oObj = oElement.getAsJsonObject();
        JsonElement attElement = oObj.get("service_id");
        int serviceId = 0;
        if (!attElement.isJsonNull()) {
            serviceId = attElement.getAsInt();
        }

        attElement = oObj.get("est_complete_time");
        Timestamp estCompletionDateTime = null;
        String dateTimeString = "1990-01-01 00:00:00";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Date parsedDate = dateFormat.parse(dateTimeString);
        estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
        if (attElement != null && !attElement.isJsonNull()) {
            dateTimeString = attElement.getAsString();
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
        }

        attElement = oObj.get("final_price");
        double finalPrice = 0.0;
        if (!attElement.isJsonNull()) {
            finalPrice = attElement.getAsDouble();
        }

        attElement = oObj.get("offer_status");
        int status = 0;
        if (!attElement.isJsonNull()) {
            status = attElement.getAsInt();
        }

        attElement = oObj.get("shop_id");
        int wsId = 0;
        if (!attElement.isJsonNull()) {
            wsId = attElement.getAsInt();
        }

        attElement = oObj.get("min_price");
        double initialMinPrice = 0.0;
        if (attElement != null && !attElement.isJsonNull()) {
            initialMinPrice = attElement.getAsDouble();
        }

        attElement = oObj.get("max_price");
        double initialMaxPrice = 0.0;
        if (attElement != null && !attElement.isJsonNull()) {
            initialMaxPrice = attElement.getAsDouble();
        }

        attElement = oObj.get("diagnostic_price");
        double diagnosticPrice = 0.0;
        if (attElement != null && !attElement.isJsonNull()) {
            diagnosticPrice = attElement.getAsDouble();
        }
        attElement = oObj.get("driver_initial_comment");
        String driverInitialComment = "";
        if (attElement != null && !attElement.isJsonNull()) {
            driverInitialComment = attElement.getAsString();
        }
        attElement = oObj.get("ws_initial_comment");
        String wsInitialComment = "";
        if (attElement != null && !attElement.isJsonNull()) {
            wsInitialComment = attElement.getAsString();
        }
        attElement = oObj.get("ws_final_comment");
        String wsFinalComment = "";
        if (attElement != null && !attElement.isJsonNull()) {
            wsFinalComment = attElement.getAsString();
        }

        offer = new Offer(offerId, serviceId, wsId, status, initialMinPrice, initialMaxPrice, diagnosticPrice, finalPrice, estCompletionDateTime, wsInitialComment, wsFinalComment, driverInitialComment);
        return offer;

    }

    public HashMap<Integer, QuotationRequest> retrieveQuotationRequestsWithoutOffer(int staffId, String token) throws SQLException, UnsupportedEncodingException, IOException, ParseException {

        HashMap<Integer, QuotationRequest> allQuotationRequests = new HashMap<Integer, QuotationRequest>();
        String url = "http://119.81.43.85/erp/quotation_request/get_request_quotation_without_offer";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("quotation_request_info");
        int arrSize = arr.size();
        if (arrSize > 20) {
            arrSize = 20;
        }
        for (int i = 0; i < arrSize; i++) {
//        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("service_id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }

            attElement = qrObj.get("service_name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = qrObj.get("service_details");
            String details = "";
            if (!attElement.isJsonNull()) {
                details = attElement.getAsString();
            }
            attElement = qrObj.get("service_description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = qrObj.get("service_mileage");
            String mileage = "";
            if (!attElement.isJsonNull()) {
                mileage = attElement.getAsString();
            }

            attElement = qrObj.get("service_urgency");
            String urgency = "";
            if (!attElement.isJsonNull()) {
                urgency = attElement.getAsString();
            }

            attElement = qrObj.get("service_address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }

            attElement = qrObj.get("service_longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("service_latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("service_amenities");
            String amenities = "";
            if (!attElement.isJsonNull()) {
                amenities = attElement.getAsString();
            }

            attElement = qrObj.get("service_photos");
            String photos = "";
            if (!attElement.isJsonNull()) {
                photos = attElement.getAsString();
            }

            attElement = qrObj.get("offer_id");
            int offerId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerId = attElement.getAsInt();
            }

            attElement = qrObj.get("offer_status");
            int offerStatus = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerStatus = attElement.getAsInt();
            }

            attElement = qrObj.get("quotation_min_price");
            double initialMinPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                initialMinPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("quotation_max_price");
            double initialMaxPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                initialMaxPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("diagnostic_price");
            double diagnosticPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                diagnosticPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("offer_final_price");
            double finalQuotationPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                finalQuotationPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("offer_est_complete_time");
            Timestamp estCompletionDateTime = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("requested_datetime");
            Timestamp requestDateTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            requestDateTime = new java.sql.Timestamp(parsedDate.getTime());
            if (!attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                requestDateTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("shop_id");
            int wsId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                wsId = attElement.getAsInt();
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

            attElement = qrObj.get("owner_nric");
            String ownerNric = "";
            if (attElement != null && !attElement.isJsonNull()) {
                ownerNric = attElement.getAsString();
            }
            
            attElement = qrObj.get("chassis_num");
            String chassisNum = "";
            if (attElement != null && !attElement.isJsonNull()) {
                chassisNum = attElement.getAsString();
            }

            attElement = qrObj.get("customer_mobile_number");
            String customerHpNo = "";
            if (!attElement.isJsonNull()) {
                customerHpNo = attElement.getAsString();
            }

            attElement = qrObj.get("service_category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }

            attElement = qrObj.get("service_rejection_times");
            int noOfRejections = 0;
            if (!attElement.isJsonNull()) {
                noOfRejections = attElement.getAsInt();
            }

            attElement = qrObj.get("chat_topic_id");
            int chatTopicId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                chatTopicId = attElement.getAsInt();
            }
            attElement = qrObj.get("driver_initial_comment");
            String driverInitialComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                driverInitialComment = attElement.getAsString();
            }
            attElement = qrObj.get("ws_initial_comment");
            String wsInitialComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                wsInitialComment = attElement.getAsString();
            }
            attElement = qrObj.get("ws_final_comment");
            String wsFinalComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                wsFinalComment = attElement.getAsString();
            }

            Vehicle vehicle = new Vehicle(vehicleId, carMake, carModel, carYear, carPlate, customerId, carColor, carControl, ownerNric, chassisNum);
            Customer customer = new Customer(customerId, customerEmail, customerName, customerHpNo);
            Offer offer = new Offer(offerId, id, wsId, offerStatus, initialMinPrice, initialMaxPrice, diagnosticPrice, finalQuotationPrice, estCompletionDateTime, wsInitialComment, wsFinalComment, driverInitialComment);

            QuotationRequest qr = new QuotationRequest(id, name, details, description, vehicle, mileage, urgency, amenities, latitude, longitude, address, photos,
                    requestDateTime, category, noOfRejections, wsId, customer, offer, chatTopicId);
            allQuotationRequests.put(i, qr);
        }
        return allQuotationRequests;
    }

    public HashMap<Integer, QuotationRequest> retrieveCompletedQuotationRequests(int staffId, String token) throws SQLException, UnsupportedEncodingException, IOException, ParseException {

        HashMap<Integer, QuotationRequest> allQuotationRequests = new HashMap<Integer, QuotationRequest>();
        String url = "http://119.81.43.85/erp/quotation_request/get_completed_quotation_request";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("quotation_request_info");
        int arrSize = arr.size();
        if (arrSize > 20) {
            arrSize = 20;
        }
        for (int i = 0; i < arrSize; i++) {
//        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("service_id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = qrObj.get("service_name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = qrObj.get("service_details");
            String details = "";
            if (!attElement.isJsonNull()) {
                details = attElement.getAsString();
            }
            attElement = qrObj.get("service_description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = qrObj.get("service_mileage");
            String mileage = "";
            if (!attElement.isJsonNull()) {
                mileage = attElement.getAsString();
            }

            attElement = qrObj.get("service_urgency");
            String urgency = "";
            if (!attElement.isJsonNull()) {
                urgency = attElement.getAsString();
            }

            attElement = qrObj.get("service_address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }

            attElement = qrObj.get("service_longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("service_latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }

            attElement = qrObj.get("service_amenities");
            String amenities = "";
            if (!attElement.isJsonNull()) {
                amenities = attElement.getAsString();
            }

            attElement = qrObj.get("service_photos");
            String photos = "";
            if (!attElement.isJsonNull()) {
                photos = attElement.getAsString();
            }

            attElement = qrObj.get("offer_id");
            int offerId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerId = attElement.getAsInt();
            }

            attElement = qrObj.get("offer_status");
            int offerStatus = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerStatus = attElement.getAsInt();
            }

            attElement = qrObj.get("quotation_min_price");
            double initialMinPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                initialMinPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("quotation_max_price");
            double initialMaxPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                initialMaxPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("diagnostic_price");
            double diagnosticPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                diagnosticPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("offer_final_price");
            double finalQuotationPrice = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                finalQuotationPrice = attElement.getAsDouble();
            }

            attElement = qrObj.get("offer_est_complete_time");
            Timestamp estCompletionDateTime = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                estCompletionDateTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("requested_datetime");
            Timestamp requestDateTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            requestDateTime = new java.sql.Timestamp(parsedDate.getTime());
            if (!attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                requestDateTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = qrObj.get("shop_id");
            int wsId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                wsId = attElement.getAsInt();
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

            attElement = qrObj.get("owner_nric");
            String ownerNric = "";
            if (attElement != null && !attElement.isJsonNull()) {
                ownerNric = attElement.getAsString();
            }

            attElement = qrObj.get("chassis_num");
            String chassisNum = "";
            if (attElement != null && !attElement.isJsonNull()) {
                chassisNum = attElement.getAsString();
            }
            
            attElement = qrObj.get("customer_mobile_number");
            String customerHpNo = "";
            if (!attElement.isJsonNull()) {
                customerHpNo = attElement.getAsString();
            }

            attElement = qrObj.get("service_category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }

            attElement = qrObj.get("service_rejection_times");
            int noOfRejections = 0;
            if (!attElement.isJsonNull()) {
                noOfRejections = attElement.getAsInt();
            }

            attElement = qrObj.get("chat_topic_id");
            int chatTopicId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                chatTopicId = attElement.getAsInt();
            }
            attElement = qrObj.get("driver_initial_comment");
            String driverInitialComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                driverInitialComment = attElement.getAsString();
            }
            attElement = qrObj.get("ws_initial_comment");
            String wsInitialComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                wsInitialComment = attElement.getAsString();
            }
            attElement = qrObj.get("ws_final_comment");
            String wsFinalComment = "";
            if (attElement != null && !attElement.isJsonNull()) {
                wsFinalComment = attElement.getAsString();
            }
            Vehicle vehicle = new Vehicle(vehicleId, carMake, carModel, carYear, carPlate, customerId, carColor, carControl, ownerNric,chassisNum);
            Customer customer = new Customer(customerId, customerEmail, customerName, customerHpNo);
            Offer offer = new Offer(offerId, id, wsId, offerStatus, initialMinPrice, initialMaxPrice, diagnosticPrice, finalQuotationPrice, estCompletionDateTime, wsInitialComment, wsFinalComment, driverInitialComment);

            QuotationRequest qr = new QuotationRequest(id, name, details, description, vehicle, mileage, urgency, amenities, latitude, longitude, address, photos,
                    requestDateTime, category, noOfRejections, wsId, customer, offer, chatTopicId);
            allQuotationRequests.put(i, qr);
        }
        return allQuotationRequests;
    }

    public HashMap<Integer, Integer> retrieveNumberOfNewRequests(int staffId, String token) throws SQLException, UnsupportedEncodingException, IOException, ParseException {

        //Key = Shop Id
        //Value = Number of new request that shop has
        HashMap<Integer, Integer> numberOfNewRequests = new HashMap<Integer, Integer>();
        String url = "http://119.81.43.85/erp/quotation_request/get_number_of_new_or_completed_requests";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("status", 1 + ""));

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("number_of_quotation_request");

        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("shop_id");
            int shopId = 0;
            if (!attElement.isJsonNull()) {
                shopId = attElement.getAsInt();
            }

            attElement = qrObj.get("num_new_requests");
            int number = 0;
            if (!attElement.isJsonNull()) {
                number = attElement.getAsInt();
            }

            numberOfNewRequests.put(shopId, number);
        }
        return numberOfNewRequests;
    }

    public HashMap<Integer, Integer> retrieveNumberOfCompletedRequests(int staffId, String token) throws SQLException, UnsupportedEncodingException, IOException, ParseException {

        //Key = Shop Id
        //Value = Number of new request that shop has
        HashMap<Integer, Integer> numberOfNewRequests = new HashMap<Integer, Integer>();
        String url = "http://119.81.43.85/erp/quotation_request/get_number_of_new_or_completed_requests";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("status", 7 + ""));

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("number_of_quotation_request");

        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("shop_id");
            int shopId = 0;
            if (!attElement.isJsonNull()) {
                shopId = attElement.getAsInt();
            }

            attElement = qrObj.get("num_completed_requests");
            int number = 0;
            if (!attElement.isJsonNull()) {
                number = attElement.getAsInt();
            }

            numberOfNewRequests.put(shopId, number);
        }
        return numberOfNewRequests;
    }

    public static void main(String[] args) throws Exception {
        //HashMap<Integer, QuotationRequest> qList = retrieveAllQuotationRequests(3, "57cd00bbfaf886f8fe9fc98e15ee3bb0b31663a18f752de76cd998d71fe983be2b2f2a3de0f41ab8f69f3d19ab29b78c1b957578f5e7679e112de86fd1841da08c48d0a674fa001c3a2fe1e161c76edc6ce950b080c9a876034b3dfeabf826efacc3fde2d5542e8d4ccb90fd0163cb76371b7159546fd7d652d31abd73c235b290d4d62e2c31a8a00704432fae9a60e9f04eb4338698e0b2d5183d8cd4a4671ac1bc1d0ae79792bc21c8a1cd902d841a8fb6e8d0197cbccb3fd6f92456d9a361b940c0ff1affe7149e458fac8d7b0783e095d0dc4c82b86930e9fa378b4ffe1f15ce963d80291a7bc1c69ee0d63fb8b1d613d5feb3820b6c1a86cf7ab95d1340d8974f4acdf8e6ce9b426565d4f14b348c80787b4f24e95f9cd625f2a50e28d5118b364c362ae096623208881a9cc9f2161a422bac6d4d8e968f7b26093837d95b17352f417d0a061138438242a2cf6dd32e736bad691912e3d2701fc17a84a855a3aeb57969ad875a656e80206f10677818967ecd6942ea5463d1e3f188b84bc54c781ca85a3dceb76da8a17d9728fb0eb94b51ecd96787f11abefc7fb0e6f80307402b8d8e00920d8a48b566dbf1ad84b0487bb67863a31d122c86084ae08b891252fad4fe7df17c76cf419f33e2fb760968ac9e112567188c0b163961ef708e1fbb9059de5d7fa1f7f20da40123d5311fd308fcee95f36a3a4991b814ef3b", 0, 0, null, "requested_datetime", "desc");
        //retrieveOffer(20, "bfa5334a57318d381e35ca9cd6c41f12cf504f6458e0f6799f62a946459def5f73f3490ba6577c61b4ea9bb69cc020ef8d37bc98ca12c57b757babf71b1d1b337729275e333b20f19a8738eca93bef992c49912d1943e599b5b5a1f33ad2d31dc6daa4f706d44760abd86764701d46b8c0e09ed0929977e41e41c62223c3267db510a9d8ff69994474d438dbee3d13d52bad3f65272b802f3cd54b9ef6da8d6c6d24a00cb263aa58e50fac2479d95f9664b1c31bfe1b0f640d3621f84f7642fefc28c0fe0c5069cbf37bf73e7e1a970a01374d3412cce1668e060af58fa02081a3ec9ba1bfe50d5a87ce82c5b30848b6c5026ba4839ab00e7fdd7e350691b323603ce4b511b5f4e7657361287d1a208ee8bf169b26db5a8419c54ca22428416ab28b95074192be54d4685b6acdaba8d1d8ceffff8c3afd565c929424faaca62f27d0e00acbd46cba910f274facfd511ed7acab33a5bb81dc622e10f43ce64f6394549535d58fb40271558f07c5b0e054121fa2382dafa2993ee393e6a2cc2693f5d11c88890bab3020f11a3e20c49fe040173b948d07cc0b76439a4a2966a59962268fb556a8deb4009333b4b0c327751430463097ca0d5231b0803c950bfb534291c57688306e4fc891b060b0a81bebc7261cf6618108f807a6685a785d72f13b086373d412218e4468bab6078c998d5f6ec3867330934c39e497d58850c5ec", 59);
        //retrieveAllQuotationRequests(2, "bf21ecf4c451bcd1a93a160678ce50f2917b72e975157b6b00f6964b16198163ce2577bc96fafe85eeb14c06bf11c800da2ea87f4a9e5584cae33ca750426bcf5e6ac8a957fe0fe58aea108b2f908f3b9e3af2c18092116326aefe4e2470d2f5eafcbb3508ae2261f11ad86235e0536f674eb09edd60ad4f223953529661786a83604c62fe02f2cb5b30acbd93e1e72eb464da60ac4fbb35d1c3443f03912a74bcffecd9cd12e0d65a11f83b3b32848dab825e785bc1e8df6959e61ef0d065a1a1e7352cb2b95bb22dff9a3c58d54561046d2552119ac471e5947093a27eda01b300e236301e5e9a7cf17cea294beedec39fbfeea3e5b97fce839617e67c91471e8b36cd65be45dc70d3fb8c9ab96eb3a12d0cb6e49bb3c07fdd387e41060b542027a620e404f015f459eef8210047cde25714446dea170a69f77f64c40d12b8ada773f79c8ad58bf01dc648e12c56d852e74c0f2be5e22fcd30b7ddc0c7807a2e919d2d3244b5593a507ce9cea41cf62ceaf861079550d580ae83b3396416cbd08a9ec2b160fed8a755c68b0e6c3f86a214168ae886afe67161e126558cf8074e117d49a6e9fb2e855571769dd6618c695f205e34f14be3b946b68e43989fb091542b1944fe40d9fc350bef84a6e70192cf00dbfa9aa76810841be02f6c87285f7163adf760473794a05083fa2de1dc1e0917d49c416ef2e6b60bbabf2bd146", 1, 7, "", "");
        //retrieveQuotationRequestsWithoutOffer(29, "b2397f111518e143d1875ee5f8f5a4fd7d47383aeecddf3b3c43ff28d9bf54ac0ba628c2abcffe4b25226f1e5c9f68852c63ae941579665da5e6bcbeabb593f123210000747c7b22e959a940d29f1ee0a3623a7f17259223fe67d8a281400edb305090339efa8cdb611bb4b6aea366e1ff6a55127a3a468278841db2b104c7dbca6aebe9a2e5dcab697eeeb0259e8b298609c3300d3c96af0e3bc72b68e9f4e1d7ffcfcbe87a0c3b37ebc6fe0b48609bdee4e052e8839ea4a265b91ffafda9d160b88234f2608bab79c39b6b09cf498db2dda5c579fb2b853333d1d77d0a9ebd9b32a67ac143b2660cf42a4630223e88fd141aaaf218664164d5a6e6d9b234f0c5979c394c3e3b2e3795928b9a86243852fd1777909246374c7696aa3233ef53f526f85b02ff9bf7b6fc0ddd30508b05b775ffa576be425924dcc048211a9fa247b0b18eac39096bc10c68cb08b6d47fd6e71fa2e1534a94c35f833d8b6c55002494332f38dfebd4d4d10f1011793f64c76a7b46d2e3ddf8a1bc1593e6ec1e95cf0a175a434a6a69d25fe8abd7b682198b438d38e62f5b7a67c2f1fafb77d83a8b7c3ee2711821b62de37f68efff029c42a72ebdbf016cea8ad020a5cfa95e638791f4286a6f117f03c1d1e72a760d5de37b581c73063c9f2b7d0bb99efde8e29cc7886dacac160fb1252ae48da48d54c29eef3c8a75992b8f495d1219af452a");
        //retrieveCompletedQuotationRequests(1, "125ec4bb60d3718c7fa212e7242714dfcac0c49a344b6b89373c21d321fe252c4d504406bb825503bc9fadc3bcd2d809d446ef29cdbdb88c344a211c03445eb5ba08cec06f6431d6a5a322e36d2c61a3e8f585af4563f77766b89658b7b7004fcaf6ed66efb11e000861a814770e45f892baf7d5b0169634387d31ed8f46a2dc9c25325aba1da930dd66307e29dfc023ffe37597e8332fe89376dc955cf2e1a422e9dbeae51b23451f6087703be4f0c023d5926ea5bfccf64bc17e068f2b80e652c62bf78dec49501a62dcfae19d66765932940ad5876cc9910b7841f3ef5735a32c52709913eaca01180f299d89974c0f5c2d7dedbf4721a5b43605d416ec2f6a0bf5ff4f825b3269950d5039955b6e4de322772a31b516141515161aa8d52ed38f1e432912e7215e6b2eecb2d3137276ff33b0f59583eb3ad5d1d8036de7dbe8cfa8501506f5534b08c3551ae8774363e5990661363bfc1fe8a74467add5694f43f73e4d09a396ac5b856ea5bff7528ff2a777136e233636b146952d3dc62c0d1b4b6e1d3e878eaf4e130f601b4b147852b9ab2502f9235109f93bbd7d135963df0fff5a4fa2e6e9f25c0e46796b3acea1a292eda83e4df8e1038d9ea810ac0c2e23f94bad28e1c6e9b620ed32728fbbfe4c435759247b21504ecad7791a55978106173a800cc5d0a5ac72fb6c5b5a2cd0fc5b9e73064ad1f1f7c503440f34");
    }
}
