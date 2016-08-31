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
import entity.Chat;
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
import static org.apache.http.HttpHeaders.USER_AGENT;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

/**
 *
 * @author User
 */
public class ChatDAO {

    private HashMap<Integer, Integer> subscribedChat;

    public ChatDAO() {
        subscribedChat = new HashMap<Integer, Integer>();
    }

    public HashMap<Integer, Chat> getChatList(int staffId, String token) throws UnsupportedEncodingException, IOException, ParseException {
        HashMap<Integer, Chat> chatList = new HashMap<Integer, Chat>();
        //Add URL here
        String url = "http://119.81.43.85/chat/retrive_chat_list_history";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        //Add parameters here
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
        JsonObject jobj2 = jobj.getAsJsonObject("payload");
        JsonObject jobj3 = jobj2.getAsJsonObject("chat_history_list_result");
        JsonArray arr = jobj3.getAsJsonArray("generalList");
        int arrSize = arr.size();
        for (int i = 0; i < arrSize; i++) {
//        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = qrObj.get("service_id");
            int service_id = 0;
            if (!attElement.isJsonNull()) {
                service_id = attElement.getAsInt();
            }
            attElement = qrObj.get("user_id");
            int user_id = 0;
            if (!attElement.isJsonNull()) {
                user_id = attElement.getAsInt();
            }
            attElement = qrObj.get("shop_id");
            int shop_id = 0;
            if (!attElement.isJsonNull()) {
                shop_id = attElement.getAsInt();
            }
            attElement = qrObj.get("last_message");
            String last_message = "";
            if (!attElement.isJsonNull()) {
                last_message = attElement.getAsString();
            }
            attElement = qrObj.get("modified");
            Timestamp modified = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            modified = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                modified = new java.sql.Timestamp(parsedDate.getTime());
            }
            attElement = qrObj.get("created");
            Timestamp created = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            created = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                created = new java.sql.Timestamp(parsedDate.getTime());
            }
            attElement = qrObj.get("deleted_at");
            Timestamp deleted_at = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            deleted_at = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                deleted_at = new java.sql.Timestamp(parsedDate.getTime());
            }
            attElement = qrObj.get("user_name");
            String user_name = "";
            if (!attElement.isJsonNull()) {
                user_name = attElement.getAsString();
            }

            Chat chat = new Chat(id, service_id, user_id, shop_id, last_message, modified, created, deleted_at, user_name);
            chatList.put(i, chat);
        }
        return chatList;
    }

    public HashMap<Integer, Chat> getRequestChatHistory(int staffID, String token, int driverID, int serviceID) throws UnsupportedEncodingException, IOException, ParseException {
        HashMap<Integer, Chat> chatList = new HashMap<Integer, Chat>();
        //Add URL here
        String url = "http://119.81.43.85/chat/retrive_chat_history";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        //Add parameters here
        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffID + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("driver_id", driverID + ""));
        urlParameters.add(new BasicNameValuePair("service_id", serviceID + ""));
        urlParameters.add(new BasicNameValuePair("type_of_message", "2"));

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
        JsonObject jobj2 = jobj.getAsJsonObject("payload");
        JsonArray arr = jobj.getAsJsonArray("chat_message");
        int arrSize = arr.size();
        for (int i = 0; i < arrSize; i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject qrObj = qrElement.getAsJsonObject();
            JsonElement attElement = qrObj.get("id");

            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = qrObj.get("topic_id");
            int topic_id = 0;
            if (!attElement.isJsonNull()) {
                topic_id = attElement.getAsInt();
            }
            attElement = qrObj.get("message");
            String message = "";
            if (!attElement.isJsonNull()) {
                message = attElement.getAsString();
            }
            attElement = qrObj.get("type");
            int type = 0;
            if (!attElement.isJsonNull()) {
                type = attElement.getAsInt();
            }
            attElement = qrObj.get("modified");
            Timestamp modified = null;
            String dateTimeString = "1990-01-01 00:00:00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            modified = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                modified = new java.sql.Timestamp(parsedDate.getTime());
            }
            attElement = qrObj.get("created");
            Timestamp created = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            created = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                created = new java.sql.Timestamp(parsedDate.getTime());
            }
            attElement = qrObj.get("deleted_at");
            Timestamp deleted_at = null;
            dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            parsedDate = dateFormat.parse(dateTimeString);
            deleted_at = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                deleted_at = new java.sql.Timestamp(parsedDate.getTime());
            }
            Chat chat = new Chat(id, topic_id, message, type, modified, created, deleted_at);
            chatList.put(i, chat);
        }

        return chatList;

    }

}
