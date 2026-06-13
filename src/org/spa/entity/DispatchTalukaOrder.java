package org.spa.entity;

public class DispatchTalukaOrder {
	private Integer dispatchDetailsID;
	private Integer dispatchID;
	private Integer beatID;
	private Integer talukaOrderID;
	private Integer fromYear;
	private Integer toYear;
	private Integer biltyFlag;
	private Integer biltyNo;
	private Integer itemID;
	private Integer districtOrderId;
	private String beatMarathi;
	private String sectionMarathi;
	private String talukaMarathi;
	private String orderNumber;
	private String fromMonth;
	private String toMonth;
	private String fromMonthYear;
	private String toMonthYear;
	private String itemMarathi;
	private String districtName;
	private Double totalLoad;
	private Double totalPreviousDispatch;
	private Double totalLoadPending;
	private Double dispatchLoading;
	private Double currentStock;
	private Double mungdaal;
	private Double matki;
	private Double mung;
	private Double masuldaal;
	private Double chvli;
	private Double tel;
	private Double mith;
	private Double mirchi;
	private Double halad;
	private Double jire;
	private Double mohari;
	private Double tandul;

	private Double harbara;
	private Double vatana;
	private Double extra1;
	private Double extra2;
	private Double extra3;
	private Double extra4;
	private Double extra5;
	private Double extra6;

	private String agentName;
	private String biltyDate;
	private String vehicleNumber;
	private Integer orderType;
	private Integer talukaID;

	public DispatchTalukaOrder() {}

	public Integer getDistrictOrderId() {
		return districtOrderId;
	}

	public void setDistrictOrderId(Integer districtOrderId) { this.districtOrderId = districtOrderId; }

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) { this.districtName = districtName; }


	public Double getCurrentStock()
	{
		return currentStock;
	}

	public void setCurrentStock(Double currentStock) { this.currentStock = currentStock; }


	public Integer getTalukaID()
	{
		return talukaID;
	}

	public void setTalukaID(Integer talukaID) { this.talukaID = talukaID; }

	public String getAgentName() {
		return agentName;
	}

	public void setAgentName(String agentName) { this.agentName = agentName; }

	public String getBiltyDate() {
		return biltyDate;
	}

	public void setBiltyDate(String biltyDate) { this.biltyDate = biltyDate; }

	public String getVehicleNumber() {
		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }

	public Integer getOrderType() {
		return orderType;
	}

	public void setOrderType(Integer orderType) { this.orderType = orderType; }

	public Integer getDispatchDetailsID() {
		return dispatchDetailsID;
	}

	public void setDispatchDetailsID(Integer dispatchDetailsID) { this.dispatchDetailsID = dispatchDetailsID; }

	public Integer getDispatchID() {
		return dispatchID;
	}

	public void setDispatchID(Integer dispatchID) { this.dispatchID = dispatchID; }

	public Integer getBeatID() {
		return beatID;
	}

	public void setBeatID(Integer beatID) { this.beatID = beatID; }

	public Integer getTalukaOrderID() {
		return talukaOrderID;
	}

	public void setTalukaOrderID(Integer talukaOrderID) { this.talukaOrderID = talukaOrderID; }

	public Integer getFromYear() {
		return fromYear;
	}

	public void setFromYear(Integer fromYear) { this.fromYear = fromYear; }

	public Integer getToYear() {
		return toYear;
	}

	public void setToYear(Integer toYear) { this.toYear = toYear; }

	public Integer getBiltyFlag() {
		return biltyFlag;
	}

	public void setBiltyFlag(Integer biltyFlag) { this.biltyFlag = biltyFlag; }

	public Integer getBiltyNo() {
		return biltyNo;
	}

	public void setBiltyNo(Integer biltyNo) { this.biltyNo = biltyNo; }

	public String getBeatMarathi() {
		return beatMarathi;
	}

	public void setBeatMarathi(String beatMarathi) { this.beatMarathi = beatMarathi; }

	public String getSectionMarathi() {
		return sectionMarathi;
	}

	public void setSectionMarathi(String sectionMarathi) { this.sectionMarathi = sectionMarathi; }

	public String getTalukaMarathi() {
		return talukaMarathi;
	}

	public void setTalukaMarathi(String talukaMarathi) { this.talukaMarathi = talukaMarathi; }

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

	public String getFromMonth() {
		return fromMonth;
	}

	public void setFromMonth(String fromMonth) { this.fromMonth = fromMonth; }

	public String getToMonth() {
		return toMonth;
	}

	public void setToMonth(String toMonth) { this.toMonth = toMonth; }

	public String getFromMonthYear() {
		return fromMonthYear;
	}

	public void setFromMonthYear(String fromMonthYear) { this.fromMonthYear = fromMonthYear; }

	public String getToMonthYear() {
		return toMonthYear;
	}

	public void setToMonthYear(String toMonthYear) { this.toMonthYear = toMonthYear; }

	public Double getTotalLoad() {
		return totalLoad;
	}

	public void setTotalLoad(Double totalLoad) { this.totalLoad = totalLoad; }

	public Double getTotalPreviousDispatch() {
		return totalPreviousDispatch;
	}

	public void setTotalPreviousDispatch(Double totalPreviousDispatch) { this.totalPreviousDispatch = totalPreviousDispatch; }

	public Double getTotalLoadPending() {
		return totalLoadPending;
	}

	public void setTotalLoadPending(Double totalLoadPending) { this.totalLoadPending = totalLoadPending; }

	public Double getDispatchLoading() {
		return dispatchLoading;
	}

	public void setDispatchLoading(Double dispatchLoading) { this.dispatchLoading = dispatchLoading; }

	public Double getMungdaal() {
		return mungdaal;
	}

	public void setMungdaal(Double mungdaal) { this.mungdaal = mungdaal; }

	public Double getMatki() {
		return matki;
	}

	public void setMatki(Double matki) { this.matki = matki; }

	public Double getMung() {
		return mung;
	}

	public void setMung(Double mung) { this.mung = mung; }

	public Double getMasuldaal() {
		return masuldaal;
	}

	public void setMasuldaal(Double masuldaal) { this.masuldaal = masuldaal; }

	public Double getChvli() {
		return chvli;
	}

	public void setChvli(Double chvli) { this.chvli = chvli; }

	public Double getTel() {
		return tel;
	}

	public void setTel(Double tel) { this.tel = tel; }

	public Double getMith() {
		return mith;
	}

	public void setMith(Double mith) { this.mith = mith; }

	public Double getMirchi() {
		return mirchi;
	}

	public void setMirchi(Double mirchi) { this.mirchi = mirchi; }

	public Double getHalad() {
		return halad;
	}

	public void setHalad(Double halad) { this.halad = halad; }

	public Double getJire() {
		return jire;
	}

	public void setJire(Double jire) { this.jire = jire; }

	public Double getMohari() {
		return mohari;
	}

	public void setMohari(Double mohari) { this.mohari = mohari; }

	public Double getTandul() {
		return tandul;
	}

	public void setTandul(Double tandul) { this.tandul = tandul; }

	public Integer getItemID() {
		return itemID;
	}

	public void setItemID(Integer itemID) { this.itemID = itemID; }

	public String getItemMarathi() {
		return itemMarathi;
	}

	public void setItemMarathi(String itemMarathi) { this.itemMarathi = itemMarathi; }

	public Double getHarbara() {
		return harbara;
	}

	public void setHarbara(Double harbara) {
		this.harbara = harbara;
	}

	public Double getVatana() {
		return vatana;
	}

	public void setVatana(Double vatana) {
		this.vatana = vatana;
	}

	public Double getExtra1() {
		return extra1;
	}

	public void setExtra1(Double extra1) {
		this.extra1 = extra1;
	}

	public Double getExtra2() {
		return extra2;
	}

	public void setExtra2(Double extra2) {
		this.extra2 = extra2;
	}

	public Double getExtra3() {
		return extra3;
	}

	public void setExtra3(Double extra3) {
		this.extra3 = extra3;
	}

	public Double getExtra4() {
		return extra4;
	}

	public void setExtra4(Double extra4) {
		this.extra4 = extra4;
	}

	public Double getExtra5() {
		return extra5;
	}

	public void setExtra5(Double extra5) {
		this.extra5 = extra5;
	}

	public Double getExtra6() {
		return extra6;
	}

	public void setExtra6(Double extra6) {
		this.extra6 = extra6;
	}
}