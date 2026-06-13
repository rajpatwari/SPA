package org.spa.ds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.spa.connect.dbConnection;
import org.spa.entity.Dispatch;
import org.spa.entity.DispatchTalukaOrder;
import org.spa.entity.SectionWiseItemSum;
import org.spa.entity.Stock;
import org.spa.query.DispatchDSQuery;

public class DispatchDS
{
  dbConnection dbConnection = null;
  Connection con = null;
  int key = 0;
  PreparedStatement ps = null; PreparedStatement ps1 = null; PreparedStatement ps2 = null;
  ResultSet resultSet = null; ResultSet resultSet1 = null; ResultSet resultSet2 = null;
  DispatchDSQuery ddsq = new DispatchDSQuery();
  
  public DispatchDS() {}
  
  public List<Dispatch> getAllDispatches(int start, int limit, String startDate, String endDate) throws SQLException {
    Dispatch dispatch = null;
    List<Dispatch> dispatchList = new ArrayList();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(ddsq.select1);
      ps.setString(1, startDate);
      ps.setString(2, endDate);
      ps.setInt(3, start);
      ps.setInt(4, limit);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          dispatch = new Dispatch();
          dispatch.setDispatchID(Integer.valueOf(resultSet.getInt(1)));
          dispatch.setBiltyNo(Integer.valueOf(resultSet.getInt(2)));
          dispatch.setCreatedOn(resultSet.getString(3));
          dispatch.setTruckCapacity(resultSet.getDouble(4));
          dispatch.setFreightPerTonInRupees(resultSet.getDouble(5));
          dispatch.setAdvanceFrieght(resultSet.getDouble(6));
          dispatch.setDriverName(resultSet.getString(7));
          dispatch.setDistrictID(Integer.valueOf(resultSet.getInt(8)));
          dispatch.setDistrictMarathi(resultSet.getString(9));
          dispatch.setTalukaID(Integer.valueOf(resultSet.getInt(10)));
          dispatch.setTalukaMarathi(resultSet.getString(11));
          dispatch.setAgentName(resultSet.getString(12));
          dispatch.setBiltyDate(resultSet.getString(13));
          dispatch.setDraftBiltyNo(Integer.valueOf(resultSet.getInt(14)));
          dispatch.setDriverLicense(resultSet.getString(15));
          dispatch.setVehicleNo(resultSet.getString(16));
          dispatch.setActualLoading(resultSet.getDouble(17));
          dispatchList.add(dispatch);
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
    
    return dispatchList;
  }
  
  public Dispatch getDispatches(int dispatchID)
    throws SQLException
  {
    Dispatch dispatch = null;
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(ddsq.select2);
      ps.setInt(1, dispatchID);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        dispatch = new Dispatch();
        dispatch.setDispatchID(Integer.valueOf(resultSet.getInt(1)));
        dispatch.setBiltyNo(Integer.valueOf(resultSet.getInt(2)));
        dispatch.setCreatedOn(resultSet.getString(3));
        dispatch.setTruckCapacity(resultSet.getDouble(4));
        dispatch.setFreightPerTonInRupees(resultSet.getDouble(5));
        dispatch.setAdvanceFrieght(resultSet.getDouble(6));
        dispatch.setDriverName(resultSet.getString(7));
        dispatch.setDistrictID(Integer.valueOf(resultSet.getInt(8)));
        dispatch.setDistrictMarathi(resultSet.getString(9));
        dispatch.setTalukaID(Integer.valueOf(resultSet.getInt(10)));
        dispatch.setTalukaMarathi(resultSet.getString(11));
        dispatch.setAgentName(resultSet.getString(12));
        dispatch.setBiltyDate(resultSet.getString(13));
        dispatch.setDraftBiltyNo(Integer.valueOf(resultSet.getInt(14)));
        dispatch.setDriverLicense(resultSet.getString(15));
        dispatch.setVehicleNo(resultSet.getString(16));
        dispatch.setActualLoading(resultSet.getDouble(17));
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return dispatch;
  }
  
  public int createDispatch(Dispatch dispatch) throws SQLException
  {
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(ddsq.insert1);
      ps.setDouble(1, dispatch.getTruckCapacity());
      ps.setDouble(2, dispatch.getFreightPerTonInRupees());
      ps.setDouble(3, dispatch.getAdvanceFrieght());
      ps.setString(4, dispatch.getDriverName());
      ps.setString(5, dispatch.getDriverLicense());
      ps.setString(6, dispatch.getVehicleNo());
      ps.setString(7, dispatch.getAgentName());
      ps.setString(8, dispatch.getBiltyDate());
      ps.setInt(9, dispatch.getDraftBiltyNo().intValue());
      ps.setInt(10, dispatch.getTalukaID().intValue());
      ps.executeUpdate();
      resultSet = ps.getGeneratedKeys();
      while (resultSet.next())
      {
        key = resultSet.getInt(1);
        System.out.println(key);
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
    
    return key;
  }
  
  public int updateDispatch(Dispatch dispatch) throws SQLException
  {
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(ddsq.update1);
      ps.setDouble(1, dispatch.getTruckCapacity());
      ps.setDouble(2, dispatch.getFreightPerTonInRupees());
      ps.setDouble(3, dispatch.getAdvanceFrieght());
      ps.setString(4, dispatch.getDriverName());
      ps.setString(5, dispatch.getDriverLicense());
      ps.setString(6, dispatch.getVehicleNo());
      ps.setString(7, dispatch.getAgentName());
      ps.setString(8, dispatch.getBiltyDate());
      ps.setInt(9, dispatch.getDraftBiltyNo().intValue());
      ps.setInt(10, dispatch.getDispatchID().intValue());
      ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    
    return 1;
  }
  
  public int deleteDispatch(int dispatchID) throws SQLException
  {
    String delete1 = " DELETE FROM dispatch_taluka_order_details WHERE dispatch_id_fk = ? ";
    String delete2 = " DELETE FROM dispatch WHERE dispatch_id = ? ";
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(delete1);
      ps.setInt(1, dispatchID);
      key = ps.executeUpdate();
      ps = con.prepareStatement(delete2);
      ps.setInt(1, dispatchID);
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
  
  public int deleteDispatchDetails(int dispatchDetailsID) throws SQLException
  {
    String delete1 = " DELETE FROM dispatch_taluka_order_details WHERE id = ? ";
    
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(delete1);
      ps.setInt(1, dispatchDetailsID);
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
  
  public int deleteBilty(int dispatchID) throws SQLException
  {
    String delete1 = " UPDATE dispatch_taluka_order_details set bilty_flag = 0 where dispatch_id_fk = ? ";
    String delete2 = " UPDATE dispatch SET bilty_no = 0 WHERE dispatch_id = ? ";
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(delete1);
      ps.setInt(1, dispatchID);
      key = ps.executeUpdate();
      ps = con.prepareStatement(delete2);
      ps.setInt(1, dispatchID);
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
  
  public List<DispatchTalukaOrder> getDispatcheTalukaOrders(int dispatchID, int biltyNo)
    throws SQLException
  {
    String sql = " SELECT dtod.id,dtod.dispatch_id_fk,dtod.beat_id,bm.beat_marathi, sm.section_marathi,tm.taluka_marathi,dtod.taluka_order_id, tor.taluka_gov_order_num,mm1.month_marathi,tor.from_year,mm.month_marathi,tor.to_year, dtod.bilty_flag, get_beat_wise_total_taluka_order(dtod.taluka_order_id,dtod.beat_id) AS total_order, get_beat_wise_total_dispatch(dtod.dispatch_id_fk,dtod.beat_id,1,dtod.taluka_order_id) AS total_dispatch, get_beat_wise_total_dispatch(dtod.dispatch_id_fk,dtod.beat_id,0,dtod.taluka_order_id) AS today_dispatch   FROM dispatch_taluka_order_details dtod  INNER JOIN beat_master bm ON bm.beat_id = dtod.beat_id  INNER JOIN section_master sm ON sm.section_id = bm.section_id  INNER JOIN taluka_master tm ON tm.taluka_id = sm.taluka_id_fk  INNER JOIN taluka_order tor ON tor.taluka_order_id = dtod.taluka_order_id  INNER JOIN month_master mm1 ON mm1.id = tor.from_month  INNER JOIN month_master mm ON mm.id = tor.to_month  WHERE dtod.dispatch_id_fk = ? ";
    
    DispatchTalukaOrder dispatchTalukaOrder = null;
    List<DispatchTalukaOrder> dispatchTalukaOrderList = new ArrayList();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, dispatchID);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          dispatchTalukaOrder = new DispatchTalukaOrder();
          dispatchTalukaOrder.setBiltyNo(Integer.valueOf(biltyNo));
          dispatchTalukaOrder.setDispatchDetailsID(Integer.valueOf(resultSet.getInt(1)));
          dispatchTalukaOrder.setDispatchID(Integer.valueOf(resultSet.getInt(2)));
          dispatchTalukaOrder.setBeatID(Integer.valueOf(resultSet.getInt(3)));
          dispatchTalukaOrder.setBeatMarathi(resultSet.getString(4));
          dispatchTalukaOrder.setSectionMarathi(resultSet.getString(5));
          dispatchTalukaOrder.setTalukaMarathi(resultSet.getString(6));
          dispatchTalukaOrder.setTalukaOrderID(Integer.valueOf(resultSet.getInt(7)));
          dispatchTalukaOrder.setOrderNumber(resultSet.getString(8));
          dispatchTalukaOrder.setFromMonth(resultSet.getString(9));
          dispatchTalukaOrder.setFromYear(Integer.valueOf(resultSet.getInt(10)));
          dispatchTalukaOrder.setToMonth(resultSet.getString(11));
          dispatchTalukaOrder.setToYear(Integer.valueOf(resultSet.getInt(12)));
          dispatchTalukaOrder.setBiltyFlag(Integer.valueOf(resultSet.getInt(13)));
          dispatchTalukaOrder.setTotalLoad(Double.valueOf(resultSet.getDouble(14)));
          dispatchTalukaOrder.setTotalPreviousDispatch(Double.valueOf(resultSet.getDouble(15)));
          dispatchTalukaOrder.setDispatchLoading(Double.valueOf(resultSet.getDouble(16)));
          dispatchTalukaOrder.setTotalLoadPending(Double.valueOf(resultSet.getDouble(14) - resultSet.getDouble(15)));
          dispatchTalukaOrder.setFromMonthYear(resultSet.getString(9) + resultSet.getInt(10));
          dispatchTalukaOrder.setToMonthYear(resultSet.getString(11) + resultSet.getInt(12));
          dispatchTalukaOrderList.add(dispatchTalukaOrder);
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
    
    return dispatchTalukaOrderList;
  }
  
  public int dubDispatchOrder(DispatchTalukaOrder dispatchTalukaOrder) throws SQLException
  {
    String sql = " SELECT COUNT(*) FROM dispatch_taluka_order_details WHERE dispatch_id_fk = ? AND  beat_id = ? AND taluka_order_id = ? ";
    
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, dispatchTalukaOrder.getDispatchID().intValue());
      ps.setInt(2, dispatchTalukaOrder.getBeatID().intValue());
      ps.setInt(3, dispatchTalukaOrder.getTalukaOrderID().intValue());
      resultSet = ps.executeQuery();
      if (resultSet.next()) {
        key = resultSet.getInt(1);
      }
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return key;
  }
  
  public int createDispatchOrder(DispatchTalukaOrder dispatchTalukaOrder)
    throws SQLException
  {
    String sql = " INSERT INTO dispatch_taluka_order_details( id, dispatch_id_fk, beat_id, taluka_order_id, bilty_flag)  VALUES                                   (null,       ?,          ?,           ?,             0    ) ";
    
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, dispatchTalukaOrder.getDispatchID().intValue());
      ps.setInt(2, dispatchTalukaOrder.getBeatID().intValue());
      ps.setInt(3, dispatchTalukaOrder.getTalukaOrderID().intValue());
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
  
  public DispatchTalukaOrder getBeatWiseOrderDetails(int beatID, int talukaOrderID) throws SQLException
  {
    String q = " SELECT IFNULL(SUM(tod.mungdaal),0) , IFNULL(SUM(tod.matki),0) , IFNULL(SUM(tod.mung),0) , IFNULL(SUM(tod.masuldaal),0) , IFNULL(SUM(tod.chvli),0) , IFNULL(SUM(tod.tel),0) , IFNULL(SUM(tod.mith),0) , IFNULL(SUM(tod.mirchi),0) , IFNULL(SUM(tod.halad),0) , IFNULL(SUM(tod.jire),0) , IFNULL(SUM(tod.mohari),0) , IFNULL(SUM(tod.tandul),0) , IFNULL(SUM(tod.harbara),0) , IFNULL(SUM(tod.vatana),0) , IFNULL(SUM(tod.extra1),0), IFNULL(SUM(tod.extra2),0), IFNULL(SUM(tod.extra3),0), IFNULL(SUM(tod.extra4),0), IFNULL(SUM(tod.extra5),0), IFNULL(SUM(tod.extra6),0)  FROM taluka_order_details tod WHERE tod.taluka_order_id = ? AND tod.beat_id = ? ";

    DispatchTalukaOrder detail = new DispatchTalukaOrder();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(q);
      ps.setInt(1, talukaOrderID);
      ps.setInt(2, beatID);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        detail.setMungdaal(Double.valueOf(resultSet.getDouble(1)));
        detail.setMatki(Double.valueOf(resultSet.getDouble(2)));
        detail.setMung(Double.valueOf(resultSet.getDouble(3)));
        detail.setMasuldaal(Double.valueOf(resultSet.getDouble(4)));
        detail.setChvli(Double.valueOf(resultSet.getDouble(5)));
        detail.setTel(Double.valueOf(resultSet.getDouble(6)));
        detail.setMith(Double.valueOf(resultSet.getDouble(7)));
        detail.setMirchi(Double.valueOf(resultSet.getDouble(8)));
        detail.setHalad(Double.valueOf(resultSet.getDouble(9)));
        detail.setJire(Double.valueOf(resultSet.getDouble(10)));
        detail.setMohari(Double.valueOf(resultSet.getDouble(11)));
        detail.setTandul(Double.valueOf(resultSet.getDouble(12)));
        
        detail.setHarbara(Double.valueOf(resultSet.getDouble(13)));
        detail.setVatana(Double.valueOf(resultSet.getDouble(14)));
        detail.setExtra1(Double.valueOf(resultSet.getDouble(15)));
        detail.setExtra2(Double.valueOf(resultSet.getDouble(16)));
        detail.setExtra3(Double.valueOf(resultSet.getDouble(17)));
        detail.setExtra4(Double.valueOf(resultSet.getDouble(18)));
        detail.setExtra5(Double.valueOf(resultSet.getDouble(19)));
        detail.setExtra6(Double.valueOf(resultSet.getDouble(20)));
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
    return detail;
  }
  
  public DispatchTalukaOrder getBeatWiseDispatchDetails(int beatID, int DispatchID, int biltyFlag, int talukaOrderID) throws SQLException
  {
    String q = " SELECT IFNULL(SUM(dtod.mungdaal),0) , IFNULL(SUM(dtod.matki),0) , IFNULL(SUM(dtod.mung),0) , IFNULL(SUM(dtod.masuldaal),0) , IFNULL(SUM(dtod.chvli),0) , IFNULL(SUM(dtod.tel),0) , IFNULL(SUM(dtod.mith),0) , IFNULL(SUM(dtod.mirchi),0) , IFNULL(SUM(dtod.halad),0) , IFNULL(SUM(dtod.jire),0) , IFNULL(SUM(dtod.mohari),0) , IFNULL(SUM(dtod.tandul),0) , IFNULL(SUM(dtod.harbara),0) , IFNULL(SUM(dtod.vatana),0) , IFNULL(SUM(dtod.extra1),0), IFNULL(SUM(dtod.extra2),0), IFNULL(SUM(dtod.extra3),0), IFNULL(SUM(dtod.extra4),0), IFNULL(SUM(dtod.extra5),0), IFNULL(SUM(dtod.extra6),0)  FROM dispatch_taluka_order_details dtod WHERE dtod.dispatch_id_fk = ? AND dtod.beat_id = ? AND dtod.bilty_flag = ? AND dtod.taluka_order_id = ? ";

    DispatchTalukaOrder detail = new DispatchTalukaOrder();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(q);
      ps.setInt(1, DispatchID);
      ps.setInt(2, beatID);
      ps.setInt(3, biltyFlag);
      ps.setInt(4, talukaOrderID);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        detail.setMungdaal(Double.valueOf(resultSet.getDouble(1)));
        detail.setMatki(Double.valueOf(resultSet.getDouble(2)));
        detail.setMung(Double.valueOf(resultSet.getDouble(3)));
        detail.setMasuldaal(Double.valueOf(resultSet.getDouble(4)));
        detail.setChvli(Double.valueOf(resultSet.getDouble(5)));
        detail.setTel(Double.valueOf(resultSet.getDouble(6)));
        detail.setMith(Double.valueOf(resultSet.getDouble(7)));
        detail.setMirchi(Double.valueOf(resultSet.getDouble(8)));
        detail.setHalad(Double.valueOf(resultSet.getDouble(9)));
        detail.setJire(Double.valueOf(resultSet.getDouble(10)));
        detail.setMohari(Double.valueOf(resultSet.getDouble(11)));
        detail.setTandul(Double.valueOf(resultSet.getDouble(12)));
        
        detail.setHarbara(Double.valueOf(resultSet.getDouble(13)));
        detail.setVatana(Double.valueOf(resultSet.getDouble(14)));
        detail.setExtra1(Double.valueOf(resultSet.getDouble(15)));
        detail.setExtra2(Double.valueOf(resultSet.getDouble(16)));
        detail.setExtra3(Double.valueOf(resultSet.getDouble(17)));
        detail.setExtra4(Double.valueOf(resultSet.getDouble(18)));
        detail.setExtra5(Double.valueOf(resultSet.getDouble(19)));
        detail.setExtra6(Double.valueOf(resultSet.getDouble(20)));
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
    return detail;
  }
  
  public DispatchTalukaOrder getItemCurrentStock(int dispatchID, int dispatchDetailID) throws SQLException
  {
    DispatchTalukaOrder detail = new DispatchTalukaOrder();
    Stock s = new StockDS().getCurrentStock();
    
    String select = " SELECT IFNULL(SUM(mungdaal),0) , IFNULL(SUM(matki),0) , IFNULL(SUM(mung),0) , IFNULL(SUM(masuldaal),0) , IFNULL(SUM(chvli),0) , IFNULL(SUM(tel),0) , IFNULL(SUM(mith),0) , IFNULL(SUM(mirchi),0) , IFNULL(SUM(halad),0) , IFNULL(SUM(jire),0) , IFNULL(SUM(mohari),0) , IFNULL(SUM(tandul),0) , IFNULL(SUM(harbara),0) , IFNULL(SUM(vatana),0) , IFNULL(SUM(extra1),0), IFNULL(SUM(extra2),0), IFNULL(SUM(extra3),0), IFNULL(SUM(extra4),0), IFNULL(SUM(extra5),0), IFNULL(SUM(extra6),0) FROM dispatch_taluka_order_details WHERE dispatch_id_fk = ? AND id <> ? ";
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(select);
      ps.setInt(1, dispatchID);
      ps.setInt(2, dispatchDetailID);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        detail.setMungdaal(Double.valueOf(s.getMungdaal().doubleValue() - resultSet.getDouble(1)));
        detail.setMatki(Double.valueOf(s.getMatki().doubleValue() - resultSet.getDouble(2)));
        detail.setMung(Double.valueOf(s.getMung().doubleValue() - resultSet.getDouble(3)));
        detail.setMasuldaal(Double.valueOf(s.getMasuldaal().doubleValue() - resultSet.getDouble(4)));
        detail.setChvli(Double.valueOf(s.getChvli().doubleValue() - resultSet.getDouble(5)));
        detail.setTel(Double.valueOf(s.getTel().doubleValue() - resultSet.getDouble(6)));
        detail.setMith(Double.valueOf(s.getMith().doubleValue() - resultSet.getDouble(7)));
        detail.setMirchi(Double.valueOf(s.getMirchi().doubleValue() - resultSet.getDouble(8)));
        detail.setHalad(Double.valueOf(s.getHalad().doubleValue() - resultSet.getDouble(9)));
        detail.setJire(Double.valueOf(s.getJire().doubleValue() - resultSet.getDouble(10)));
        detail.setMohari(Double.valueOf(s.getMohari().doubleValue() - resultSet.getDouble(11)));
        detail.setTandul(Double.valueOf(s.getTandul().doubleValue() - resultSet.getDouble(12)));
        
        detail.setHarbara(Double.valueOf(s.getHarbara().doubleValue() - resultSet.getDouble(13)));
        detail.setVatana(Double.valueOf(s.getVatana().doubleValue() - resultSet.getDouble(14)));
        detail.setExtra1(Double.valueOf(s.getExtra1().doubleValue() - resultSet.getDouble(15)));
        detail.setExtra2(Double.valueOf(s.getExtra2().doubleValue() - resultSet.getDouble(16)));
        detail.setExtra3(Double.valueOf(s.getExtra3().doubleValue() - resultSet.getDouble(17)));
        detail.setExtra4(Double.valueOf(s.getExtra4().doubleValue() - resultSet.getDouble(18)));
        detail.setExtra5(Double.valueOf(s.getExtra5().doubleValue() - resultSet.getDouble(19)));
        detail.setExtra6(Double.valueOf(s.getExtra6().doubleValue() - resultSet.getDouble(20)));
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
    
    return detail;
  }
  
  public List<DispatchTalukaOrder> getDispatchesDetails(int beatID, int biltyFlag, int dispatchDetailsID, int talukaOrderID, int dispatchID)
    throws SQLException
  {
    String q = " SELECT item_id, item_name_marathi FROM item_master ";
    DispatchTalukaOrder detail = null;
    List<DispatchTalukaOrder> detailList1 = null;
    DispatchTalukaOrder order = getBeatWiseOrderDetails(beatID, talukaOrderID);
    DispatchTalukaOrder privDispatch = getBeatWiseDispatchDetails(beatID, dispatchID, 1, talukaOrderID);
    DispatchTalukaOrder todayDispatch = getBeatWiseDispatchDetails(beatID, dispatchID, 0, talukaOrderID);
    DispatchTalukaOrder currentStock = getItemCurrentStock(dispatchID, dispatchDetailsID);
    List<DispatchTalukaOrder> detailList = new ArrayList();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(q);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        detail = new DispatchTalukaOrder();
        detail.setItemID(Integer.valueOf(resultSet.getInt(1)));
        detail.setItemMarathi(resultSet.getString(2));
        detail.setDispatchDetailsID(Integer.valueOf(dispatchDetailsID));
        detail.setTalukaOrderID(Integer.valueOf(talukaOrderID));
        if (detail.getItemID().intValue() == 1)
        {
          detail.setTotalLoad(order.getMungdaal());
          detail.setTotalPreviousDispatch(privDispatch.getMungdaal());
          detail.setDispatchLoading(todayDispatch.getMungdaal());
          detail.setTotalLoadPending(Double.valueOf(order.getMungdaal().doubleValue() - privDispatch.getMungdaal().doubleValue()));
          detail.setCurrentStock(currentStock.getMungdaal());
        }
        if (detail.getItemID().intValue() == 2)
        {
          detail.setTotalLoad(order.getMatki());
          detail.setTotalPreviousDispatch(privDispatch.getMatki());
          detail.setDispatchLoading(todayDispatch.getMatki());
          detail.setTotalLoadPending(Double.valueOf(order.getMatki().doubleValue() - privDispatch.getMatki().doubleValue()));
          detail.setCurrentStock(currentStock.getMatki());
        }
        if (detail.getItemID().intValue() == 3)
        {
          detail.setTotalLoad(order.getMung());
          detail.setTotalPreviousDispatch(privDispatch.getMung());
          detail.setDispatchLoading(todayDispatch.getMung());
          detail.setTotalLoadPending(Double.valueOf(order.getMung().doubleValue() - privDispatch.getMung().doubleValue()));
          detail.setCurrentStock(currentStock.getMung());
        }
        if (detail.getItemID().intValue() == 4)
        {
          detail.setTotalLoad(order.getMasuldaal());
          detail.setTotalPreviousDispatch(privDispatch.getMasuldaal());
          detail.setDispatchLoading(todayDispatch.getMasuldaal());
          detail.setTotalLoadPending(Double.valueOf(order.getMasuldaal().doubleValue() - privDispatch.getMasuldaal().doubleValue()));
          detail.setCurrentStock(currentStock.getMasuldaal());
        }
        if (detail.getItemID().intValue() == 5)
        {
          detail.setTotalLoad(order.getChvli());
          detail.setTotalPreviousDispatch(privDispatch.getChvli());
          detail.setDispatchLoading(todayDispatch.getChvli());
          detail.setTotalLoadPending(Double.valueOf(order.getChvli().doubleValue() - privDispatch.getChvli().doubleValue()));
          detail.setCurrentStock(currentStock.getChvli());
        }
        if (detail.getItemID().intValue() == 6)
        {
          detail.setTotalLoad(order.getTel());
          detail.setTotalPreviousDispatch(privDispatch.getTel());
          detail.setDispatchLoading(todayDispatch.getTel());
          detail.setTotalLoadPending(Double.valueOf(order.getTel().doubleValue() - privDispatch.getTel().doubleValue()));
          detail.setCurrentStock(currentStock.getTel());
        }
        if (detail.getItemID().intValue() == 7)
        {
          detail.setTotalLoad(order.getMith());
          detail.setTotalPreviousDispatch(privDispatch.getMith());
          detail.setDispatchLoading(todayDispatch.getMith());
          detail.setTotalLoadPending(Double.valueOf(order.getMith().doubleValue() - privDispatch.getMith().doubleValue()));
          detail.setCurrentStock(currentStock.getMith());
        }
        if (detail.getItemID().intValue() == 8)
        {
          detail.setTotalLoad(order.getMirchi());
          detail.setTotalPreviousDispatch(privDispatch.getMirchi());
          detail.setDispatchLoading(todayDispatch.getMirchi());
          detail.setTotalLoadPending(Double.valueOf(order.getMirchi().doubleValue() - privDispatch.getMirchi().doubleValue()));
          detail.setCurrentStock(currentStock.getMirchi());
        }
        if (detail.getItemID().intValue() == 9)
        {
          detail.setTotalLoad(order.getHalad());
          detail.setTotalPreviousDispatch(privDispatch.getHalad());
          detail.setDispatchLoading(todayDispatch.getHalad());
          detail.setTotalLoadPending(Double.valueOf(order.getHalad().doubleValue() - privDispatch.getHalad().doubleValue()));
          detail.setCurrentStock(currentStock.getHalad());
        }
        if (detail.getItemID().intValue() == 10)
        {
          detail.setTotalLoad(order.getJire());
          detail.setTotalPreviousDispatch(privDispatch.getJire());
          detail.setDispatchLoading(todayDispatch.getJire());
          detail.setTotalLoadPending(Double.valueOf(order.getJire().doubleValue() - privDispatch.getJire().doubleValue()));
          detail.setCurrentStock(currentStock.getJire());
        }
        if (detail.getItemID().intValue() == 11)
        {
          detail.setTotalLoad(order.getMohari());
          detail.setTotalPreviousDispatch(privDispatch.getMohari());
          detail.setDispatchLoading(todayDispatch.getMohari());
          detail.setTotalLoadPending(Double.valueOf(order.getMohari().doubleValue() - privDispatch.getMohari().doubleValue()));
          detail.setCurrentStock(currentStock.getMohari());
        }
        if (detail.getItemID().intValue() == 12)
        {
          detail.setTotalLoad(order.getTandul());
          detail.setTotalPreviousDispatch(privDispatch.getTandul());
          detail.setDispatchLoading(todayDispatch.getTandul());
          detail.setTotalLoadPending(Double.valueOf(order.getTandul().doubleValue() - privDispatch.getTandul().doubleValue()));
          detail.setCurrentStock(currentStock.getTandul());
        }
        if (detail.getItemID().intValue() == 13)
        {
          detail.setTotalLoad(order.getHarbara());
          detail.setTotalPreviousDispatch(privDispatch.getHarbara());
          detail.setDispatchLoading(todayDispatch.getHarbara());
          detail.setTotalLoadPending(Double.valueOf(order.getHarbara().doubleValue() - privDispatch.getHarbara().doubleValue()));
          detail.setCurrentStock(currentStock.getHarbara());
        }
        if (detail.getItemID().intValue() == 14)
        {
          detail.setTotalLoad(order.getVatana());
          detail.setTotalPreviousDispatch(privDispatch.getVatana());
          detail.setDispatchLoading(todayDispatch.getVatana());
          detail.setTotalLoadPending(Double.valueOf(order.getVatana().doubleValue() - privDispatch.getVatana().doubleValue()));
          detail.setCurrentStock(currentStock.getVatana());
        }
         if (detail.getItemID().intValue() == 15)
         {
           detail.setTotalLoad(order.getExtra1());
           detail.setTotalPreviousDispatch(privDispatch.getExtra1());
           detail.setDispatchLoading(todayDispatch.getExtra1());
           detail.setTotalLoadPending(Double.valueOf(order.getExtra1().doubleValue() - privDispatch.getExtra1().doubleValue()));
           detail.setCurrentStock(currentStock.getExtra1());
         }
         if (detail.getItemID().intValue() == 16)
         {
           detail.setTotalLoad(order.getExtra2());
           detail.setTotalPreviousDispatch(privDispatch.getExtra2());
           detail.setDispatchLoading(todayDispatch.getExtra2());
           detail.setTotalLoadPending(Double.valueOf(order.getExtra2().doubleValue() - privDispatch.getExtra2().doubleValue()));
           detail.setCurrentStock(currentStock.getExtra2());
         }
         if (detail.getItemID().intValue() == 17)
         {
           detail.setTotalLoad(order.getExtra3());
           detail.setTotalPreviousDispatch(privDispatch.getExtra3());
           detail.setDispatchLoading(todayDispatch.getExtra3());
           detail.setTotalLoadPending(Double.valueOf(order.getExtra3().doubleValue() - privDispatch.getExtra3().doubleValue()));
           detail.setCurrentStock(currentStock.getExtra3());
         }
         if (detail.getItemID().intValue() == 18)
         {
           detail.setTotalLoad(order.getExtra4());
           detail.setTotalPreviousDispatch(privDispatch.getExtra4());
           detail.setDispatchLoading(todayDispatch.getExtra4());
           detail.setTotalLoadPending(Double.valueOf(order.getExtra4().doubleValue() - privDispatch.getExtra4().doubleValue()));
           detail.setCurrentStock(currentStock.getExtra4());
         }
         if (detail.getItemID().intValue() == 19)
         {
           detail.setTotalLoad(order.getExtra5());
           detail.setTotalPreviousDispatch(privDispatch.getExtra5());
           detail.setDispatchLoading(todayDispatch.getExtra5());
           detail.setTotalLoadPending(Double.valueOf(order.getExtra5().doubleValue() - privDispatch.getExtra5().doubleValue()));
           detail.setCurrentStock(currentStock.getExtra5());
         }
         if (detail.getItemID().intValue() == 20)
         {
           detail.setTotalLoad(order.getExtra6());
           detail.setTotalPreviousDispatch(privDispatch.getExtra6());
           detail.setDispatchLoading(todayDispatch.getExtra6());
           detail.setTotalLoadPending(Double.valueOf(order.getExtra6().doubleValue() - privDispatch.getExtra6().doubleValue()));
           detail.setCurrentStock(currentStock.getExtra6());
         }
         detailList.add(detail);
      }
      detailList1 = new ArrayList();
      
      if (order.getTandul().doubleValue() != 0.0D)
      {
        detailList1.add((DispatchTalukaOrder)detailList.get(11));
      }
      else
      {
        detailList1 = detailList;
        detailList1.remove(detailList.get(11));
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
    return detailList1;
  }
  
  public int updateOrderDetails(DispatchTalukaOrder dto)
    throws SQLException
  {
    String sql = " UPDATE dispatch_taluka_order_details  SET mungdaal = ?, matki = ?, mung = ?, masuldaal = ?, chvli = ?, tel = ?, mith = ?, mirchi = ?, halad = ?, jire = ?, mohari = ?, tandul = ?, harbara = ?, vatana = ?, extra1 = ?, extra2 = ?, extra3 = ?, extra4 = ?, extra5 = ?, extra6 = ?  WHERE id = ? AND taluka_order_id = ? ";

    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setDouble(1, dto.getMungdaal().doubleValue());
      ps.setDouble(2, dto.getMatki().doubleValue());
      ps.setDouble(3, dto.getMung().doubleValue());
      ps.setDouble(4, dto.getMasuldaal().doubleValue());
      ps.setDouble(5, dto.getChvli().doubleValue());
      ps.setDouble(6, dto.getTel().doubleValue());
      ps.setDouble(7, dto.getMith().doubleValue());
      ps.setDouble(8, dto.getMirchi().doubleValue());
      ps.setDouble(9, dto.getHalad().doubleValue());
      ps.setDouble(10, dto.getJire().doubleValue());
      ps.setDouble(11, dto.getMohari().doubleValue());
      ps.setDouble(12, dto.getTandul().doubleValue());
      
      ps.setDouble(13, dto.getHarbara().doubleValue());
      ps.setDouble(14, dto.getVatana().doubleValue());
      ps.setDouble(15, dto.getExtra1().doubleValue());
      ps.setDouble(16, dto.getExtra2().doubleValue());
      ps.setDouble(17, dto.getExtra3().doubleValue());
      ps.setDouble(18, dto.getExtra4().doubleValue());
      ps.setDouble(19, dto.getExtra5().doubleValue());
      ps.setDouble(20, dto.getExtra6().doubleValue());

      ps.setInt(21, dto.getDispatchDetailsID().intValue());
      ps.setInt(22, dto.getTalukaOrderID().intValue());
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
  
  public int createBilty(int dispatchID) throws SQLException
  {
    String sql = " UPDATE dispatch SET bilty_no = ? WHERE dispatch_id = ? ";
    String sql1 = " UPDATE dispatch_taluka_order_details SET bilty_flag = 1 WHERE dispatch_id_fk = ? ";
    
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setDouble(1, dispatchID);
      ps.setDouble(2, dispatchID);
      key = ps.executeUpdate();
      if (key != 0)
      {
        ps = con.prepareStatement(sql1);
        ps.setDouble(1, dispatchID);
        key = ps.executeUpdate();
      }
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
  
  public List<DispatchTalukaOrder> getAllDispatcheDetailsByDistrictOrderID(int districtOrderID) throws SQLException
  {
    DispatchTalukaOrder dispatch = null;
    List<DispatchTalukaOrder> dispatchList = new ArrayList();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(ddsq.select3);
      ps.setInt(1, districtOrderID);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          dispatch = new DispatchTalukaOrder();
          dispatch.setDispatchID(Integer.valueOf(resultSet.getInt(1)));
          dispatch.setBiltyNo(Integer.valueOf(resultSet.getInt(2)));
          dispatch.setBiltyDate(resultSet.getString(3));
          dispatch.setAgentName(resultSet.getString(4));
          dispatch.setVehicleNumber(resultSet.getString(5));
          dispatch.setOrderType(Integer.valueOf(resultSet.getInt(6)));
          dispatch.setMungdaal(Double.valueOf(resultSet.getDouble(7)));
          dispatch.setMatki(Double.valueOf(resultSet.getDouble(8)));
          dispatch.setMung(Double.valueOf(resultSet.getDouble(9)));
          dispatch.setMasuldaal(Double.valueOf(resultSet.getDouble(10)));
          dispatch.setChvli(Double.valueOf(resultSet.getDouble(11)));
          dispatch.setTel(Double.valueOf(resultSet.getDouble(12)));
          dispatch.setMith(Double.valueOf(resultSet.getDouble(13)));
          dispatch.setMirchi(Double.valueOf(resultSet.getDouble(14)));
          dispatch.setHalad(Double.valueOf(resultSet.getDouble(15)));
          dispatch.setJire(Double.valueOf(resultSet.getDouble(16)));
          dispatch.setMohari(Double.valueOf(resultSet.getDouble(17)));
          dispatch.setTandul(Double.valueOf(resultSet.getDouble(18)));
          
          dispatch.setHarbara(Double.valueOf(resultSet.getDouble(19)));
          dispatch.setVatana(Double.valueOf(resultSet.getDouble(20)));
          dispatch.setExtra1(Double.valueOf(resultSet.getDouble(21)));
          dispatch.setExtra2(Double.valueOf(resultSet.getDouble(22)));
          dispatch.setExtra3(Double.valueOf(resultSet.getDouble(23)));
          dispatch.setExtra4(Double.valueOf(resultSet.getDouble(24)));
          dispatch.setExtra5(Double.valueOf(resultSet.getDouble(25)));
          dispatch.setExtra6(Double.valueOf(resultSet.getDouble(26)));

          dispatchList.add(dispatch);
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
    return dispatchList;
  }
  
  public List<SectionWiseItemSum> getTalukaWiseDispatcheDetailsByDistrictOrderID(int districtOrderID) throws SQLException
  {
    SectionWiseItemSum dispatch = null;
    List<SectionWiseItemSum> dispatchList = new ArrayList();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(ddsq.select4);
      ps.setInt(1, districtOrderID);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          dispatch = new SectionWiseItemSum();
          dispatch.setTalukaID(resultSet.getInt(1));
          dispatch.setTalukaMarathi(resultSet.getString(2));
          dispatch.setTalukaOrderId(resultSet.getInt(3));
          dispatch.setMungdaal(resultSet.getDouble(4));
          dispatch.setMatki(resultSet.getDouble(5));
          dispatch.setMung(resultSet.getDouble(6));
          dispatch.setMasuldaal(resultSet.getDouble(7));
          dispatch.setChvli(resultSet.getDouble(8));
          dispatch.setTel(resultSet.getDouble(9));
          dispatch.setMith(resultSet.getDouble(10));
          dispatch.setMirchi(resultSet.getDouble(11));
          dispatch.setHalad(resultSet.getDouble(12));
          dispatch.setJire(resultSet.getDouble(13));
          dispatch.setMohari(resultSet.getDouble(14));
          dispatch.setTandul(resultSet.getDouble(15));
          
          dispatch.setHarbara(resultSet.getDouble(16));
          dispatch.setVatana(resultSet.getDouble(17));
          dispatch.setExtra1(resultSet.getDouble(18));
          dispatch.setExtra2(resultSet.getDouble(19));
          dispatch.setExtra3(resultSet.getDouble(20));
          dispatch.setExtra4(resultSet.getDouble(21));
          dispatch.setExtra5(resultSet.getDouble(22));
          dispatch.setExtra6(resultSet.getDouble(23));

          
          dispatchList.add(dispatch);
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
    return dispatchList;
  }
  
  public List<SectionWiseItemSum> getTalukaWiseDispatcheRemaining(int districtOrderID) throws SQLException
  {
    List<SectionWiseItemSum> order = new DistrictOrderDS().getTalukaWiseOrderDetailsByDistrictOrderID(districtOrderID);
    List<SectionWiseItemSum> dispatch = getTalukaWiseDispatcheDetailsByDistrictOrderID(districtOrderID);
    List<SectionWiseItemSum> rList = new ArrayList();
    for (SectionWiseItemSum s : order)
    {
      for (SectionWiseItemSum s1 : dispatch)
      {
        if (s1.getTalukaID() == s.getTalukaID())
        {
          s.setMungdaal(s1.getMungdaal());
          s.setMatki(s1.getMatki());
          s.setMung(s1.getMung());
          s.setMasuldaal(s1.getMasuldaal());
          s.setChvli(s1.getChvli());
          s.setTel(s1.getTel());
          s.setMith(s1.getMith());
          s.setMirchi(s1.getMirchi());
          s.setHalad(s1.getHalad());
          s.setJire(s1.getJire());
          s.setMohari(s1.getMohari());
          s.setTandul(s1.getTandul());
          
           s.setHarbara(s1.getHarbara());
           s.setVatana(s1.getVatana());
           s.setExtra1(s1.getExtra1());
           s.setExtra2(s1.getExtra2());
           s.setExtra3(s1.getExtra3());
           s.setExtra4(s1.getExtra4());
           s.setExtra5(s1.getExtra5());
           s.setExtra6(s1.getExtra6());
        }
      }
      rList.add(s);
    }
    return rList;
  }
  
  public List<Dispatch> getAllDispatchesBetweenDate(String startDate, String endDate)
    throws SQLException
  {
    Dispatch dispatch = null;
    List<Dispatch> dispatchList = new ArrayList();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(ddsq.select5);
      ps.setString(1, startDate);
      ps.setString(2, endDate);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          dispatch = new Dispatch();
          dispatch.setDispatchID(Integer.valueOf(resultSet.getInt(1)));
          dispatch.setBiltyNo(Integer.valueOf(resultSet.getInt(2)));
          dispatch.setCreatedOn(resultSet.getString(3));
          dispatch.setTruckCapacity(resultSet.getDouble(4));
          dispatch.setFreightPerTonInRupees(resultSet.getDouble(5));
          dispatch.setAdvanceFrieght(resultSet.getDouble(6));
          dispatch.setDriverName(resultSet.getString(7));
          dispatch.setDistrictID(Integer.valueOf(resultSet.getInt(8)));
          dispatch.setDistrictMarathi(resultSet.getString(9));
          dispatch.setTalukaID(Integer.valueOf(resultSet.getInt(10)));
          dispatch.setTalukaMarathi(resultSet.getString(11));
          dispatch.setAgentName(resultSet.getString(12));
          dispatch.setBiltyDate(resultSet.getString(13));
          dispatch.setDraftBiltyNo(Integer.valueOf(resultSet.getInt(14)));
          dispatch.setDriverLicense(resultSet.getString(15));
          dispatch.setVehicleNo(resultSet.getString(16));
          dispatch.setActualLoading(resultSet.getDouble(17));
          dispatchList.add(dispatch);
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
    return dispatchList;
  }
}
