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
public class Notification {
    private int id;
    private int staffId;
    private int messageId;
    private String predefinedMessage;
    private String actualMessage;
    
    public Notification(int id, int staffId, int messageId, String predefinedMessage, String actualMessage) {
        this.id = id;
        this.staffId = staffId;
        this.messageId = messageId;
        this.predefinedMessage = predefinedMessage;
        this.actualMessage = actualMessage;
    }
    
    public int getId() {
        return id;
    }
    
    public int getStaffId() {
        return staffId;
    }
    
    public int getMessageId() {
        return messageId;
    }
    
    public String getPredefinedMessage() {
        return predefinedMessage;
    }
    
    public String getActualMessage() {
        return actualMessage;
    }
}
