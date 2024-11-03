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
    private int unitStatus;
    private float salePrice;
    
    // thêm
    private Unit unit;
    private int packaging;

    public ProductPriceQuantity() {
    }
    
    public ProductPriceQuantity(String productUnitID, String packagingDetails, String productID, String unitID, int unitStatus, float salePrice, Unit unit) {
        this.productUnitID = productUnitID;
        this.packagingDetails = packagingDetails;
        this.productID = productID;
        this.unitID = unitID;
        this.unitStatus = unitStatus;
        this.salePrice = salePrice;
        this.unit = unit;
    }

    public ProductPriceQuantity(String productUnitID, String packagingDetails, String productID, String unitID, int unitStatus, float salePrice, Unit unit, int packaging) {
        this.productUnitID = productUnitID;
        this.packagingDetails = packagingDetails;
        this.productID = productID;
        this.unitID = unitID;
        this.unitStatus = unitStatus;
        this.salePrice = salePrice;
        this.unit = unit;
        this.packaging = packaging;
    }
    
    public int getPackaging() {
        return packaging;
    }

    public void setPackaging(int packaging) {
        this.packaging = packaging;
    }

    public Unit getUnit() {
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }

    public float getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(float salePrice) {
        this.salePrice = salePrice;
    }
    

    // Constructor
    public ProductPriceQuantity(String productUnitID, String packagingDetails, String productID, String unitID, int unitStatus, float salePrice) {
        this.productUnitID = productUnitID;
        this.packagingDetails = packagingDetails;
        this.productID = productID;
        this.unitID = unitID;
        this.unitStatus = unitStatus;
        this.salePrice = salePrice;
    }

    public int getUnitStatus() {
        return unitStatus;
    }

    public void setUnitStatus(int unitStatus) {
        this.unitStatus = unitStatus;
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
