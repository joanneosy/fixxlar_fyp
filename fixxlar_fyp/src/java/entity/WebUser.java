/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author joanne.ong.2014
 */
public class WebUser {

    private int staffId;
    private String email;
    private String password;
    private int userType;
    private int refStaffId;
    private String token;
    private int shopId;
    private String handphone;
    private String name;
    private int staffType;
    private String chatToken;

    public WebUser(int staffId, String email, int userType, int refStaffId, String token, int shopId, String name, String handphone, int staffType) {
        this.staffId = staffId;
        this.email = email;
        this.userType = userType;
        this.refStaffId = refStaffId;
        this.token = token;
        this.shopId = shopId;
        this.handphone = handphone;
        this.name = name;
        this.staffType = staffType;
    }
    public WebUser(int staffId, String email, int userType, int refStaffId, String token, int shopId, String name, String handphone, int staffType, String chatToken) {
        this.staffId = staffId;
        this.email = email;
        this.userType = userType;
        this.refStaffId = refStaffId;
        this.token = token;
        this.shopId = shopId;
        this.handphone = handphone;
        this.name = name;
        this.staffType = staffType;
        this.chatToken = chatToken;
    }

    //getter methods
    /**
     * Returns the email.
     *
     * @return the email
     */
    public int getStaffId() {
        return staffId;
    }

    /**
     * Returns the email.
     *
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * Returns the user type.
     *
     * @return the user type
     */
    public int getUserType() {
        return userType;
    }

    public int getRefStaffId() {
        return refStaffId;
    }

    public String getToken() {
        return token;
    }

    public int getShopId() {
        return shopId;
    }

    public String getName() {
        return name;
    }

    public String getHandphone() {
        return handphone;
    }

    //Whether the user is super / master / normal user
    public int getStaffType() {
        return staffType;
    }
    
    public String getChatToken(){
        return chatToken;
    }
}
