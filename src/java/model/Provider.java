package model;

public class Provider {
    private int providerID; // Mã nhà cung cấp
    private String providerName; // Tên nhà cung cấp
    private String phone; // Số điện thoại
    private String address; // Địa chỉ

    // Constructor
    public Provider() {
    }

    public Provider(int providerID, String providerName, String phone, String address) {
        this.providerID = providerID;
        this.providerName = providerName;
        this.phone = phone;
        this.address = address;
    }

    // Getter và Setter cho providerID
    public int getProviderID() {
        return providerID;
    }

    public void setProviderID(int providerID) {
        this.providerID = providerID;
    }

    // Getter và Setter cho providerName
    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    // Getter và Setter cho phone
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    // Getter và Setter cho address
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Provider{" +
                "providerID=" + providerID +
                ", providerName='" + providerName + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
