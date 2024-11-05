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
    
    // thêm 
    private String phone_number_order;
    private String address;
    

    public Order() {
    }

    public Order(int orderId, Date orderDate, String status, double orderTotal, User userId, String phone_number_order, String address) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.status = status;
        this.orderTotal = orderTotal;
        this.userId = userId;
        this.phone_number_order = phone_number_order;
        this.address = address;
    }

    public Order(int orderId, Date orderDate, String status, double orderTotal, User userId, List<OrderDetail> OrderDetail) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.status = status;
        this.orderTotal = orderTotal;
        this.userId = userId;
        this.OrderDetail = OrderDetail;
    }

    public Order(int orderId, Date orderDate, String status, double orderTotal, User userId, List<OrderDetail> OrderDetail, String phone_number_order, String address) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.status = status;
        this.orderTotal = orderTotal;
        this.userId = userId;
        this.OrderDetail = OrderDetail;
        this.phone_number_order = phone_number_order;
        this.address = address;
    }

    
    
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }



    public String getPhone_number_order() {
        return phone_number_order;
    }

    public void setPhone_number_order(String phone_number_order) {
        this.phone_number_order = phone_number_order;
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
        return "Order{" + "orderId=" + orderId + ", orderDate=" + orderDate + ", status=" + status + ", orderTotal=" + orderTotal + ", userId=" + userId + ", OrderDetail=" + OrderDetail + ", phone_number_order=" + phone_number_order + ", address=" + address + '}';
    }

 
    
}
