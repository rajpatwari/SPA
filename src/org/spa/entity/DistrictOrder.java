package org.spa.entity;

public class DistrictOrder {
  int orderID;
  int districtID;
  int stdType;
  String orderNoDate;
  String districtGovOrderID;
  String creationDate;
  String orderNumber;
  String districtName;
  String stdTypeDetails;
  String DistOrderWithOrderNo;
  
  public DistrictOrder() {}
  
  public String getCreationDate() {
    return creationDate;
  }
  
  public void setCreationDate(String creationDate)
  {
    this.creationDate = creationDate;
  }
  
  public String getDistrictGovOrderID()
  {
    return districtGovOrderID;
  }
  
  public void setDistrictGovOrderID(String districtGovOrderID)
  {
    this.districtGovOrderID = districtGovOrderID;
  }
  
  public int getDistrictID()
  {
    return districtID;
  }
  
  public void setDistrictID(int districtID)
  {
    this.districtID = districtID;
  }
  
  public int getOrderID()
  {
    return orderID;
  }
  
  public void setOrderID(int orderID)
  {
    this.orderID = orderID;
  }
  
  public String getOrderNoDate()
  {
    return orderNoDate;
  }
  
  public void setOrderNoDate(String orderNoDate)
  {
    this.orderNoDate = orderNoDate;
  }
  
  public String getOrderNumber()
  {
    return orderNumber;
  }
  
  public void setOrderNumber(String orderNumber)
  {
    this.orderNumber = orderNumber;
  }
  
  public String getDistrictName()
  {
    return districtName;
  }
  
  public void setDistrictName(String districtName)
  {
    this.districtName = districtName;
  }
  
  public String getDistOrderWithOrderNo()
  {
    return DistOrderWithOrderNo;
  }
  
  public void setDistOrderWithOrderNo(String DistOrderWithOrderNo)
  {
    this.DistOrderWithOrderNo = DistOrderWithOrderNo;
  }
  
  public int getStdType() {
    return stdType;
  }
  
  public void setStdType(int stdType) {
    this.stdType = stdType;
  }
  
  public String getStdTypeDetails() {
    return stdTypeDetails;
  }
  
  public void setStdTypeDetails(String stdTypeDetails) {
    this.stdTypeDetails = stdTypeDetails;
  }
}
