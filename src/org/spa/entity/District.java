package org.spa.entity;

public class District {
  private int districtID;
  private String district;
  private String districtMarathi;
  private int stdType;
  private String stdTypeDetails;
  private String districtList;
  
  public District() {}
  
  public String getDistrict() {
    return district;
  }
  
  public void setDistrict(String district)
  {
    district = district != null ? district.trim() : district;
    this.district = district;
  }
  
  public int getDistrictID()
  {
    return districtID;
  }
  
  public void setDistrictID(int districtID)
  {
    this.districtID = districtID;
  }
  
  public String getDistrictMarathi()
  {
    return districtMarathi;
  }
  
  public void setDistrictMarathi(String districtMarathi)
  {
    districtMarathi = districtMarathi != null ? districtMarathi.trim() : districtMarathi;
    this.districtMarathi = districtMarathi;
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
  
  public String getDistrictList() {
    return districtList;
  }
  
  public void setDistrictList(String districtList) {
    this.districtList = districtList;
  }
  
  public String toString()
  {
    return districtID + "-" + district + "-" + districtMarathi;
  }
}
