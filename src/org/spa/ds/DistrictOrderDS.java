package org.spa.ds;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.spa.connect.dbConnection;
import org.spa.entity.DistrictOrder;
import org.spa.entity.SectionWiseItemSum;
import org.spa.query.DistrictOrderDSQuery;

public class DistrictOrderDS
{
  dbConnection dbCon;
  Connection con;
  PreparedStatement ps = null;
  ResultSet resultSet = null;
  DistrictOrderDSQuery DODSQ = new DistrictOrderDSQuery();
  
  public DistrictOrderDS() {}
  
  public ArrayList<DistrictOrder> getAllDistrictOrder(String fromDate, String toDate, int start, int limit) throws SQLException {
    ArrayList arr_dOrders = new ArrayList();
    DistrictOrder dOrders = null;
    
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(DODSQ.s1);
      ps.setString(1, fromDate);
      ps.setString(2, toDate);
      ps.setInt(3, start);
      ps.setInt(4, limit);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        dOrders = new DistrictOrder();
        dOrders.setOrderID(resultSet.getInt(1));
        dOrders.setDistrictName(resultSet.getString(2));
        dOrders.setDistrictGovOrderID(resultSet.getString(3));
        dOrders.setOrderNoDate(resultSet.getString(4));
        dOrders.setOrderNumber(resultSet.getString(5));
        dOrders.setCreationDate(resultSet.getString(6));
        dOrders.setDistrictID(resultSet.getInt(7));
        dOrders.setStdType(resultSet.getInt(8));
        if (dOrders.getStdType() == 1)
        {
          dOrders.setStdTypeDetails("STD 1 TO 5");
        }
        else
        {
          dOrders.setStdTypeDetails("STD 6 TO 8");
        }
        arr_dOrders.add(dOrders);
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
    return arr_dOrders;
  }
  
  public int addDistrictOrder(DistrictOrder dOrder)
    throws SQLException
  {
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    int key = 0;
    try
    {
      ps = con.prepareStatement(DODSQ.i1);
      ps.setInt(1, dOrder.getDistrictID());
      ps.setString(2, dOrder.getOrderNumber());
      ps.setString(3, dOrder.getDistrictGovOrderID());
      ps.setString(4, dOrder.getOrderNoDate());
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
  
  public int updateDistrictOrder(DistrictOrder dOrder)
    throws SQLException
  {
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    int key = 0;
    try
    {
      ps = con.prepareStatement(DODSQ.u1);
      ps.setString(1, dOrder.getOrderNoDate());
      ps.setString(2, dOrder.getOrderNumber());
      ps.setString(3, dOrder.getDistrictGovOrderID());
      ps.setInt(4, dOrder.getOrderID());
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
  
  public int deleteDistrictOrder(DistrictOrder dOrder)
    throws SQLException
  {
    int key = 0;
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(DODSQ.u2);
      ps.setInt(1, dOrder.getOrderID());
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
  
  public DistrictOrder getDistrictOrderDetails(int districtOrderID)
    throws SQLException
  {
    DistrictOrder dOrders = null;
    
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(DODSQ.s2);
      ps.setInt(1, districtOrderID);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        dOrders = new DistrictOrder();
        dOrders.setOrderID(resultSet.getInt(1));
        dOrders.setDistrictName(resultSet.getString(2));
        dOrders.setDistrictGovOrderID(resultSet.getString(3));
        dOrders.setOrderNoDate(resultSet.getString(4));
        dOrders.setOrderNumber(resultSet.getString(5));
        dOrders.setCreationDate(resultSet.getString(6));
        dOrders.setDistrictID(resultSet.getInt(7));
        dOrders.setStdType(resultSet.getInt(8));
        if (dOrders.getStdType() == 1)
        {
          dOrders.setStdTypeDetails("STD 1 TO 5");
        }
        else
        {
          dOrders.setStdTypeDetails("STD 6 TO 8");
        }
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
    return dOrders;
  }
  
  public List<DistrictOrder> getDistrictOrderList(int districtID)
    throws SQLException
  {
    String sql = "  SELECT `district_order_id`,order_number,  CONCAT('Order No :',CAST(order_number AS CHAR),' ','-','Order Date','(',`district_order_date`,')') AS orderList   FROM district_order WHERE deleted <> 1 AND district_id = ?";
    
    DistrictOrder order = null;
    List list = new ArrayList();
    
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, districtID);
      resultSet = ps.executeQuery();
      if (resultSet != null) {
        while (resultSet.next()) {
          order = new DistrictOrder();
          order.setOrderID(resultSet.getInt(1));
          order.setOrderNumber(resultSet.getString(2));
          order.setOrderNoDate(resultSet.getString(3));
          list.add(order);
        }
      }
    } catch (Exception e) {
      throw new RuntimeException(e);
    } finally {
      resultSet.close();
      ps.close();
    }
    return list;
  }
  
  public List<DistrictOrder> getDistrictOrderListBysTypeAndOrderType(int sType, int orderType, String fromDate, String toDate)
    throws SQLException
  {
    String sql = " SELECT dor.district_order_id,tor.order_type,CONCAT('Order No :',CAST(dor.order_number AS CHAR),' ','-','Order Date','(',dor.`district_order_date`,')-') AS orderList FROM district_order dor  LEFT JOIN taluka_order tor ON dor.district_order_id = tor.district_order_id AND tor.deleted <> 1 INNER JOIN district_master dm ON dm.district_id = dor.district_id  WHERE tor.order_type = ? AND dm.std_type = ? AND STR_TO_DATE(dor.district_order_date,'%d/%m/%Y') BETWEEN STR_TO_DATE(?,'%d/%m/%Y') AND STR_TO_DATE(?,'%d/%m/%Y')  AND (dor.district_order_id NOT IN (SELECT district_order_id_1to5 FROM district_sales_invoice) AND dor.district_order_id NOT IN (SELECT district_order_id_6to8 FROM district_sales_invoice) )  GROUP BY dor.district_order_id ";
    
    DistrictOrder order = null;
    List list = new ArrayList();
    
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, orderType);
      ps.setInt(2, sType);
      ps.setString(3, fromDate);
      ps.setString(4, toDate);
      resultSet = ps.executeQuery();
      System.out.println("Anita Mad-am :" + ps);
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          order = new DistrictOrder();
          order.setOrderID(resultSet.getInt(1));
          if (resultSet.getInt(2) == 1)
          {
            order.setOrderNumber(resultSet.getString(3) + "Rice");
          }
          else
          {
            order.setOrderNumber(resultSet.getString(3) + "Ration");
          }
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
  
  public List<SectionWiseItemSum> getTalukaWiseOrderDetailsByDistrictOrderID(int districtOrderID) throws SQLException
  {
    SectionWiseItemSum dispatch = null;
    List dispatchList = new ArrayList();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DODSQ.select4);
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
          dispatch.setOmungdaal(resultSet.getDouble(4));
          dispatch.setOmatki(resultSet.getDouble(5));
          dispatch.setOmung(resultSet.getDouble(6));
          dispatch.setOmasuldaal(resultSet.getDouble(7));
          dispatch.setOchvli(resultSet.getDouble(8));
          dispatch.setOtel(resultSet.getDouble(9));
          dispatch.setOmith(resultSet.getDouble(10));
          dispatch.setOmirchi(resultSet.getDouble(11));
          dispatch.setOhalad(resultSet.getDouble(12));
          dispatch.setOjire(resultSet.getDouble(13));
          dispatch.setOmohari(resultSet.getDouble(14));
          dispatch.setOtandul(resultSet.getDouble(15));
          dispatch.setOrderType(resultSet.getInt(16));
          
          dispatch.setOharbara(resultSet.getInt(17));
           dispatch.setOvatana(resultSet.getInt(18));
           dispatch.setOextra1(resultSet.getInt(19));
           dispatch.setOextra2(resultSet.getInt(20));
           dispatch.setOextra3(resultSet.getInt(21));
           dispatch.setOextra4(resultSet.getInt(22));
           dispatch.setOextra5(resultSet.getInt(23));
           dispatch.setOextra6(resultSet.getInt(24));

          dispatch.setMungdaal(0.0D);
          dispatch.setMatki(0.0D);
          dispatch.setMung(0.0D);
          dispatch.setMasuldaal(0.0D);
          dispatch.setChvli(0.0D);
          dispatch.setTel(0.0D);
          dispatch.setMith(0.0D);
          dispatch.setMirchi(0.0D);
          dispatch.setHalad(0.0D);
          dispatch.setJire(0.0D);
          dispatch.setMohari(0.0D);
          dispatch.setTandul(0.0D);
          
           dispatch.setHarbara(0.0D);
           dispatch.setVatana(0.0D);
           dispatch.setExtra1(0.0D);
           dispatch.setExtra2(0.0D);
           dispatch.setExtra3(0.0D);
           dispatch.setExtra4(0.0D);
           dispatch.setExtra5(0.0D);
           dispatch.setExtra6(0.0D);
          
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
  
  public List<SectionWiseItemSum> getAllChallanDetailsBetweenDate(String fromDate, String toDate) throws SQLException
  {
    SectionWiseItemSum dispatch = null;
    List dispatchList = new ArrayList();
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DODSQ.select5);
      ps.setString(1, fromDate);
      ps.setString(2, toDate);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          dispatch = new SectionWiseItemSum();
          dispatch.setTalukaMarathi(resultSet.getString(1));
          dispatch.setSchoolMarathi(resultSet.getString(2));
          dispatch.setChallanNumber(resultSet.getInt(3));
          dispatch.setChallanDate(resultSet.getString(4));
          dispatch.setOrderType(resultSet.getInt(5));
          dispatch.setMungdaal(resultSet.getDouble(6));
          dispatch.setMatki(resultSet.getDouble(7));
          dispatch.setMung(resultSet.getDouble(8));
          dispatch.setMasuldaal(resultSet.getDouble(9));
          dispatch.setChvli(resultSet.getDouble(10));
          dispatch.setTel(resultSet.getDouble(11));
          dispatch.setMith(resultSet.getDouble(12));
          dispatch.setMirchi(resultSet.getDouble(13));
          dispatch.setHalad(resultSet.getDouble(14));
          dispatch.setJire(resultSet.getDouble(15));
          dispatch.setMohari(resultSet.getDouble(16));
          dispatch.setTandul(resultSet.getDouble(17));
          
           dispatch.setHarbara(resultSet.getDouble(18));
           dispatch.setVatana(resultSet.getDouble(19));
           dispatch.setExtra1(resultSet.getDouble(20));
           dispatch.setExtra2(resultSet.getDouble(21));
           dispatch.setExtra3(resultSet.getDouble(22));
           dispatch.setExtra4(resultSet.getDouble(23));
           dispatch.setExtra5(resultSet.getDouble(24));
           dispatch.setExtra6(resultSet.getDouble(25));

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
