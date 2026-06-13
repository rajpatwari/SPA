package org.spa.entity;

public class TalukaOrder {
  int talukaOrderId;
  int talukaId;
  int tOrderDistrictId;
  int monthDiff;
  int orderNumber;
  int talukaOrderDetailsId;
  int fMonthId;
  int tMonthId;
  int districtId;
  int orderType;
  int stdType;
  int invoiceID;
  String tOrderDate;
  String talukaName;
  String fromMonth;
  String fromYear;
  String toMonth;
  String toYear;
  String talukaOrderGovNum;
  String districtName;
  String orderYear;
  String orderTypeDetails;
  String stdTypeDetails;
  String invoiceDate;
  Double weight;
  Double weight1;
  int version;
  int G1;
  int districtOrderId;
  int checkInviceID;
  
  public TalukaOrder() {}
  
  public String getInvoiceDate() {
    return invoiceDate;
  }
  
  public void setInvoiceDate(String invoiceDate) { this.invoiceDate = invoiceDate; }
  
  public Double getWeight1()
  {
    return weight1;
  }
  
  public void setWeight1(Double weight1) { this.weight1 = weight1; }
  
  public Double getWeight()
  {
    return weight;
  }
  
  public void setWeight(Double weight) { this.weight = weight; }
  
  public int getVersion() {
    return version;
  }
  
  public void setVersion(int version) { this.version = version; }
  
  public int getDistrictId()
  {
    return districtId;
  }
  
  public void setDistrictId(int districtId) {
    this.districtId = districtId;
  }
  
  public int getfMonthId() {
    return fMonthId;
  }
  
  public void setfMonthId(int fMonthId) {
    this.fMonthId = fMonthId;
  }
  
  public int gettMonthId() {
    return tMonthId;
  }
  
  public void settMonthId(int tMonthId)
  {
    this.tMonthId = tMonthId;
  }
  
  public int getTalukaOrderDetailsId()
  {
    return talukaOrderDetailsId;
  }
  
  public void setTalukaOrderDetailsId(int talukaOrderDetailsId)
  {
    this.talukaOrderDetailsId = talukaOrderDetailsId;
  }
  
  public String getFromMonth()
  {
    return fromMonth;
  }
  
  public void setFromMonth(String fromMonth) {
    this.fromMonth = fromMonth;
  }
  
  public String getFromYear() {
    return fromYear;
  }
  
  public void setFromYear(String fromYear) {
    this.fromYear = fromYear;
  }
  
  public String gettOrderDate() {
    return tOrderDate;
  }
  
  public void settOrderDate(String tOrderDate) {
    this.tOrderDate = tOrderDate;
  }
  
  public int gettOrderDistrictId() {
    return tOrderDistrictId;
  }
  
  public void settOrderDistrictId(int tOrderDistrictId) {
    this.tOrderDistrictId = tOrderDistrictId;
  }
  
  public int getTalukaId() {
    return talukaId;
  }
  
  public void setTalukaId(int talukaId) {
    this.talukaId = talukaId;
  }
  
  public String getTalukaName() {
    return talukaName;
  }
  
  public void setTalukaName(String talukaName) {
    this.talukaName = talukaName;
  }
  
  public int getTalukaOrderId() {
    return talukaOrderId;
  }
  
  public void setTalukaOrderId(int talukaOrderId) {
    this.talukaOrderId = talukaOrderId;
  }
  
  public String getToMonth() {
    return toMonth;
  }
  
  public void setToMonth(String toMonth) {
    this.toMonth = toMonth;
  }
  
  public String getToYear() {
    return toYear;
  }
  
  public void setToYear(String toYear) {
    this.toYear = toYear;
  }
  
  public String getTalukaOrderGovNum() {
    return talukaOrderGovNum;
  }
  
  public void setTalukaOrderGovNum(String talukaOrderGovNum) {
    this.talukaOrderGovNum = talukaOrderGovNum;
  }
  
  public String getDistrictName() { return districtName; }
  
  public void setDistrictName(String districtName)
  {
    this.districtName = districtName;
  }
  
  public int getMonthDiff() {
    return monthDiff;
  }
  
  public void setMonthDiff(int monthDiff) {
    this.monthDiff = monthDiff;
  }
  
  public int getOrderNumber() {
    return orderNumber;
  }
  
  public void setOrderNumber(int orderNumber) {
    this.orderNumber = orderNumber;
  }
  
  public String getOrderYear() {
    return orderYear;
  }
  
  public void setOrderYear(String orderYear) {
    this.orderYear = orderYear;
  }
  
  public int getG1()
  {
    return G1;
  }
  
  public void setG1(int G1) {
    this.G1 = G1;
  }
  
  public int getDistrictOrderId()
  {
    return districtOrderId;
  }
  
  public void setDistrictOrderId(int districtOrderId) {
    this.districtOrderId = districtOrderId;
  }
  
  public int getCheckInviceID()
  {
    return checkInviceID;
  }
  
  public void setCheckInviceID(int checkInviceID) {
    this.checkInviceID = checkInviceID;
  }
  
  public int getOrderType() { return orderType; }
  
  public void setOrderType(int orderType) {
    this.orderType = orderType;
  }
  
  public String getOrderTypeDetails() { return orderTypeDetails; }
  
  public void setOrderTypeDetails(String orderTypeDetails) {
    this.orderTypeDetails = orderTypeDetails;
  }
  
  public int getStdType() { return stdType; }
  
  public void setStdType(int stdType) {
    this.stdType = stdType;
  }
  
  public String getStdTypeDetails() { return stdTypeDetails; }
  
  public void setStdTypeDetails(String stdTypeDetails) {
    this.stdTypeDetails = stdTypeDetails;
  }
  
  public int getInvoiceID() { return invoiceID; }
  
  public void setInvoiceID(int invoiceID) {
    this.invoiceID = invoiceID;
  }
}
