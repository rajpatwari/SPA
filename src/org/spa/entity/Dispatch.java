package org.spa.entity;

public class Dispatch {
  private Integer dispatchID;
  private Integer biltyNo;
  private Integer districtID;
  private Integer godownID;
  private Integer districtOrder;
  private Integer draftBiltyNo;
  private String vehicleNo;
  private String districtMarathi;
  private String talukaMarathi;
  private String agentName;
  private String biltyDate;
  private Integer rationVersion;
  private String challanVersionStartDate;
  private String challanVersionEndDate;
  private String dispatchFinancialYear;
  private Integer challanVersion;
  private Integer dispatchTalukaOrdersID;
  private Integer dispatchTalukaOrderDetailID;
  private Integer rationID;
  private Integer batchID;
  private Integer todaysDispatch;
  private String batchName;
  private String batchNumber;
  private Integer talukaID;
  private String createdOn;
  private String godownName;
  private String driverName;
  private String driverLicense;
  private String loadingStatus;
  private double truckCapacity;
  private double actualLoading;
  private double freightPerTonInRupees;
  private double advanceFrieght;
  private double totalFrieght;
  private double pendingFrieght;
  private double emptySpace;
  String biltyNos;
  String draftBiltyNos;
  
  public Dispatch() {}
  
  public Integer getTalukaID() {
    return talukaID;
  }
  
  public void setTalukaID(Integer talukaID) {
    this.talukaID = talukaID;
  }
  
  public String getBatchNumber() {
    return batchNumber;
  }
  
  public void setBatchNumber(String batchNumber) {
    this.batchNumber = batchNumber;
  }
  
  public Integer getBatchID() {
    return batchID;
  }
  
  public void setBatchID(Integer batchID) {
    this.batchID = batchID;
  }
  
  public String getBatchName() {
    return batchName;
  }
  
  public void setBatchName(String batchName) {
    this.batchName = batchName;
  }
  
  public Integer getTodaysDispatch() {
    return todaysDispatch;
  }
  
  public void setTodaysDispatch(Integer todaysDispatch) {
    this.todaysDispatch = todaysDispatch;
  }
  
  public Integer getRationID() {
    return rationID;
  }
  
  public void setRationID(Integer rationID) {
    this.rationID = rationID;
  }
  
  public Integer getDispatchTalukaOrderDetailID() {
    return dispatchTalukaOrderDetailID;
  }
  
  public void setDispatchTalukaOrderDetailID(Integer dispatchTalukaOrderDetailID) {
    this.dispatchTalukaOrderDetailID = dispatchTalukaOrderDetailID;
  }
  
  public Integer getDispatchTalukaOrdersID() {
    return dispatchTalukaOrdersID;
  }
  
  public void setDispatchTalukaOrdersID(Integer dispatchTalukaOrdersID) {
    this.dispatchTalukaOrdersID = dispatchTalukaOrdersID;
  }
  
  public Integer getChallanVersion() {
    return challanVersion;
  }
  
  public void setChallanVersion(Integer challanVersion) {
    this.challanVersion = challanVersion;
  }
  
  public String getDispatchFinancialYear() {
    return dispatchFinancialYear;
  }
  
  public void setDispatchFinancialYear(String dispatchFinancialYear) {
    this.dispatchFinancialYear = dispatchFinancialYear;
  }
  
  public String getChallanVersionEndDate() {
    return challanVersionEndDate;
  }
  
  public void setChallanVersionEndDate(String challanVersionEndDate) {
    this.challanVersionEndDate = challanVersionEndDate;
  }
  
  public String getChallanVersionStartDate() {
    return challanVersionStartDate;
  }
  
  public void setChallanVersionStartDate(String challanVersionStartDate) {
    this.challanVersionStartDate = challanVersionStartDate;
  }
  
  public Integer getRationVersion() {
    return rationVersion;
  }
  
  public void setRationVersion(Integer rationVersion) {
    this.rationVersion = rationVersion;
  }
  
  public Integer getDraftBiltyNo()
  {
    return draftBiltyNo;
  }
  
  public void setDraftBiltyNo(Integer draftBiltyNo) {
    this.draftBiltyNo = draftBiltyNo;
  }
  
  public String getBiltyDate() {
    return biltyDate;
  }
  
  public void setBiltyDate(String biltyDate) {
    this.biltyDate = biltyDate;
  }
  
  public String getAgentName() {
    return agentName;
  }
  
  public void setAgentName(String agentName) {
    this.agentName = agentName;
  }
  
  public Integer getDistrictOrder() {
    return districtOrder;
  }
  
  public String getDistrictMarathi() {
    return districtMarathi;
  }
  
  public void setDistrictMarathi(String districtMarathi) {
    this.districtMarathi = districtMarathi;
  }
  
  public String getTalukaMarathi() {
    return talukaMarathi;
  }
  
  public void setTalukaMarathi(String talukaMarathi) {
    this.talukaMarathi = talukaMarathi;
  }
  
  public void setDistrictOrder(Integer districtOrder) {
    this.districtOrder = districtOrder;
  }
  
  public double getTotalFrieght()
  {
    return totalFrieght;
  }
  
  public String getVehicleNo() {
    return vehicleNo;
  }
  
  public void setVehicleNo(String vehicleNo) {
    this.vehicleNo = vehicleNo;
  }
  
  public Integer getDistrictID()
  {
    return districtID;
  }
  
  public void setDistrictID(Integer districtID) {
    this.districtID = districtID;
  }
  
  public Integer getGodownID() {
    return godownID;
  }
  
  public void setGodownID(Integer godownID) {
    this.godownID = godownID;
  }
  
  public void setTotalFrieght(double totalFrieght) {
    this.totalFrieght = totalFrieght;
  }
  
  public double getActualLoading() {
    return actualLoading;
  }
  
  public void setActualLoading(double actualLoading) {
    this.actualLoading = actualLoading;
  }
  
  public double getPendingFrieght() {
    return getTotalFrieght() - getAdvanceFrieght();
  }
  
  public double getEmptySpace() {
    return truckCapacity - actualLoading;
  }
  
  public void setEmptySpace(double emptySpace) {
    this.emptySpace = emptySpace;
  }
  
  public String getLoadingStatus() {
    double diff = truckCapacity - actualLoading;
    String status = "Under Loaded";
    
    if (diff < 0.0D) {
      status = "Over Loaded";
    }
    
    if (diff == 0.0D) {
      status = "OK";
    }
    
    return status;
  }
  
  public void setLoadingStatus(String loadingStatus) {
    this.loadingStatus = loadingStatus;
  }
  
  public void setPendingFrieght(double pendingFrieght) {
    this.pendingFrieght = pendingFrieght;
  }
  
  public double getAdvanceFrieght() { return advanceFrieght; }
  
  public void setAdvanceFrieght(double advanceFrieght)
  {
    this.advanceFrieght = advanceFrieght;
  }
  
  public Integer getBiltyNo() {
    return biltyNo;
  }
  
  public void setBiltyNo(Integer biltyNo) {
    this.biltyNo = biltyNo;
  }
  
  public String getCreatedOn() {
    return createdOn;
  }
  
  public void setCreatedOn(String createdOn) {
    this.createdOn = createdOn;
  }
  
  public Integer getDispatchID() {
    return dispatchID;
  }
  
  public void setDispatchID(Integer dispatchID) {
    this.dispatchID = dispatchID;
  }
  
  public String getDriverLicense() {
    return driverLicense;
  }
  
  public void setDriverLicense(String driverLicense) {
    this.driverLicense = driverLicense;
  }
  
  public String getDriverName() {
    return driverName;
  }
  
  public void setDriverName(String driverName) {
    this.driverName = driverName;
  }
  
  public double getFreightPerTonInRupees() {
    return freightPerTonInRupees;
  }
  
  public void setFreightPerTonInRupees(double freightPerTonInRupees) {
    this.freightPerTonInRupees = freightPerTonInRupees;
  }
  
  public String getGodownName() {
    return godownName;
  }
  
  public void setGodownName(String godownName) {
    this.godownName = godownName;
  }
  
  public double getTruckCapacity() {
    return truckCapacity;
  }
  
  public void setTruckCapacity(double truckCapacity) {
    this.truckCapacity = truckCapacity;
  }
  
  public String getBiltyNos()
  {
    return biltyNos;
  }
  
  public void setBiltyNos(String biltyNos) {
    this.biltyNos = biltyNos;
  }
  
  public String getDraftBiltyNos() {
    return draftBiltyNos;
  }
  
  public void setDraftBiltyNos(String draftBiltyNos) {
    this.draftBiltyNos = draftBiltyNos;
  }
}
