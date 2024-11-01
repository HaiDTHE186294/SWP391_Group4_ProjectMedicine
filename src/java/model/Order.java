/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author trant
 */
public class Order {
    private int orderId;
    private Date orderDate;
    private String status;
    private double orderTotal;
    private User userId;
    private List<OrderDetail> OrderDetail;

    public Order() {
    }

    public Order(int orderId, Date orderDate, String status, double orderTotal, User userId, List<OrderDetail> OrderDetail) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.status = status;
        this.orderTotal = orderTotal;
        this.userId = userId;
        this.OrderDetail = OrderDetail;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getOrderTotal() {
        return orderTotal;
    }

    public void setOrderTotal(double orderTotal) {
        this.orderTotal = orderTotal;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public List<OrderDetail> getOrderDetail() {
        return OrderDetail;
    }

    public void setOrderDetail(List<OrderDetail> OrderDetail) {
        this.OrderDetail = OrderDetail;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", orderDate=" + orderDate + ", status=" + status + ", orderTotal=" + orderTotal + ", userId=" + userId + ", OrderDetail=" + OrderDetail + '}';
    }
    
    
}
