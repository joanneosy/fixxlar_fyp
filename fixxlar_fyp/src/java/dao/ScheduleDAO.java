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
import entity.Schedule;
import entity.Vehicle;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
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
public class ScheduleDAO {

    private final String USER_AGENT = "Mozilla/5.0";

    public String addSchedule(int staffId, String token, int shopId, String startTime, String endTime, int all_day) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/schedule/add_schedule";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", shopId + ""));
        urlParameters.add(new BasicNameValuePair("start_time", startTime));
        urlParameters.add(new BasicNameValuePair("end_time", endTime));
        urlParameters.add(new BasicNameValuePair("title", "Blocked"));
        urlParameters.add(new BasicNameValuePair("all_day", all_day + ""));

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
    
    public String deleteSchedule(int staffId, String token, int scheduleId) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/schedule/delete_schedule";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("schedule_id", scheduleId + ""));
  
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
    
    public HashMap<Integer, Schedule> retrieveSchedule(int staffId, String token, int shopId, int month, int year) throws UnsupportedEncodingException, IOException, ParseException {
        HashMap<Integer, Schedule> monthlySchedule = new HashMap<Integer, Schedule>();
        String url = "http://119.81.43.85/erp/schedule/retrieve_schedule";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", shopId + ""));
        urlParameters.add(new BasicNameValuePair("month", month + ""));
        urlParameters.add(new BasicNameValuePair("year", year + ""));

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("schedule");
                
        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject obj = qrElement.getAsJsonObject();
            JsonElement attElement = obj.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = obj.get("service_id");
            int serviceId = 0;
            if (!attElement.isJsonNull()) {
                serviceId = attElement.getAsInt();
            }

            attElement = obj.get("start_time");
            Timestamp startTime = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            startTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                startTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = obj.get("end_time");
            Timestamp endTime = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            endTime = new java.sql.Timestamp(parsedDate.getTime());
            if (!attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                endTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            Schedule schedule = new Schedule(id, serviceId, shopId, startTime, endTime);
            monthlySchedule.put(i, schedule);
        }
        return monthlySchedule;
    }
    
    public static void main (String[] args) throws IOException, UnsupportedEncodingException, ParseException {
        //addSchedule(2, "21737ff401f203f41bd2f47aa5cb7344571871cd7dbff5e6428ae36a20373e171be09d46502d4850dd31a3b5eb7416a135de74ee6b27456a66bd70618b38ce3fc5ce6718962284577158112fecae73203866cac519df39da7cc28e1be1c7c0bf0e0a136dcc2c7bff0067db97d5c59c2a386a1fb19e979ed629064fbbcdb9c9ddd46b990f0e2c3c5da8399d7030842f5fc64baf6bab7c5acb8f928b32482eb6da388b051f939abb7fbec7faa6934c15d5abc25247307d574b2f915c590eb26dd20beef843ae0b3a7015ad0b1e24afc2b1532052601717990239b9fb2f0a5d13bcb43824dbf764f438fc8bf9f79ce714cb787910759a54f2ecbc2eac90494d925414d78764282f111d1cb8effcb879bfe4ab5de3c7083cf1359c1c302bf6b9b8d79fe0478678d11debf1b32983f4519487b29fb422d9c8286d5e59f2bd8a8b27ff9c73a61128d48c9db480f12015e0a654cbf83c5dd787a7e8e3cdf3226e1189408518a6a4120db4f6f23aae2d5090ade34839e4be86973df4019fe61f565f3cc6ddfb8ad6c9cd244b8602aef5c2fb614727ba0bce777d8616f69f80751bc95b66e814eb4a246c7f6cecd8f902a9c9ca7d9a38a24187058fa5aeca3e29d3e319893d69561f9ae7b7e29c8803d42d6e8042ac263cc1e156399fb5c9d8213d32b88ec1f208c6e29d83770d4506eb4111b1cdc6835e16bf6ffd26cc4ea6e6be4d6914", 1, "2016-09-16 15:00:00", "2016-09-16 17:00:00");
        //retrieveSchedule(2, "21737ff401f203f41bd2f47aa5cb7344571871cd7dbff5e6428ae36a20373e171be09d46502d4850dd31a3b5eb7416a135de74ee6b27456a66bd70618b38ce3fc5ce6718962284577158112fecae73203866cac519df39da7cc28e1be1c7c0bf0e0a136dcc2c7bff0067db97d5c59c2a386a1fb19e979ed629064fbbcdb9c9ddd46b990f0e2c3c5da8399d7030842f5fc64baf6bab7c5acb8f928b32482eb6da388b051f939abb7fbec7faa6934c15d5abc25247307d574b2f915c590eb26dd20beef843ae0b3a7015ad0b1e24afc2b1532052601717990239b9fb2f0a5d13bcb43824dbf764f438fc8bf9f79ce714cb787910759a54f2ecbc2eac90494d925414d78764282f111d1cb8effcb879bfe4ab5de3c7083cf1359c1c302bf6b9b8d79fe0478678d11debf1b32983f4519487b29fb422d9c8286d5e59f2bd8a8b27ff9c73a61128d48c9db480f12015e0a654cbf83c5dd787a7e8e3cdf3226e1189408518a6a4120db4f6f23aae2d5090ade34839e4be86973df4019fe61f565f3cc6ddfb8ad6c9cd244b8602aef5c2fb614727ba0bce777d8616f69f80751bc95b66e814eb4a246c7f6cecd8f902a9c9ca7d9a38a24187058fa5aeca3e29d3e319893d69561f9ae7b7e29c8803d42d6e8042ac263cc1e156399fb5c9d8213d32b88ec1f208c6e29d83770d4506eb4111b1cdc6835e16bf6ffd26cc4ea6e6be4d6914", 1, 12, 2016);
        //deleteSchedule(2, "21737ff401f203f41bd2f47aa5cb7344571871cd7dbff5e6428ae36a20373e171be09d46502d4850dd31a3b5eb7416a135de74ee6b27456a66bd70618b38ce3fc5ce6718962284577158112fecae73203866cac519df39da7cc28e1be1c7c0bf0e0a136dcc2c7bff0067db97d5c59c2a386a1fb19e979ed629064fbbcdb9c9ddd46b990f0e2c3c5da8399d7030842f5fc64baf6bab7c5acb8f928b32482eb6da388b051f939abb7fbec7faa6934c15d5abc25247307d574b2f915c590eb26dd20beef843ae0b3a7015ad0b1e24afc2b1532052601717990239b9fb2f0a5d13bcb43824dbf764f438fc8bf9f79ce714cb787910759a54f2ecbc2eac90494d925414d78764282f111d1cb8effcb879bfe4ab5de3c7083cf1359c1c302bf6b9b8d79fe0478678d11debf1b32983f4519487b29fb422d9c8286d5e59f2bd8a8b27ff9c73a61128d48c9db480f12015e0a654cbf83c5dd787a7e8e3cdf3226e1189408518a6a4120db4f6f23aae2d5090ade34839e4be86973df4019fe61f565f3cc6ddfb8ad6c9cd244b8602aef5c2fb614727ba0bce777d8616f69f80751bc95b66e814eb4a246c7f6cecd8f902a9c9ca7d9a38a24187058fa5aeca3e29d3e319893d69561f9ae7b7e29c8803d42d6e8042ac263cc1e156399fb5c9d8213d32b88ec1f208c6e29d83770d4506eb4111b1cdc6835e16bf6ffd26cc4ea6e6be4d6914", 1);
    }
}
