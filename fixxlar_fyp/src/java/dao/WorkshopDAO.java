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
import entity.CarBrand;
import entity.Workshop;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
 * @author Fixxlar
 */
public class WorkshopDAO {

    private static final String USER_AGENT = "Mozilla/5.0";

    public Workshop retrieveWorkshop(String givenEmail, int staffId, String token) throws UnsupportedEncodingException, IOException {
        Workshop ws = null;
        String url = "http://119.81.43.85/erp/workshop/get_shop_by_id_or_email";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);
        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("email", givenEmail));

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
            return ws;
        } else {
            shop = shopElement.getAsJsonObject().getAsJsonObject("shop");
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
            attElement = shop.get("email");
            String email = "";
            if (!attElement.isJsonNull()) {
                email = attElement.getAsString();
            }
            attElement = shop.get("description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = shop.get("website");
            String website = "";
            if (!attElement.isJsonNull()) {
                website = attElement.getAsString();
            }
            attElement = shop.get("address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_full");
            String openingHour = "";
            if (!attElement.isJsonNull()) {
                openingHour = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_format");
            String openingHourFormat = "";
            if (!attElement.isJsonNull()) {
                openingHourFormat = attElement.getAsString();
            }

            attElement = shop.get("opening_hour_format2");
            String openingHourFormat2 = "";
            if (!attElement.isJsonNull()) {
                openingHourFormat2 = attElement.getAsString();
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
            attElement = shop.get("contact");
            String contact = "";
            if (!attElement.isJsonNull()) {
                contact = attElement.getAsString();
            }
            attElement = shop.get("contact2");
            String contact2 = "";
            if (!attElement.isJsonNull()) {
                contact2 = attElement.getAsString();
            }
            attElement = shop.get("location");
            String location = "";
            if (!attElement.isJsonNull()) {
                location = attElement.getAsString();
            }
            attElement = shop.get("specialize");
            String specialize = "";
            if (!attElement.isJsonNull()) {
                specialize = attElement.getAsString();
            }
            attElement = shop.get("category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }
            attElement = shop.get("brand_carried");
            String brandsCarried = "";
            if (!attElement.isJsonNull()) {
                brandsCarried = attElement.getAsString();
            }
            attElement = shop.get("remark");
            String remark = "";
            if (!attElement.isJsonNull()) {
                remark = attElement.getAsString();
            }
            attElement = shop.get("status");
            int status = 0;
            if (!attElement.isJsonNull()) {
                status = attElement.getAsInt();
            }
            ws = new Workshop(id, email, name, description, website, address, openingHour, openingHourFormat, openingHourFormat2,
                    latitude, longitude, contact, contact2, location, specialize, category, brandsCarried, remark, status);
        }
        return ws;
    }

    public Workshop retrieveWorkshop(int givenID, int staffId, String token) throws IOException {
        Workshop ws = null;
        String url = "http://119.81.43.85/erp/workshop/get_shop_by_id_or_email";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", givenID + ""));

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
            return ws;
        } else {
            shop = shopElement.getAsJsonObject().getAsJsonObject("shop");
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
            attElement = shop.get("email");
            String email = "";
            if (!attElement.isJsonNull()) {
                email = attElement.getAsString();
            }
            attElement = shop.get("description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = shop.get("website");
            String website = "";
            if (!attElement.isJsonNull()) {
                website = attElement.getAsString();
            }
            attElement = shop.get("address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_full");
            String openingHour = "";
            if (!attElement.isJsonNull()) {
                openingHour = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_format");
            String openingHourFormat = "";
            if (!attElement.isJsonNull()) {
                openingHourFormat = attElement.getAsString();
            }

            attElement = shop.get("opening_hour_format2");
            String openingHourFormat2 = "";
            if (!attElement.isJsonNull()) {
                openingHourFormat2 = attElement.getAsString();
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
            attElement = shop.get("contact");
            String contact = "";
            if (!attElement.isJsonNull()) {
                contact = attElement.getAsString();
            }
            attElement = shop.get("contact2");
            String contact2 = "";
            if (!attElement.isJsonNull()) {
                contact2 = attElement.getAsString();
            }
            attElement = shop.get("location");
            String location = "";
            if (!attElement.isJsonNull()) {
                location = attElement.getAsString();
            }
            attElement = shop.get("specialize");
            String specialize = "";
            if (!attElement.isJsonNull()) {
                specialize = attElement.getAsString();
            }
            attElement = shop.get("category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }
            attElement = shop.get("brand_carried");
            String brandsCarried = "";
            if (!attElement.isJsonNull()) {
                brandsCarried = attElement.getAsString();
            }
            attElement = shop.get("remark");
            String remark = "";
            if (!attElement.isJsonNull()) {
                remark = attElement.getAsString();
            }
            attElement = shop.get("status");
            int status = 0;
            if (!attElement.isJsonNull()) {
                status = attElement.getAsInt();
            }
            ws = new Workshop(id, email, name, description, website, address, openingHour, openingHourFormat, openingHourFormat2,
                    latitude, longitude, contact, contact2, location, specialize, category, brandsCarried, remark, status);
        }
        return ws;
    }

    public ArrayList<String> addWorkshop(String email, String name, String description, String website, String address, String openingHour, String openingHourFormat, String openingHourFormat2, double latitude,
            double longitude, String contact, String contact2, String location, String specialize, String category, String brandsCarried,
            String remark, int staffId, String token, String staffName, String staffEmail, String hpNo, String password) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/workshop/add_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("description", description));
        urlParameters.add(new BasicNameValuePair("website", website));
        urlParameters.add(new BasicNameValuePair("address", address));
        urlParameters.add(new BasicNameValuePair("opening_hour_full", openingHour));
        urlParameters.add(new BasicNameValuePair("opening_hour_format", openingHourFormat));
        urlParameters.add(new BasicNameValuePair("opening_hour_format2", openingHourFormat2));
        urlParameters.add(new BasicNameValuePair("latitude", latitude + ""));
        urlParameters.add(new BasicNameValuePair("longitude", longitude + ""));
        urlParameters.add(new BasicNameValuePair("contact", contact));
        urlParameters.add(new BasicNameValuePair("contact2", contact2));
        urlParameters.add(new BasicNameValuePair("location", location));
        urlParameters.add(new BasicNameValuePair("specialize", specialize));
        urlParameters.add(new BasicNameValuePair("category", category));
        urlParameters.add(new BasicNameValuePair("brand_carried", brandsCarried));
        urlParameters.add(new BasicNameValuePair("remark", remark));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("status", 1 + ""));
        urlParameters.add(new BasicNameValuePair("staff_name", staffName));
        urlParameters.add(new BasicNameValuePair("staff_email", staffEmail));
        urlParameters.add(new BasicNameValuePair("handphone", hpNo));
        urlParameters.add(new BasicNameValuePair("password", password));

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
            if (!fields.isJsonNull()) {
                JsonArray arr = fields.getAsJsonObject().get("error_field").getAsJsonArray();
                for (int i = 0; i < arr.size(); i++) {
                    String f = arr.get(i).getAsString();
                    errors.add(f);
                }
            }
        }

        return errors;

    }

    public ArrayList<Workshop> retrieveAllWorkshops(int staffId, String token) throws UnsupportedEncodingException, IOException {
        ArrayList<Workshop> allWorkshops = new ArrayList<Workshop>();
        String url = "http://119.81.43.85/erp/workshop/get_all_shop";

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
        JsonArray arr = (jobj.getAsJsonObject("payload")).getAsJsonArray("shops");

        for (int i = 0; i < arr.size(); i++) {
            JsonElement workshop = arr.get(i);
            JsonObject shop = workshop.getAsJsonObject();
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
            attElement = shop.get("email");
            String email = "";
            if (!attElement.isJsonNull()) {
                email = attElement.getAsString();
            }
            attElement = shop.get("description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = shop.get("website");
            String website = "";
            if (!attElement.isJsonNull()) {
                website = attElement.getAsString();
            }
            attElement = shop.get("address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_full");
            String openingHour = "";
            if (!attElement.isJsonNull()) {
                openingHour = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_format");
            String openingHourFormat = "";
            if (!attElement.isJsonNull()) {
                openingHourFormat = attElement.getAsString();
            }

            attElement = shop.get("opening_hour_format2");
            String openingHourFormat2 = "";
            if (!attElement.isJsonNull()) {
                openingHourFormat2 = attElement.getAsString();
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
            attElement = shop.get("contact");
            String contact = "";
            if (!attElement.isJsonNull()) {
                contact = attElement.getAsString();
            }
            attElement = shop.get("contact2");
            String contact2 = "";
            if (!attElement.isJsonNull()) {
                contact2 = attElement.getAsString();
            }
            attElement = shop.get("location");
            String location = "";
            if (!attElement.isJsonNull()) {
                location = attElement.getAsString();
            }
            attElement = shop.get("specialize");
            String specialize = "";
            if (!attElement.isJsonNull()) {
                specialize = attElement.getAsString();
            }
            attElement = shop.get("category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }
            attElement = shop.get("brand_carried");
            String brandsCarried = "";
            if (!attElement.isJsonNull()) {
                brandsCarried = attElement.getAsString();
            }
            attElement = shop.get("remark");
            String remark = "";
            if (!attElement.isJsonNull()) {
                remark = attElement.getAsString();
            }
            attElement = shop.get("status");
            int status = 0;
            if (!attElement.isJsonNull()) {
                status = attElement.getAsInt();
            }
            //int status = attElement.getAsInt();
            Workshop ws = new Workshop(id, email, name, description, website, address, openingHour, openingHourFormat, openingHourFormat2,
                    latitude, longitude, contact, contact2, location, specialize, category, brandsCarried, remark, status);

            allWorkshops.add(ws);
        }
        return allWorkshops;
    }

    public ArrayList<String> updateWorkshop(int id, String email, String name, String description, String website, String address, String openingHour, String openingHourFormat, String openingHourFormat2, double latitude,
            double longitude, String contact, String contact2, String location, String specialize, String category, String brandsCarried,
            String remark, int status, int staffId, String token) throws UnsupportedEncodingException, IOException {

        String url = "http://119.81.43.85/erp/workshop/edit_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("description", description));
        urlParameters.add(new BasicNameValuePair("website", website));
        urlParameters.add(new BasicNameValuePair("address", address));
        urlParameters.add(new BasicNameValuePair("opening_hour_full", openingHour));
        urlParameters.add(new BasicNameValuePair("opening_hour_format", openingHourFormat));
        urlParameters.add(new BasicNameValuePair("opening_hour_format2", openingHourFormat2));
        urlParameters.add(new BasicNameValuePair("latitude", latitude + ""));
        urlParameters.add(new BasicNameValuePair("longitude", longitude + ""));
        urlParameters.add(new BasicNameValuePair("contact", contact));
        urlParameters.add(new BasicNameValuePair("contact2", contact2));
        urlParameters.add(new BasicNameValuePair("location", location));
        urlParameters.add(new BasicNameValuePair("specialize", specialize));
        urlParameters.add(new BasicNameValuePair("category", category));
        urlParameters.add(new BasicNameValuePair("brand_carried", brandsCarried));
        urlParameters.add(new BasicNameValuePair("remark", remark));
        urlParameters.add(new BasicNameValuePair("email", email));
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
        System.out.print(str);
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

    public ArrayList<String> retrieveAllCarBrands(int staffId, String token) throws UnsupportedEncodingException, IOException {
        ArrayList<String> carBrands = new ArrayList<String>();
        String url = "http://119.81.43.85/erp/avalible_car/get_all_avalible_car";

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

        JsonElement brandsElement = jobj.get("payload");
        JsonObject brands = null;
        if (brandsElement.isJsonNull()) {
            return carBrands;
        } else {
            brands = brandsElement.getAsJsonObject();
            JsonArray brandsArr = brands.getAsJsonArray("available_cars");
            for (int i = 0; i < brandsArr.size(); i++) {
                JsonElement brandArr = brandsArr.get(i);
                JsonObject brandObj = brandArr.getAsJsonObject();
                JsonElement attElement = brandObj.get("car_brand");
                String brand = "";
                if (!attElement.isJsonNull()) {
                    brand = attElement.getAsString();
                    if (!carBrands.contains(brand)) {
                        carBrands.add(brand);
                    }
                }

            }
        }
        return carBrands;
    }

    //Convert address to latitude and longitude 
    //Latitude = String[0]
    //Longitude = String[1]
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

    public String deleteWorkshop(int staffId, String token, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/workshop/delete_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));

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

    public static int retrieveServiceCapcity(int staffId, String token, int shopId) throws UnsupportedEncodingException, IOException {
        int serviceCapacity = 0;
        String url = "http://119.81.43.85/erp/workshop/get_service_capacity";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", shopId + ""));

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
        JsonObject obj = null;
        if (shopElement.isJsonNull()) {
            return serviceCapacity;
        } else {
            obj = shopElement.getAsJsonObject();
            JsonElement attElement = obj.get("service_capacity");
            if (attElement != null && !attElement.isJsonNull()) {
                serviceCapacity = attElement.getAsInt();
            }

        }
        return serviceCapacity;
    }

    public static String updateServiceCapcity(int staffId, String token, int shopId, int serviceCapacity) throws UnsupportedEncodingException, IOException {

        String url = "http://119.81.43.85/erp/workshop/update_service_capacity";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", shopId + ""));
        urlParameters.add(new BasicNameValuePair("service_capacity", serviceCapacity + ""));

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

    public static void main(String[] args) throws IOException {
        String openingHour = "Monday-0100-0300,Tuesday-0100-0300,Wednesday-0000-0200,Thursday-0100-0500,Friday-0100-0500,Saturday-Closed-Closed,Sunday-1600-1900,Ph-1600-1900,PhEve-Closed-Closed";
        ArrayList<String> compiled = new ArrayList<String>();
        //Monday-0900-1800
        String[] daysAndTime = openingHour.split(",");
        //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
        String[] openCloseTimings = daysAndTime[0].split("-");
        String dayToCompare = openCloseTimings[0];
        String openToCompare = openCloseTimings[1];
        String closeToCompare = openCloseTimings[2];
        String toAdd = dayToCompare + "-" + dayToCompare + "-" + openToCompare + "-" + closeToCompare;
        String closeDays = "";

        for (int i = 1; i < daysAndTime.length - 2; i++) {
            openCloseTimings = daysAndTime[i].split("-");
            if (openCloseTimings[1].equals(openToCompare) && openCloseTimings[2].equals(closeToCompare)) {
                String[] toAddArr = toAdd.split("-");
                toAdd = toAddArr[0] + "-" + openCloseTimings[0] + "-" + openToCompare + "-" + closeToCompare;
            } else {
                String[] toAddArr = toAdd.split("-");
                //Closed-Closed
                if (toAddArr[2].equals("Closed")) {
                    closeDays += "," + toAddArr[0];
                    //toAdd = "----";
                } else //Saturday-Saturday
                {
                    if (toAddArr[0].equals(toAddArr[1])) {
                        toAdd = toAddArr[0] + ":" + toAddArr[2] + "-" + toAddArr[3];
                    } else {
                        toAdd = toAddArr[0] + "-" + toAddArr[1] + ":" + toAddArr[2] + "-" + toAddArr[3];
                    }

                    System.out.println(toAdd);
                    compiled.add(toAdd);
                }
                dayToCompare = openCloseTimings[0];
                openToCompare = openCloseTimings[1];
                closeToCompare = openCloseTimings[2];
                toAdd = dayToCompare + "-" + dayToCompare + "-" + openToCompare + "-" + closeToCompare;
            }

            if (i == daysAndTime.length - 3) {
                String[] toAddArr = toAdd.split("-");
                //Closed-Closed
                if (toAddArr[2].equals("Closed")) {
                    //Saturday-Saturday
                    closeDays += "," + toAddArr[0];
                } else //Saturday-Saturday
                 if (toAddArr[0].equals(toAddArr[1])) {
                        toAdd = toAddArr[0] + ":" + toAddArr[2] + "-" + toAddArr[3];
                    } else {
                        toAdd = toAddArr[0] + "-" + toAddArr[1] + ":" + toAddArr[2] + "-" + toAddArr[3];
                    }
                //compiled.add(toAdd);
            }
        }

        for (int i = 7; i < 9; i++) {
            toAdd = "";
            openCloseTimings = daysAndTime[i].split("-");
            //Closed-Closed
            if (openCloseTimings[2].equals("Closed")) {
                closeDays += "," + openCloseTimings[0];
            } else {
                toAdd = openCloseTimings[0] + ":" + openCloseTimings[1] + "-" + openCloseTimings[2];
                compiled.add(toAdd);
            }
        }
        if (closeDays.length() != 0) {
            compiled.add(";" + closeDays.substring(1));
        }

        String openingHour2 = "";
        for (int i = 0; i < compiled.size(); i++) {
            String add = compiled.get(i);
            String addCheck = "";
            if (i == compiled.size() - 1) {
                addCheck = compiled.get(i);
            } else {
                addCheck = compiled.get(i + 1);
            }
            if (String.valueOf(addCheck.charAt(0)).equals(";")) {
                openingHour2 += add;
            } else {
                openingHour2 += add + ",";
            }
        }

        String lastChar = String.valueOf(openingHour2.charAt(openingHour2.length() - 1));
        if (lastChar.equals(",")) {
            openingHour2 = openingHour2.substring(0, openingHour2.length() - 1);
        }
        System.out.println(openingHour2);

//        String[] openingHoursArr = openingHour.split(",");
//        for (String s : openingHoursArr) {
//            String[] eachDayArr = s.split("-");
//            if (eachDayArr[1].equals("Closed") || eachDayArr[2].equals("Closed")) {
//                if (!eachDayArr[1].equals(eachDayArr[2])) {
//                    System.out.println("Invalid Opening Hours");
//                    break;
//                }
//            } else {
//                int open = Integer.parseInt(eachDayArr[1]);
//                int close = Integer.parseInt(eachDayArr[2]);
//                if (open > close) {
//                    System.out.println("Invalid Opening Hours");
//                    break;
//                }
//            }
//        }
    }
    //retrieveServiceCapcity(1, "a937e7120cb738c3a4d34802159d14252e6f93ad40bf2d86160bf9681b3a2424d12d7187b54d4f7aeff1018daf4f4ef4251351d1b6306f851207da1a05ae5bc58dcbaef7484ddb00072c9d01cb7441de5bcf5c4a38e54703e3ee9db81a81ac03a57ac0c9adfc67502a9527b2b3c2f45ce72b18012bafa93453697b1ee4f8f7c2d44d5c3e1d1d3c3911d1ad0e28a6397d23399227855a56876801422efadfecf0ab5338c9a897445d4c9a69270a6a4fc7d4422cc61d2eedc3d69cd7768f0f60f08c690ad22226e12f592d26ad5ed8a5554ed0b62b199d040f8b300120b63ba9909497358e88557dfdddb18caf08945d286196b6f8f627b30282946c1bde9f7c9ad6c807292183b8221279c0ebaeeb48449dd8163ee79ebeae77cefc1e4f8fd6116bba9d17942552d50cfdc7d1d27fdc7a2a93a2131c385416c43dd3d7e689a16b415d5c29dd8b425be5c9acd140b974483984ee2377efa2b15cb19ef82d55ea6a79b01e63a684c8ef7bf499a2fd04f4035f51d8f0cbcf32c53992401d3d3dbecc9c5109ae45832204686d25daaa67822bc42f1965e260e95c903e3c0563b51a785085538d9b925ab574ff0a27b710de5c05c73f011a0c81fbaa81f4aa98923ccf47fa9a4c07f4947fd240299dfea65ab355d9ad96dd5f765b5637a9d81ea6b247adeb4330968362a3c8995d6e6d03ef353cd6305c72a92a399ab51b6e85d86c44", 1);
    //updateServiceCapcity(1, "a937e7120cb738c3a4d34802159d14252e6f93ad40bf2d86160bf9681b3a2424d12d7187b54d4f7aeff1018daf4f4ef4251351d1b6306f851207da1a05ae5bc58dcbaef7484ddb00072c9d01cb7441de5bcf5c4a38e54703e3ee9db81a81ac03a57ac0c9adfc67502a9527b2b3c2f45ce72b18012bafa93453697b1ee4f8f7c2d44d5c3e1d1d3c3911d1ad0e28a6397d23399227855a56876801422efadfecf0ab5338c9a897445d4c9a69270a6a4fc7d4422cc61d2eedc3d69cd7768f0f60f08c690ad22226e12f592d26ad5ed8a5554ed0b62b199d040f8b300120b63ba9909497358e88557dfdddb18caf08945d286196b6f8f627b30282946c1bde9f7c9ad6c807292183b8221279c0ebaeeb48449dd8163ee79ebeae77cefc1e4f8fd6116bba9d17942552d50cfdc7d1d27fdc7a2a93a2131c385416c43dd3d7e689a16b415d5c29dd8b425be5c9acd140b974483984ee2377efa2b15cb19ef82d55ea6a79b01e63a684c8ef7bf499a2fd04f4035f51d8f0cbcf32c53992401d3d3dbecc9c5109ae45832204686d25daaa67822bc42f1965e260e95c903e3c0563b51a785085538d9b925ab574ff0a27b710de5c05c73f011a0c81fbaa81f4aa98923ccf47fa9a4c07f4947fd240299dfea65ab355d9ad96dd5f765b5637a9d81ea6b247adeb4330968362a3c8995d6e6d03ef353cd6305c72a92a399ab51b6e85d86c44", 999, 2);
}
