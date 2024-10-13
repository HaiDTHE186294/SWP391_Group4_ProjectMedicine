/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Import {
    private String orderId;         // Corresponds to O_id
    private String provider;        // Corresponds to NCC
    private String productId;       // Corresponds to Pid
    private String baseUnitId;      // Corresponds to Base_unit_ID
    private String batchNo;         // Corresponds to Batch_no
    private String dateManufacture; // Corresponds to Date_manufacture (as String)
    private String dateExpired;     // Corresponds to Date_expired (as String)
    private float priceImport;      // Corresponds to Price_import
    private int importer;           // Corresponds to Importer (User/Staff ID)

    // Constructor
    public Import(String orderId, String provider, String productId, String baseUnitId, String batchNo,
                  String dateManufacture, String dateExpired, float priceImport, int importer) {
        this.orderId = orderId;
        this.provider = provider;
        this.productId = productId;
        this.baseUnitId = baseUnitId;
        this.batchNo = batchNo;
        this.dateManufacture = dateManufacture;
        this.dateExpired = dateExpired;
        this.priceImport = priceImport;
        this.importer = importer;
    }

    // Getters and Setters
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
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

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
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

    public float getPriceImport() {
        return priceImport;
    }

    public void setPriceImport(float priceImport) {
        this.priceImport = priceImport;
    }

    public int getImporter() {
        return importer;
    }

    public void setImporter(int importer) {
        this.importer = importer;
    }
}
