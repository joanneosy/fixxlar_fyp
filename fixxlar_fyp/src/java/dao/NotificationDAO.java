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
import entity.Notification;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.ArrayList;
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
public class NotificationDAO {

    private static final String USER_AGENT = "Mozilla/5.0";

    public HashMap<Integer, Notification> retrieveNotificationsByShop(int staffId, String token, int shopId) throws UnsupportedEncodingException, IOException, ParseException {
        HashMap<Integer, Notification> notifications = new HashMap<Integer, Notification>();
        String url = "http://119.81.43.85/erp/ws_notification/retrieve_notifications_by_shop";

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("notifications");

        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject obj = qrElement.getAsJsonObject();
            JsonElement attElement = obj.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }

            attElement = obj.get("staff_id");
            int notificationStaffId = 0;
            if (!attElement.isJsonNull()) {
                notificationStaffId = attElement.getAsInt();
            }

            attElement = obj.get("message_id");
            int messageId = 0;
            if (!attElement.isJsonNull()) {
                messageId = attElement.getAsInt();
            }

            attElement = obj.get("message");
            String predefinedMessage = "";
            if (!attElement.isJsonNull()) {
                predefinedMessage = attElement.getAsString();
            }

            attElement = obj.get("actual_message");
            String actualMessage = "";
            if (!attElement.isJsonNull()) {
                actualMessage = attElement.getAsString();
            }
            Notification notification = new Notification(id, notificationStaffId, messageId, predefinedMessage, actualMessage);
            notifications.put(i, notification);
        }
        return notifications;
    }

    public String addNotification(int staffId, String token, int shopId, int messageId, String customizedMessage) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/ws_notification/add_notification";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", shopId + ""));
        urlParameters.add(new BasicNameValuePair("message_id", messageId + ""));
        urlParameters.add(new BasicNameValuePair("customized_message", customizedMessage));


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
        System.out.println(errMsg);
        return errMsg;
    }

    public HashMap<Integer, String> retrieveNotificationMessages(int staffId, String token) throws UnsupportedEncodingException, IOException, ParseException {
        HashMap<Integer, String> messages = new HashMap<Integer, String>();
        String url = "http://119.81.43.85/erp/ws_notification/retrieve_all_notification_messages";

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("notification_messages");

        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject obj = qrElement.getAsJsonObject();
            JsonElement attElement = obj.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }

            attElement = obj.get("message");
            String message = "";
            if (!attElement.isJsonNull()) {
                message = attElement.getAsString();
            }
            messages.put(id, message);
        }
        return messages;
    }

    public static void main(String[] args) throws ParseException, IOException {
        //addNotification(1,"8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c",1,1);
        //retrieveNotificationsByShop(2,"6ee59f20efb2d3e46227f496a9d51a6ddcb7d7f040a3b8834ea10e5a6888a21654e43cf00d743643a9097b4176148471310293d14202be0bcb1a5f1a548e4295efa720a24f01c52b47125f72eada41209b3fe4b6af239848b0966b459d52a5b20e6ad293f6941eafa4cc8c7b7bc240f660ffaf7196d1afe58608a158233b5bdbef52efdc1af8bb53de96591bdd9884ec3680d21cb158a43cf91562d65f5855114a2a2844626e70040dcf3b11919a4420cad0850005e422c52e2e8271a6d95364d8a809ba38291d4cff68fc5490787179450358e983a5ed9f23b93e70c8f139ef62e2512ab8e60c487701ec5dcb7dc3af42c8a187c07072b395c2f5fa286e2be11858ac859a5711a98417a90e6da482f3d3ef672f5301a9889b1d8b778a1876fc96b0e5da4b0df11e666ee4832343df46d7b4ceac644a91a6700830559174e4518491239120536a541b75bcc41f3ce10fb328b1ff3f95bdb46d3dc3b811cc7fbc4f94bdaa891ac96c30936634cb1fae656c609de6c1daf5df68191de02b2b058cbdd78be4369609ec1eae823644374b1633bdfe9ca5303ae6bb5bb6179758282fd4435445235d03eb5f9008bd113c21615c206f268045004b5f7b4e58fd0144b5cf71aea5b51341cec4abc8e33487bb52346e910904abc78c7c91f30399b8de0007f64fa390112eebbe33a06d956ccf344c7c6e98d2421a6d247273a972bb63fc",1);
        //retrieveNotificationMessages(1, "8cb6851ca519e9de55d52fd43aeca61160466249be970930c5cd6d1602f83c24944a8f624eab70e14373b2798bef97ae4692af3b7e4bf4a2627b8320c97795927be296f2765e65958d374e422dc5d6c4fa2f800204b9bf4917e8c2f2e2aef0163b86f1e13b8dbf5b0edfe6d15f903b64214b0a303a4c58451888b9be433d784aa3ee35aeb23a21c68a19227c9210f9daf4acce73954f4ee2fe8c17e3abce98c44ec44312fb27154dbe49864204742eff92536284173858bf1251ec9004c7b43d29ffa345b7d848404f8c6fb2a954ac3fe9fd4cd20fe8f128f62602dadcd6b9a7cb165bed14e7fe5458e4b974c3bbe8521f329ec3fffc3b90f2bb6047faf1bac0909f8c1695156c8993235f95449dba7aa390e8e706a2557a883337c6dcf386db291f8ff0e7b96162ad47b26285939d98b265da40aafe523540b92d46f0312b2f093942336909f35b5608affb91699b66d58c49c0aec3c0bdccbae852f3a4d04c03ae0dcc1e2d3b49ef7f810bf95c4dda33da8c8e8796e1568f833227b81dfd6efadc166b25d4d21e0ec6ecda67f9c8810d55c259597d448e2e2ae2b3b9865cc5f678ec42f45bb0b43aa2961565f87c931f77eaa09adbbba22d08f9912905587bad36793ef2e2688c1d10472daf3c36f0ba356050757acba53bb166aa8ebcb798ecf0fbd5bf6569d648cecb1546317c78f053da836bd2c4f1a0ad2d073713ca1c");
    }
}
