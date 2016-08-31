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
public class QuotationRequest {
    private int id;
    private String name;
    private String details;
    private String description;
    private String mileage;
    private String urgency;
    private double latitude;
    private double longitude;
    private String amenities;
    private String address;
    private String photos;
    private Timestamp requestedDate;
    private String category;
    private int noOfRejections;
    private int workshopId;
    private Customer customer;
    private Vehicle vehicle;
    private Offer offer;

    public QuotationRequest(int id, String name, String details, String description, Vehicle vehicle, String mileage, String urgency,
            String amenities, double latitude, double longitude, String address, String photos, Timestamp requestedDate, String category, int noOfRejections,
            int workshopId, Customer customer, Offer offer) {
        this.details = details;
        this.name = name;
        this.address = address;
        this.id = id;
        this.description = description;
        this.vehicle = vehicle;
        this.mileage = mileage;
        this.urgency = urgency;
        this.amenities = amenities;
        this.latitude = latitude;
        this.longitude = longitude;
        this.photos = photos;
        this.requestedDate = requestedDate;
        this.workshopId = workshopId;
        this.customer = customer;
        this.offer = offer;
        this.category = category;
        this.noOfRejections = noOfRejections;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDetails() {
        return details;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public String getDescription() {
        return description;
    }

    public String getMileage() {
        return mileage;
    }

    public String getUrgency() {
        return urgency;
    }

    public String getAmenities() {
        return amenities;
    }

    public String getAddress() {
        return address;
    }

    public String getPhotos() {
        return photos;
    }

    public double getLatitude() {
        return latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public Timestamp getRequestedDate() {
        return requestedDate;
    }

    
    public int getWorkshopId() {
        return workshopId;
    }
    
    public Customer getCustomer() {
        return customer;
    }
    
    public Offer getOffer() {
        return offer;
    }
    
    public String getCategory() {
        return category;
    }
    
    public int getNoOfRejections() {
        return noOfRejections;
    }
}

