/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.daos;

import hautt.dtos.EmotionDTO;
import hautt.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author SE130205
 */
public class EmotionDAO {

    public String checkEmotion(String articleID, String email) throws SQLException, ClassNotFoundException, NamingException {
        String result = "";
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT status FROM tblEmotions WHERE articleID = ? AND email = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, articleID);
                stm.setString(2, email);
                rs = stm.executeQuery();
                if (rs.next()) {
                    result = rs.getString("status");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public boolean addEmotion(EmotionDTO dto) throws ClassNotFoundException, NamingException, SQLException {
        boolean isAdd = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblEmotions(articleID, email, status) VALUES(?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getArticleID());
                stm.setString(2, dto.getEmail());
                stm.setString(3, dto.getStatus());
                if (stm.executeUpdate() > 0) {
                    isAdd = true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return isAdd;
    }

    public boolean updateEmotion(EmotionDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean isUpdate = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblEmotions SET status = ? WHERE articleID = ? AND email = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getStatus());
                stm.setString(2, dto.getArticleID());
                stm.setString(3, dto.getEmail());
                if (stm.executeUpdate() > 0) {
                    isUpdate = true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return isUpdate;
    }
}
