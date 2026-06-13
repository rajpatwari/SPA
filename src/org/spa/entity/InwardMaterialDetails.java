package org.spa.entity;

public class InwardMaterialDetails {
  private Integer inwardId;
  private Integer itemId;
  private Integer supplierId;
  private Integer bag;
  private double qtyInKG;
  private String itemMarathi;
  private String supplierName;
  private String inwardDate;
  private String truckNo;
  
  public InwardMaterialDetails() {}
  
  public Integer getInwardId() {
    return inwardId;
  }
  
  public void setInwardId(Integer inwardId) { this.inwardId = inwardId; }
  
  public Integer getItemId() {
    return itemId;
  }
  
  public void setItemId(Integer itemId) { this.itemId = itemId; }
  
  public Integer getSupplierId() {
    return supplierId;
  }
  
  public void setSupplierId(Integer supplierId) { this.supplierId = supplierId; }
  
  public Integer getBag() {
    return bag;
  }
  
  public void setBag(Integer bag) { this.bag = bag; }
  
  public double getQtyInKG() {
    return qtyInKG;
  }
  
  public void setQtyInKG(double qtyInKG) { this.qtyInKG = qtyInKG; }
  
  public String getItemMarathi() {
    return itemMarathi;
  }
  
  public void setItemMarathi(String itemMarathi) { this.itemMarathi = itemMarathi; }
  
  public String getSupplierName() {
    return supplierName;
  }
  
  public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
  
  public String getInwardDate() {
    return inwardDate;
  }
  
  public void setInwardDate(String inwardDate) { this.inwardDate = inwardDate; }
  
  public String getTruckNo() {
    return truckNo;
  }
  
  public void setTruckNo(String truckNo) { this.truckNo = truckNo; }
}
