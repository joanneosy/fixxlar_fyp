/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Joanne
 */
public class ValetShop {
    private int id;
    private String name;
    private String address;
    private double latitude;
    private double longitude;
    private int noOfEmployees;
    private double revenueShare;
    private String openingHours;
    
    public ValetShop(int id, String name, String address, double latitude, double longitude, int noOfEmployees, double revenueShare, String openingHours) {
        this.id = id; 
        this.name = name; 
        this.address = address; 
        this.latitude = latitude; 
        this.longitude = longitude; 
        this.noOfEmployees = noOfEmployees; 
        this.revenueShare = revenueShare; 
        this.openingHours = openingHours; 
    }
    
    public int getId() {
        return id; 
    }
    
    public String getName() {
        return name; 
    }
    
    public String getAddress() {
        return address; 
    }
    
    public double getLatitude() {
        return latitude; 
    }
    
    public double getLongitude() {
        return longitude; 
    }
    
    public int getNoOfEmployees() {
        return noOfEmployees; 
    }
    
    public double getRevenueShare() {
        return revenueShare; 
    }
    
    public String getOpeningHours() {
        return openingHours; 
    }
}

