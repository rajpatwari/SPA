package org.spa.entity;

public class InwardMaterialStock {
  int batch_id;
  int inward_material_id;
  int ration_id;
  double wheat;
  double soya_seed;
  double oil;
  double gud;
  double groundnut;
  double moong;
  double sugar;
  double coconut;
  double spices;
  double chana;
  String fromDate;
  String toDate;
  String production_date;
  
  public InwardMaterialStock() {}
  
  public String getProduction_date() {
    return production_date;
  }
  
  public void setProduction_date(String production_date) {
    this.production_date = production_date;
  }
  
  public String getFromDate() {
    return fromDate;
  }
  
  public void setFromDate(String fromDate) {
    this.fromDate = fromDate;
  }
  
  public String getToDate() {
    return toDate;
  }
  
  public void setToDate(String toDate) {
    this.toDate = toDate;
  }
  
  public int getBatch_id() {
    return batch_id;
  }
  
  public void setBatch_id(int batch_id) {
    this.batch_id = batch_id;
  }
  
  public int getRation_id() {
    return ration_id;
  }
  
  public void setRation_id(int ration_id) {
    this.ration_id = ration_id;
  }
  
  public int getInward_material_id() {
    return inward_material_id;
  }
  
  public void setInward_material_id(int inward_material_id) {
    this.inward_material_id = inward_material_id;
  }
  
  public double getChana()
  {
    return chana;
  }
  
  public void setChana(double chana) {
    this.chana = chana;
  }
  
  public double getCoconut() {
    return coconut;
  }
  
  public void setCoconut(double coconut) {
    this.coconut = coconut;
  }
  
  public double getGroundnut() {
    return groundnut;
  }
  
  public void setGroundnut(double groundnut) {
    this.groundnut = groundnut;
  }
  
  public double getGud() {
    return gud;
  }
  
  public void setGud(double gud) {
    this.gud = gud;
  }
  
  public double getMoong() {
    return moong;
  }
  
  public void setMoong(double moong) {
    this.moong = moong;
  }
  
  public double getOil() {
    return oil;
  }
  
  public void setOil(double oil) {
    this.oil = oil;
  }
  
  public double getSoya_seed() {
    return soya_seed;
  }
  
  public void setSoya_seed(double soya_seed) {
    this.soya_seed = soya_seed;
  }
  
  public double getSpices() {
    return spices;
  }
  
  public void setSpices(double spices) {
    this.spices = spices;
  }
  
  public double getSugar() {
    return sugar;
  }
  
  public void setSugar(double sugar) {
    this.sugar = sugar;
  }
  
  public double getWheat() {
    return wheat;
  }
  
  public void setWheat(double wheat) {
    this.wheat = wheat;
  }
}
