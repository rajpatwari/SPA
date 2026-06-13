package org.spa.entity;

public class Supplier {
  private int supplierID;
  private String supplierName;
  private String supplierAddress;
  private String contactNum;
  private String vat;
  private String tin;
  private String cst;
  
  public Supplier() {}
  
  public int getSupplierID() {
    return supplierID;
  }
  
  public void setSupplierID(int supplierID) {
    this.supplierID = supplierID;
  }
  
  public String getSupplierName() {
    return supplierName;
  }
  
  public void setSupplierName(String supplierName) {
    this.supplierName = supplierName;
  }
  
  public String getSupplierAddress() {
    return supplierAddress;
  }
  
  public void setSupplierAddress(String supplierAddress) {
    this.supplierAddress = supplierAddress;
  }
  
  public String getContactNum() {
    return contactNum;
  }
  
  public void setContactNum(String contactNum) {
    this.contactNum = contactNum;
  }
  
  public String getVat() {
    return vat;
  }
  
  public void setVat(String vat) {
    this.vat = vat;
  }
  
  public String getTin() {
    return tin;
  }
  
  public void setTin(String tin) {
    this.tin = tin;
  }
  
  public String getCst() {
    return cst;
  }
  
  public void setCst(String cst) {
    this.cst = cst;
  }
}
