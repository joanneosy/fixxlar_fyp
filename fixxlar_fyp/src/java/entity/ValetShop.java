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
    private String openingHoursDisplay;
    private String email;
    
    
    public ValetShop(int id, String name, String address, String email, double latitude, double longitude, int noOfEmployees, double revenueShare, String openingHours, String openingHoursDisplay) {
        this.id = id; 
        this.name = name; 
        this.address = address; 
        this.email = email;
        this.latitude = latitude; 
        this.longitude = longitude; 
        this.noOfEmployees = noOfEmployees; 
        this.revenueShare = revenueShare; 
        this.openingHours = openingHours; 
        this.openingHoursDisplay = openingHoursDisplay;
    }

    public String getOpeningHoursDisplay() {
        return openingHoursDisplay;
    }

    public void setOpeningHoursDisplay(String openingHoursDisplay) {
        this.openingHoursDisplay = openingHoursDisplay;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

