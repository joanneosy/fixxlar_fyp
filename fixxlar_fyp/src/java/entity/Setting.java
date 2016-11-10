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
public class Setting {
    private int id; 
    private String category;
    private String name;
    private String value; 
    
    public Setting(int id, String category, String name, String value) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.value = value;
    }
    
    public int getId() {
        return id;
    }
    
    public String getCategory() {
        return category;
    }
    
    public String getName() {
        return name;
    }
    
    public String getValue() {
        return value;
    }
}
