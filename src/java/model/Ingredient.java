package model;

public class Ingredient {
    private String productIngredientID;  // ID duy nhất cho mỗi nguyên liệu
    private String productID;            // ID sản phẩm
    private String ingredientName;       // Tên nguyên liệu
    private float quantity;              // Số lượng nguyên liệu
    private String unit;                 // Đơn vị của nguyên liệu

    // Constructor
    public Ingredient(String productID, int index, String ingredientName, float quantity, String unit) {
        this.productIngredientID = productID + "_I" + index; // Kết hợp ProductID và số thứ tự
        this.productID = productID;
        this.ingredientName = ingredientName;
        this.quantity = quantity;
        this.unit = unit;
    }

    // Các hàm getter và setter
    public String getProductIngredientID() {
        return productIngredientID;
    }

    public String getProductID() {
        return productID;
    }

    public String getIngredientName() {
        return ingredientName;
    }

    public float getQuantity() {
        return quantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setProductIngredientID(String productIngredientID) {
        this.productIngredientID = productIngredientID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public void setIngredientName(String ingredientName) {
        this.ingredientName = ingredientName;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
}
