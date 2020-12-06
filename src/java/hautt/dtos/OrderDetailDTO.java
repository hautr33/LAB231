/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.dtos;

import java.io.Serializable;

/**
 *
 * @author SE130205
 */
public class OrderDetailDTO implements Serializable {

    private String orderID, cakeID;
    private int quantity;
    private float price, total;

    public OrderDetailDTO(String orderID, String cakeID, int quantity, float price, float total) {
        this.orderID = orderID;
        this.cakeID = cakeID;
        this.quantity = quantity;
        this.price = price;
        this.total = total;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getCakeID() {
        return cakeID;
    }

    public void setCakeID(String cakeID) {
        this.cakeID = cakeID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

}
