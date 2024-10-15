/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class Stock {
    private String batchNo;      // Corresponds to Batch_no
    private String productId;    // Corresponds to Pid
    private String baseUnitId;   // Corresponds to Base_unit_ID
    private float quantity;        // Corresponds to Quantity
    private float priceImport;   // Corresponds to Price_import
    private String dateManufacture; // Corresponds to Date_manufacture
    private String dateExpired;    // Corresponds to Date_expired

    // Constructor
    public Stock(String batchNo, String productId, String baseUnitId, float quantity, float priceImport, String dateManufacture, String dateExpired) {
        this.batchNo = batchNo;
        this.productId = productId;
        this.baseUnitId = baseUnitId;
        this.quantity = quantity;
        this.priceImport = priceImport;
        this.dateManufacture = dateManufacture;
        this.dateExpired = dateExpired;
    }

    public Stock() {
    }

    // Getters and Setters
    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getBaseUnitId() {
        return baseUnitId;
    }

    public void setBaseUnitId(String baseUnitId) {
        this.baseUnitId = baseUnitId;
    }

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }

    public float getPriceImport() {
        return priceImport;
    }

    public void setPriceImport(float priceImport) {
        this.priceImport = priceImport;
    }

    public String getDateManufacture() {
        return dateManufacture;
    }

    public void setDateManufacture(String dateManufacture) {
        this.dateManufacture = dateManufacture;
    }

    public String getDateExpired() {
        return dateExpired;
    }

    public void setDateExpired(String dateExpired) {
        this.dateExpired = dateExpired;
    }
}
