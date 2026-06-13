package org.spa.entity;

public class Section {
  private Integer sectionID;
  private Integer talukaID;
  private String section;
  private String sectionMarathi;
  private String talukaMarathi;
  private String districtMarathi;
  private Integer districtID;
  private Integer beatFlag;
  
  public Section() {}
  
  public Integer getSectionID() {
    return sectionID;
  }
  
  public void setSectionID(Integer sectionID) { this.sectionID = sectionID; }
  
  public Integer getTalukaID() {
    return talukaID;
  }
  
  public void setTalukaID(Integer talukaID) { this.talukaID = talukaID; }
  
  public String getSection() {
    return section;
  }
  
  public void setSection(String section) { this.section = section; }
  
  public String getSectionMarathi() {
    return sectionMarathi;
  }
  
  public void setSectionMarathi(String sectionMarathi) { this.sectionMarathi = sectionMarathi; }
  
  public String getTalukaMarathi() {
    return talukaMarathi;
  }
  
  public void setTalukaMarathi(String talukaMarathi) { this.talukaMarathi = talukaMarathi; }
  
  public String getDistrictMarathi() {
    return districtMarathi;
  }
  
  public void setDistrictMarathi(String districtMarathi) { this.districtMarathi = districtMarathi; }
  
  public Integer getDistrictID() {
    return districtID;
  }
  
  public void setDistrictID(Integer districtID) { this.districtID = districtID; }
  
  public Integer getBeatFlag() {
    return beatFlag;
  }
  
  public void setBeatFlag(Integer beatFlag) { this.beatFlag = beatFlag; }
}
