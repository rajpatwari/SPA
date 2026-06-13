package org.spa.entity;

public class Beat {
  private int beatID;
  private int sectionID;
  private String beat;
  private String beatMarathi;
  private String sectionMarathi;
  private String talukaMarathi;
  private String districtMarathi;
  private int talukaID;
  private int districtID;
  
  public Beat() {}
  
  public int getBeatID() {
    return beatID;
  }
  
  public void setBeatID(int beatID) {
    this.beatID = beatID;
  }
  
  public int getSectionID() {
    return sectionID;
  }
  
  public void setSectionID(int sectionID) {
    this.sectionID = sectionID;
  }
  
  public String getBeat() {
    return beat;
  }
  
  public void setBeat(String beat) {
    this.beat = beat;
  }
  
  public String getBeatMarathi() {
    return beatMarathi;
  }
  
  public void setBeatMarathi(String beatMarathi) {
    this.beatMarathi = beatMarathi;
  }
  
  public String getSectionMarathi() {
    return sectionMarathi;
  }
  
  public void setSectionMarathi(String sectionMarathi) {
    this.sectionMarathi = sectionMarathi;
  }
  
  public String getTalukaMarathi() {
    return talukaMarathi;
  }
  
  public void setTalukaMarathi(String talukaMarathi) {
    this.talukaMarathi = talukaMarathi;
  }
  
  public String getDistrictMarathi() {
    return districtMarathi;
  }
  
  public void setDistrictMarathi(String districtMarathi) {
    this.districtMarathi = districtMarathi;
  }
  
  public int getTalukaID() {
    return talukaID;
  }
  
  public void setTalukaID(int talukaID) {
    this.talukaID = talukaID;
  }
  
  public int getDistrictID() {
    return districtID;
  }
  
  public void setDistrictID(int districtID) {
    this.districtID = districtID;
  }
}
