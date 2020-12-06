/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.daos;

import hautt.dtos.UserDTO;
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
public class UserDAO {

    public UserDTO checkLogin(String email, String password) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT name, roleID, status FROM tblUsers WHERE email = ? AND password = ?  AND (status = 'New' OR status = 'Verified')";
                stm = conn.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    String role = rs.getString("roleID");
                    String status = rs.getString("status");
                    result = new UserDTO(email, name, "", role, status);
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

    public UserDTO getUser(String email) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT name FROM tblUsers WHERE email = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, email);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    result = new UserDTO(email, name, "", "", "");
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

    public boolean verifyAccount(String email) throws SQLException, ClassNotFoundException, NamingException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblUsers SET status = 'Verified' WHERE email = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, email);
                if (stm.executeUpdate() > 0) {
                    result = true;
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
        return result;
    }

    public boolean registerAccount(UserDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean isRegister = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblUsers(email, password, name, roleID, status) VALUES(?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getEmail());
                stm.setString(2, dto.getPassword());
                stm.setString(3, dto.getName());
                stm.setString(4, dto.getRoleID());
                stm.setString(5, dto.getStatus());
                if (stm.executeUpdate() > 0) {
                    isRegister = true;
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
        return isRegister;
    }
}
