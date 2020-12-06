/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.dtos;

import hautt.daos.CakeDAO;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;
import javax.naming.NamingException;

/**
 *
 * @author SE130205
 */
public class CartDTO {

    private Map<String, CakeDTO> cart;

    public CartDTO() {
    }

    public CartDTO(Map<String, CakeDTO> cart) {
        this.cart = cart;
    }

    public Map<String, CakeDTO> getCart() {
        return cart;
    }

    public void setCart(Map<String, CakeDTO> cart) {
        this.cart = cart;
    }

    public float getTotalAmount() {
        float total = 0;
        for (CakeDTO dto : cart.values()) {
            DecimalFormat df = new DecimalFormat("#.##");
            total = Float.parseFloat(df.format(total + dto.getTotal()));
        }
        return total;
    }

    public int getSize() {
        return this.cart.size();
    }

    public void add(CakeDTO dto) throws ClassNotFoundException, NamingException, SQLException {
        if (this.cart == null) {
            cart = new HashMap<>();
        }
        if (this.cart.containsKey(dto.getCakeID())) {
            int quantity = this.cart.get(dto.getCakeID()).getQuantity();
            dto.setQuantity(quantity + 1);
        } else {
            dto.setQuantity(1);
        }
        CakeDAO dao = new CakeDAO();
        int stockQuantity = dao.getCakeQuantity(dto.getCakeID());
        dto.setStockQuantity(stockQuantity);
        DecimalFormat df = new DecimalFormat("#.##");
        dto.setTotal(Float.parseFloat(df.format(dto.getPrice() * dto.getQuantity())));
        cart.put(dto.getCakeID(), dto);
    }

    public void delete(String cakeID) {
        if (this.cart != null) {
            if (this.cart.containsKey(cakeID)) {
                this.cart.remove(cakeID);
            }
        }
    }

    public void update(String cakeID, int quantity) {
        if (this.cart != null) {
            if (this.cart.containsKey(cakeID)) {
                this.cart.get(cakeID).setQuantity(quantity);
                DecimalFormat df = new DecimalFormat("#.##");
                this.cart.get(cakeID).setTotal(Float.parseFloat(df.format(this.cart.get(cakeID).getPrice() * this.cart.get(cakeID).getQuantity())));
            }
        }
    }
}
