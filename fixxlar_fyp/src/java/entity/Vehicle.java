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
public class Vehicle {
    
    private int id;
    private String make;
    private String model;
    private int year;
    private String plateNumber;
    private int customerID;
    private String colour;
    private String control;
    private String ownerNric;
    
    public Vehicle(int id, String make, String model, int year, String plateNumber, int customerID, String colour, String control, String ownerNric) {
        this.id = id;
        this.make = make;
        this.model = model;
        this.year = year;
        this.plateNumber = plateNumber;
        this.customerID = customerID;
        this.colour = colour;
        this.control = control;
        this.ownerNric = ownerNric;
    }
    
    public Vehicle(int id, String make, String model, int year, String plateNumber, int customerID, String colour, String control) {
        this.id = id;
        this.make = make;
        this.model = model;
        this.year = year;
        this.plateNumber = plateNumber;
        this.customerID = customerID;
        this.colour = colour;
        this.control = control;
    }
    
    public Vehicle(int id, String make, String model, int year, String plateNumber, String colour, String control) {
        this.id = id;
        this.make = make;
        this.model = model;
        this.year = year;
        this.plateNumber = plateNumber;
        this.colour = colour;
        this.control = control;
    }
    public int getId() {
        return id;
    }
    
    public String getMake() {
        return make;
    }
    
    public String getModel() {
        return model;
    }
    
    public String getPlateNumber() {
        return plateNumber;
    }
    
    public int getYear() {
        return year;
    }
    
    public int getCustomerID() {
        return customerID;
    }
    
    public String getColour() {
        return colour;
    }
    
    public String getControl() {
        return control;
    }

    public String getOwnerNric() {
        return ownerNric;
    }

    public void setOwnerNric(String ownerNric) {
        this.ownerNric = ownerNric;
    }
}
