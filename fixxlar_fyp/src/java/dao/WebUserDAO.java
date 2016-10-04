package dao;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import entity.Customer;
import entity.ValetRequest;
import entity.ValetStaff;
import entity.Vehicle;
import entity.WebUser;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

    private static final String USER_AGENT = "Mozilla/5.0";

    /**
     * Retrieve user
     *
     * @param givenEmail email of the user
     * @return a user
     * @throws SQLException if an SQL error occurs
     */
    public WebUser retrieveUser(int staffId, String token, int givenId) throws IOException, ParseException {
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

            attElement = userObj.get("valet_staff_id");
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

            if (userType == 4) {
                attElement = userObj.get("license_issue_date");
                Date issueDate = null;
                String dateString = "1990-01-01";
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date parsed = dateFormat.parse(dateString);
                issueDate = new java.sql.Date(parsed.getTime());
                if (!attElement.isJsonNull()) {
                    dateString = attElement.getAsString();
                    dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    parsed = dateFormat.parse(dateString);
                    issueDate = new java.sql.Date(parsed.getTime());
                }

                String licenseNumber = "";
                attElement = userObj.get("license_number");
                if (attElement != null && !attElement.isJsonNull()) {
                    licenseNumber = attElement.getAsString();
                }

                int status = 0;
                attElement = userObj.get("status");
                if (attElement != null && !attElement.isJsonNull()) {
                    status = attElement.getAsInt();
                }
                ValetStaff vs = null;
                vs = new ValetStaff(id, staffType, licenseNumber, issueDate, shopId, status);
                user = new WebUser(id, email, userType, refStaffId, "", shopId, name, handphone, staffType, vs);
            } else {
                user = new WebUser(id, email, userType, refStaffId, "", shopId, name, handphone, staffType);
            }
        }
        return user;
    }

    public WebUser retrieveUser(int staffId, String token, String email) throws IOException {
        WebUser user = null;
        String url = "http://119.81.43.85/erp/user/get_staff_info";

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
//            attElement = userObj.get("email");
//            String email = "";
//            if (attElement != null && !attElement.isJsonNull()) {
//                email = attElement.getAsString();
//            }
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

            attElement = user.get("valet_staff_id");
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

    public String addMasterValet(int staffId, String token, String name, String email, String hpNo, String password, int shopId) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/add_master_valet_staff";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", hpNo));
        urlParameters.add(new BasicNameValuePair("password", password));
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
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }

    public String addNormalValet(int staffId, String token, String name, String email, String hpNo, String password, int shopId, String issueDate, String licenseNumber) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/add_normal_valet_staff";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", hpNo));
        urlParameters.add(new BasicNameValuePair("password", password));
        urlParameters.add(new BasicNameValuePair("shop_id", shopId + ""));
        urlParameters.add(new BasicNameValuePair("license_number", licenseNumber));
        urlParameters.add(new BasicNameValuePair("license_issuse_date", issueDate + ""));

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

    public String updateMasterValet(int staffId, String token, String name, String email, String handphone, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/update_master_valet_staff";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));
        urlParameters.add(new BasicNameValuePair("name", name));
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

    public String updateNormalValet(int staffId, String token, String name, String email, String handphone, int id, String licenseNumber, String issueDate) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/user/update_normal_valet_staff";
        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("handphone", handphone));
        urlParameters.add(new BasicNameValuePair("license_number", licenseNumber));
        urlParameters.add(new BasicNameValuePair("license_issue_date", issueDate + ""));

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

    public HashMap<Integer, WebUser> retrieveAllValetStaffByShop(int staffId, String token, int shopId) throws UnsupportedEncodingException, IOException, ParseException {
        HashMap<Integer, WebUser> allStaff = new HashMap<>();
        String url = "http://119.81.43.85/erp/user/get_all_valet_drivers_by_shop_id";
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
        System.out.println(str);
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

            JsonElement attElement = user.get("staff_id");
            int indivStaffId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                indivStaffId = attElement.getAsInt();
            }

            int staffType = 0;
            attElement = user.get("staff_type");
            if (attElement != null && !attElement.isJsonNull()) {
                staffType = attElement.getAsInt();
            }

            String email = "";
            attElement = user.get("staff_email");
            if (attElement != null && !attElement.isJsonNull()) {
                email = attElement.getAsString();
            }

            String handphone = "";
            attElement = user.get("staff_handphone");
            if (attElement != null && !attElement.isJsonNull()) {
                handphone = attElement.getAsString();
            }

            String name = "";
            attElement = user.get("staff_name");
            if (attElement != null && !attElement.isJsonNull()) {
                name = attElement.getAsString();
            }

            String licenseNumber = "";
            attElement = user.get("staff_license_number");
            if (attElement != null && !attElement.isJsonNull()) {
                licenseNumber = attElement.getAsString();
            }

            attElement = user.get("staff_license_issue_date");
            Date issueDate = null;
            String dateString = "1990-01-01";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date parsed = dateFormat.parse(dateString);
            issueDate = new java.sql.Date(parsed.getTime());
            if (!attElement.isJsonNull()) {
                dateString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                parsed = dateFormat.parse(dateString);
                issueDate = new java.sql.Date(parsed.getTime());
            }

            int status = 0;
            attElement = user.get("staff_status");
            if (attElement != null && !attElement.isJsonNull()) {
                status = attElement.getAsInt();
            }
            
            attElement = user.get("request_id");
            int id = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = user.get("service_type");
            int serviceType = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                serviceType = attElement.getAsInt();
            }
            attElement = user.get("pick_up_address");
            String pickUpAddress = "";
            if (attElement != null && !attElement.isJsonNull()) {
                pickUpAddress = attElement.getAsString();
            }
            attElement = user.get("pick_up_longitude");
            double pickUpLongitude = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                pickUpLongitude = attElement.getAsDouble();
            }

            attElement = user.get("pick_up_latitude");
            double pickUpLatitude = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                pickUpLatitude = attElement.getAsDouble();
            }

            attElement = user.get("drop_off_address");
            String dropOffAddress = "";
            if (attElement != null && !attElement.isJsonNull()) {
                dropOffAddress = attElement.getAsString();
            }
            attElement = user.get("drop_off_latitude");
            double dropOffLongitude = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                dropOffLongitude = attElement.getAsDouble();
            }

            attElement = user.get("drop_off_longitude");
            double dropOffLatitude = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                dropOffLatitude = attElement.getAsDouble();
            }

            attElement = user.get("scheduled_pick_up_time");
            Timestamp scheduledPickUpTime = null;
            String dateTimeString = "1990-01-01 00:00:00";
            dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate = dateFormat.parse(dateTimeString);
            scheduledPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            if (attElement != null && !attElement.isJsonNull()) {
                dateTimeString = attElement.getAsString();
                dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                parsedDate = dateFormat.parse(dateTimeString);
                scheduledPickUpTime = new java.sql.Timestamp(parsedDate.getTime());
            }

            attElement = user.get("actual_pick_up_time");
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

            attElement = user.get("completed_time");
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

            attElement = user.get("request_status");
            int requestStatus = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                requestStatus = attElement.getAsInt();
            }

            attElement = user.get("price");
            double price = 0.0;
            if (attElement != null && !attElement.isJsonNull()) {
                price = attElement.getAsDouble();
            }

            attElement = user.get("offer_id");
            int offerId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                offerId = attElement.getAsInt();
            }

            attElement = user.get("vehicle_id");
            int vehicleId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                vehicleId = attElement.getAsInt();
            }

            attElement = user.get("car_make");
            String make = "";
            if (attElement != null && !attElement.isJsonNull()) {
                make = attElement.getAsString();
            }

            attElement = user.get("car_model");
            String model = "";
            if (attElement != null && !attElement.isJsonNull()) {
                model = attElement.getAsString();
            }

            attElement = user.get("car_year_manufactured");
            int year = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                year = attElement.getAsInt();
            }

            attElement = user.get("car_plate_number");
            String plateNumber = "";
            if (attElement != null && !attElement.isJsonNull()) {
                plateNumber = attElement.getAsString();
            }

            attElement = user.get("car_color");
            String colour = "";
            if (attElement != null && !attElement.isJsonNull()) {
                colour = attElement.getAsString();
            }

            attElement = user.get("car_type_of_control_of_car");
            String control = "";
            if (attElement != null && !attElement.isJsonNull()) {
                control = attElement.getAsString();
            }

            attElement = user.get("customer_id");
            int customerId = 0;
            if (attElement != null && !attElement.isJsonNull()) {
                customerId = attElement.getAsInt();
            }

            attElement = user.get("customer_name");
            String customerName = "";
            if (attElement != null && !attElement.isJsonNull()) {
                customerName = attElement.getAsString();
            }

            attElement = user.get("customer_email");
            String customerEmail = "";
            if (attElement != null && !attElement.isJsonNull()) {
                customerEmail = attElement.getAsString();
            }

            attElement = user.get("customer_mobile_number");
            String customerHpNo = "";
            if (attElement != null && !attElement.isJsonNull()) {
                customerHpNo = attElement.getAsString();
            }

            Customer customer = new Customer(customerId, customerEmail, customerName, customerHpNo);
            ValetStaff vs = new ValetStaff(indivStaffId, staffType, licenseNumber, issueDate, shopId, status);
            Vehicle vehicle = new Vehicle(vehicleId, make, model, year, plateNumber, colour, control);
            ValetRequest valetRequest = new ValetRequest(id, vehicle, pickUpAddress, pickUpLatitude, pickUpLongitude, dropOffAddress, 
            dropOffLatitude, dropOffLongitude, scheduledPickUpTime, actualPickUpTime, completedTime, price, offerId, requestStatus);
            
            WebUser staff = new WebUser(indivStaffId, email, shopId, name, handphone, staffType, vs, valetRequest, customer, vehicle);
            if (id == 0) {
                staff = new WebUser(indivStaffId, email, shopId, name, handphone, staffType, vs, null, null, null);
            }

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

    public static void main(String[] args) throws IOException, ParseException {
        //retrieveNormalWorkshopStaff(31,"24a76c100537f25a2c92788297c7d836e9dc09712b20d36c5e7db5c36d35b26178ed27855177f7aa965daaf02bf178a2333a5fbde5707e9a1df80e899ea88f7b648ec3c645970583d2a7614232d75cd1211542eccf9f3ad0aeea39514e6a694392cb377ba32bab68d43b23f19f25db128fdab9b1d3e49a69c55e6e6104aca06de73540466cc37d48e001c56819f38fa974fe199f1a1a2d66460d9977a9508c96035c3302796e0e213aaaa0a9adae6a6b4a6cf5da71f51bda275358ae930c94a3587b57acecc88b555b94cc12434055e3a417e6385a09f00983e0529f0f7089d56286cb0aa33d81b30b58df85f367a4ccc2d9521478f609d054aebdaf2359545b7013de846ff37ff98ee1e55f14bcb089d02ce4b13f8686d8c0cefbfccb0c63340b4689e086891bb0f33747ad35810b52cddefb3b73b8de82d7db1cce0bbcb251e1fc1f12ba761a43602569cfedd5faf7d53994cb278201a7c37a9ea37dfdf3c3664ebe57320cb307ce662b2a037682dd2c6d8f5ff3591b29443ea669fb54001155ad21964573413d448a0da93ae410aeac029aca93fca1b877fc84a0e51732e564ea25d194ef5a2eb9723781780daa3e0b1d8e91616496650d87ff6877f7e031b1b6bb69c32733137bbc0841c5080efff7d47f7fcd7b0c6b2aa2c3aeff2ed7ff0baa38c954243f51e8a2d17f84530174ca74e8d78c1fb17e926e038e5ba0a5d8",1);
        //retrieveAllAdmin(1, "6c8c6a53d657b54e3cd6305805ef5edd3b2117910c8e0e1dd12518aaa92b549e50352e1c79d95c5bc9ad31ff06fa2ae7ccad106834ebf95ccf2b3ebcc25ac7194018b0d66f35338df5726d37b3403caed2f78e7f6ac41ccf3081248b0ac9cd2d2f6fc43fabb5d70f4517909ffaf60252bc088942028237598940788857e2e2d0d9c62fbe91a4002fd3a72643f04cf5b0b83f7ae95a4d7fbb44f456eca32e49b7dbe7b21bd50a385fb7ddef297ff2c8d508d8b86d05f614272675c53a1e098a6c2e8adefde60b339d7902e08ab20a048cf40a5bb232fd197bba5ec32cb2f9dcd056e740200577f3c375845f52c0879cf1b3358bf663e409e97e9404d782f9554dd54f23fda5d8c254cf97cac553478c461148d1114bca5ed2631239481b6c38a4cb44a1f9936942fe1fffc73c3f6fd27b747f3ba671dee533d099d253b39baf56c8309025277b9e12ac1edf1d1c36dc73b0eba5a51c5d8090a374f76ea8b040c4a389d68d2332e523c848099d570c0bbbd7cbfdccdf59136126ea468a99b0640b9d6fac31bb3e07489fac9ee3e48ed30486462c3819ef877b370e4502f68a7bd5b95502869cd54898e61c066db904379d1e848f6cb7dcd16e1e51e92da123075eef785ce033137473d469ee40371574389ac06f966b6ea3c2c0638f6260bdc15db2eb403301ea6cdfe41ac222d10bfc9b137474cc9dbabe50a18408f0f21c247c");
//        addMasterValet(1, "58522896deaae56427ffce72ee56daea708a4b892c1481952a7feb493b72af26970f09a97c91b07058ceba3362b818e2a197ab08d76acbd8eee6477e76f2ac7495e27e095537e681268689dd2bc71732dddd693faaf5f45f4b8b10b1d9a54f46e7002eb8afaca543f64b80c1ad914ab1958f44ae841ea2827aae4f549580c02d6a2b5c7cb0877d529ae326cbebcbe41319cec7de01a2ed3647ddeaab5cf712c412907d1504d3c7df354c476566dfd18b7b6f3ba5f7ae58ebaf0c14d586bbd0568b02853214adc5cb6f46c241c492ac87518582160b9341992445c3ef592e535883f9e410d1ba588f4af387905f6ef72bd6f8af3c21e562d660d232261f02e24595deb1aa98d59865babc3e1e3dae954ef59c02f734500917d37c39951ca3bc99a9c7d3fd22ce787700edefc25ee30ccc06eb99f8d32f131a232a2e6d519d26e40ded6f2d60de4913b25ac7fabc1b1123ef400cb7ee9440a34048ca4a5ae13e22b5f9598de348c250acd2000d0b3d927485dacdeea3f0d576ad222aac05fb5cda4178ef7501d09363f3ab70fdb28f2b14a5d5ff6bf5514422ac69f57b14d76129c9f70f238932bf2092b419e62661686ee49218482bab0bbd9dd0b09b0fb1e1030ebfdb307217d89d43e96118877dbd939a4570cdbe1ad3df73abb9680487b06a8f6c701515304529455a6aced9630d496dedda3857d62798f21189961d0806c8", "Hello", "valet5@valet.com", "98765432", "12345678", 1);
        String dateString = "1990-01-01";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date parsed = dateFormat.parse(dateString);
        Date issueDate = new java.sql.Date(parsed.getTime());
//        addNormalValet(1, "58522896deaae56427ffce72ee56daea708a4b892c1481952a7feb493b72af26970f09a97c91b07058ceba3362b818e2a197ab08d76acbd8eee6477e76f2ac7495e27e095537e681268689dd2bc71732dddd693faaf5f45f4b8b10b1d9a54f46e7002eb8afaca543f64b80c1ad914ab1958f44ae841ea2827aae4f549580c02d6a2b5c7cb0877d529ae326cbebcbe41319cec7de01a2ed3647ddeaab5cf712c412907d1504d3c7df354c476566dfd18b7b6f3ba5f7ae58ebaf0c14d586bbd0568b02853214adc5cb6f46c241c492ac87518582160b9341992445c3ef592e535883f9e410d1ba588f4af387905f6ef72bd6f8af3c21e562d660d232261f02e24595deb1aa98d59865babc3e1e3dae954ef59c02f734500917d37c39951ca3bc99a9c7d3fd22ce787700edefc25ee30ccc06eb99f8d32f131a232a2e6d519d26e40ded6f2d60de4913b25ac7fabc1b1123ef400cb7ee9440a34048ca4a5ae13e22b5f9598de348c250acd2000d0b3d927485dacdeea3f0d576ad222aac05fb5cda4178ef7501d09363f3ab70fdb28f2b14a5d5ff6bf5514422ac69f57b14d76129c9f70f238932bf2092b419e62661686ee49218482bab0bbd9dd0b09b0fb1e1030ebfdb307217d89d43e96118877dbd939a4570cdbe1ad3df73abb9680487b06a8f6c701515304529455a6aced9630d496dedda3857d62798f21189961d0806c8", "Hello", "valet6@valet.com", "98765432", "12345678", 1, issueDate, "123456789");
//        updateMasterValet(1, "58522896deaae56427ffce72ee56daea708a4b892c1481952a7feb493b72af26970f09a97c91b07058ceba3362b818e2a197ab08d76acbd8eee6477e76f2ac7495e27e095537e681268689dd2bc71732dddd693faaf5f45f4b8b10b1d9a54f46e7002eb8afaca543f64b80c1ad914ab1958f44ae841ea2827aae4f549580c02d6a2b5c7cb0877d529ae326cbebcbe41319cec7de01a2ed3647ddeaab5cf712c412907d1504d3c7df354c476566dfd18b7b6f3ba5f7ae58ebaf0c14d586bbd0568b02853214adc5cb6f46c241c492ac87518582160b9341992445c3ef592e535883f9e410d1ba588f4af387905f6ef72bd6f8af3c21e562d660d232261f02e24595deb1aa98d59865babc3e1e3dae954ef59c02f734500917d37c39951ca3bc99a9c7d3fd22ce787700edefc25ee30ccc06eb99f8d32f131a232a2e6d519d26e40ded6f2d60de4913b25ac7fabc1b1123ef400cb7ee9440a34048ca4a5ae13e22b5f9598de348c250acd2000d0b3d927485dacdeea3f0d576ad222aac05fb5cda4178ef7501d09363f3ab70fdb28f2b14a5d5ff6bf5514422ac69f57b14d76129c9f70f238932bf2092b419e62661686ee49218482bab0bbd9dd0b09b0fb1e1030ebfdb307217d89d43e96118877dbd939a4570cdbe1ad3df73abb9680487b06a8f6c701515304529455a6aced9630d496dedda3857d62798f21189961d0806c8", "Hello", "valet5@valet.com", "98765432", 53);
//        updateNormalValet(50, "64b5fdeaa30365d3ae9106f70d8468a0e06bb4a60765163f3e0960c703ef7a17b1133ce36265062463edd39538c7ee8355559be04f1f6adbf94827d91bb0d375dc5d230cb6149d452c4054ed84a14edcf557e5adc7d6d4a12f0c61008423987b8e766c121e0030dbd4f6f4336659272c31a84d5b0aba9a821aafba185c641f818c37760be01259daf536d9c164ce2e198a3b20ab4a88335eb62e49e5d47f9a78456d6f755fde70d6fd333b3fec4b66d38c7b5291aa74d71e563986888ed698d36f209e74be1a040e1c1d1b6294aa571e0f6e55923a9cb58c9ad4e331086a94ac40b42e7bf8724f48c1dfc5530e78fefe5b7bcd581097a7c50bebc6382b1c4293e6815b2ffa1634e473cb8c64f54b247245f5ba41af1f02eba674e35c234331af82e6a554e2b986dcfe347aa2d41e79f485284929f6b55bbc1feac57f1fbf269b61bdf5a08561ac632d570bf9e1416063467836102310b2a51fd88b451f64d8614465272311535db4f525e91f4f03f2d03c11e61e4e7e1c1b3632641e14c1b03d3f7eee84768a0edb8aad7a37791b0620f38b7ead6f7bbbb335694ff89ece3158119e769481a43534271ca74197c767719afd2746407dfc466f18acb09a5efb8359b8555f5b02cfd5e6d7cdd4dd972b85efd8fea73e5ff5abdcdc86561be9f70be493f7d9274822a6300cdf0237a392adf344955b4bf81bc15e128b99901801e4", "Hello", "valet6@valett.com", "98765432", 54, "12345678", issueDate);
//        retrieveAllValetStaffByShop(1, "58522896deaae56427ffce72ee56daea708a4b892c1481952a7feb493b72af26970f09a97c91b07058ceba3362b818e2a197ab08d76acbd8eee6477e76f2ac7495e27e095537e681268689dd2bc71732dddd693faaf5f45f4b8b10b1d9a54f46e7002eb8afaca543f64b80c1ad914ab1958f44ae841ea2827aae4f549580c02d6a2b5c7cb0877d529ae326cbebcbe41319cec7de01a2ed3647ddeaab5cf712c412907d1504d3c7df354c476566dfd18b7b6f3ba5f7ae58ebaf0c14d586bbd0568b02853214adc5cb6f46c241c492ac87518582160b9341992445c3ef592e535883f9e410d1ba588f4af387905f6ef72bd6f8af3c21e562d660d232261f02e24595deb1aa98d59865babc3e1e3dae954ef59c02f734500917d37c39951ca3bc99a9c7d3fd22ce787700edefc25ee30ccc06eb99f8d32f131a232a2e6d519d26e40ded6f2d60de4913b25ac7fabc1b1123ef400cb7ee9440a34048ca4a5ae13e22b5f9598de348c250acd2000d0b3d927485dacdeea3f0d576ad222aac05fb5cda4178ef7501d09363f3ab70fdb28f2b14a5d5ff6bf5514422ac69f57b14d76129c9f70f238932bf2092b419e62661686ee49218482bab0bbd9dd0b09b0fb1e1030ebfdb307217d89d43e96118877dbd939a4570cdbe1ad3df73abb9680487b06a8f6c701515304529455a6aced9630d496dedda3857d62798f21189961d0806c8", 1);
//        deleteStaff(1, "58522896deaae56427ffce72ee56daea708a4b892c1481952a7feb493b72af26970f09a97c91b07058ceba3362b818e2a197ab08d76acbd8eee6477e76f2ac7495e27e095537e681268689dd2bc71732dddd693faaf5f45f4b8b10b1d9a54f46e7002eb8afaca543f64b80c1ad914ab1958f44ae841ea2827aae4f549580c02d6a2b5c7cb0877d529ae326cbebcbe41319cec7de01a2ed3647ddeaab5cf712c412907d1504d3c7df354c476566dfd18b7b6f3ba5f7ae58ebaf0c14d586bbd0568b02853214adc5cb6f46c241c492ac87518582160b9341992445c3ef592e535883f9e410d1ba588f4af387905f6ef72bd6f8af3c21e562d660d232261f02e24595deb1aa98d59865babc3e1e3dae954ef59c02f734500917d37c39951ca3bc99a9c7d3fd22ce787700edefc25ee30ccc06eb99f8d32f131a232a2e6d519d26e40ded6f2d60de4913b25ac7fabc1b1123ef400cb7ee9440a34048ca4a5ae13e22b5f9598de348c250acd2000d0b3d927485dacdeea3f0d576ad222aac05fb5cda4178ef7501d09363f3ab70fdb28f2b14a5d5ff6bf5514422ac69f57b14d76129c9f70f238932bf2092b419e62661686ee49218482bab0bbd9dd0b09b0fb1e1030ebfdb307217d89d43e96118877dbd939a4570cdbe1ad3df73abb9680487b06a8f6c701515304529455a6aced9630d496dedda3857d62798f21189961d0806c8", 54);
//        retrieveUser(2, "8c12df51abc894d7614e0ab012a2b8f348edf2147b438ae55c449379136523f1d3e49341c9e22c85e4536bb2987cc7923560c1e86110b38444d4120cd6d7e25143ca4afc8fb9ee9fd74a456b37604c6830720bd2db97bcf0d059f4373314c1f220a7c871649bc505d46b24d09c7eea106b701b1f83b47145917ffe0fc11387a5799b9958de797d916feb5e355f49352a947e3599a711adf429a0db557a0fe47191cccc4f498404626b5a604595a8cd482f58c0df67820a4700990699fa150203e336484f60fcb8ec1e395baf8d0ab6458b39350d5d4cd1c9d0a22e16b0866f59593dd08ca751ffa0e87ab72ab6a495261612354df27e5fb5416d90c8c2f7a98835e816b78828ad0346fa365c1d79faadf521f2a931bfee8e1933c03604a38617bb27563418b7edfe6876ebe6788b3fccc7a060032f75e23f77e166181997c2e5c498c60e538d5435b7a3a073390b8fc70081a2e13094e475369795a334c1ef2b488536cc81114106e038ee194c68fed76497af8006dcc2b41b48cb6234601c01d96b7453a5ed9e0d2d2206abb9f1f2bccbf1aae789a3ac015d0c939cfad8515badf5438b928cfdd1459c6b7b4bd96d864550201259f3fe846c8435ec7b8af481c3034c8624c151d43747662fc59ec164cdc07eab77e3b34ca09fcd4e77980d946dbc975965b6fc5527461acf55375d6124c0ff2a693861e18b4b2b4c527c19ae", 54);
    
    }
}
