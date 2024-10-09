/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author kan3v
 */
public class Category {
    private String CategoryID;
    private String Icon;
    private String CategoryName;
    private String ParentCategoryID;

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
