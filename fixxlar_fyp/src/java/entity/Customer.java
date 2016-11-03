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
public class Customer {
    private int id;
    private String email;
    private String name;
    private String handphone;
    
    
    public Customer (int id, String email, String name, String handphone) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.handphone = handphone;
    }
    
    public int getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public String getEmail() {
        return email;
    }
    
    public String getHandphone() {
        return handphone;
    }

    
}
