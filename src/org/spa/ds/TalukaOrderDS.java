package org.spa.ds;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.spa.connect.dbConnection;
import org.spa.convert.monthYearToMarathi;
import org.spa.entity.SectionWiseItemSum;
import org.spa.entity.TalukaOrder;
import org.spa.query.TalukaOrderDSQuery;



public class TalukaOrderDS
{
	PreparedStatement ps = null; PreparedStatement ps1 = null;
	ResultSet resultSet = null; ResultSet resultSet1 = null;

	TalukaOrderDSQuery TODSQ = new TalukaOrderDSQuery();
	dbConnection dbCon;

	public TalukaOrderDS() {}

	public ArrayList<TalukaOrder> getAllTalukaOrder(int dOrderId, String fromDate, String toDate, int district_id, int start, int limit) throws SQLException { ArrayList arr_tOrders = new ArrayList();
	TalukaOrder tOrders = null;
	dbCon = new dbConnection();
	con = dbCon.getConnection();
	try
	{
		ps = con.prepareStatement(TODSQ.s1);
		ps.setInt(1, dOrderId);
		ps.setString(2, fromDate);
		ps.setString(3, toDate);
		ps.setInt(4, district_id);
		ps.setInt(5, start);
		ps.setInt(6, limit);
		resultSet = ps.executeQuery();
		while (resultSet.next())
		{
			tOrders = new TalukaOrder();
			tOrders.setTalukaOrderId(resultSet.getInt(1));
			tOrders.setTalukaOrderGovNum(resultSet.getString(2));
			tOrders.setTalukaId(resultSet.getInt(3));
			tOrders.setTalukaName(resultSet.getString(4));
			tOrders.setFromMonth(new monthYearToMarathi().monthString(resultSet.getInt(5)));
			tOrders.setfMonthId(resultSet.getInt(5));
			tOrders.setFromYear(resultSet.getString(6));
			tOrders.setToMonth(new monthYearToMarathi().monthString(resultSet.getInt(7)));
			tOrders.settMonthId(resultSet.getInt(7));
			tOrders.setToYear(resultSet.getString(8));
			tOrders.settOrderDate(resultSet.getString(9));
			tOrders.setOrderType(resultSet.getInt(10));
			if (resultSet.getInt(10) == 1)
			{
				tOrders.setOrderTypeDetails("Rice");
			}
			else if (resultSet.getInt(10) == 2)
			{
				tOrders.setOrderTypeDetails("Ration");
			}
			tOrders.setTalukaOrderDetailsId(resultSet.getInt(11));
			arr_tOrders.add(tOrders);
		}
	}
	catch (Exception ex)
	{
		throw new RuntimeException(ex);
	}
	finally
	{
		ps.close();
		resultSet.close();
	}
	return arr_tOrders;
	}

	Connection con;
	private int key;
	public int addTalukaOrder(TalukaOrder tOrder) throws SQLException {
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		int key = 0;
		String fMonth = tOrder.getFromMonth();
		String fYear = tOrder.getFromYear();
		String tMonth = tOrder.getToMonth();
		String tYear = tOrder.getToYear();
		try
		{
			ps = con.prepareStatement(TODSQ.i1);
			ps.setInt(1, tOrder.gettOrderDistrictId());
			ps.setInt(2, tOrder.getTalukaId());
			ps.setString(3, tOrder.getTalukaOrderGovNum());
			ps.setString(4, tOrder.gettOrderDate());
			ps.setInt(5, Integer.parseInt(fMonth));
			ps.setInt(6, Integer.parseInt(fYear));
			ps.setInt(7, Integer.parseInt(tMonth));
			ps.setInt(8, Integer.parseInt(tYear));
			ps.setInt(9, tOrder.getOrderType());
			key = ps.executeUpdate();
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			ps.close();
		}
		return key;
	}

	public int updateTalukaOrder(TalukaOrder tOrder)
			throws SQLException
	{
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		int key = 0;
		String fMonth = tOrder.getFromMonth();
		String fYear = tOrder.getFromYear();
		String tMonth = tOrder.getToMonth();
		String tYear = tOrder.getToYear();
		try
		{
			ps = con.prepareStatement(TODSQ.u1);
			ps.setString(1, tOrder.getTalukaOrderGovNum());
			ps.setString(2, tOrder.gettOrderDate());
			ps.setInt(3, Integer.parseInt(fMonth));
			ps.setInt(4, Integer.parseInt(fYear));
			ps.setInt(5, Integer.parseInt(tMonth));
			ps.setInt(6, Integer.parseInt(tYear));
			ps.setInt(7, tOrder.getTalukaOrderId());
			key = ps.executeUpdate();
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			ps.close();
		}
		return key;
	}

	public int deleteTalukaOrder(TalukaOrder tOrder)
			throws SQLException
	{
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		int key = 0;
		try
		{
			ps = con.prepareStatement(TODSQ.u2);
			ps.setInt(1, tOrder.getTalukaOrderId());
			key = ps.executeUpdate();
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			ps.close();
		}
		return key;
	}

	public ArrayList<SectionWiseItemSum> getAllSectionForOrder(int taluka_id, int taluka_order_id)
			throws SQLException
	{
		ArrayList arr_sOrders_sum = new ArrayList();
		SectionWiseItemSum sOrdersSum = null;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		double j = 0.0D;
		try
		{
			ps = con.prepareStatement(TODSQ.s2);
			ps.setInt(1, taluka_order_id);
			ps.setInt(2, taluka_id);
			resultSet = ps.executeQuery();
			while (resultSet.next())
			{
				j = 0.0D;
				j = resultSet.getDouble(12);
				System.out.println("J value :" + j);
				sOrdersSum = new SectionWiseItemSum();
				sOrdersSum.setSectionID(resultSet.getInt(1));
				sOrdersSum.setSectionMarathi(resultSet.getString(2));
				sOrdersSum.setMungdaal(resultSet.getDouble(3));
				sOrdersSum.setMatki(resultSet.getDouble(4));
				sOrdersSum.setMung(resultSet.getDouble(5));
				sOrdersSum.setMasuldaal(resultSet.getDouble(6));
				sOrdersSum.setChvli(resultSet.getDouble(7));
				sOrdersSum.setTel(resultSet.getDouble(8));
				sOrdersSum.setMith(resultSet.getDouble(9));
				sOrdersSum.setMirchi(resultSet.getDouble(10));
				sOrdersSum.setHalad(resultSet.getDouble(11));
				sOrdersSum.setJire(j);
				sOrdersSum.setMohari(resultSet.getDouble(13));
				sOrdersSum.setTandul(resultSet.getDouble(14));

				sOrdersSum.setHarbara(resultSet.getDouble(15));
				sOrdersSum.setVatana(resultSet.getDouble(16));
				sOrdersSum.setExtra1(resultSet.getDouble(17));
				sOrdersSum.setExtra2(resultSet.getDouble(18));
				sOrdersSum.setExtra3(resultSet.getDouble(19));
				sOrdersSum.setExtra4(resultSet.getDouble(20));
				sOrdersSum.setExtra5(resultSet.getDouble(21));
				sOrdersSum.setExtra6(resultSet.getDouble(22));
	
				arr_sOrders_sum.add(sOrdersSum);
			}
		}
		catch (Exception ex)
		{
			throw new RuntimeException(ex);
		}

		return arr_sOrders_sum;
	}

	public ArrayList<SectionWiseItemSum> getAllBeatForOrder(int section_id, int taluka_order_id)
			throws SQLException
	{
		ArrayList arr_bOrders_sum = new ArrayList();
		SectionWiseItemSum bOrdersSum = null;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try
		{
			ps = con.prepareStatement(TODSQ.s3);
			ps.setInt(1, taluka_order_id);
			ps.setInt(2, section_id);
			resultSet = ps.executeQuery();
			while (resultSet.next())
			{
				bOrdersSum = new SectionWiseItemSum();
				bOrdersSum.setBeatID(resultSet.getInt(1));
				bOrdersSum.setBeatMarathi(resultSet.getString(2));
				bOrdersSum.setMungdaal(resultSet.getDouble(3));
				bOrdersSum.setMatki(resultSet.getDouble(4));
				bOrdersSum.setMung(resultSet.getDouble(5));
				bOrdersSum.setMasuldaal(resultSet.getDouble(6));
				bOrdersSum.setChvli(resultSet.getDouble(7));
				bOrdersSum.setTel(resultSet.getDouble(8));
				bOrdersSum.setMith(resultSet.getDouble(9));
				bOrdersSum.setMirchi(resultSet.getDouble(10));
				bOrdersSum.setHalad(resultSet.getDouble(11));
				bOrdersSum.setJire(resultSet.getDouble(12));
				bOrdersSum.setMohari(resultSet.getDouble(13));
				bOrdersSum.setTandul(resultSet.getDouble(14));

				bOrdersSum.setHarbara(resultSet.getDouble(15));
				bOrdersSum.setVatana(resultSet.getDouble(16));
				bOrdersSum.setExtra1(resultSet.getDouble(17));
				bOrdersSum.setExtra2(resultSet.getDouble(18));
				bOrdersSum.setExtra3(resultSet.getDouble(19));
				bOrdersSum.setExtra4(resultSet.getDouble(20));
				bOrdersSum.setExtra5(resultSet.getDouble(21));
				bOrdersSum.setExtra6(resultSet.getDouble(22));
	
				arr_bOrders_sum.add(bOrdersSum);
			}
		}
		catch (Exception ex)
		{
			throw new RuntimeException(ex);
		}
		finally
		{
			resultSet.close();
			ps.close();
		}
		return arr_bOrders_sum;
	}

	public ArrayList<SectionWiseItemSum> getAllTalukaOrderDetails(int beat_id, int talukaOrderId) throws SQLException {
		ArrayList arr_tOrdersDetails = new ArrayList();
		SectionWiseItemSum schoolOrders = null;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try {
			ps = con.prepareStatement(TODSQ.s4);
			ps.setInt(1, talukaOrderId);
			ps.setInt(2, talukaOrderId);
			ps.setInt(3, beat_id);
			resultSet = ps.executeQuery();
			while (resultSet.next())
			{
				schoolOrders = new SectionWiseItemSum();
				schoolOrders.setTalukaOrderDetailsId(resultSet.getInt(1));
				schoolOrders.setTalukaOrderId(resultSet.getInt(2));
				schoolOrders.setBeatID(resultSet.getInt(3));
				schoolOrders.setSchoolID(resultSet.getInt(4));
				schoolOrders.setSchoolMarathi(resultSet.getString(5));
				schoolOrders.setChallanNumber(resultSet.getInt(6));
				schoolOrders.setChallanDate(resultSet.getString(7));
				schoolOrders.setMungdaal(resultSet.getDouble(8));
				schoolOrders.setMatki(resultSet.getDouble(9));
				schoolOrders.setMung(resultSet.getDouble(10));
				schoolOrders.setMasuldaal(resultSet.getDouble(11));
				schoolOrders.setChvli(resultSet.getDouble(12));
				schoolOrders.setTel(resultSet.getDouble(13));
				schoolOrders.setMith(resultSet.getDouble(14));
				schoolOrders.setMirchi(resultSet.getDouble(15));
				schoolOrders.setHalad(resultSet.getDouble(16));
				schoolOrders.setJire(resultSet.getDouble(17));
				schoolOrders.setMohari(resultSet.getDouble(18));
				schoolOrders.setTandul(resultSet.getDouble(19));
				schoolOrders.setChallanMasterID(resultSet.getInt(20));
				schoolOrders.setTruckNo(resultSet.getString(21));
				schoolOrders.setBillNumber(resultSet.getInt(22));
				schoolOrders.setOrderType(resultSet.getInt(23));

				schoolOrders.setHarbara(resultSet.getDouble(24));
				schoolOrders.setVatana(resultSet.getDouble(25));
				schoolOrders.setExtra1(resultSet.getDouble(26));
				schoolOrders.setExtra2(resultSet.getDouble(27));
				schoolOrders.setExtra3(resultSet.getDouble(28));
				schoolOrders.setExtra4(resultSet.getDouble(29));
				schoolOrders.setExtra5(resultSet.getDouble(30));
				schoolOrders.setExtra6(resultSet.getDouble(31));
	
				arr_tOrdersDetails.add(schoolOrders);
			}
		}
		catch (Exception ex) {
			throw new RuntimeException(ex);
		} finally {
			ps.close();resultSet.close(); 
		}
		return arr_tOrdersDetails;
	}

	public ArrayList<SectionWiseItemSum> getAllTalukaOrderDetailsforChallan(int beat_id, int talukaOrderId)
			throws SQLException
	{
		ArrayList arr_tOrdersDetails = new ArrayList();
		SectionWiseItemSum schoolOrders = null;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try
		{
			ps = con.prepareStatement(TODSQ.s12);
			ps.setInt(1, talukaOrderId);
			ps.setInt(2, talukaOrderId);
			ps.setInt(3, beat_id);
			resultSet = ps.executeQuery();
			while (resultSet.next()) {
				schoolOrders = new SectionWiseItemSum();
				schoolOrders.setTalukaOrderDetailsId(resultSet.getInt(1));
				schoolOrders.setTalukaOrderId(resultSet.getInt(2));
				schoolOrders.setBeatID(resultSet.getInt(3));
				schoolOrders.setSchoolID(resultSet.getInt(4));
				schoolOrders.setSchoolMarathi(resultSet.getString(5));
				schoolOrders.setChallanNumber(resultSet.getInt(6));
				schoolOrders.setChallanDate(resultSet.getString(7));
				schoolOrders.setMungdaal(resultSet.getDouble(8));
				schoolOrders.setMatki(resultSet.getDouble(9));
				schoolOrders.setMung(resultSet.getDouble(10));
				schoolOrders.setMasuldaal(resultSet.getDouble(11));
				schoolOrders.setChvli(resultSet.getDouble(12));
				schoolOrders.setTel(resultSet.getDouble(13));
				schoolOrders.setMith(resultSet.getDouble(14));
				schoolOrders.setMirchi(resultSet.getDouble(15));
				schoolOrders.setHalad(resultSet.getDouble(16));
				schoolOrders.setJire(resultSet.getDouble(17));
				schoolOrders.setMohari(resultSet.getDouble(18));
				schoolOrders.setTandul(resultSet.getDouble(19));
				schoolOrders.setChallanMasterID(resultSet.getInt(20));
				schoolOrders.setTruckNo(resultSet.getString(21));
				schoolOrders.setBillNumber(resultSet.getInt(22));
				schoolOrders.setOrderType(resultSet.getInt(23));

				schoolOrders.setHarbara(resultSet.getInt(24));
				schoolOrders.setVatana(resultSet.getInt(25));
				schoolOrders.setExtra1(resultSet.getInt(26));
				schoolOrders.setExtra2(resultSet.getDouble(27));
				schoolOrders.setExtra3(resultSet.getDouble(28));
				schoolOrders.setExtra4(resultSet.getDouble(29));
				schoolOrders.setExtra5(resultSet.getDouble(30));
				schoolOrders.setExtra6(resultSet.getDouble(31));
	
				arr_tOrdersDetails.add(schoolOrders);
		}
	}
	catch (Exception ex)
	{
		throw new RuntimeException(ex);
	} finally {
		ps.close();resultSet.close();
	}
	return arr_tOrdersDetails;
	}

	public ArrayList<SectionWiseItemSum> getAllTalukaReturnDetails(int beat_id, int talukaOrderId)
			throws SQLException
	{
		ArrayList arr_tOrdersDetails = new ArrayList();
		SectionWiseItemSum schoolOrders = null;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try
		{
			ps = con.prepareStatement(TODSQ.s10);
			ps.setInt(1, talukaOrderId);
			ps.setInt(2, beat_id);
			resultSet = ps.executeQuery();
			while (resultSet.next())
			{
				schoolOrders = new SectionWiseItemSum();
				schoolOrders.setTalukaOrderDetailsId(resultSet.getInt(1));
				schoolOrders.setTalukaOrderId(resultSet.getInt(2));
				schoolOrders.setBeatID(resultSet.getInt(3));
				schoolOrders.setSchoolID(resultSet.getInt(4));
				schoolOrders.setSchoolMarathi(resultSet.getString(5));
				schoolOrders.setMungdaal(resultSet.getDouble(6));
				schoolOrders.setMatki(resultSet.getDouble(7));
				schoolOrders.setMung(resultSet.getDouble(8));
				schoolOrders.setMasuldaal(resultSet.getDouble(9));
				schoolOrders.setChvli(resultSet.getDouble(10));
				schoolOrders.setTel(resultSet.getDouble(11));
				schoolOrders.setMith(resultSet.getDouble(12));
				schoolOrders.setMirchi(resultSet.getDouble(13));
				schoolOrders.setHalad(resultSet.getDouble(14));
				schoolOrders.setJire(resultSet.getDouble(15));
				schoolOrders.setMohari(resultSet.getDouble(16));
				schoolOrders.setTandul(resultSet.getDouble(17));

			schoolOrders.setHarbara(resultSet.getDouble(18));
			schoolOrders.setVatana(resultSet.getDouble(19));
			schoolOrders.setExtra1(resultSet.getDouble(20));
			schoolOrders.setExtra2(resultSet.getDouble(21));
			schoolOrders.setExtra3(resultSet.getDouble(22));
			schoolOrders.setExtra4(resultSet.getDouble(23));
			schoolOrders.setExtra5(resultSet.getDouble(24));
			schoolOrders.setExtra6(resultSet.getDouble(25));

			arr_tOrdersDetails.add(schoolOrders);
			}
		}
		catch (Exception ex)
		{
			throw new RuntimeException(ex);
		} finally {
			ps.close();resultSet.close(); }
		return arr_tOrdersDetails;
	}

	public SectionWiseItemSum getTalukaReturnDetails(int talukaOrderId)
			throws SQLException
	{
		SectionWiseItemSum schoolOrders = null;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try
		{
			ps = con.prepareStatement(TODSQ.s11);
			ps.setInt(1, talukaOrderId);
			resultSet = ps.executeQuery();
			if (resultSet.next())
			{
				schoolOrders = new SectionWiseItemSum();
				schoolOrders.setMungdaal(resultSet.getDouble(1));
				schoolOrders.setMatki(resultSet.getDouble(2));
				schoolOrders.setMung(resultSet.getDouble(3));
				schoolOrders.setMasuldaal(resultSet.getDouble(4));
				schoolOrders.setChvli(resultSet.getDouble(5));
				schoolOrders.setTel(resultSet.getDouble(6));
				schoolOrders.setMith(resultSet.getDouble(7));
				schoolOrders.setMirchi(resultSet.getDouble(8));
				schoolOrders.setHalad(resultSet.getDouble(9));
				schoolOrders.setJire(resultSet.getDouble(10));
				schoolOrders.setMohari(resultSet.getDouble(11));
				schoolOrders.setTandul(resultSet.getDouble(12));

				schoolOrders.setHarbara(resultSet.getDouble(13));
				schoolOrders.setVatana(resultSet.getDouble(14));
				schoolOrders.setExtra1(resultSet.getDouble(15));
				schoolOrders.setExtra2(resultSet.getDouble(16));
				schoolOrders.setExtra3(resultSet.getDouble(17));
				schoolOrders.setExtra4(resultSet.getDouble(18));
				schoolOrders.setExtra5(resultSet.getDouble(19));
				schoolOrders.setExtra6(resultSet.getDouble(20));
			}
		}
		catch (Exception ex)
		{
			throw new RuntimeException(ex);
		}
		finally
		{
			ps.close();
			resultSet.close();
		}
		return schoolOrders;
	}

	public int createOrderDetail(SectionWiseItemSum detail, int sectionID)
			throws SQLException
	{
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		int key = 0;
		try
		{
			ps = con.prepareStatement(TODSQ.i2);
			ps.setInt(1, detail.getTalukaOrderId());
			ps.setInt(2, sectionID);
			ps.setInt(3, detail.getBeatID());
			ps.setInt(4, detail.getSchoolID());
			ps.setDouble(5, detail.getMungdaal());
			ps.setDouble(6, detail.getMatki());
			ps.setDouble(7, detail.getMung());
			ps.setDouble(8, detail.getMasuldaal());
			ps.setDouble(9, detail.getChvli());
			ps.setDouble(10, detail.getTel());
			ps.setDouble(11, detail.getMith());
			ps.setDouble(12, detail.getMirchi());
			ps.setDouble(13, detail.getHalad());
			ps.setDouble(14, detail.getJire());
			ps.setDouble(15, detail.getMohari());
			ps.setDouble(16, detail.getTandul());

			ps.setDouble(17, detail.getHarbara());
			ps.setDouble(18, detail.getVatana());
			ps.setDouble(19, detail.getExtra1());
			ps.setDouble(20, detail.getExtra2());
			ps.setDouble(21, detail.getExtra3());
			ps.setDouble(22, detail.getExtra4());
			ps.setDouble(23, detail.getExtra5());
			ps.setDouble(24, detail.getExtra6());

			key = ps.executeUpdate();
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			ps.close();
		}
		return key;
	}

	public int createReturnDetail(SectionWiseItemSum detail, int sectionID)
			throws SQLException
	{
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		int key = 0;
		try
		{
			ps = con.prepareStatement(TODSQ.i5);
			ps.setInt(1, detail.getTalukaOrderId());
			ps.setInt(2, sectionID);
			ps.setInt(3, detail.getBeatID());
			ps.setInt(4, detail.getSchoolID());
			ps.setDouble(5, detail.getMungdaal());
			ps.setDouble(6, detail.getMatki());
			ps.setDouble(7, detail.getMung());
			ps.setDouble(8, detail.getMasuldaal());
			ps.setDouble(9, detail.getChvli());
			ps.setDouble(10, detail.getTel());
			ps.setDouble(11, detail.getMith());
			ps.setDouble(12, detail.getMirchi());
			ps.setDouble(13, detail.getHalad());
			ps.setDouble(14, detail.getJire());
			ps.setDouble(15, detail.getMohari());
			ps.setDouble(16, detail.getTandul());

			ps.setDouble(17, detail.getHarbara());
			ps.setDouble(18, detail.getVatana());
			ps.setDouble(19, detail.getExtra1());
			ps.setDouble(20, detail.getExtra2());
			ps.setDouble(21, detail.getExtra3());
			ps.setDouble(22, detail.getExtra4());
			ps.setDouble(23, detail.getExtra5());
			ps.setDouble(24, detail.getExtra6());

			key = ps.executeUpdate();
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			ps.close();
		}
		return key;
	}

	public int updateOrderDetail(SectionWiseItemSum detail, int sectionID)
			throws SQLException
	{
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		int key = 0;
		try
		{
		ps = con.prepareStatement(TODSQ.i3);
		ps.setDouble(1, detail.getMungdaal());
		ps.setDouble(2, detail.getMatki());
		ps.setDouble(3, detail.getMung());
		ps.setDouble(4, detail.getMasuldaal());
		ps.setDouble(5, detail.getChvli());
		ps.setDouble(6, detail.getTel());
		ps.setDouble(7, detail.getMith());
		ps.setDouble(8, detail.getMirchi());
		ps.setDouble(9, detail.getHalad());
		ps.setDouble(10, detail.getJire());
		ps.setDouble(11, detail.getMohari());
		ps.setDouble(12, detail.getTandul());

		ps.setDouble(13, detail.getHarbara());
		ps.setDouble(14, detail.getVatana());
		ps.setDouble(15, detail.getExtra1());
		ps.setDouble(16, detail.getExtra2());
		ps.setDouble(17, detail.getExtra3());
		ps.setDouble(18, detail.getExtra4());
		ps.setDouble(19, detail.getExtra5());
		ps.setDouble(20, detail.getExtra6());
		ps.setInt(21, detail.getTalukaOrderId());
		ps.setInt(22, sectionID);
		ps.setInt(23, detail.getBeatID());
		ps.setInt(24, detail.getSchoolID());
			key = ps.executeUpdate();
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			ps.close();
		}
		return key;
	}

	public int updateReturnDetail(SectionWiseItemSum detail, int sectionID)
			throws SQLException
	{
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		int key = 0;
		try
		{
		ps = con.prepareStatement(TODSQ.i6);
		ps.setDouble(1, detail.getMungdaal());
		ps.setDouble(2, detail.getMatki());
		ps.setDouble(3, detail.getMung());
		ps.setDouble(4, detail.getMasuldaal());
		ps.setDouble(5, detail.getChvli());
		ps.setDouble(6, detail.getTel());
		ps.setDouble(7, detail.getMith());
		ps.setDouble(8, detail.getMirchi());
		ps.setDouble(9, detail.getHalad());
		ps.setDouble(10, detail.getJire());
		ps.setDouble(11, detail.getMohari());
		ps.setDouble(12, detail.getTandul());

		ps.setDouble(13, detail.getHarbara());
		ps.setDouble(14, detail.getVatana());
		ps.setDouble(15, detail.getExtra1());
		ps.setDouble(16, detail.getExtra2());
		ps.setDouble(17, detail.getExtra3());
		ps.setDouble(18, detail.getExtra4());
		ps.setDouble(19, detail.getExtra5());
		ps.setDouble(20, detail.getExtra6());
		ps.setInt(21, detail.getTalukaOrderId());
		ps.setInt(22, sectionID);
		ps.setInt(23, detail.getBeatID());
		ps.setInt(24, detail.getSchoolID());
			key = ps.executeUpdate();
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			ps.close();
		}
		return key;
	}

	public int resetSectionOrderDetails(int tOrderID)
			throws SQLException
	{
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		int key = 0;
		try
		{
			ps = con.prepareStatement(TODSQ.d1);
			ps.setInt(1, tOrderID);
			key = ps.executeUpdate();
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			ps.close();
		}
		return key;
	}

	public int createChallans(int beatID, int talukaOrderID, String challanDate) throws SQLException
	{
		List<SectionWiseItemSum> details = getAllTalukaOrderDetails(beatID, talukaOrderID);
		for (SectionWiseItemSum detail : details)
		{
			key = createChallans(detail, beatID, talukaOrderID, challanDate);
		}
		return key;
	}

	public int createChallans(SectionWiseItemSum details, int beatID, int orderID, String challanDate) throws SQLException
	{
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		int getgeneratedkey = 0;
		if (details.getChallanMasterID() == 0) {
			int nextChallan = getNextChallan();
			int nextbillNumber = 0;
			System.out.println("printed by raj details.getOrderType() : "+details.getOrderType());
			if(details.getOrderType() == 2){
				nextbillNumber = getNextBillNumber();
			}
			try {
				ps = con.prepareStatement(TODSQ.i4);
				ps.setInt(1, nextChallan);
				ps.setInt(2, nextbillNumber);
				ps.setString(3, challanDate);
				ps.executeUpdate();
				resultSet = ps.getGeneratedKeys();
				if (resultSet.next()) {
					getgeneratedkey = resultSet.getInt(1);
				}
				ps = con.prepareStatement(TODSQ.u4);
				ps.setInt(1, getgeneratedkey);
				ps.setString(2, challanDate);
				ps.setInt(3, details.getTalukaOrderDetailsId());
				key = ps.executeUpdate();
			}
			catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		else {
			try {
				ps = con.prepareStatement(TODSQ.u3);
				ps.setString(1, challanDate);
				ps.setInt(2, details.getChallanMasterID());
				key = ps.executeUpdate();
				ps = con.prepareStatement(TODSQ.u4);
				ps.setInt(1, details.getChallanMasterID());
				ps.setString(2, challanDate);
				ps.setInt(3, details.getTalukaOrderDetailsId());
				key = ps.executeUpdate();
			}
			catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		return 1;
	}

	public int getNextChallan() throws SQLException
	{
		int max = 0;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try
		{
			ps = con.prepareStatement(TODSQ.s5);
			resultSet = ps.executeQuery();
			if ((resultSet != null) && (resultSet.next()))
			{
				max = resultSet.getInt(1);
			}
		}
		catch (Exception e) {
			throw new RuntimeException(e);
		}
		finally {
			resultSet.close();
			ps.close();
		}
		return max + 1;
	}

	public int getNextBillNumber() throws SQLException {
		int max = 0;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try
		{
			ps = con.prepareStatement(TODSQ.s14);
			resultSet = ps.executeQuery();
			if ((resultSet != null) && (resultSet.next())) {
				max = resultSet.getInt(1);
			}
		}
		catch (Exception e) {
			throw new RuntimeException(e);
		}
		finally {
			resultSet.close();
			ps.close();
		}
		return max + 1;
	}

	public List<TalukaOrder> getTalukaOrderList(int talukaID, int talukaOrderID, int orderType)
			throws SQLException
	{
		TalukaOrder order = null;
		List list = new ArrayList();

		monthYearToMarathi monthYear = new monthYearToMarathi();

		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try
		{
			ps = con.prepareStatement(TODSQ.s6);
			ps.setInt(1, talukaID);
			ps.setInt(2, talukaOrderID);
			ps.setInt(3, orderType);
			ps.setInt(4, talukaOrderID);
			resultSet = ps.executeQuery();
			if (resultSet != null)
			{
				while (resultSet.next())
				{
					order = new TalukaOrder();
					order.setTalukaOrderId(resultSet.getInt(1));
					order.setOrderNumber(resultSet.getInt(2));

					order.setOrderYear(resultSet.getInt(2) + " (" + monthYear.monthString(resultSet.getInt(3)) + "/" + monthYear.yearString(resultSet.getInt(4)) + "-" + monthYear.monthString(resultSet.getInt(5)) + "/" + monthYear.yearString(resultSet.getInt(6)) + ")");
					order.settOrderDate(resultSet.getString(7));
					list.add(order);
				}
			}
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			resultSet.close();
			ps.close();
		}
		return list;
	}

	public List<TalukaOrder> getTalukaOrderListAll(int talukaID, int orderType)
			throws SQLException
	{
		TalukaOrder order = null;
		List list = new ArrayList();

		monthYearToMarathi monthYear = new monthYearToMarathi();

		dbCon = new dbConnection();
		con = dbCon.getConnection();
		String ot = null;
		try
		{
			if (orderType != 0)
			{
				ps = con.prepareStatement(TODSQ.s7);
				ps.setInt(1, talukaID);
				ps.setInt(2, orderType);
			}
			else
			{
				ps = con.prepareStatement(TODSQ.s9);
				ps.setInt(1, talukaID);
			}
			resultSet = ps.executeQuery();
			if (resultSet != null)
			{
				while (resultSet.next())
				{
					order = new TalukaOrder();
					order.setTalukaOrderId(resultSet.getInt(1));
					order.setOrderNumber(resultSet.getInt(2));
					if (Integer.parseInt(resultSet.getString(8)) == 1) {
						ot = "Rise";
					} else
						ot = "Ration";
					order.setOrderYear(resultSet.getInt(2) + " (" + monthYear.monthString(resultSet.getInt(3)) + "/" + monthYear.yearString(resultSet.getInt(4)) + "-" + monthYear.monthString(resultSet.getInt(5)) + "/" + monthYear.yearString(resultSet.getInt(6)) + ") " + " " + ot);
					order.settOrderDate(resultSet.getString(7));
					list.add(order);
				}
			}
		}
		catch (Exception e)
		{
			throw new RuntimeException(e);
		}
		finally
		{
			resultSet.close();
			ps.close();
		}
		return list;
	}

	public ArrayList<SectionWiseItemSum> getAllTalukaOrderDetailsForCopy(int talukaOrderId)
			throws SQLException
	{
		ArrayList arr_tOrdersDetails = new ArrayList();
		SectionWiseItemSum sectionWiseItemSum = null;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try
		{
			ps = con.prepareStatement(TODSQ.s8);
			ps.setInt(1, talukaOrderId);
			resultSet = ps.executeQuery();
			while (resultSet.next())
			{
				sectionWiseItemSum = new SectionWiseItemSum();
				sectionWiseItemSum.setSectionID(resultSet.getInt(1));
				sectionWiseItemSum.setBeatID(resultSet.getInt(2));
				sectionWiseItemSum.setSchoolID(resultSet.getInt(3));
				sectionWiseItemSum.setMungdaal(resultSet.getDouble(4));
				sectionWiseItemSum.setMatki(resultSet.getDouble(5));
				sectionWiseItemSum.setMung(resultSet.getDouble(6));
				sectionWiseItemSum.setMasuldaal(resultSet.getDouble(7));
				sectionWiseItemSum.setChvli(resultSet.getDouble(8));
				sectionWiseItemSum.setTel(resultSet.getDouble(9));
				sectionWiseItemSum.setMith(resultSet.getDouble(10));
				sectionWiseItemSum.setMirchi(resultSet.getDouble(11));
				sectionWiseItemSum.setHalad(resultSet.getDouble(12));
				sectionWiseItemSum.setJire(resultSet.getDouble(13));
				sectionWiseItemSum.setMohari(resultSet.getDouble(14));
				sectionWiseItemSum.setTandul(resultSet.getDouble(15));

				sectionWiseItemSum.setHarbara(resultSet.getDouble(16));
				sectionWiseItemSum.setVatana(resultSet.getDouble(17));
				sectionWiseItemSum.setExtra1(resultSet.getDouble(18));
				sectionWiseItemSum.setExtra2(resultSet.getDouble(19));
				sectionWiseItemSum.setExtra3(resultSet.getDouble(20));
				sectionWiseItemSum.setExtra4(resultSet.getDouble(21));
				sectionWiseItemSum.setExtra5(resultSet.getDouble(22));
				sectionWiseItemSum.setExtra6(resultSet.getDouble(23));
	
				arr_tOrdersDetails.add(sectionWiseItemSum);
			}
		}
		catch (Exception ex)
		{
			throw new RuntimeException(ex);
		}
		finally
		{
			ps.close();
		}

		return arr_tOrdersDetails;
	}

	public ArrayList<SectionWiseItemSum> getAllOrderWiseSchoolDetailsByRoot(int taluka_order_id, int rootID)
			throws SQLException
	{
		ArrayList arr_sOrders_sum = new ArrayList();
		SectionWiseItemSum sOrdersSum = null;
		dbCon = new dbConnection();
		con = dbCon.getConnection();
		try
		{
			ps = con.prepareStatement(TODSQ.s13);
			ps.setInt(1, rootID);
			ps.setInt(2, taluka_order_id);
			resultSet = ps.executeQuery();
			while (resultSet.next())
			{
				sOrdersSum = new SectionWiseItemSum();
				sOrdersSum.setTalukaOrderDetailsId(resultSet.getInt(1));
				sOrdersSum.setSectionID(resultSet.getInt(2));
				sOrdersSum.setSchoolMarathi(resultSet.getString(3));
				sOrdersSum.setMungdaal(resultSet.getDouble(4));
				sOrdersSum.setMatki(resultSet.getDouble(5));
				sOrdersSum.setMung(resultSet.getDouble(6));
				sOrdersSum.setMasuldaal(resultSet.getDouble(7));
				sOrdersSum.setChvli(resultSet.getDouble(8));
				sOrdersSum.setTel(resultSet.getDouble(9));
				sOrdersSum.setMith(resultSet.getDouble(10));
				sOrdersSum.setMirchi(resultSet.getDouble(11));
				sOrdersSum.setHalad(resultSet.getDouble(12));
				sOrdersSum.setJire(resultSet.getDouble(13));
				sOrdersSum.setMohari(resultSet.getDouble(14));
				sOrdersSum.setTandul(resultSet.getDouble(15));

				sOrdersSum.setHarbara(resultSet.getDouble(16));
				sOrdersSum.setVatana(resultSet.getDouble(17));
				sOrdersSum.setExtra1(resultSet.getDouble(18));
				sOrdersSum.setExtra2(resultSet.getDouble(19));
				sOrdersSum.setExtra3(resultSet.getDouble(20));
				sOrdersSum.setExtra4(resultSet.getDouble(21));
				sOrdersSum.setExtra5(resultSet.getDouble(22));
				sOrdersSum.setExtra6(resultSet.getDouble(23));

			arr_sOrders_sum.add(sOrdersSum);
			}
		}
		catch (Exception ex)
		{
			throw new RuntimeException(ex);
		}

		return arr_sOrders_sum;
	}
}