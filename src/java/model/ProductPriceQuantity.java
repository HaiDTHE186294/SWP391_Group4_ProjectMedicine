package model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Asus
 */
public class ProductPriceQuantity {
    private String productUnitID;  // Primary key for the product-unit entry
    private String packagingDetails;  // Packaging details for the product
    private String productID;  // Foreign key referencing the Product table
    private String unitID;  // Foreign key referencing the Unit table

    // Constructor
    public ProductPriceQuantity(String productUnitID, String packagingDetails, String productID, String unitID) {
        this.productUnitID = productUnitID;
        this.packagingDetails = packagingDetails;
        this.productID = productID;
        this.unitID = unitID;
    }

    // Getters and Setters
    public String getProductUnitID() {
        return productUnitID;
    }

    public void setProductUnitID(String productUnitID) {
        this.productUnitID = productUnitID;
    }

    public String getPackagingDetails() {
        return packagingDetails;
    }

    public void setPackagingDetails(String packagingDetails) {
        this.packagingDetails = packagingDetails;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getUnitID() {
        return unitID;
    }

    public void setUnitID(String unitID) {
        this.unitID = unitID;
    }

    @Override
    public String toString() {
        return "ProductPriceQuantity{" +
                "productUnitID='" + productUnitID + '\'' +
                ", packagingDetails='" + packagingDetails + '\'' +
                ", productID='" + productID + '\'' +
                ", unitID='" + unitID + '\'' +
                '}';
    }
}