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
import entity.ValetShop;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.w3c.dom.Document;

/**
 *
 * @author Joanne
 */
public class ValetShopDAO {

    private final String USER_AGENT = "Mozilla/5.0";

    public String addShop(int staffId, String token, String name, String address, String email, double latitude, double longitude, int noOfEmployees, double revenueShare, String openingHours,String openingHourFormat) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/valet_shop/add_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("address", address));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("latitude", latitude + ""));
        urlParameters.add(new BasicNameValuePair("longitude", longitude + ""));
        urlParameters.add(new BasicNameValuePair("no_of_employees", noOfEmployees + ""));
        urlParameters.add(new BasicNameValuePair("revenue_share", revenueShare + ""));
        urlParameters.add(new BasicNameValuePair("opening_hours", openingHourFormat));
        urlParameters.add(new BasicNameValuePair("opening_hours_display", openingHours));

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

    public ValetShop retrieveValetShop(int staffId, String token, int givenID) throws IOException {
        ValetShop vs = null;
        String url = "http://119.81.43.85/erp/valet_shop/get_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", givenID + ""));

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

        JsonElement shopElement = jobj.get("payload");
        JsonObject shop = null;
        if (shopElement.isJsonNull()) {
            return vs;
        } else {
            shop = shopElement.getAsJsonObject().getAsJsonObject("valet_shop");
            JsonElement attElement = shop.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = shop.get("name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = shop.get("address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }
            attElement = shop.get("email");
            String email = "";
            if (!attElement.isJsonNull()) {
                email = attElement.getAsString();
            }
            attElement = shop.get("latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }
            attElement = shop.get("longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }
            attElement = shop.get("no_of_employee");
            int noOfEmployees = 0;
            if (!attElement.isJsonNull()) {
                noOfEmployees = attElement.getAsInt();
            }
            attElement = shop.get("revenue_share");
            double revenueShare = 0;
            if (!attElement.isJsonNull()) {
                revenueShare = attElement.getAsDouble();
            }
            attElement = shop.get("opening_hours");
            String openingHours = "";
            if (!attElement.isJsonNull()) {
                openingHours = attElement.getAsString();
            }
            attElement = shop.get("opening_hours_display");
            String openingHoursDisplay = "";
            if (!attElement.isJsonNull()) {
                openingHoursDisplay = attElement.getAsString();
            }
            
            attElement = shop.get("contact_person");
            String contactPerson = "";
            if (!attElement.isJsonNull()) {
                contactPerson = attElement.getAsString();
            }
            
            attElement = shop.get("contact_number");
            String contactNumber = "";
            if (!attElement.isJsonNull()) {
                contactNumber = attElement.getAsString();
            }
            vs = new ValetShop(id, name, address, email, latitude, longitude, noOfEmployees, revenueShare, openingHours,openingHoursDisplay, contactPerson, contactNumber);
        }
        return vs;
    }

    public ValetShop retrieveValetShop(int staffId, String token, String email) throws IOException {
        ValetShop vs = null;
        String url = "http://119.81.43.85/erp/valet_shop/get_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("email", email));

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

        JsonElement shopElement = jobj.get("payload");
        JsonObject shop = null;
        if (shopElement.isJsonNull()) {
            return vs;
        } else {
            shop = shopElement.getAsJsonObject().getAsJsonObject("valet_shop");
            JsonElement attElement = shop.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = shop.get("name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = shop.get("address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }
//            attElement = shop.get("email");
//            String email = "";
//            if (!attElement.isJsonNull()) {
//                email = attElement.getAsString();
//            }
            attElement = shop.get("latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }
            attElement = shop.get("longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }
            attElement = shop.get("no_of_employee");
            int noOfEmployees = 0;
            if (!attElement.isJsonNull()) {
                noOfEmployees = attElement.getAsInt();
            }
            attElement = shop.get("revenue_share");
            double revenueShare = 0;
            if (!attElement.isJsonNull()) {
                revenueShare = attElement.getAsDouble();
            }
            attElement = shop.get("opening_hours");
            String openingHours = "";
            if (!attElement.isJsonNull()) {
                openingHours = attElement.getAsString();
            }
            attElement = shop.get("opening_hours_display");
            String openingHoursDisplay = "";
            if (!attElement.isJsonNull()) {
                openingHoursDisplay = attElement.getAsString();
            }
            
            attElement = shop.get("contact_person");
            String contactPerson = "";
            if (!attElement.isJsonNull()) {
                contactPerson = attElement.getAsString();
            }
            
            attElement = shop.get("contact_number");
            String contactNumber = "";
            if (!attElement.isJsonNull()) {
                contactNumber = attElement.getAsString();
            }
            System.out.println(name);
            vs = new ValetShop(id, name, address, email, latitude, longitude, noOfEmployees, revenueShare, openingHours,openingHoursDisplay, contactPerson, contactNumber);
        }
        return vs;
    }
    
    public ArrayList<ValetShop> retrieveAllValetShops(int staffId, String token) throws IOException {
        ArrayList<ValetShop> shops = new ArrayList<ValetShop>();
        String url = "http://119.81.43.85/erp/valet_shop/get_all_shops";

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
        JsonArray arr = (jobj.getAsJsonObject("payload")).getAsJsonArray("valet_shops");

        for (int i = 0; i < arr.size(); i++) {
            JsonElement ele = arr.get(i);
            JsonObject shop = ele.getAsJsonObject();
            JsonElement attElement = shop.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = shop.get("name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = shop.get("address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }
            attElement = shop.get("email");
            String email = "";
            if (!attElement.isJsonNull()) {
                email = attElement.getAsString();
            }
            attElement = shop.get("latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }
            attElement = shop.get("longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }
            attElement = shop.get("no_of_employee");
            int noOfEmployees = 0;
            if (!attElement.isJsonNull()) {
                noOfEmployees = attElement.getAsInt();
            }
            attElement = shop.get("revenue_share");
            double revenueShare = 0;
            if (!attElement.isJsonNull()) {
                revenueShare = attElement.getAsDouble();
            }
            attElement = shop.get("opening_hours");
            String openingHours = "";
            if (!attElement.isJsonNull()) {
                openingHours = attElement.getAsString();
            }
            attElement = shop.get("opening_hours_display");
            String openingHoursDisplay = "";
            if (!attElement.isJsonNull()) {
                openingHoursDisplay = attElement.getAsString();
            }
            
            attElement = shop.get("contact_person");
            String contactPerson = "";
            if (!attElement.isJsonNull()) {
                contactPerson = attElement.getAsString();
            }
            
            attElement = shop.get("contact_number");
            String contactNumber = "";
            if (!attElement.isJsonNull()) {
                contactNumber = attElement.getAsString();
            }
            ValetShop vs = new ValetShop(id, name, address, email, latitude, longitude, noOfEmployees, revenueShare, openingHours,openingHoursDisplay, contactPerson, contactNumber);
            shops.add(vs);
        }
        return shops;
    }

    public ArrayList<String> updateValetShop(int staffId, String token, int id, String name, String address, String email, double latitude, double longitude, int noOfEmployees, double revenueShare, String openingHours, String openingHourFormat) throws UnsupportedEncodingException, IOException {

        String url = "http://119.81.43.85/erp/valet_shop/edit_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", id + ""));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("address", address));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("opening_hours", openingHourFormat));
        urlParameters.add(new BasicNameValuePair("opening_hours_display", openingHours));
        urlParameters.add(new BasicNameValuePair("latitude", latitude + ""));
        urlParameters.add(new BasicNameValuePair("longitude", longitude + ""));
        urlParameters.add(new BasicNameValuePair("no_of_employees", noOfEmployees + ""));
        urlParameters.add(new BasicNameValuePair("revenue_share", revenueShare + ""));

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
        String errorMessage = null;
        ArrayList<String> errors = new ArrayList<String>();
        JsonElement isSuccess = jobj.get("is_success");
        if (isSuccess.getAsString().equals("false")) {
            errorMessage = jobj.get("error_message").getAsString();
            errors.add(errorMessage);
            JsonElement fields = jobj.get("payload");
            JsonArray arr;
            if (!fields.isJsonNull()) {
                arr = fields.getAsJsonObject().get("error_field").getAsJsonArray();

                for (int i = 0; i < arr.size(); i++) {
                    String f = arr.get(i).getAsString();
                    errors.add(f);
                }
            }
        }

        return errors;
    }

    public String deleteValetShop(int staffId, String token, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/valet_shop/delete_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", id + ""));

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

    public String[] retrieveLatLong(String address) throws Exception {
        int responseCode = 0;
        String api = "http://maps.googleapis.com/maps/api/geocode/xml?address=" + URLEncoder.encode(address, "UTF-8") + "&sensor=true";
        URL url = new URL(api);
        HttpURLConnection httpConnection = (HttpURLConnection) url.openConnection();
        httpConnection.connect();
        responseCode = httpConnection.getResponseCode();
        if (responseCode == 200) {
            DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();;
            Document document = builder.parse(httpConnection.getInputStream());
            XPathFactory xPathfactory = XPathFactory.newInstance();
            XPath xpath = xPathfactory.newXPath();
            XPathExpression expr = xpath.compile("/GeocodeResponse/status");
            String status = (String) expr.evaluate(document, XPathConstants.STRING);
            if (status.equals("OK")) {
                expr = xpath.compile("//geometry/location/lat");
                String latitude = (String) expr.evaluate(document, XPathConstants.STRING);
                expr = xpath.compile("//geometry/location/lng");
                String longitude = (String) expr.evaluate(document, XPathConstants.STRING);
                return new String[]{latitude, longitude};
            } else {
                return null;
            }
        }
        return null;
    }

    public static void main (String[] args) throws IOException {
//        //addShop(1,"8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c","Test2","Blk 123 ABC", 1.338915, 103.899519, 3, 0.5, "Monday-0900-1800,Tuesday-0900-1800,Wednesday-0900-1800,Thursday-0900-1800,Friday-0900-1800,Saturday-0900-1400,Sunday-Closed-Closed,Ph-Closed-Closed");
//        retrieveValetShop(1, "8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c", "shop12@shop.com");
//        //retrieveAllValetShops(1, "8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c");
//        //updateValetShop(1,"8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c",3, "Test234","Blk 123 ABC", 1.338915, 103.899519, 3, 0.5, "Monday-0900-1800,Tuesday-0900-1800,Wednesday-0900-1800,Thursday-0900-1800,Friday-0900-1800,Saturday-0900-1400,Sunday-Closed-Closed,Ph-Closed-Closed");
//        //retrieveValetShop(1, "8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c", 3);
//        //deleteValetShop(1,"8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c", 3);
//        //retrieveValetShop(1, "8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c", 3);
    }
}
