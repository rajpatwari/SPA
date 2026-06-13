package org.spa.entity;

public class TalukaInvoice {
  private int invoiceID;
  private int invoiceIDMan;
  private int invoiceIDMan1;
  private int invoiceIDMan2;
  private int talukaID;
  private int version;
  private int orderID;
  private int orderType;
  private int stdType;
  private int districtID;
  private int orderID1;
  private String distOrder1to5Details;
  private String distOrder6to8Details;
  private String districtOrderDate;
  private String fromMonth;
  private String fromYear;
  private String toMonth;
  private String toYear;
  private String invoiceDate;
  private String creationDate;
  private double totalAmount;
  private double totalAmount1;
  private double totalAmount2;
  private double weight;
  private double weight1;
  private String talukaMarathi;
  private String districtMarathi;
  private String stdTypeDetails;
  private String talukaOrderNo;
  private String districtOrderNo;
  
  public TalukaInvoice() {}
  
  public String getFromMonth() {
    return fromMonth;
  }
  
  public void setFromMonth(String fromMonth) { this.fromMonth = fromMonth; }
  
  public String getFromYear() {
    return fromYear;
  }
  
  public void setFromYear(String fromYear) { this.fromYear = fromYear; }
  
  public String getToMonth() {
    return toMonth;
  }
  
  public void setToMonth(String toMonth) { this.toMonth = toMonth; }
  
  public String getToYear() {
    return toYear;
  }
  
  public void setToYear(String toYear) { this.toYear = toYear; }
  
  public String getDistrictOrderDate() {
    return districtOrderDate;
  }
  
  public void setDistrictOrderDate(String districtOrderDate) { this.districtOrderDate = districtOrderDate; }
  
  public String getDistOrder1to5Details() {
    return distOrder1to5Details;
  }
  
  public void setDistOrder1to5Details(String distOrder1to5Details) { this.distOrder1to5Details = distOrder1to5Details; }
  
  public String getDistOrder6to8Details() {
    return distOrder6to8Details;
  }
  
  public void setDistOrder6to8Details(String distOrder6to8Details) { this.distOrder6to8Details = distOrder6to8Details; }
  
  public int getOrderID1() {
    return orderID1;
  }
  
  public void setOrderID1(int orderID1) { this.orderID1 = orderID1; }
  

  public double getWeight1()
  {
    return weight1;
  }
  
  public void setWeight1(double weight1) { this.weight1 = weight1; }
  

  public String getDistrictOrderNo()
  {
    return districtOrderNo;
  }
  
  public void setDistrictOrderNo(String districtOrderNo) { this.districtOrderNo = districtOrderNo; }
  
  public String getTalukaOrderNo() {
    return talukaOrderNo;
  }
  
  public void setTalukaOrderNo(String talukaOrderNo) { this.talukaOrderNo = talukaOrderNo; }
  
  public double getWeight() {
    return weight;
  }
  
  public int getDistrictID() { return districtID; }
  
  public void setDistrictID(int districtID) {
    this.districtID = districtID;
  }
  
  public void setWeight(double weight) { this.weight = weight; }
  
  public int getVersion() {
    return version;
  }
  
  public void setVersion(int version) { this.version = version; }
  
  public int getOrderType() {
    return orderType;
  }
  
  public void setOrderType(int orderType) { this.orderType = orderType; }
  
  public double getTotalAmount1() {
    return totalAmount1;
  }
  
  public void setTotalAmount1(double totalAmount1) { this.totalAmount1 = totalAmount1; }
  
  public double getTotalAmount2() {
    return totalAmount2;
  }
  
  public void setTotalAmount2(double totalAmount2) { this.totalAmount2 = totalAmount2; }
  
  public int getInvoiceIDMan() {
    return invoiceIDMan;
  }
  
  public void setInvoiceIDMan(int invoiceIDMan) { this.invoiceIDMan = invoiceIDMan; }
  
  public int getTalukaID() {
    return talukaID;
  }
  
  public void setTalukaID(int talukaID) { this.talukaID = talukaID; }
  
  public String getCreationDate() {
    return creationDate;
  }
  
  public void setCreationDate(String creationDate) { this.creationDate = creationDate; }
  
  public int getOrderID() {
    return orderID;
  }
  
  public void setOrderID(int orderID) { this.orderID = orderID; }
  
  public int getInvoiceID() {
    return invoiceID;
  }
  
  public void setInvoiceID(int invoiceID) { this.invoiceID = invoiceID; }
  
  public String getInvoiceDate() {
    return invoiceDate;
  }
  
  public void setInvoiceDate(String invoiceDate) { this.invoiceDate = invoiceDate; }
  
  public double getTotalAmount() {
    return totalAmount;
  }
  
  public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
  
  public int getInvoiceIDMan1() {
    return invoiceIDMan1;
  }
  
  public void setInvoiceIDMan1(int invoiceIDMan1) { this.invoiceIDMan1 = invoiceIDMan1; }
  
  public int getInvoiceIDMan2() {
    return invoiceIDMan2;
  }
  
  public void setInvoiceIDMan2(int invoiceIDMan2) { this.invoiceIDMan2 = invoiceIDMan2; }
  
  public int getStdType() {
    return stdType;
  }
  
  public void setStdType(int stdType) { this.stdType = stdType; }
  
  public String getTalukaMarathi() {
    return talukaMarathi;
  }
  
  public void setTalukaMarathi(String talukaMarathi) { this.talukaMarathi = talukaMarathi; }
  
  public String getDistrictMarathi() {
    return districtMarathi;
  }
  
  public void setDistrictMarathi(String districtMarathi) { this.districtMarathi = districtMarathi; }
  
  public String getStdTypeDetails() {
    return stdTypeDetails;
  }
  
  public void setStdTypeDetails(String stdTypeDetails) { this.stdTypeDetails = stdTypeDetails; }
}
