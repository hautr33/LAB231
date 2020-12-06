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
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author SE130205
 */
public class UserDAO {

    public List<UserDTO> getAllUsers() throws ClassNotFoundException, NamingException, SQLException {
        List<UserDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT userID, username, facebookID, name, phone, address, roleID, status FROM tblUsers";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String username = rs.getString("username");
                    String facebookID = rs.getString("facebookID");
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String roleID = rs.getString("roleID");
                    String status = rs.getString("status");
                    String tempSql = "SELECT roleName FROM tblRoles WHERE roleID = ?";
                    PreparedStatement tempStm = conn.prepareStatement(tempSql);
                    tempStm.setString(1, roleID);
                    ResultSet tempRs = tempStm.executeQuery();
                    if (tempRs.next()) {
                        String roleName = tempRs.getString("roleName");
                        result.add(new UserDTO(userID, facebookID, username, name, phone, address, roleName, status));
                    }
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

    public UserDTO checkLogin(String username, String password) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT userID, name, phone, address, roleID FROM tblUsers WHERE username = ? AND password = ?  AND status = 'Active'";
                stm = conn.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String userID = rs.getString("userID");
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String roleID = rs.getString("roleID");
                    result = new UserDTO(userID, name, phone, address, roleID);
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

    public UserDTO getUser(String userID) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT userID, name, phone, address, roleID FROM tblUsers WHERE userID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String roleID = rs.getString("roleID");
                    result = new UserDTO(userID, name, phone, address, roleID);
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

    public boolean register(UserDTO dto) throws ClassNotFoundException, SQLException, NamingException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblUsers(name, address, phone, status, roleID) VALUES(?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getName());
                stm.setString(2, dto.getAddress());
                stm.setString(3, dto.getPhone());
                stm.setString(4, "Active");
                stm.setString(5, dto.getRoleID());
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

    public String getGuestID(UserDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        String result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT userID FROM tblUsers WHERE name = ? AND address = ? AND phone = ? AND status = ? AND roleID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getName());
                stm.setString(2, dto.getAddress());
                stm.setString(3, dto.getPhone());
                stm.setString(4, "Active");
                stm.setString(5, dto.getRoleID());
                rs = stm.executeQuery();
                if (rs.next()) {
                    result = rs.getString("userID");
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

    public boolean registerFacebook(UserDTO dto) throws ClassNotFoundException, SQLException, NamingException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblUsers(name, facebookID, status, roleID) VALUES(?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getName());
                stm.setString(2, dto.getFacebookID());
                stm.setString(3, "Active");
                stm.setString(4, "MB");
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

    public UserDTO checkLogin(String facebookID) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT userID, name, phone, address, roleID FROM tblUsers WHERE facebookID = ? AND status = 'Active'";
                stm = conn.prepareStatement(sql);
                stm.setString(1, facebookID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String userID = rs.getString("userID");
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String roleID = rs.getString("roleID");
                    result = new UserDTO(userID, name, phone, address, roleID);
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

    public boolean updateInfo(UserDTO dto) throws ClassNotFoundException, SQLException, NamingException {
        boolean isUpdate = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblUsers SET name = ?, address = ?, phone = ? "
                        + "WHERE userID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getName());
                stm.setString(2, dto.getAddress());
                stm.setString(3, dto.getPhone());
                stm.setString(4, dto.getUserID());
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
