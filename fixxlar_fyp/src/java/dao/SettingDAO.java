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
import entity.Setting;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
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
public class SettingDAO {

    private final String USER_AGENT = "Mozilla/5.0";

    public Setting retrieveSettingById(int staffId, String token, int settingId) throws UnsupportedEncodingException, IOException, ParseException {
        Setting setting = null;
        String url = "http://119.81.43.85/erp/settings/retrieve_settings";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("setting_id", settingId + ""));

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
        JsonElement ele = jobj.get("payload");
        JsonObject obj = null;
        if (ele.isJsonNull()) {
            return setting;
        } else {
            obj = ele.getAsJsonObject().getAsJsonObject("setting");
            JsonElement attElement = obj.get("id");

            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }

            attElement = obj.get("category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }

            attElement = obj.get("name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }

            attElement = obj.get("value");
            String value = "";
            if (!attElement.isJsonNull()) {
                value = attElement.getAsString();
            }
            setting = new Setting(id, category, name, value);
            return setting;
        }
    }

    //String: Setting ID , Name of setting
    public ArrayList<Setting> retrieveAllSettings(int staffId, String token) throws UnsupportedEncodingException, IOException, ParseException {
        ArrayList<Setting> settings = new ArrayList<Setting>();
        String url = "http://119.81.43.85/erp/settings/retrieve_settings";

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
        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("settings");

        for (int i = 0; i < arr.size(); i++) {
            JsonElement qrElement = arr.get(i);
            JsonObject obj = qrElement.getAsJsonObject();

            JsonElement attElement = obj.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }

            attElement = obj.get("category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }

            attElement = obj.get("name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }

            attElement = obj.get("value");
            String value = "";
            if (!attElement.isJsonNull()) {
                value = attElement.getAsString();
            }
            Setting setting = new Setting(id, category, name, value);
            settings.add(setting);
        }
        return settings;
    }

    public String editSetting(int staffId, String token, int settingId, String value) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/settings/edit_setting";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("setting_id", settingId + ""));
        urlParameters.add(new BasicNameValuePair("value", value + ""));

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

    public String addSetting(int staffId, String token, String category, String name, String value) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/settings/add_setting";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("category", category));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("value", value + ""));

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

    public int retrieveServiceCapacity(int staffId, String token, int shopId) throws UnsupportedEncodingException, IOException, ParseException {
        HashMap<String, JsonObject> settings = new HashMap<String, JsonObject>();
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
//        JsonArray arr = jobj.getAsJsonObject("payload").getAsJsonArray("settings");
        JsonObject obj = jobj.getAsJsonObject("payload");
        JsonElement el = obj.get("service_capacity");
        int capacity = el.getAsInt();

        return capacity;
    }

    public String editServiceCapacity(int staffId, String token, int workshopId, int service_capacity) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/workshop/update_service_capacity";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", workshopId + ""));
        urlParameters.add(new BasicNameValuePair("service_capacity", service_capacity + ""));

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

    public static void main(String[] args) throws IOException, UnsupportedEncodingException, ParseException {
        JsonObject obj = new JsonObject();
        obj.addProperty("high", "10");
        obj.addProperty("medium", "5");
        obj.addProperty("low", "1");
        Map<String, Object> attributes = new HashMap<String, Object>();
        Set<Entry<String, JsonElement>> entrySet = obj.entrySet();
        for (Map.Entry<String, JsonElement> entry : entrySet) {
            System.out.println(entry.getKey());
            System.out.println(entry.getValue().toString());

        }
//        addSetting(1, "24de1d05aa5f2eeb7918a4e9b3a0bf6289f774f2f29df603e8436153d67687795dd011ba78d1c67f099561424990af65df46f8057f3e4cb3707ffe89668985801b0d8ec15e0255b7445e54b4cbdadfd4ab0089eaf914107e1cf01467cc03cbbf992c16fa7970f10bb71b58b4ec1b4b258ced529cf8899389591873ea0de02c796fcef006e14186e75b396129a12829d787cc1ae3a384922d4cbda55457bc05bc5b3a6fc5811be704d3120424832958b073f461599d6083bb10997c5e8b15e188308bf85bc325524add893a141e4bba040c4d2b6ab7d2ac0d9bcd9cb2ed1e0dd86e9310b2f2ff1de11864d68629a66912fe0e78a119921921a1f7788001e5cea1f25a00f47d351bbf04c1e5b0a23d6575525f51a0d0b6ec359d2644744e3a8818c814191c2c6de9e6de20a06e25a9a846ef1758c8be01f68de7fc4aa023f24c0f6d399b1826600255b69c2e7b8d673fed69b7178ea1f3664669be8f6c52a2573f747d23299158ecd3b490939a05c2511be8e60e355617c4e2f6caddb84eec1252b9ed49475393d6377b642aa70b2392dd6d62eb0467c64d29b2b129ea923383c9e8269864d3ac41dfabf78616cf99c41d24244e57f963437bb07fbf6f9602ddc581aa646948483e6afcfff990e8d256cad605eab555eb056ef3a5b5d9ece67b9e7413843400578b67b000eef0c4b1c0ceb80bf7d40c4e4897eb8d7b5dcca7b7aa", "urgency", obj);
//        retrieveAllSettings(1, "24de1d05aa5f2eeb7918a4e9b3a0bf6289f774f2f29df603e8436153d67687795dd011ba78d1c67f099561424990af65df46f8057f3e4cb3707ffe89668985801b0d8ec15e0255b7445e54b4cbdadfd4ab0089eaf914107e1cf01467cc03cbbf992c16fa7970f10bb71b58b4ec1b4b258ced529cf8899389591873ea0de02c796fcef006e14186e75b396129a12829d787cc1ae3a384922d4cbda55457bc05bc5b3a6fc5811be704d3120424832958b073f461599d6083bb10997c5e8b15e188308bf85bc325524add893a141e4bba040c4d2b6ab7d2ac0d9bcd9cb2ed1e0dd86e9310b2f2ff1de11864d68629a66912fe0e78a119921921a1f7788001e5cea1f25a00f47d351bbf04c1e5b0a23d6575525f51a0d0b6ec359d2644744e3a8818c814191c2c6de9e6de20a06e25a9a846ef1758c8be01f68de7fc4aa023f24c0f6d399b1826600255b69c2e7b8d673fed69b7178ea1f3664669be8f6c52a2573f747d23299158ecd3b490939a05c2511be8e60e355617c4e2f6caddb84eec1252b9ed49475393d6377b642aa70b2392dd6d62eb0467c64d29b2b129ea923383c9e8269864d3ac41dfabf78616cf99c41d24244e57f963437bb07fbf6f9602ddc581aa646948483e6afcfff990e8d256cad605eab555eb056ef3a5b5d9ece67b9e7413843400578b67b000eef0c4b1c0ceb80bf7d40c4e4897eb8d7b5dcca7b7aa");
//        retrieveSettingById(1, "24de1d05aa5f2eeb7918a4e9b3a0bf6289f774f2f29df603e8436153d67687795dd011ba78d1c67f099561424990af65df46f8057f3e4cb3707ffe89668985801b0d8ec15e0255b7445e54b4cbdadfd4ab0089eaf914107e1cf01467cc03cbbf992c16fa7970f10bb71b58b4ec1b4b258ced529cf8899389591873ea0de02c796fcef006e14186e75b396129a12829d787cc1ae3a384922d4cbda55457bc05bc5b3a6fc5811be704d3120424832958b073f461599d6083bb10997c5e8b15e188308bf85bc325524add893a141e4bba040c4d2b6ab7d2ac0d9bcd9cb2ed1e0dd86e9310b2f2ff1de11864d68629a66912fe0e78a119921921a1f7788001e5cea1f25a00f47d351bbf04c1e5b0a23d6575525f51a0d0b6ec359d2644744e3a8818c814191c2c6de9e6de20a06e25a9a846ef1758c8be01f68de7fc4aa023f24c0f6d399b1826600255b69c2e7b8d673fed69b7178ea1f3664669be8f6c52a2573f747d23299158ecd3b490939a05c2511be8e60e355617c4e2f6caddb84eec1252b9ed49475393d6377b642aa70b2392dd6d62eb0467c64d29b2b129ea923383c9e8269864d3ac41dfabf78616cf99c41d24244e57f963437bb07fbf6f9602ddc581aa646948483e6afcfff990e8d256cad605eab555eb056ef3a5b5d9ece67b9e7413843400578b67b000eef0c4b1c0ceb80bf7d40c4e4897eb8d7b5dcca7b7aa", 2);
//        obj = new JsonObject();
//        obj.addProperty("high", "10");
//        obj.addProperty("medium", "5");
//        obj.addProperty("low", "1");
//        editSetting(1, "24de1d05aa5f2eeb7918a4e9b3a0bf6289f774f2f29df603e8436153d67687795dd011ba78d1c67f099561424990af65df46f8057f3e4cb3707ffe89668985801b0d8ec15e0255b7445e54b4cbdadfd4ab0089eaf914107e1cf01467cc03cbbf992c16fa7970f10bb71b58b4ec1b4b258ced529cf8899389591873ea0de02c796fcef006e14186e75b396129a12829d787cc1ae3a384922d4cbda55457bc05bc5b3a6fc5811be704d3120424832958b073f461599d6083bb10997c5e8b15e188308bf85bc325524add893a141e4bba040c4d2b6ab7d2ac0d9bcd9cb2ed1e0dd86e9310b2f2ff1de11864d68629a66912fe0e78a119921921a1f7788001e5cea1f25a00f47d351bbf04c1e5b0a23d6575525f51a0d0b6ec359d2644744e3a8818c814191c2c6de9e6de20a06e25a9a846ef1758c8be01f68de7fc4aa023f24c0f6d399b1826600255b69c2e7b8d673fed69b7178ea1f3664669be8f6c52a2573f747d23299158ecd3b490939a05c2511be8e60e355617c4e2f6caddb84eec1252b9ed49475393d6377b642aa70b2392dd6d62eb0467c64d29b2b129ea923383c9e8269864d3ac41dfabf78616cf99c41d24244e57f963437bb07fbf6f9602ddc581aa646948483e6afcfff990e8d256cad605eab555eb056ef3a5b5d9ece67b9e7413843400578b67b000eef0c4b1c0ceb80bf7d40c4e4897eb8d7b5dcca7b7aa", 2, obj);
        //retrieveSettingById(1, "24de1d05aa5f2eeb7918a4e9b3a0bf6289f774f2f29df603e8436153d67687795dd011ba78d1c67f099561424990af65df46f8057f3e4cb3707ffe89668985801b0d8ec15e0255b7445e54b4cbdadfd4ab0089eaf914107e1cf01467cc03cbbf992c16fa7970f10bb71b58b4ec1b4b258ced529cf8899389591873ea0de02c796fcef006e14186e75b396129a12829d787cc1ae3a384922d4cbda55457bc05bc5b3a6fc5811be704d3120424832958b073f461599d6083bb10997c5e8b15e188308bf85bc325524add893a141e4bba040c4d2b6ab7d2ac0d9bcd9cb2ed1e0dd86e9310b2f2ff1de11864d68629a66912fe0e78a119921921a1f7788001e5cea1f25a00f47d351bbf04c1e5b0a23d6575525f51a0d0b6ec359d2644744e3a8818c814191c2c6de9e6de20a06e25a9a846ef1758c8be01f68de7fc4aa023f24c0f6d399b1826600255b69c2e7b8d673fed69b7178ea1f3664669be8f6c52a2573f747d23299158ecd3b490939a05c2511be8e60e355617c4e2f6caddb84eec1252b9ed49475393d6377b642aa70b2392dd6d62eb0467c64d29b2b129ea923383c9e8269864d3ac41dfabf78616cf99c41d24244e57f963437bb07fbf6f9602ddc581aa646948483e6afcfff990e8d256cad605eab555eb056ef3a5b5d9ece67b9e7413843400578b67b000eef0c4b1c0ceb80bf7d40c4e4897eb8d7b5dcca7b7aa", 2);

    }
}
