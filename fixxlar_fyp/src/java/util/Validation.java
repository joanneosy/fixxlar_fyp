/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.util.ArrayList;

/**
 *
 * @author Joanne
 */
public class Validation {

    public ArrayList<String> validateWorkshop(String contact, String contact2, String postalCode, String openingHours) {
        ArrayList<String> errMsg = new ArrayList<String>();
        String err = isValidHomeContact(contact);
        if (err != null) {
            errMsg.add(err);
        }

        err = isValidMobileContact(contact2);
        if (err != null && !errMsg.contains(err)) {
            errMsg.add(err);
        }

        err = isValidPostalCode(postalCode);
        if (err != null) {
            errMsg.add(err);
        }

        err = isValidOpeningHours(openingHours);
        if (err != null) {
            errMsg.add(err);
        }
        return errMsg;
    }

    public ArrayList<String> validateNewEmployee(String contact, String password, String confirmPassword) {
        ArrayList<String> errMsg = new ArrayList<String>();
        String err = isValidMobileContact(contact);
        if (err != null) {
            errMsg.add(err);
        }
        
        err = isValidPassword(password, confirmPassword);
        if (err != null) {
            errMsg.add(err);
        }
        
        return errMsg;
    }
    
    public ArrayList<String> validateExistingEmployee(String contact) {
        ArrayList<String> errMsg = new ArrayList<String>();
        String err = isValidMobileContact(contact);
        if (err != null) {
            errMsg.add(err);
        }
        
        return errMsg;
    }

    public String isValidHomeContact(String contact) {
        try {
            int contactInt = Integer.parseInt(contact);
        } catch (NumberFormatException e) {
            return "Please enter valid contact numbers.";
        }
        if (contact.length() != 8) {
            return "Please enter a 8 digit contact number.";
        } else if (!contact.substring(0, 1).equals("6")) {
            return "Please enter an office contact number which starts with a 6.";
        }
        return null;
    }

    public String isValidMobileContact(String contact) {
        try {
            int contactInt = Integer.parseInt(contact);
        } catch (NumberFormatException e) {
            return "Please enter valid contact numbers.";
        }
        if (contact.length() != 8) {
            return "Please enter a 8 digit contact number.";
        } else if (!contact.substring(0, 1).equals("8") && !contact.substring(0, 1).equals("9")) {
            return "Please enter a mobile contact number which starts with a 8 or 9.";
        }
        return null;
    }

    public String isValidPostalCode(String postalCode) {
        if (postalCode == null || postalCode.length() != 6) {
            return "Please enter a valid postal code.";
        } else {
            try {
                int postalCodeInt = Integer.parseInt(postalCode);
            } catch (NumberFormatException e) {
                return "Please enter a valid postal code.";
            }
        }
        return null;
    }

    public String isValidOpeningHours(String openingHours) {
        String[] openingHoursArr = openingHours.split(",");
        for (String s : openingHoursArr) {
            String[] eachDayArr = s.split("-");
            if (eachDayArr[1].equals("Closed") || eachDayArr[2].equals("Closed")) {
                if (!eachDayArr[1].equals(eachDayArr[2])) {
                    return "Please enter valid opening hours.";
                }
            } else {
                int open = Integer.parseInt(eachDayArr[1]);
                int close = Integer.parseInt(eachDayArr[2]);
                if (open > close) {
                    return "Please enter valid opening hours.";
                }
            }
        }
        return null;
    }

    public String isValidPassword(String password, String confirmPassword) {
        if (password == null || password.length() < 8 || confirmPassword == null || confirmPassword.length() < 8) {
            return "Please enter a password with at least 8 characters.";
        } else if (!password.equals(confirmPassword)) {
            return "Please enter the matching passwords.";
        }
        return null;
    }

}
