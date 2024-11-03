/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;
import java.util.Map;

/**
 *
 * @author trant
 */
public class OrderDetail {
    private int orderDetailId;
    private Order orderId;
    private Map<String, Object> productId;
    private int quantity;
    private double price;
    
    // thêm 
    private Product product;
    private List<ProductPriceQuantity> productPriceQuantity;
    private int idOrder;
    private String unitId;
    
    
    public OrderDetail() {
    }

    public OrderDetail(int orderDetailId, Order orderId, Map<String, Object> productId, int quantity, double price) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    public OrderDetail(int orderDetailId, int quantity, double price, Product product, List<ProductPriceQuantity> productPriceQuantity, int idOrder) {
        this.orderDetailId = orderDetailId;
        this.quantity = quantity;
        this.price = price;
        this.product = product;
        this.productPriceQuantity = productPriceQuantity;
        this.idOrder = idOrder;
    }

    public OrderDetail(int orderDetailId, int quantity, double price, Product product, List<ProductPriceQuantity> productPriceQuantity, int idOrder, String unitId) {
        this.orderDetailId = orderDetailId;
        this.quantity = quantity;
        this.price = price;
        this.product = product;
        this.productPriceQuantity = productPriceQuantity;
        this.idOrder = idOrder;
        this.unitId = unitId;
    }

    public String getUnitId() {
        return unitId;
    }

    public void setUnitId(String unitId) {
        this.unitId = unitId;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

   

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<ProductPriceQuantity> getProductPriceQuantity() {
        return productPriceQuantity;
    }

    public void setProductPriceQuantity(List<ProductPriceQuantity> productPriceQuantity) {
        this.productPriceQuantity = productPriceQuantity;
    }

  
        
    

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public Order getOrderId() {
        return orderId;
    }

    public void setOrderId(Order orderId) {
        this.orderId = orderId;
    }

    public Map<String, Object> getProductId() {
        return productId;
    }

    public void setProductId(Map<String, Object> productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "orderDetailId=" + orderDetailId + ", orderId=" + orderId + ", productId=" + productId + ", quantity=" + quantity + ", price=" + price + ", product=" + product + ", productPriceQuantity=" + productPriceQuantity + ", idOrder=" + idOrder + '}';
    }

  
    
}
