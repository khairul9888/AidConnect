package com.aidconnect.dao;

import com.aidconnect.db.DBConnection;
import com.aidconnect.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public boolean registerUser(User user) {
        boolean result = false;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO Users (full_name, email, password, phone, role, registration_date) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getRole());
            stmt.setDate(6, new java.sql.Date(user.getRegistrationDate().getTime()));

            int rowsInserted = stmt.executeUpdate();
            result = (rowsInserted > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // ✅ Add this method below
    public User login(String email, String password) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM Users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setRegistrationDate(rs.getDate("registration_date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
