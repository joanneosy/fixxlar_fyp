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
public class Offer {

    private int id;
    private int serviceId;
    private Timestamp estCompletionTime;
    private double finalPrice;
    private int status;
    private int workshopId;
    private double initialMinPrice;
    private double initialMaxPrice;
    private double diagnosticPrice;

    public Offer(int id, int serviceId, int workshopId, int status, double initialMinPrice, double initialMaxPrice, double diagnosticPrice, double finalPrice, Timestamp estCompletionTime) {
        this.id = id;
        this.serviceId = serviceId;
        this.estCompletionTime = estCompletionTime;
        this.finalPrice = finalPrice;
        this.status = status;
        this.workshopId = workshopId;
        this.initialMinPrice = initialMinPrice; 
        this.initialMaxPrice = initialMaxPrice;
        this.diagnosticPrice = diagnosticPrice;
    }
    
    public int getId() {
        return id;
    }
    
    public int getServiceId() {
        return serviceId;
    }
    
    public int getWorkshopId() {
        return workshopId;
    }
    
    public int getStatus() {
        return status;
    }
    
    public double getInitialMinPrice() {
        return initialMinPrice;
    }
    
    public double getInitialMaxPrice() {
        return initialMaxPrice;
    }
    
    public double getFinalPrice() {
        return finalPrice;
    }
    
    public Timestamp getEstCompletionTime() {
        return estCompletionTime;
    }
    
    public double getDiagnosticPrice() {
        return diagnosticPrice;
    }
}
