/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.daos;

import hautt.dtos.OrderDTO;
import hautt.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import javax.naming.NamingException;

/**
 *
 * @author SE130205
 */
public class OrderDAO {

    public boolean insert(OrderDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        DecimalFormat df = new DecimalFormat("#.##");
        try {
            conn = DBUtils.getConnection();
            String sql = "INSERT INTO tblOrders(userID, name, address, phone, note, orderDate, arrivalDate, payment, totalAmount, status) "
                    + "VALUES(?,?,?,?,?,?,?,?," + df.format(dto.getTotalAmount()) + ",?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, dto.getUserID());
            stm.setString(2, dto.getName());
            stm.setString(3, dto.getAddress());
            stm.setString(4, dto.getPhone());
            stm.setString(5, dto.getNote());
            stm.setTimestamp(6, dto.getOrderDate());
            stm.setTimestamp(7, dto.getArrivalDate());
            stm.setString(8, dto.getPayment());
            stm.setString(9, dto.getStatus());
            if (stm.executeUpdate() > 0) {
                result = true;
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

    public String getOrderID(String userID, Timestamp orderDate) throws ClassNotFoundException, NamingException, SQLException {
        String result = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT orderID "
                        + "FROM tblOrders "
                        + "WHERE userID = ? AND orderDate = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setTimestamp(2, orderDate);
                rs = stm.executeQuery();
                if (rs.next()) {
                    result = rs.getString("orderID");
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
}
