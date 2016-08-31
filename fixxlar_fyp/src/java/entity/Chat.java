/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Timestamp;

/**
 *
 * @author User
 */
public class Chat {
    private int id;
    private int topic_id;
    private String message;
    private int type;
    private Timestamp modified;
    private Timestamp created;
    private Timestamp deleted_at;
    private int service_id;
    private int user_id;
    private int shop_id;
    private String last_message;
    private String user_name;
    
    public Chat(int id,int topic_id,String message,int type,Timestamp modified,Timestamp created,Timestamp deleted_at){
        this.id = id;
        this.topic_id = topic_id;
        this.message = message;
        this.type = type;
        this.modified = modified;
        this.created = created;
        this.deleted_at = deleted_at;
    }
    
    public Chat(int id,int service_id,int user_id,int shop_id,String last_message,Timestamp modified,Timestamp created,Timestamp deleted_at,String user_name){
        this.id = id;
        this.service_id = service_id;
        this.user_id = user_id;
        this.shop_id = shop_id;
        this.last_message = last_message;
        this.modified = modified;
        this.created = created;
        this.deleted_at = deleted_at;
        this.user_name = user_name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTopic_id() {
        return topic_id;
    }

    public void setTopic_id(int topic_id) {
        this.topic_id = topic_id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Timestamp getModified() {
        return modified;
    }

    public void setModified(Timestamp modified) {
        this.modified = modified;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public Timestamp getDeleted_at() {
        return deleted_at;
    }

    public void setDeleted_at(Timestamp deleted_at) {
        this.deleted_at = deleted_at;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getShop_id() {
        return shop_id;
    }

    public void setShop_id(int shop_id) {
        this.shop_id = shop_id;
    }

    public String getLast_message() {
        return last_message;
    }

    public void setLast_message(String last_message) {
        this.last_message = last_message;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
    
    
}
