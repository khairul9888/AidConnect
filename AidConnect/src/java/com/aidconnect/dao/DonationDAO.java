package com.aidconnect.dao;

import com.aidconnect.db.DBConnection;
import com.aidconnect.model.Donation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DonationDAO {

    public boolean insertDonation(Donation donation) {
        boolean success = false;
        String sql = "INSERT INTO Donation (user_id, product_id, quantity, donation_date) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, donation.getUserId());
            stmt.setInt(2, donation.getProductId());
            stmt.setInt(3, donation.getQuantity());
            stmt.setDate(4, donation.getDonationDate());

            success = stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public List<Donation> getDonationsByUserId(int userId) {
        List<Donation> list = new ArrayList<>();
        String sql = "SELECT * FROM Donation WHERE user_id = ? ORDER BY donation_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Donation d = new Donation();
                d.setDonationId(rs.getInt("donation_id"));
                d.setUserId(rs.getInt("user_id"));
                d.setProductId(rs.getInt("product_id"));
                d.setQuantity(rs.getInt("quantity"));
                d.setDonationDate(rs.getDate("donation_date"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean deleteDonationById(int donationId) {
        boolean success = false;
        String sql = "DELETE FROM Donation WHERE donation_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, donationId);
            success = stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }

public List<Donation> getAllDonations() {
    List<Donation> donations = new ArrayList<>();

    String sql = "SELECT d.donation_id, d.user_id, d.product_id, d.quantity, d.donation_date, " +
                 "p.product_name, u.full_name " +
                 "FROM Donation d " +
                 "JOIN Product p ON d.product_id = p.product_id " +
                 "JOIN Users u ON d.user_id = u.user_id " +
                 "ORDER BY donation_date DESC";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Donation d = new Donation();
            d.setDonationId(rs.getInt("donation_id"));
            d.setUserId(rs.getInt("user_id"));
            d.setProductId(rs.getInt("product_id"));
            d.setQuantity(rs.getInt("quantity"));
            d.setDonationDate(rs.getDate("donation_date"));
            d.setProductName(rs.getString("product_name"));
            d.setFullName(rs.getString("full_name"));  // You need to add this property in Donation class
            donations.add(d);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return donations;
}


    public Donation getDonationById(int donationId) {
        Donation d = null;
        String sql = "SELECT * FROM Donation WHERE donation_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, donationId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                d = new Donation();
                d.setDonationId(rs.getInt("donation_id"));
                d.setUserId(rs.getInt("user_id"));
                d.setProductId(rs.getInt("product_id"));
                d.setQuantity(rs.getInt("quantity"));
                d.setDonationDate(rs.getDate("donation_date"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return d;
    }
    
    public boolean updateDonation(Donation donation) {
    boolean success = false;
    String sql = "UPDATE Donation SET product_id = ?, quantity = ?, donation_date = ? WHERE donation_id = ?";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, donation.getProductId());
        stmt.setInt(2, donation.getQuantity());
        stmt.setDate(3, donation.getDonationDate());
        stmt.setInt(4, donation.getDonationId());

        success = stmt.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return success;
}

}
