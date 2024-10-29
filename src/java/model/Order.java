/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author M7510
 */
public class Order {

    private String order_id;
    private Date order_date;
    private int status;
    private float order_total;
    private int user_id;
    private int sales_id;
    
    private OrderUser user;
    
    private User sales;

    private List<OrderDetail> orderDetail = new ArrayList<>();

    public Order() {
    }

    public Order(String order_id, Date order_date, int status, float order_total, int user_id) {
        this.order_id = order_id;
        this.order_date = order_date;
        this.status = status;
        this.order_total = order_total;
        this.user_id = user_id;
    }

    public Order(String order_id, Date order_date, int status, float order_total, int user_id, int sales_id) {
        this.order_id = order_id;
        this.order_date = order_date;
        this.status = status;
        this.order_total = order_total;
        this.user_id = user_id;
        this.sales_id = sales_id;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public float getOrder_total() {
        return order_total;
    }

    public void setOrder_total(float order_total) {
        this.order_total = order_total;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public List<OrderDetail> getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(List<OrderDetail> orderDetail) {
        this.orderDetail = orderDetail;
    }

    public OrderUser getUser() {
        return user;
    }

    public void setUser(OrderUser user) {
        this.user = user;
    }

    public int getSales_id() {
        return sales_id;
    }

    public void setSales_id(int sales_id) {
        this.sales_id = sales_id;
    }

    public String getStatus(int status) {
        return switch (status) {
            case 0 -> "Pending";
            case 1 -> "Submitted";
            case 2 -> "Delivering";
            case 3 -> "Completed";
            case 4 -> "Canceled";
            case 5 -> "Refunded";
            default -> null;
        };
    }

    public User getSales() {
        return sales;
    }

    public void setSales(User sales) {
        this.sales = sales;
    }
}
