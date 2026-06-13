package org.spa.entity;

public class Item {
  int itemId;
  int version;
  String itemEnglish;
  String itemMarathi;
  double ratePerKg;
  double vat;
  double tranRate;
  double kRate;
  double rRate;
  
  public Item() {}
  
  public double getkRate() {
    return kRate;
  }
  
  public void setkRate(double kRate) {
    this.kRate = kRate;
  }
  
  public double getrRate() {
    return rRate;
  }
  
  public void setrRate(double rRate) {
    this.rRate = rRate;
  }
  
  public int getVersion() {
    return version;
  }
  
  public void setVersion(int version) {
    this.version = version;
  }
  
  public double getVat() { return vat; }
  
  public void setVat(double vat)
  {
    this.vat = vat;
  }
  
  public double getTranRate() {
    return tranRate;
  }
  
  public void setTranRate(double tranRate) {
    this.tranRate = tranRate;
  }
  
  public int getItemId() {
    return itemId;
  }
  
  public void setItemId(int itemId) {
    this.itemId = itemId;
  }
  
  public String getItemEnglish() {
    return itemEnglish;
  }
  
  public void setItemEnglish(String itemEnglish) {
    this.itemEnglish = itemEnglish;
  }
  
  public String getItemMarathi() {
    return itemMarathi;
  }
  
  public void setItemMarathi(String itemMarathi) {
    this.itemMarathi = itemMarathi;
  }
  
  public double getRatePerKg() {
    return ratePerKg;
  }
  
  public void setRatePerKg(double ratePerKg) {
    this.ratePerKg = ratePerKg;
  }
}
