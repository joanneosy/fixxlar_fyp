/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Timestamp;

/**
 *
 * @author Joanne
 */
public class ValetRequest {
    
    private int id; 
    private Vehicle vehicle;
    private Customer customer;
    private int serviceType;
    private WebUser valetDriver;
    private String pickUpAddress;
    private double pickUpLatitude;
    private double pickUpLongitude;
    private String dropOffAddress;
    private double dropOffLatitude;
    private double dropOffLongitude;
    private Timestamp scheduledPickUpTime;
    private Timestamp actualPickUpTime;
    private Timestamp completedTime;
    private double price;
    private int offerId;
    private int status;
    
    public ValetRequest(int id, Vehicle vehicle, Customer customer, int serviceType, WebUser valetDriver, String pickUpAddress, double pickUpLatitude, double pickUpLongitude, String dropOffAddress, 
            double dropOffLatitude, double dropOffLongitude, Timestamp scheduledPickUpTime, Timestamp actualPickUpTime, Timestamp completedTime, double price, int offerId, int status) {
        this.id = id;
        this.vehicle = vehicle;
        this.serviceType = serviceType;
        this.valetDriver = valetDriver;
        this.pickUpAddress = pickUpAddress;
        this.pickUpLatitude = pickUpLatitude;
        this.pickUpLongitude = pickUpLongitude;
        this.dropOffAddress = dropOffAddress;
        this.dropOffLatitude = dropOffLatitude;
        this.dropOffLongitude = dropOffLongitude;
        this.scheduledPickUpTime = scheduledPickUpTime;
        this.actualPickUpTime = actualPickUpTime;
        this.completedTime = completedTime;
        this.price = price;
        this.offerId = offerId;
        this.status = status;  
    }
    
    public int getId() {
        return id; 
    }
    
    public Vehicle getVehicle() {
        return vehicle; 
    }
    
    public Customer getCustomer() {
        return customer; 
    }
    
    public int getServiceType() {
        return serviceType; 
    }
    
    public WebUser getValetDriver() {
        return valetDriver; 
    }
    
    public String getPickUpAddress() {
        return pickUpAddress; 
    }
    
    public double getPickUpLatitude() {
        return pickUpLatitude; 
    }
    
    public double getPickUpLongitude() {
        return pickUpLongitude; 
    }
    
    public String getDropOffAddress() {
        return dropOffAddress; 
    }
    
    public double getDropOffLatitude() {
        return dropOffLatitude; 
    }
    
    public double getDropOffLongitude() {
        return dropOffLongitude; 
    }
    
    public Timestamp getScheduledPickUpTime() {
        return scheduledPickUpTime; 
    }
    
    public Timestamp getActualPickUpTime() {
        return actualPickUpTime; 
    }
    
    public Timestamp getCompletedTime() {
        return completedTime; 
    }
    
    public double getPrice() {
        return price; 
    }
    
    public int getOfferId() {
        return offerId; 
    }
    
    public int getStatus() {
        return status; 
    }
}
