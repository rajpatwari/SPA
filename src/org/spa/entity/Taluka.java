package org.spa.entity;

public class Taluka {
  private int talukaID;
  private int districtID;
  private String taluka;
  private String talukaMarathi;
  private String districtMarathi;
  
  public Taluka() {}
  
  public int getDistrictID() {
    return districtID;
  }
  
  public void setDistrictID(int districtID) {
    this.districtID = districtID;
  }
  
  public String getTaluka() {
    return taluka;
  }
  
  public void setTaluka(String taluka) {
    taluka = taluka != null ? taluka.trim() : taluka;
    this.taluka = taluka;
  }
  
  public int getTalukaID() {
    return talukaID;
  }
  
  public void setTalukaID(int talukaID) {
    this.talukaID = talukaID;
  }
  
  public String getTalukaMarathi() {
    return talukaMarathi;
  }
  
  public void setTalukaMarathi(String talukaMarathi) {
    talukaMarathi = talukaMarathi != null ? talukaMarathi.trim() : talukaMarathi;
    this.talukaMarathi = talukaMarathi;
  }
  
  public String getDistrictMarathi() {
    return districtMarathi;
  }
  
  public void setDistrictMarathi(String districtMarathi) {
    this.districtMarathi = districtMarathi;
  }
  
  public String toString()
  {
    return talukaID + "-" + districtID + "-" + taluka + "-" + talukaMarathi;
  }
}
