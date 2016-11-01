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
    private String wsInitialComment;
    private String wsFinalComment;
    private String driverInitialComment;

    public Offer(int id, int serviceId, int workshopId, int status, double initialMinPrice, double initialMaxPrice, double diagnosticPrice, double finalPrice, Timestamp estCompletionTime, String wsInitialComment, String wsFinalComment, String driverInitialComment) {
        this.id = id;
        this.serviceId = serviceId;
        this.estCompletionTime = estCompletionTime;
        this.finalPrice = finalPrice;
        this.status = status;
        this.workshopId = workshopId;
        this.initialMinPrice = initialMinPrice; 
        this.initialMaxPrice = initialMaxPrice;
        this.diagnosticPrice = diagnosticPrice;
        this.wsInitialComment = wsInitialComment;
        this.wsFinalComment = wsFinalComment;
        this.driverInitialComment = driverInitialComment;
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

    public String getDriverInitialComment() {
        return driverInitialComment;
    }

    public void setDriverInitialComment(String driverInitialComment) {
        this.driverInitialComment = driverInitialComment;
    }

    public String getWsInitialComment() {
        return wsInitialComment;
    }

    public void setWsInitialComment(String wsInitialComment) {
        this.wsInitialComment = wsInitialComment;
    }

    public String getWsFinalComment() {
        return wsFinalComment;
    }

    public void setWsFinalComment(String wsFinalComment) {
        this.wsFinalComment = wsFinalComment;
    }
    
}
