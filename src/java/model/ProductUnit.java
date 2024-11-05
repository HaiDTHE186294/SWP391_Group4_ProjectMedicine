/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class ProductUnit {
    private String unitID;  // Identifier for the unit of measure
    private String unitName; // Name of the unit (e.g., tablet, bottle, blister)

    // Constructor
    public ProductUnit(String unitID, String unitName) {
        this.unitID = unitID;
        this.unitName = unitName;
    }

    // Getter and Setter for UnitID
    public String getUnitID() {
        return unitID;
    }

    public void setUnitID(String unitID) {
        this.unitID = unitID;
    }

    // Getter and Setter for UnitName
    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    @Override
    public String toString() {
        return "Unit{" +
                "unitID='" + unitID + '\'' +
                ", unitName='" + unitName + '\'' +
                '}';
    }
}
