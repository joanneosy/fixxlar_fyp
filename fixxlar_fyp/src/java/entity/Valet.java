/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author User
 */
public class Valet {

    private int id;
    private String name;
    private String address;
    private double latitude;
    private double longitude;
    private int no_of_employees;
    private double revenue_share;
    private String opening_hours;

    public Valet(int id, String name, String address, double latitude, double longitude, int no_of_employees, double revenue_share, String opening_hours) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.latitude = latitude;
        this.longitude = longitude;
        this.no_of_employees = no_of_employees;
        this.revenue_share = revenue_share;
        this.opening_hours = opening_hours;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public int getNo_of_employees() {
        return no_of_employees;
    }

    public void setNo_of_employees(int no_of_employees) {
        this.no_of_employees = no_of_employees;
    }

    public double getRevenue_share() {
        return revenue_share;
    }

    public void setRevenue_share(double revenue_share) {
        this.revenue_share = revenue_share;
    }

    public String getOpening_hours() {
        return opening_hours;
    }

    public void setOpening_hours(String opening_hours) {
        this.opening_hours = opening_hours;
    }

}
