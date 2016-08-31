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
public class Schedule {
    private int id;
    private int serviceId;
    private int shopId;
    private Timestamp startTime;
    private Timestamp endTime;
    
    public Schedule (int id, int serviceId, int shopId, Timestamp startTime, Timestamp endTime) {
        this.id = id; 
        this.serviceId = serviceId;
        this.shopId = shopId;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    
    public int getId() {
        return id;
    }
    
    public int getServiceId() {
        return serviceId;
    }
    
    public int getShopId() {
        return shopId;
    }
    
    public Timestamp getStartTime() {
        return startTime;
    }
    
    public Timestamp getEndTime() {
        return endTime;
    }
}
