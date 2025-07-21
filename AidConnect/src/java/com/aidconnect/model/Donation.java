package com.aidconnect.model;

import java.sql.Date;

public class Donation {
    private int donationId;
    private int userId;
    private int productId;
    private int quantity;
    private Date donationDate;

    // ✅ Add this for display use (e.g. join with Product table)
    private String productName;

    // Constructors
    public Donation() {}

    public Donation(int userId, int productId, int quantity, Date donationDate) {
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.donationDate = donationDate;
    }

    public Donation(int donationId, int userId, int productId, int quantity, Date donationDate) {
        this.donationId = donationId;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.donationDate = donationDate;
    }

    // Getters & Setters
    public int getDonationId() {
        return donationId;
    }

    public void setDonationId(int donationId) {
        this.donationId = donationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getDonationDate() {
        return donationDate;
    }

    public void setDonationDate(Date donationDate) {
        this.donationDate = donationDate;
    }

    // ✅ Getter and Setter for productName
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    private String fullName;

public String getFullName() {
    return fullName;
}

public void setFullName(String fullName) {
    this.fullName = fullName;
}

}
