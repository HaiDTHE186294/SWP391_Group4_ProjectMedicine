package model;

public class Product {
    private String categoryID;
    private String brand;
    private String productID;
    private String productName;
    private String pharmaceuticalForm;
    private String brandOrigin;
    private String manufacturer;
    private String countryOfProduction;
    private String shortDescription;
    private String registrationNumber;
    private String productDescription;
    private String contentReviewer;
    private String faq;
    private String productReviews;
    private int status;
    private int sold;
    private String dateCreated;
    private int productVersion;
    private String prescriptionRequired;
    private String targetAudience;
    private String imagePath;
    private String ing;

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getIng() {
        return ing;
    }

    public void setIng(String ing) {
        this.ing = ing;
    }

      
    // Constructor
    public Product(String categoryID, String brand, String productID, String productName, String pharmaceuticalForm, 
                   String brandOrigin, String manufacturer, String countryOfProduction, String shortDescription, 
                   String registrationNumber, String productDescription, String contentReviewer, String faq, 
                   String productReviews, int status, int sold, String dateCreated, int productVersion, 
                   String prescriptionRequired, String targetAudience, String imagePath) {
        this.categoryID = categoryID;
        this.brand = brand;
        this.productID = productID;
        this.productName = productName;
        this.pharmaceuticalForm = pharmaceuticalForm;
        this.brandOrigin = brandOrigin;
        this.manufacturer = manufacturer;
        this.countryOfProduction = countryOfProduction;
        this.shortDescription = shortDescription;
        this.registrationNumber = registrationNumber;
        this.productDescription = productDescription;
        this.contentReviewer = contentReviewer;
        this.faq = faq;
        this.productReviews = productReviews;
        this.status = status;
        this.sold = sold;
        this.dateCreated = dateCreated;
        this.productVersion = productVersion;
        this.prescriptionRequired = prescriptionRequired;
        this.targetAudience = targetAudience;
        this.imagePath = imagePath;
    }
    
    public Product(String categoryID, String brand, String productID, String productName, String pharmaceuticalForm, 
                   String brandOrigin, String manufacturer, String countryOfProduction, String shortDescription, 
                   String registrationNumber, String productDescription, String contentReviewer, String faq, 
                   String productReviews, int status, int sold, String dateCreated, int productVersion, 
                   String prescriptionRequired, String targetAudience, String imagePath, String ing) {
        this.categoryID = categoryID;
        this.brand = brand;
        this.productID = productID;
        this.productName = productName;
        this.pharmaceuticalForm = pharmaceuticalForm;
        this.brandOrigin = brandOrigin;
        this.manufacturer = manufacturer;
        this.countryOfProduction = countryOfProduction;
        this.shortDescription = shortDescription;
        this.registrationNumber = registrationNumber;
        this.productDescription = productDescription;
        this.contentReviewer = contentReviewer;
        this.faq = faq;
        this.productReviews = productReviews;
        this.status = status;
        this.sold = sold;
        this.dateCreated = dateCreated;
        this.productVersion = productVersion;
        this.prescriptionRequired = prescriptionRequired;
        this.targetAudience = targetAudience;
        this.imagePath = imagePath;
        this.ing = ing;
    }
    
    
    public Product(String categoryID, String brand, String productID, String productName, String pharmaceuticalForm, 
                   String brandOrigin, String manufacturer, String countryOfProduction, String shortDescription, 
                   String registrationNumber, String productDescription, String contentReviewer, String faq, 
                   String productReviews, int status, int sold, String dateCreated, int productVersion, 
                   String prescriptionRequired, String targetAudience) {
        this.categoryID = categoryID;
        this.brand = brand;
        this.productID = productID;
        this.productName = productName;
        this.pharmaceuticalForm = pharmaceuticalForm;
        this.brandOrigin = brandOrigin;
        this.manufacturer = manufacturer;
        this.countryOfProduction = countryOfProduction;
        this.shortDescription = shortDescription;
        this.registrationNumber = registrationNumber;
        this.productDescription = productDescription;
        this.contentReviewer = contentReviewer;
        this.faq = faq;
        this.productReviews = productReviews;
        this.status = status;
        this.sold = sold;
        this.dateCreated = dateCreated;
        this.productVersion = productVersion;
        this.prescriptionRequired = prescriptionRequired;
        this.targetAudience = targetAudience;
    }

    // Getters and Setters
    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getPharmaceuticalForm() {
        return pharmaceuticalForm;
    }

    public void setPharmaceuticalForm(String pharmaceuticalForm) {
        this.pharmaceuticalForm = pharmaceuticalForm;
    }

    public String getBrandOrigin() {
        return brandOrigin;
    }

    public void setBrandOrigin(String brandOrigin) {
        this.brandOrigin = brandOrigin;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getCountryOfProduction() {
        return countryOfProduction;
    }

    public void setCountryOfProduction(String countryOfProduction) {
        this.countryOfProduction = countryOfProduction;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public String getContentReviewer() {
        return contentReviewer;
    }

    public void setContentReviewer(String contentReviewer) {
        this.contentReviewer = contentReviewer;
    }

    public String getFaq() {
        return faq;
    }

    public void setFaq(String faq) {
        this.faq = faq;
    }

    public String getProductReviews() {
        return productReviews;
    }

    public void setProductReviews(String productReviews) {
        this.productReviews = productReviews;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public String getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }

    public int getProductVersion() {
        return productVersion;
    }

    public void setProductVersion(int productVersion) {
        this.productVersion = productVersion;
    }

    public String getPrescriptionRequired() {
        return prescriptionRequired;
    }

    public void setPrescriptionRequired(String prescriptionRequired) {
        this.prescriptionRequired = prescriptionRequired;
    }

    public String getTargetAudience() {
        return targetAudience;
    }

    public void setTargetAudience(String targetAudience) {
        this.targetAudience = targetAudience;
    }
}
