/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.daos;

import hautt.dtos.OrderDetailDTO;
import hautt.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DecimalFormat;
import javax.naming.NamingException;

/**
 *
 * @author SE130205
 */
public class OrderDetailDAO {

    public boolean insert(OrderDetailDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement stm = null;
        DecimalFormat df = new DecimalFormat("#.##");
        try {
            conn = DBUtils.getConnection();
            String sql = "INSERT INTO tblOrderDetails( orderID, cakeID, quantity, price, total) VALUES(?,?,?," + df.format(dto.getPrice()) + "," + df.format(dto.getTotal()) + ")";
            stm = conn.prepareStatement(sql);
            stm.setString(1, dto.getOrderID());
            stm.setString(2, dto.getCakeID());
            stm.setInt(3, dto.getQuantity());
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
}
