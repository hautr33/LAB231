/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.daos;

import hautt.dtos.CakeDTO;
import hautt.utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author SE130205
 */
public class CakeDAO {

    public List<CakeDTO> getAllCakes(int curPage) throws ClassNotFoundException, NamingException, SQLException {
        List<CakeDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Date today = Date.valueOf(LocalDate.now());
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT cakeID, cakeName, description, imageURL, price, categoryID, quantity, createDate, expirationDate "
                        + "FROM tblCakes "
                        + "WHERE status = 'Active' AND quantity > 0 AND expirationDate >= ? "
                        + "ORDER BY expirationDate "
                        + "OFFSET (? - 1) * 20 ROWS "
                        + "FETCH NEXT 20 ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setDate(1, today);
                stm.setInt(2, curPage);
                rs = stm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    String cakeID = rs.getString("cakeID");
                    String cakeName = rs.getString("cakeName");
                    String description = rs.getString("description");
                    String imageURL = rs.getString("imageURL");
                    float price = rs.getFloat("price");
                    String categoryID = rs.getString("categoryID");
                    int quantity = rs.getInt("quantity");
                    Date createDate = rs.getDate("createDate");
                    Date expirationDate = rs.getDate("expirationDate");
                    result.add(new CakeDTO(cakeID, cakeName, imageURL, description, categoryID, price, quantity, createDate, expirationDate));
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

    public boolean updateStatus() throws ClassNotFoundException, SQLException, NamingException {
        boolean isUpdate = false;
        Connection conn = null;
        PreparedStatement stm = null;
        Date today = Date.valueOf(LocalDate.now());
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblCakes SET status = 'Expired' "
                        + "WHERE expirationDate <= ?";
                stm = conn.prepareStatement(sql);
                stm.setDate(1, today);
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

    public boolean updateQuantity(String cakeID, int quantity) throws ClassNotFoundException, SQLException, NamingException {
        boolean isUpdate = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblCakes SET quantity = ? "
                        + "WHERE cakeID = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, quantity);
                stm.setString(2, cakeID);
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

    public CakeDTO getCake(String cakeID) throws ClassNotFoundException, NamingException, SQLException {
        CakeDTO result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Date today = Date.valueOf(LocalDate.now());
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT cakeID, cakeName, description, imageURL, price, categoryID, quantity, createDate, expirationDate, status "
                        + "FROM tblCakes "
                        + "WHERE cakeID = ? AND status = 'Active' AND quantity > 0 AND expirationDate >= ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, cakeID);
                stm.setDate(2, today);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String cakeName = rs.getString("cakeName");
                    String description = rs.getString("description");
                    String imageURL = rs.getString("imageURL");
                    float price = rs.getFloat("price");
                    String categoryID = rs.getString("categoryID");
                    int quantity = rs.getInt("quantity");
                    Date createDate = rs.getDate("createDate");
                    Date expirationDate = rs.getDate("expirationDate");
                    String status = rs.getString("status");
                    result = new CakeDTO(cakeID, cakeName, imageURL, description, categoryID, price, quantity, createDate, expirationDate);
                    result.setStatus(status);
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

    public List<CakeDTO> searchCakeName(String search, int curPage) throws ClassNotFoundException, NamingException, SQLException {
        List<CakeDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Date today = Date.valueOf(LocalDate.now());
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT cakeID, cakeName, description, imageURL, price, categoryID, quantity, createDate, expirationDate "
                        + "FROM tblCakes "
                        + "WHERE cakeName LIKE ? AND status = 'Active' AND quantity > 0 AND expirationDate >= ? "
                        + "ORDER BY expirationDate "
                        + "OFFSET (? - 1) * 20 ROWS "
                        + "FETCH NEXT 20 ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setString(1, "%" + search + "%");
                stm.setDate(2, today);
                stm.setInt(3, curPage);
                rs = stm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    String cakeID = rs.getString("cakeID");
                    String cakeName = rs.getString("cakeName");
                    String description = rs.getString("description");
                    String imageURL = rs.getString("imageURL");
                    float price = rs.getFloat("price");
                    String categoryID = rs.getString("categoryID");
                    int quantity = rs.getInt("quantity");
                    Date createDate = rs.getDate("createDate");
                    Date expirationDate = rs.getDate("expirationDate");
                    result.add(new CakeDTO(cakeID, cakeName, imageURL, description, categoryID, price, quantity, createDate, expirationDate));
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

    public List<CakeDTO> searchCakePrice(float fromPrice, float toPrice, int curPage) throws ClassNotFoundException, NamingException, SQLException {
        List<CakeDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Date today = Date.valueOf(LocalDate.now());
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT cakeID, cakeName, description, imageURL, price, categoryID, quantity, createDate, expirationDate "
                        + "FROM tblCakes "
                        + "WHERE price >= ? AND price <= ? AND status = 'Active' AND quantity > 0 AND expirationDate >= ? "
                        + "ORDER BY expirationDate "
                        + "OFFSET (? - 1) * 20 ROWS "
                        + "FETCH NEXT 20 ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setFloat(1, fromPrice);
                stm.setFloat(2, toPrice);
                stm.setDate(3, today);
                stm.setInt(4, curPage);
                rs = stm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    String cakeID = rs.getString("cakeID");
                    String cakeName = rs.getString("cakeName");
                    String description = rs.getString("description");
                    String imageURL = rs.getString("imageURL");
                    float price = rs.getFloat("price");
                    String categoryID = rs.getString("categoryID");
                    int quantity = rs.getInt("quantity");
                    Date createDate = rs.getDate("createDate");
                    Date expirationDate = rs.getDate("expirationDate");
                    result.add(new CakeDTO(cakeID, cakeName, imageURL, description, categoryID, price, quantity, createDate, expirationDate));
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

    public List<CakeDTO> searchCakeCategory(String categoryID, int curPage) throws ClassNotFoundException, NamingException, SQLException {
        List<CakeDTO> result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Date today = Date.valueOf(LocalDate.now());
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT cakeID, cakeName, description, imageURL, price, categoryID, quantity, createDate, expirationDate "
                        + "FROM tblCakes "
                        + "WHERE categoryID = ? AND status = 'Active' AND quantity > 0 AND expirationDate >= ? "
                        + "ORDER BY expirationDate "
                        + "OFFSET (? - 1) * 20 ROWS "
                        + "FETCH NEXT 20 ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setString(1, categoryID);
                stm.setDate(2, today);
                stm.setInt(3, curPage);
                rs = stm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    String cakeID = rs.getString("cakeID");
                    String cakeName = rs.getString("cakeName");
                    String description = rs.getString("description");
                    String imageURL = rs.getString("imageURL");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
                    Date createDate = rs.getDate("createDate");
                    Date expirationDate = rs.getDate("expirationDate");
                    result.add(new CakeDTO(cakeID, cakeName, imageURL, description, categoryID, price, quantity, createDate, expirationDate));
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

    public boolean createCake(CakeDTO dto) throws ClassNotFoundException, NamingException, SQLException {
        boolean isPost = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblCakes(cakeName, description, imageURL, price, categoryID, quantity, createDate, expirationDate, status, lastUpdateDate, lastUpdateUser) VALUES(?,?,?," + dto.getPriceString() + ",?,?,?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getCakeName());
                stm.setString(2, dto.getDescription());
                stm.setString(3, dto.getImageURL());
                stm.setString(4, dto.getCategoryID());
                stm.setInt(5, dto.getQuantity());
                stm.setDate(6, dto.getCreateDate());
                stm.setDate(7, dto.getExpirationDate());
                stm.setString(8, "Active");
                stm.setTimestamp(9, dto.getLastUpdateDate());
                stm.setString(10, dto.getLastUpdateUser());
                if (stm.executeUpdate() > 0) {
                    isPost = true;
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
        return isPost;
    }

    public boolean updateCake(CakeDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean isUpdate = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE tblCakes SET cakeName = ?, description = ?, imageURL = ?, price = " + dto.getPriceString() + ", categoryID = ?, quantity = ?, createDate = ?, expirationDate = ?, status = ?, lastUpdateDate = ?, lastUpdateUser = ? "
                        + "WHERE cakeID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getCakeName());
                stm.setString(2, dto.getDescription());
                stm.setString(3, dto.getImageURL());
                stm.setString(4, dto.getCategoryID());
                stm.setInt(5, dto.getQuantity());
                stm.setDate(6, dto.getCreateDate());
                stm.setDate(7, dto.getExpirationDate());
                stm.setString(8, "Active");
                stm.setTimestamp(9, dto.getLastUpdateDate());
                stm.setString(10, dto.getLastUpdateUser());
                stm.setString(11, dto.getCakeID());
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

    public int getCakeQuantity(String cakeID) throws ClassNotFoundException, NamingException, SQLException {
        int quantity = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Date today = Date.valueOf(LocalDate.now());
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT quantity FROM tblCakes WHERE cakeID = ? AND status = 'Active' AND quantity > 0 AND expirationDate >= ? ";
                stm = conn.prepareStatement(sql);
                stm.setString(1, cakeID);
                stm.setDate(2, today);
                rs = stm.executeQuery();
                if (rs.next()) {
                    quantity = rs.getInt("quantity");
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
        return quantity;
    }
}
