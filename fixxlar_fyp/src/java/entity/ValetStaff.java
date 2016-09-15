/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.Date;

/**
 *
 * @author Joanne
 */
public class ValetStaff {
    private int id;
    private int staffType;
    private String licenseNumber;
    private Date licenseIssueDate;
    private int valetShopId;
    private int status;
    
    public ValetStaff(int id, int staffType, String licenseNumber, Date licenseIssueDate, int valetShopId, int status) {
        this.id = id;
        this.staffType = staffType;
        this.licenseNumber = licenseNumber;
        this.licenseIssueDate = licenseIssueDate;
        this.valetShopId = valetShopId;
        this.status = status;
    }
    
    public int getId() {
        return staffType;
    }
    
    public int getStaffType() {
        return id;
    }
    
    public String getLicenseNumber() {
        return licenseNumber;
    }
    
    public Date getLicenseIssueDate() {
        return licenseIssueDate;
    }
    
    public int getValetShopId() {
        return valetShopId;
    }
    
    public int getStatus() {
        return status;
    }
    
}
