/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author kan3v
 */
public class Category {

    private String CategoryID;
    private String Icon;
    private String CategoryName;
    private String ParentCategoryID;
    private String description;
    private int Status;
    private List<Category> subCategories; // Thêm thuộc tính này

    public List<Category> getSubCategories() {
        return subCategories;
    }

    public void setSubCategories(List<Category> subCategories) {
        this.subCategories = subCategories;
    }

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Category(String CategoryID, String Icon, String CategoryName, String ParentCategoryID, String description, int Status) {
        this.CategoryID = CategoryID;
        this.Icon = Icon;
        this.CategoryName = CategoryName;
        this.ParentCategoryID = ParentCategoryID;
        this.description = description;
        this.Status = Status;
    }

    public Category() {
    }

    public Category(String CategoryID, String Icon, String CategoryName, String ParentCategoryID) {
        this.CategoryID = CategoryID;
        this.Icon = Icon;
        this.CategoryName = CategoryName;
        this.ParentCategoryID = ParentCategoryID;
    }

    public String getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(String CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getIcon() {
        return Icon;
    }

    public void setIcon(String Icon) {
        this.Icon = Icon;
    }

    public String getCategoryName() {
        return CategoryName;
    }

    public void setCategoryName(String CategoryName) {
        this.CategoryName = CategoryName;
    }

    public String getParentCategoryID() {
        return ParentCategoryID;
    }

    public void setParentCategoryID(String ParentCategoryID) {
        this.ParentCategoryID = ParentCategoryID;
    }

}
