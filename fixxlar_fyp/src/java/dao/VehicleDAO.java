/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import entity.Customer;
import entity.QuotationRequest;
import entity.Vehicle;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
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
public class VehicleDAO {

    private final String USER_AGENT = "Mozilla/5.0";

    public Vehicle getVehicle(int staffId, String token, int givenId) throws UnsupportedEncodingException, IOException {

        //Add URL here
        String url = "http://119.81.43.85/erp/vehicle/get_vehicle_by_id";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        //Add parameters here
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
        JsonElement isSuccess = jobj.get("is_success");
        Vehicle vehicle = null;
        if (isSuccess.getAsString().equals("false")) {
            return vehicle;
        } else {
            jobj = element.getAsJsonObject().getAsJsonObject("payload").getAsJsonObject("vehicle");
            JsonElement attElement = jobj.get("id");
            int id = attElement.getAsInt();
            attElement = jobj.get("make");
            String make = attElement.getAsString();
            attElement = jobj.get("model");
            String model = attElement.getAsString();
            attElement = jobj.get("year");
            int year = attElement.getAsInt();
            attElement = jobj.get("plate_number");
            String plateNumber = attElement.getAsString();
            attElement = jobj.get("user_id");
            int customerID = attElement.getAsInt();
            attElement = jobj.get("car_color");
            String color = attElement.getAsString();
            attElement = jobj.get("type_of_control_of_car");
            String control = attElement.getAsString();
            vehicle = new Vehicle(id, make, model, year, plateNumber, customerID, color, control);
            return vehicle;
        }
    }
    
    public static void main (String[] args) throws IOException {
        //getVehicle(18, "cb2341be42e49a320f0dbba633e242254956ca9bb800485c757a6e37284fc9693c28a333b39df2791c5a8f88fe136c4060fb65814c807c7cc7acc897a529fc6d22ca19d35ee58820a3571eda94eae9c7c8ca3d76e7501e7df79840f3ede675f0b042cf09ca4e0dfe3ef7a21a4ea49bb0ae14225354831375b78acc64b0bdb6088b9693747d3e145715caa1f3e0dac23bf5190c37ef119f300a3ca1ac0ab18dd9a39c244e1fe7aeab8ad409e365d35a95a01ed3f2467b94fc97aadc2e4cb75482c517edb9e542387fa205b5549d89cae8463bf446cbb4c92b725cd99da45109badf09f2abd13c0d54143f3071186640a7fb1f100b849e5f6c6e1fbcbfa91a1ccec982b106d80b3d21a011f75e82ca16cb7f5d820374e1fd074b5373a367d1cf4c49668b790c3b761df624862302c78acd282c1f3d36eedb98e3d33bcf0b2ed2285490f953e0c588f65a893f07dbd49fbbe4211f898c23b3713358bbe00c0d0574a95256a5bfec7ae42a12f4df75a359fd7dd44d2c72430bb0426e1429fc5e9dad491e8cdb520d0f61b271efde9fe74a24baf208c542bdd49d9eab9a6d3eb836468b7c295d3d9792398b1287c86dd5fb59427cf8e038f1b2643e1dda27b9f4ac99fddf0af3b942d34b2f3b8d36c07b2552fdba09c535162e7eabfb80291f5b6e0087dfe5fcabf9a1384ca93d81923773ce6fd28e1efec778c656e7f379af9b994f", 1);
    }
}
