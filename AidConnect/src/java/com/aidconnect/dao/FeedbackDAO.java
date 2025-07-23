package com.aidconnect.dao;

import com.aidconnect.db.DBConnection;
import com.aidconnect.model.Feedback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    public List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.feedback_id, f.user_id, f.message, f.submitted_at, u.full_name " +
                     "FROM Feedback f JOIN Users u ON f.user_id = u.user_id " +
                     "ORDER BY submitted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackId(rs.getInt("feedback_id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setMessage(rs.getString("message"));
                fb.setSubmittedAt(rs.getDate("submitted_at"));
                fb.setUserFullName(rs.getString("full_name"));
                list.add(fb);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
