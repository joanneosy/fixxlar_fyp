package dao;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import entity.WebUser;
import entity.Workshop;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

public class WebUserDAO {

    private final String USER_AGENT = "Mozilla/5.0";

    /**
     * Retrieve user
     *
     * @param givenEmail email of the user
     * @return a user
     * @throws SQLException if an SQL error occurs
     */
    public WebUser retrieveUser(int staffId, String token, int givenId) throws IOException {
        WebUser user = null;
        String url = "http://119.81.43.85/erp/user/get_staff_info";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", givenId + ""));

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
        JsonObject userObj = null;
        if (shopElement.isJsonNull()) {
            return user;
        } else {
            userObj = shopElement.getAsJsonObject().getAsJsonObject("staff");
            JsonElement attElement = userObj.get("id");
            int id = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = userObj.get("name");
            String name = "";
            if (attElement != null && !attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = userObj.get("email");
            String email = "";
            if (attElement != null && !attElement.isJsonNull()) {
                email = attElement.getAsString();
            }
            attElement = userObj.get("handphone");
            String handphone = "";
            if (attElement != null && !attElement.isJsonNull()) {
                handphone = attElement.getAsString();
            }

            attElement = userObj.get("user_type");
            int userType = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                userType = attElement.getAsInt();
            }

            int refStaffId = 0;
            attElement = userObj.get("workshop_staff_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            attElement = userObj.get("web_admin_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            int shopId = 0;
            attElement = userObj.get("shop_id");
            if (attElement != null && !attElement.isJsonNull()) {
                shopId = attElement.getAsInt();
            }

            int staffType = 0;
            attElement = userObj.get("staff_type");
            if (attElement != null && !attElement.isJsonNull()) {
                staffType = attElement.getAsInt();
            }

            user = new WebUser(id, email, userType, refStaffId, "", shopId, name, handphone, staffType);
        }
        return user;
    }

    public WebUser authenticateUser(String email, String password) throws UnsupportedEncodingException, IOException {
        WebUser webUser = null;
        String url = "http://119.81.43.85/erp/user/login_web_app_user";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("email", email));
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
        JsonElement isSuccess = jobj.get("is_success");
        if (isSuccess.getAsString().equals("false")) {
            return webUser;
        } else {
            JsonElement userElement = jobj.get("payload");
            JsonObject user = userElement.getAsJsonObject();
            JsonElement attElement = user.get("staff_id");
            int staffId = 0;
            if (!attElement.isJsonNull()) {
                staffId = attElement.getAsInt();
            }

            int userType = 0;
            attElement = user.get("user_type");
            if (!attElement.isJsonNull()) {
                userType = attElement.getAsInt();
            }

            int refStaffId = 0;
            attElement = user.get("workshop_staff_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            attElement = user.get("web_admin_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            String token = "";
            attElement = user.get("token");
            if (!attElement.isJsonNull()) {
                token = attElement.getAsString();
            }

            int shopId = 0;
            attElement = user.get("shop_id");
            if (attElement != null && !attElement.isJsonNull()) {
                shopId = attElement.getAsInt();
            }

            String handphone = "";
            attElement = user.get("handphone");
            if (attElement != null && !attElement.isJsonNull()) {
                handphone = attElement.getAsString();
            }

            String name = "";
            attElement = user.get("name");
            if (attElement != null && !attElement.isJsonNull()) {
                name = attElement.getAsString();
            }

            int staffType = 0;
            attElement = user.get("staff_type");
            if (attElement != null && !attElement.isJsonNull()) {
                staffType = attElement.getAsInt();
            }
            String chatToken = "";
            attElement = user.get("chat_token");
            if (attElement != null && !attElement.isJsonNull()) {
                chatToken = attElement.getAsString();
            }
            webUser = new WebUser(staffId, email, userType, refStaffId, token, shopId, name, handphone, staffType, chatToken);
        }
        return webUser;
    }

    // Update user's password with the new pasword hash 
    public boolean updateUserPassword(int staffId, String token, String currentPassword, String newPassword) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/change_password";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("currentPassword", currentPassword));
        urlParameters.add(new BasicNameValuePair("nPassword", newPassword));

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
        JsonElement isSuccess = jobj.get("is_success");
        if (isSuccess.getAsString().equals("false")) {
            return false;
        } else {
            return true;
        }
    }

    public String addMasterWorkshopStaff(int staffId, String token, String name, String email, String hpNo, int shopId, String password) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/add_new_master_workshop_staff";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("staff_name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", hpNo));
        urlParameters.add(new BasicNameValuePair("shop_id", shopId + ""));
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
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }

    public String addNormalWorkshopStaff(int staffId, String token, String name, String email, String hpNo, int shopId, String password) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/add_new_normal_workshop_staff";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("staff_name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", hpNo));
        urlParameters.add(new BasicNameValuePair("shop_id", shopId + ""));
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
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }

    public String addMasterAdmin(int staffId, String token, String name, String email, String hpNo, String password) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/add_new_master_admin";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("staff_name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
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
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }

    public String addNormalAdmin(int staffId, String token, String name, String email, String hpNo, String password) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/add_new_normal_admin";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("staff_name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
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
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }

    public String updateMasterWorkshopStaff(int staffId, String token, String name, String email, String handphone, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/update_master_workshop_staff";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));
        urlParameters.add(new BasicNameValuePair("staff_name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", handphone));

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

    public String updateNormalWorkshopStaff(int staffId, String token, String name, String email, String handphone, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/update_normal_workshop_staff";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));
        urlParameters.add(new BasicNameValuePair("staff_name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", handphone));

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

    public String updateSuperAdmin(int staffId, String token, String name, String email, String handphone, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/update_master_workshop_staff";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));
        urlParameters.add(new BasicNameValuePair("staff_name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", handphone));

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
    
    public String updateMasterAdmin(int staffId, String token, String name, String email, String handphone, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/update_master_admin";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));
        urlParameters.add(new BasicNameValuePair("staff_name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", handphone));

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

    public String updateNormalAdmin(int staffId, String token, String name, String email, String handphone, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/update_normal_admin";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));
        urlParameters.add(new BasicNameValuePair("staff_name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", handphone));

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

    //View employees for workshop master staff
    public HashMap<Integer, WebUser> retrieveNormalWorkshopStaff(int staffId, String token, int wsId) throws UnsupportedEncodingException, IOException {
        HashMap<Integer, WebUser> allStaff = new HashMap<>();
        String url = "http://119.81.43.85/erp/user/get_normal_workshop_staff_info";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("shop_id", wsId + ""));

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
        JsonArray arr = (jobj.getAsJsonObject("payload")).getAsJsonArray("staff");
        for (int i = 0; i < arr.size(); i++) {
            JsonElement userEle = arr.get(i);
            JsonObject user = userEle.getAsJsonObject();

            JsonElement attElement = user.get("id");
            int indivStaffId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                indivStaffId = attElement.getAsInt();
            }

            int userType = 0;
            attElement = user.get("user_type");
            if (attElement != null && !attElement.isJsonNull()) {
                userType = attElement.getAsInt();
            }

            int refStaffId = 0;
            attElement = user.get("workshop_staff_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            attElement = user.get("web_admin_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            String indivToken = "";
            attElement = user.get("token");
            if (attElement != null && !attElement.isJsonNull()) {
                indivToken = attElement.getAsString();
            }

            int shopId = 0;
            attElement = user.get("shop_id");
            if (attElement != null && !attElement.isJsonNull()) {
                shopId = attElement.getAsInt();
            }

            String email = "";
            attElement = user.get("email");
            if (attElement != null && !attElement.isJsonNull()) {
                email = attElement.getAsString();
            }

            String handphone = "";
            attElement = user.get("handphone");
            if (attElement != null && !attElement.isJsonNull()) {
                handphone = attElement.getAsString();
            }

            String name = "";
            attElement = user.get("name");
            if (attElement != null && !attElement.isJsonNull()) {
                name = attElement.getAsString();
            }

            int staffType = 0;
            attElement = user.get("staff_type");
            if (attElement != null && !attElement.isJsonNull()) {
                staffType = attElement.getAsInt();
            }

            WebUser staff = new WebUser(indivStaffId, email, userType, refStaffId, indivToken, shopId, name, handphone, staffType);
            allStaff.put(i, staff);
        }
        return allStaff;
    }

    public HashMap<Integer, WebUser> retrieveAllMasterWorkshopStaff(int staffId, String token) throws UnsupportedEncodingException, IOException {
        HashMap<Integer, WebUser> allStaff = new HashMap<>();
        String url = "http://119.81.43.85/erp/user/get_all_master_workshop_staff";
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
        JsonElement ele = element.getAsJsonObject().getAsJsonObject("payload").get("staff");
        if (ele.isJsonNull()) {
            return allStaff;
        }

        JsonArray arr = ele.getAsJsonArray();
        for (int i = 0; i < arr.size(); i++) {
            JsonElement userEle = arr.get(i);
            JsonObject user = userEle.getAsJsonObject();

            JsonElement attElement = user.get("id");
            int indivStaffId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                indivStaffId = attElement.getAsInt();
            }

            int userType = 0;
            attElement = user.get("user_type");
            if (attElement != null && !attElement.isJsonNull()) {
                userType = attElement.getAsInt();
            }

            int refStaffId = 0;
            attElement = user.get("workshop_staff_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            attElement = user.get("web_admin_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            String indivToken = "";
            attElement = user.get("token");
            if (attElement != null && !attElement.isJsonNull()) {
                indivToken = attElement.getAsString();
            }

            int shopId = 0;
            attElement = user.get("shop_id");
            if (attElement != null && !attElement.isJsonNull()) {
                shopId = attElement.getAsInt();
            }

            String email = "";
            attElement = user.get("email");
            if (attElement != null && !attElement.isJsonNull()) {
                email = attElement.getAsString();
            }

            String handphone = "";
            attElement = user.get("handphone");
            if (attElement != null && !attElement.isJsonNull()) {
                handphone = attElement.getAsString();
            }

            String name = "";
            attElement = user.get("name");
            if (attElement != null && !attElement.isJsonNull()) {
                name = attElement.getAsString();
            }

            int staffType = 0;
            attElement = user.get("staff_type");
            if (attElement != null && !attElement.isJsonNull()) {
                staffType = attElement.getAsInt();
            }

            WebUser staff = new WebUser(indivStaffId, email, userType, refStaffId, indivToken, shopId, name, handphone, staffType);
            allStaff.put(i, staff);
        }
        return allStaff;
    }

    public HashMap<Integer, WebUser> retrieveAllAdmin(int staffId, String token) throws UnsupportedEncodingException, IOException {
        HashMap<Integer, WebUser> allStaff = new HashMap<>();
        String url = "http://119.81.43.85/erp/user/get_all_admin_staff";
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
        JsonElement ele = element.getAsJsonObject().getAsJsonObject("payload").get("staff");
        if (ele.isJsonNull()) {
            return allStaff;
        }

        JsonArray arr = ele.getAsJsonArray();
        for (int i = 0; i < arr.size(); i++) {
            JsonElement userEle = arr.get(i);
            JsonObject user = userEle.getAsJsonObject();

            JsonElement attElement = user.get("id");
            int indivStaffId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                indivStaffId = attElement.getAsInt();
            }

            int userType = 0;
            attElement = user.get("user_type");
            if (attElement != null && !attElement.isJsonNull()) {
                userType = attElement.getAsInt();
            }

            int refStaffId = 0;
            attElement = user.get("workshop_staff_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            attElement = user.get("web_admin_id");
            if (attElement != null && !attElement.isJsonNull()) {
                refStaffId = attElement.getAsInt();
            }

            String indivToken = "";
            attElement = user.get("token");
            if (attElement != null && !attElement.isJsonNull()) {
                indivToken = attElement.getAsString();
            }

            int shopId = 0;
            attElement = user.get("shop_id");
            if (attElement != null && !attElement.isJsonNull()) {
                shopId = attElement.getAsInt();
            }

            String email = "";
            attElement = user.get("email");
            if (attElement != null && !attElement.isJsonNull()) {
                email = attElement.getAsString();
            }

            String handphone = "";
            attElement = user.get("handphone");
            if (attElement != null && !attElement.isJsonNull()) {
                handphone = attElement.getAsString();
            }

            String name = "";
            attElement = user.get("name");
            if (attElement != null && !attElement.isJsonNull()) {
                name = attElement.getAsString();
            }

            int staffType = 0;
            attElement = user.get("staff_type");
            if (attElement != null && !attElement.isJsonNull()) {
                staffType = attElement.getAsInt();
            }

            WebUser staff = new WebUser(indivStaffId, email, userType, refStaffId, indivToken, shopId, name, handphone, staffType);
            allStaff.put(i, staff);
        }
        return allStaff;
    }

    public String deleteStaff(int staffId, String token, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/delete_staff";

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

    public static void main(String[] args) throws IOException {
        //retrieveNormalWorkshopStaff(31,"24a76c100537f25a2c92788297c7d836e9dc09712b20d36c5e7db5c36d35b26178ed27855177f7aa965daaf02bf178a2333a5fbde5707e9a1df80e899ea88f7b648ec3c645970583d2a7614232d75cd1211542eccf9f3ad0aeea39514e6a694392cb377ba32bab68d43b23f19f25db128fdab9b1d3e49a69c55e6e6104aca06de73540466cc37d48e001c56819f38fa974fe199f1a1a2d66460d9977a9508c96035c3302796e0e213aaaa0a9adae6a6b4a6cf5da71f51bda275358ae930c94a3587b57acecc88b555b94cc12434055e3a417e6385a09f00983e0529f0f7089d56286cb0aa33d81b30b58df85f367a4ccc2d9521478f609d054aebdaf2359545b7013de846ff37ff98ee1e55f14bcb089d02ce4b13f8686d8c0cefbfccb0c63340b4689e086891bb0f33747ad35810b52cddefb3b73b8de82d7db1cce0bbcb251e1fc1f12ba761a43602569cfedd5faf7d53994cb278201a7c37a9ea37dfdf3c3664ebe57320cb307ce662b2a037682dd2c6d8f5ff3591b29443ea669fb54001155ad21964573413d448a0da93ae410aeac029aca93fca1b877fc84a0e51732e564ea25d194ef5a2eb9723781780daa3e0b1d8e91616496650d87ff6877f7e031b1b6bb69c32733137bbc0841c5080efff7d47f7fcd7b0c6b2aa2c3aeff2ed7ff0baa38c954243f51e8a2d17f84530174ca74e8d78c1fb17e926e038e5ba0a5d8",1);
        //retrieveAllAdmin(1, "6c8c6a53d657b54e3cd6305805ef5edd3b2117910c8e0e1dd12518aaa92b549e50352e1c79d95c5bc9ad31ff06fa2ae7ccad106834ebf95ccf2b3ebcc25ac7194018b0d66f35338df5726d37b3403caed2f78e7f6ac41ccf3081248b0ac9cd2d2f6fc43fabb5d70f4517909ffaf60252bc088942028237598940788857e2e2d0d9c62fbe91a4002fd3a72643f04cf5b0b83f7ae95a4d7fbb44f456eca32e49b7dbe7b21bd50a385fb7ddef297ff2c8d508d8b86d05f614272675c53a1e098a6c2e8adefde60b339d7902e08ab20a048cf40a5bb232fd197bba5ec32cb2f9dcd056e740200577f3c375845f52c0879cf1b3358bf663e409e97e9404d782f9554dd54f23fda5d8c254cf97cac553478c461148d1114bca5ed2631239481b6c38a4cb44a1f9936942fe1fffc73c3f6fd27b747f3ba671dee533d099d253b39baf56c8309025277b9e12ac1edf1d1c36dc73b0eba5a51c5d8090a374f76ea8b040c4a389d68d2332e523c848099d570c0bbbd7cbfdccdf59136126ea468a99b0640b9d6fac31bb3e07489fac9ee3e48ed30486462c3819ef877b370e4502f68a7bd5b95502869cd54898e61c066db904379d1e848f6cb7dcd16e1e51e92da123075eef785ce033137473d469ee40371574389ac06f966b6ea3c2c0638f6260bdc15db2eb403301ea6cdfe41ac222d10bfc9b137474cc9dbabe50a18408f0f21c247c");
    }
}
