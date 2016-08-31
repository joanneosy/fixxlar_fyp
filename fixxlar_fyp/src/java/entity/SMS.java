/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Fixxlar
 */
public class SMS {

    private String recipient;
    private String message;
    private String username;
    private String password;
    private String requestUrl;
    
    public SMS (String recipient, String message, String username, String password, String requestUrl) {
        this.recipient = recipient;
        this.message = message;
        this.username = username;
        this.password = password;
        this.requestUrl = requestUrl;

    }
    public String getRecipient() {
        return recipient;
    }
    
    public String getMessage() {
        return message;
    }

    public String getUsername() {
        return username;
    } 
    
    public String getPassword() {
        return password;
    }

    public String getRequestUrl() {
        return requestUrl;
    }


}
