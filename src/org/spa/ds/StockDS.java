package org.spa.ds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.spa.connect.dbConnection;
import org.spa.entity.Stock;
import org.spa.query.StockDSQuery;

public class StockDS
{
  dbConnection dbConnection = null;
  Connection con = null;
  int key = 0;
  PreparedStatement ps = null; PreparedStatement ps1 = null;
  ResultSet resultSet = null; ResultSet resultSet1 = null;
  StockDSQuery sdsq = new StockDSQuery();
  
  public StockDS() {}
  
  public ArrayList<Stock> getAllStockDifferance() throws SQLException {
    ArrayList arr_stock = new ArrayList();
    Stock stock = null;
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.select1);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        stock = new Stock();
        stock.setStockDiffID(Integer.valueOf(resultSet.getInt(1)));
        stock.setStockDiffDate(resultSet.getString(2));
        stock.setDiffType(Integer.valueOf(resultSet.getInt(3)));
        if (resultSet.getInt(3) == 1) {
          stock.setDiffTypeDetail("Short");
        } else
          stock.setDiffTypeDetail("Extra");
        stock.setMungdaal(Double.valueOf(resultSet.getDouble(4)));
        stock.setMatki(Double.valueOf(resultSet.getDouble(5)));
        stock.setMung(Double.valueOf(resultSet.getDouble(6)));
        stock.setMasuldaal(Double.valueOf(resultSet.getDouble(7)));
        stock.setChvli(Double.valueOf(resultSet.getDouble(8)));
        stock.setTel(Double.valueOf(resultSet.getDouble(9)));
        stock.setMith(Double.valueOf(resultSet.getDouble(10)));
        stock.setMirchi(Double.valueOf(resultSet.getDouble(11)));
        stock.setHalad(Double.valueOf(resultSet.getDouble(12)));
        stock.setJire(Double.valueOf(resultSet.getDouble(13)));
        stock.setMohari(Double.valueOf(resultSet.getDouble(14)));
        stock.setTandul(Double.valueOf(resultSet.getDouble(15)));
        
        stock.setHarbara(Double.valueOf(resultSet.getDouble(16)));
        stock.setVatana(Double.valueOf(resultSet.getDouble(17)));
        stock.setExtra1(Double.valueOf(resultSet.getDouble(18)));
        stock.setExtra2(Double.valueOf(resultSet.getDouble(19)));
        stock.setExtra3(Double.valueOf(resultSet.getDouble(20)));
        stock.setExtra4(Double.valueOf(resultSet.getDouble(21)));
        stock.setExtra5(Double.valueOf(resultSet.getDouble(22)));
        stock.setExtra6(Double.valueOf(resultSet.getDouble(23)));

        arr_stock.add(stock);
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
    return arr_stock;
  }
  
  public int createStockDifferance(Stock stock)
    throws SQLException
  {
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.insert1);
      ps.setString(1, stock.getStockDiffDate());
      ps.setInt(2, stock.getDiffType().intValue());
      ps.setDouble(3, stock.getMungdaal().doubleValue());
      ps.setDouble(4, stock.getMatki().doubleValue());
      ps.setDouble(5, stock.getMung().doubleValue());
      ps.setDouble(6, stock.getMasuldaal().doubleValue());
      ps.setDouble(7, stock.getChvli().doubleValue());
      ps.setDouble(8, stock.getTel().doubleValue());
      ps.setDouble(9, stock.getMith().doubleValue());
      ps.setDouble(10, stock.getMirchi().doubleValue());
      ps.setDouble(11, stock.getHalad().doubleValue());
      ps.setDouble(12, stock.getJire().doubleValue());
      ps.setDouble(13, stock.getMohari().doubleValue());
      ps.setDouble(14, stock.getTandul().doubleValue());
      
       ps.setDouble(15, stock.getHarbara().doubleValue());
       ps.setDouble(16, stock.getVatana().doubleValue());
       ps.setDouble(17, stock.getExtra1().doubleValue());
       ps.setDouble(18, stock.getExtra2() != null ? stock.getExtra2().doubleValue() : 0);
       ps.setDouble(19, stock.getExtra3() != null ? stock.getExtra3().doubleValue() : 0);
       ps.setDouble(20, stock.getExtra4() != null ? stock.getExtra4().doubleValue() : 0);
       ps.setDouble(21, stock.getExtra5() != null ? stock.getExtra5().doubleValue() : 0);
       ps.setDouble(22, stock.getExtra6() != null ? stock.getExtra6().doubleValue() : 0);

       key = ps.executeUpdate();
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int updateStockDifferance(Stock stock)
    throws SQLException
  {
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.update1);
      ps.setString(1, stock.getStockDiffDate());
      ps.setInt(2, stock.getDiffType().intValue());
      ps.setDouble(3, stock.getMungdaal().doubleValue());
      ps.setDouble(4, stock.getMatki().doubleValue());
      ps.setDouble(5, stock.getMung().doubleValue());
      ps.setDouble(6, stock.getMasuldaal().doubleValue());
      ps.setDouble(7, stock.getChvli().doubleValue());
      ps.setDouble(8, stock.getTel().doubleValue());
      ps.setDouble(9, stock.getMith().doubleValue());
      ps.setDouble(10, stock.getMirchi().doubleValue());
      ps.setDouble(11, stock.getHalad().doubleValue());
      ps.setDouble(12, stock.getJire().doubleValue());
      ps.setDouble(13, stock.getMohari().doubleValue());
      ps.setDouble(14, stock.getTandul().doubleValue());
      
       ps.setDouble(15, stock.getHarbara().doubleValue());
       ps.setDouble(16, stock.getVatana().doubleValue());
       ps.setDouble(17, stock.getExtra1().doubleValue());
       ps.setDouble(18, stock.getExtra2() != null ? stock.getExtra2().doubleValue() : 0);
       ps.setDouble(19, stock.getExtra3() != null ? stock.getExtra3().doubleValue() : 0);
       ps.setDouble(20, stock.getExtra4() != null ? stock.getExtra4().doubleValue() : 0);
       ps.setDouble(21, stock.getExtra5() != null ? stock.getExtra5().doubleValue() : 0);
       ps.setDouble(22, stock.getExtra6() != null ? stock.getExtra6().doubleValue() : 0);

       ps.setInt(23, stock.getStockDiffID().intValue());
      key = ps.executeUpdate();
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int deleteStockDifferance(Stock stock)
    throws SQLException
  {
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.delete1);
      ps.setInt(1, stock.getStockDiffID().intValue());
      key = ps.executeUpdate();
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public Stock getTotalStockDifferance()
    throws SQLException
  {
    Stock stock = null;
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.select2);
      ps.setInt(1, 2);
      resultSet = ps.executeQuery();
      
      ps1 = con.prepareStatement(sdsq.select2);
      ps1.setInt(1, 1);
      resultSet1 = ps1.executeQuery();
      if (resultSet.next())
      {
        if (resultSet1.next())
        {
          stock = new Stock();
          stock.setMungdaal(Double.valueOf(resultSet.getDouble(1) - resultSet1.getDouble(1)));
          stock.setMatki(Double.valueOf(resultSet.getDouble(2) - resultSet1.getDouble(2)));
          stock.setMung(Double.valueOf(resultSet.getDouble(3) - resultSet1.getDouble(3)));
          stock.setMasuldaal(Double.valueOf(resultSet.getDouble(4) - resultSet1.getDouble(4)));
          stock.setChvli(Double.valueOf(resultSet.getDouble(5) - resultSet1.getDouble(5)));
          stock.setTel(Double.valueOf(resultSet.getDouble(6) - resultSet1.getDouble(6)));
          stock.setMith(Double.valueOf(resultSet.getDouble(7) - resultSet1.getDouble(7)));
          stock.setMirchi(Double.valueOf(resultSet.getDouble(8) - resultSet1.getDouble(8)));
          stock.setHalad(Double.valueOf(resultSet.getDouble(9) - resultSet1.getDouble(9)));
          stock.setJire(Double.valueOf(resultSet.getDouble(10) - resultSet1.getDouble(10)));
          stock.setMohari(Double.valueOf(resultSet.getDouble(11) - resultSet1.getDouble(11)));
           stock.setTandul(Double.valueOf(resultSet.getDouble(12) - resultSet1.getDouble(12)));

           stock.setHarbara(Double.valueOf(resultSet.getDouble(13) - resultSet1.getDouble(13)));
           stock.setVatana(Double.valueOf(resultSet.getDouble(14) - resultSet1.getDouble(14)));
           stock.setExtra1(Double.valueOf(resultSet.getDouble(15) - resultSet1.getDouble(15)));
           stock.setExtra2(Double.valueOf(resultSet.getDouble(16) - resultSet1.getDouble(16)));
           stock.setExtra3(Double.valueOf(resultSet.getDouble(17) - resultSet1.getDouble(17)));
           stock.setExtra4(Double.valueOf(resultSet.getDouble(18) - resultSet1.getDouble(18)));
           stock.setExtra5(Double.valueOf(resultSet.getDouble(19) - resultSet1.getDouble(19)));
           stock.setExtra6(Double.valueOf(resultSet.getDouble(20) - resultSet1.getDouble(20)));
         }
      }
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    }
    finally
    {
      resultSet1.close();
      resultSet.close();
      ps.close();
    }
    return stock;
  }
  
  public Stock getReciveItemStock()
    throws SQLException
  {
    Stock stock = new Stock();
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.select3);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        if (resultSet.getInt(1) == 1)
          stock.setMungdaal(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 2)
          stock.setMatki(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 3)
          stock.setMung(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 4)
          stock.setMasuldaal(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 5)
          stock.setChvli(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 6)
          stock.setTel(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 7)
          stock.setMith(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 8)
          stock.setMirchi(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 9)
          stock.setHalad(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 10)
          stock.setJire(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 11)
          stock.setMohari(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 12)
          stock.setTandul(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 13)
          stock.setHarbara(Double.valueOf(resultSet.getDouble(3)));
         if (resultSet.getInt(1) == 14)
           stock.setVatana(Double.valueOf(resultSet.getDouble(3)));
         if (resultSet.getInt(1) == 15)
           stock.setExtra1(Double.valueOf(resultSet.getDouble(3)));
         if (resultSet.getInt(1) == 16)
           stock.setExtra2(Double.valueOf(resultSet.getDouble(3)));
         if (resultSet.getInt(1) == 17)
           stock.setExtra3(Double.valueOf(resultSet.getDouble(3)));
         if (resultSet.getInt(1) == 18)
           stock.setExtra4(Double.valueOf(resultSet.getDouble(3)));
         if (resultSet.getInt(1) == 19)
           stock.setExtra5(Double.valueOf(resultSet.getDouble(3)));
         if (resultSet.getInt(1) == 20)
           stock.setExtra6(Double.valueOf(resultSet.getDouble(3)));
       }
     }
     catch (Exception ex) {
       throw new RuntimeException(ex);
     }
     finally
     {
       resultSet.close();
       ps.close();
     }
     return stock;
   }

  public Stock getItemStockReturnBySchool()
    throws SQLException
  {
    Stock stock = new Stock();
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.select4);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        stock = new Stock();
        stock.setMungdaal(Double.valueOf(resultSet.getDouble(1)));
        stock.setMatki(Double.valueOf(resultSet.getDouble(2)));
        stock.setMung(Double.valueOf(resultSet.getDouble(3)));
        stock.setMasuldaal(Double.valueOf(resultSet.getDouble(4)));
        stock.setChvli(Double.valueOf(resultSet.getDouble(5)));
        stock.setTel(Double.valueOf(resultSet.getDouble(6)));
        stock.setMith(Double.valueOf(resultSet.getDouble(7)));
        stock.setMirchi(Double.valueOf(resultSet.getDouble(8)));
        stock.setHalad(Double.valueOf(resultSet.getDouble(9)));
        stock.setJire(Double.valueOf(resultSet.getDouble(10)));
        stock.setMohari(Double.valueOf(resultSet.getDouble(11)));
        stock.setTandul(Double.valueOf(resultSet.getDouble(12)));
        
        stock.setHarbara(Double.valueOf(resultSet.getDouble(13)));
        stock.setVatana(Double.valueOf(resultSet.getDouble(14)));
        stock.setExtra1(Double.valueOf(resultSet.getDouble(15)));
        stock.setExtra2(Double.valueOf(resultSet.getDouble(16)));
        stock.setExtra3(Double.valueOf(resultSet.getDouble(17)));
        stock.setExtra4(Double.valueOf(resultSet.getDouble(18)));
        stock.setExtra5(Double.valueOf(resultSet.getDouble(19)));
        stock.setExtra6(Double.valueOf(resultSet.getDouble(20)));
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
    return stock;
  }
  
  public Stock getCurrentStock() throws SQLException
  {
    Stock s = getTotalStockDifferance();
    Stock s1 = getReciveItemStock();
    Stock s2 = getItemStockReturnBySchool();
    s.setMungdaal(Double.valueOf(s.getMungdaal().doubleValue() + s1.getMungdaal().doubleValue() + s2.getMungdaal().doubleValue()));
    s.setMatki(Double.valueOf(s.getMatki().doubleValue() + s1.getMatki().doubleValue() + s2.getMatki().doubleValue()));
    s.setMung(Double.valueOf(s.getMung().doubleValue() + s1.getMung().doubleValue() + s2.getMung().doubleValue()));
    s.setMasuldaal(Double.valueOf(s.getMasuldaal().doubleValue() + s1.getMasuldaal().doubleValue() + s2.getMasuldaal().doubleValue()));
    s.setChvli(Double.valueOf(s.getChvli().doubleValue() + s1.getChvli().doubleValue() + s2.getChvli().doubleValue()));
    s.setTel(Double.valueOf(s.getTel().doubleValue() + s1.getTel().doubleValue() + s2.getTel().doubleValue()));
    s.setMith(Double.valueOf(s.getMith().doubleValue() + s1.getMith().doubleValue() + s2.getMith().doubleValue()));
    s.setMirchi(Double.valueOf(s.getMirchi().doubleValue() + s1.getMirchi().doubleValue() + s2.getMirchi().doubleValue()));
    s.setHalad(Double.valueOf(s.getHalad().doubleValue() + s1.getHalad().doubleValue() + s2.getHalad().doubleValue()));
    s.setJire(Double.valueOf(s.getJire().doubleValue() + s1.getJire().doubleValue() + s2.getJire().doubleValue()));
    s.setMohari(Double.valueOf(s.getMohari().doubleValue() + s1.getMohari().doubleValue() + s2.getMohari().doubleValue()));
    s.setTandul(Double.valueOf(s.getTandul().doubleValue() + s1.getTandul().doubleValue() + s2.getTandul().doubleValue()));
    
    s.setHarbara(Double.valueOf(s.getHarbara().doubleValue() + s1.getHarbara().doubleValue() + s2.getHarbara().doubleValue()));
    s.setVatana(Double.valueOf(s.getVatana().doubleValue() + s1.getVatana().doubleValue() + s2.getVatana().doubleValue()));
    s.setExtra1(Double.valueOf(s.getExtra1().doubleValue() + s1.getExtra1().doubleValue() + s2.getExtra1().doubleValue()));
    s.setExtra2(Double.valueOf(s.getExtra2().doubleValue() + s1.getExtra2().doubleValue() + s2.getExtra2().doubleValue()));
    s.setExtra3(Double.valueOf(s.getExtra3().doubleValue() + s1.getExtra3().doubleValue() + s2.getExtra3().doubleValue()));
    s.setExtra4(Double.valueOf(s.getExtra4().doubleValue() + s1.getExtra4().doubleValue() + s2.getExtra4().doubleValue()));
    s.setExtra5(Double.valueOf(s.getExtra5().doubleValue() + s1.getExtra5().doubleValue() + s2.getExtra5().doubleValue()));
    s.setExtra6(Double.valueOf(s.getExtra6().doubleValue() + s1.getExtra6().doubleValue() + s2.getExtra6().doubleValue()));
    return s;
  }
  
  public ArrayList<Stock> getStockDifferanceBetweenDates(String fromDate, String toDate, int diffType)
    throws SQLException
  {
    ArrayList arr_stock = null;
    Stock stock = null;
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      arr_stock = new ArrayList();
      ps = con.prepareStatement(sdsq.select5);
      ps.setString(1, fromDate);
      ps.setString(2, toDate);
      ps.setInt(3, diffType);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        stock = new Stock();
        stock.setStockDiffID(Integer.valueOf(resultSet.getInt(1)));
        stock.setStockDiffDate(resultSet.getString(2));
        stock.setDiffType(Integer.valueOf(resultSet.getInt(3)));
        if (resultSet.getInt(3) == 1) {
          stock.setDiffTypeDetail("Short");
        } else
          stock.setDiffTypeDetail("Extra");
        stock.setMungdaal(Double.valueOf(resultSet.getDouble(4)));
        stock.setMatki(Double.valueOf(resultSet.getDouble(5)));
        stock.setMung(Double.valueOf(resultSet.getDouble(6)));
        stock.setMasuldaal(Double.valueOf(resultSet.getDouble(7)));
        stock.setChvli(Double.valueOf(resultSet.getDouble(8)));
        stock.setTel(Double.valueOf(resultSet.getDouble(9)));
        stock.setMith(Double.valueOf(resultSet.getDouble(10)));
        stock.setMirchi(Double.valueOf(resultSet.getDouble(11)));
        stock.setHalad(Double.valueOf(resultSet.getDouble(12)));
        stock.setJire(Double.valueOf(resultSet.getDouble(13)));
        stock.setMohari(Double.valueOf(resultSet.getDouble(14)));
        stock.setTandul(Double.valueOf(resultSet.getDouble(15)));
        
        stock.setHarbara(Double.valueOf(resultSet.getDouble(16)));
        stock.setVatana(Double.valueOf(resultSet.getDouble(17)));
        stock.setExtra1(Double.valueOf(resultSet.getDouble(18)));
        stock.setExtra2(Double.valueOf(resultSet.getDouble(19)));
        stock.setExtra3(Double.valueOf(resultSet.getDouble(20)));
        stock.setExtra4(Double.valueOf(resultSet.getDouble(21)));
        stock.setExtra5(Double.valueOf(resultSet.getDouble(22)));
        stock.setExtra6(Double.valueOf(resultSet.getDouble(23)));

        arr_stock.add(stock);
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
    return arr_stock;
  }
  
  public Stock getTotalStockDifferanceOnDate(String biltyDate)
    throws SQLException
  {
    Stock stock = null;
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.select6);
      ps.setInt(1, 2);
      ps.setString(2, biltyDate);
      resultSet = ps.executeQuery();
      
      ps1 = con.prepareStatement(sdsq.select6);
      ps1.setInt(1, 1);
      ps1.setString(2, biltyDate);
      resultSet1 = ps1.executeQuery();
      
       resultSet.next();
       resultSet1.next();
       stock = new Stock();
       stock.setMungdaal(Double.valueOf(resultSet.getDouble(1) - resultSet1.getDouble(1)));
       stock.setMatki(Double.valueOf(resultSet.getDouble(2) - resultSet1.getDouble(2)));
       stock.setMung(Double.valueOf(resultSet.getDouble(3) - resultSet1.getDouble(3)));
       stock.setMasuldaal(Double.valueOf(resultSet.getDouble(4) - resultSet1.getDouble(4)));
       stock.setChvli(Double.valueOf(resultSet.getDouble(5) - resultSet1.getDouble(5)));
       stock.setTel(Double.valueOf(resultSet.getDouble(6) - resultSet1.getDouble(6)));
       stock.setMith(Double.valueOf(resultSet.getDouble(7) - resultSet1.getDouble(7)));
       stock.setMirchi(Double.valueOf(resultSet.getDouble(8) - resultSet1.getDouble(8)));
       stock.setHalad(Double.valueOf(resultSet.getDouble(9) - resultSet1.getDouble(9)));
       stock.setJire(Double.valueOf(resultSet.getDouble(10) - resultSet1.getDouble(10)));
       stock.setMohari(Double.valueOf(resultSet.getDouble(11) - resultSet1.getDouble(11)));
       stock.setTandul(Double.valueOf(resultSet.getDouble(12) - resultSet1.getDouble(12)));

       stock.setHarbara(Double.valueOf(resultSet.getDouble(13) - resultSet1.getDouble(13)));
       stock.setVatana(Double.valueOf(resultSet.getDouble(14) - resultSet1.getDouble(14)));
       stock.setExtra1(Double.valueOf(resultSet.getDouble(15) - resultSet1.getDouble(15)));
       stock.setExtra2(Double.valueOf(resultSet.getDouble(16) - resultSet1.getDouble(16)));
       stock.setExtra3(Double.valueOf(resultSet.getDouble(17) - resultSet1.getDouble(17)));
       stock.setExtra4(Double.valueOf(resultSet.getDouble(18) - resultSet1.getDouble(18)));
       stock.setExtra5(Double.valueOf(resultSet.getDouble(19) - resultSet1.getDouble(19)));
       stock.setExtra6(Double.valueOf(resultSet.getDouble(20) - resultSet1.getDouble(20)));
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    }
    finally
    {
      ps1.close();
      ps.close();
      resultSet1.close();
      resultSet.close();
    }
    return stock;
  }
  
  public Stock getItemStockReturnBySchoolOnDate(String returnDate)
    throws SQLException
  {
    Stock stock = new Stock();
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.select7);
      ps.setString(1, returnDate);
      resultSet = ps.executeQuery();
       if (resultSet.next())
       {
         stock = new Stock();
         stock.setMungdaal(Double.valueOf(resultSet.getDouble(1)));
         stock.setMatki(Double.valueOf(resultSet.getDouble(2)));
         stock.setMung(Double.valueOf(resultSet.getDouble(3)));
         stock.setMasuldaal(Double.valueOf(resultSet.getDouble(4)));
         stock.setChvli(Double.valueOf(resultSet.getDouble(5)));
         stock.setTel(Double.valueOf(resultSet.getDouble(6)));
         stock.setMith(Double.valueOf(resultSet.getDouble(7)));
         stock.setMirchi(Double.valueOf(resultSet.getDouble(8)));
         stock.setHalad(Double.valueOf(resultSet.getDouble(9)));
         stock.setJire(Double.valueOf(resultSet.getDouble(10)));
         stock.setMohari(Double.valueOf(resultSet.getDouble(11)));
         stock.setTandul(Double.valueOf(resultSet.getDouble(12)));

         stock.setHarbara(Double.valueOf(resultSet.getDouble(13)));
         stock.setVatana(Double.valueOf(resultSet.getDouble(14)));
         stock.setExtra1(Double.valueOf(resultSet.getDouble(15)));
         stock.setExtra2(Double.valueOf(resultSet.getDouble(16)));
         stock.setExtra3(Double.valueOf(resultSet.getDouble(17)));
         stock.setExtra4(Double.valueOf(resultSet.getDouble(18)));
         stock.setExtra5(Double.valueOf(resultSet.getDouble(19)));
         stock.setExtra6(Double.valueOf(resultSet.getDouble(20)));
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
    return stock;
  }
  
  public Stock getTotalItemDispatchOnDate(String biltyDate) throws SQLException
  {
    Stock detail = new Stock();
    String select = " SELECT IFNULL(SUM(mungdaal),0) , IFNULL(SUM(matki),0) , IFNULL(SUM(mung),0) , IFNULL(SUM(masuldaal),0) , IFNULL(SUM(chvli),0) , IFNULL(SUM(tel),0) , IFNULL(SUM(mith),0) , IFNULL(SUM(mirchi),0) , IFNULL(SUM(halad),0) , IFNULL(SUM(jire),0) , IFNULL(SUM(mohari),0) , IFNULL(SUM(tandul),0) , IFNULL(SUM(harbara),0) , IFNULL(SUM(vatana),0) , IFNULL(SUM(extra1),0), IFNULL(SUM(extra2),0), IFNULL(SUM(extra3),0), IFNULL(SUM(extra4),0), IFNULL(SUM(extra5),0), IFNULL(SUM(extra6),0)  FROM dispatch_taluka_order_details  INNER JOIN dispatch d ON dispatch_id_fk = d.dispatch_id  WHERE bilty_flag = 1 AND STR_TO_DATE(d.bilty_date,'%d/%m/%Y') <= STR_TO_DATE(?,'%d/%m/%Y') ";

    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(select);
      ps.setString(1, biltyDate);
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
  
  public Stock getReciveItemStockOnDate(String recDate)
    throws SQLException
  {
    Stock stock = new Stock();
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sdsq.select8);
      ps.setString(1, recDate);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        if (resultSet.getInt(1) == 1)
          stock.setMungdaal(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 2)
          stock.setMatki(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 3)
          stock.setMung(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 4)
          stock.setMasuldaal(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 5)
          stock.setChvli(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 6)
          stock.setTel(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 7)
          stock.setMith(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 8)
          stock.setMirchi(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 9)
          stock.setHalad(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 10)
          stock.setJire(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 11)
          stock.setMohari(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 12)
          stock.setTandul(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 13)
            stock.setHarbara(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 14)
            stock.setVatana(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 15)
            stock.setExtra1(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 16)
            stock.setExtra2(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 17)
            stock.setExtra3(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 18)
            stock.setExtra4(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 19)
            stock.setExtra5(Double.valueOf(resultSet.getDouble(3)));
        if (resultSet.getInt(1) == 20)
            stock.setExtra6(Double.valueOf(resultSet.getDouble(3)));
      }
    }
    catch (Exception ex) {
      throw new RuntimeException(ex);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return stock;
  }
  
  public Stock getCurrentStockOnDate(String onDate) throws SQLException
  {
    Stock s = getTotalStockDifferanceOnDate(onDate);
    Stock s1 = getTotalItemDispatchOnDate(onDate);
    Stock s2 = getReciveItemStockOnDate(onDate);
    Stock s3 = getItemStockReturnBySchoolOnDate(onDate);
    s.setMungdaal(Double.valueOf(s.getMungdaal().doubleValue() + s1.getMungdaal().doubleValue() + s2.getMungdaal().doubleValue() - s3.getMungdaal().doubleValue()));
    s.setMatki(Double.valueOf(s.getMatki().doubleValue() + s1.getMatki().doubleValue() + s2.getMatki().doubleValue() - s3.getMatki().doubleValue()));
    s.setMung(Double.valueOf(s.getMung().doubleValue() + s1.getMung().doubleValue() + s2.getMung().doubleValue() - s3.getMung().doubleValue()));
    s.setMasuldaal(Double.valueOf(s.getMasuldaal().doubleValue() + s1.getMasuldaal().doubleValue() + s2.getMasuldaal().doubleValue() - s3.getMasuldaal().doubleValue()));
    s.setChvli(Double.valueOf(s.getChvli().doubleValue() + s1.getChvli().doubleValue() + s2.getChvli().doubleValue() - s3.getChvli().doubleValue()));
    s.setTel(Double.valueOf(s.getTel().doubleValue() + s1.getTel().doubleValue() + s2.getTel().doubleValue() - s3.getTel().doubleValue()));
    s.setMith(Double.valueOf(s.getMith().doubleValue() + s1.getMith().doubleValue() + s2.getMith().doubleValue() - s3.getMith().doubleValue()));
    s.setMirchi(Double.valueOf(s.getMirchi().doubleValue() + s1.getMirchi().doubleValue() + s2.getMirchi().doubleValue() - s3.getMirchi().doubleValue()));
    s.setHalad(Double.valueOf(s.getHalad().doubleValue() + s1.getHalad().doubleValue() + s2.getHalad().doubleValue() - s3.getHalad().doubleValue()));
    s.setJire(Double.valueOf(s.getJire().doubleValue() + s1.getJire().doubleValue() + s2.getJire().doubleValue() - s3.getJire().doubleValue()));
    s.setMohari(Double.valueOf(s.getMohari().doubleValue() + s1.getMohari().doubleValue() + s2.getMohari().doubleValue() - s3.getMohari().doubleValue()));
    s.setTandul(Double.valueOf(s.getTandul().doubleValue() + s1.getTandul().doubleValue() + s2.getTandul().doubleValue() - s3.getTandul().doubleValue()));
    
    s.setHarbara(Double.valueOf(s.getHarbara().doubleValue() + s1.getHarbara().doubleValue() + s2.getHarbara().doubleValue() - s3.getHarbara().doubleValue()));
    s.setVatana(Double.valueOf(s.getVatana().doubleValue() + s1.getVatana().doubleValue() + s2.getVatana().doubleValue() - s3.getVatana().doubleValue()));
    s.setExtra1(Double.valueOf(s.getExtra1().doubleValue() + s1.getExtra1().doubleValue() + s2.getExtra1().doubleValue() - s3.getExtra1().doubleValue()));
    s.setExtra2(Double.valueOf(s.getExtra2().doubleValue() + s1.getExtra2().doubleValue() + s2.getExtra2().doubleValue() - s3.getExtra2().doubleValue()));
    s.setExtra3(Double.valueOf(s.getExtra3().doubleValue() + s1.getExtra3().doubleValue() + s2.getExtra3().doubleValue() - s3.getExtra3().doubleValue()));
    s.setExtra4(Double.valueOf(s.getExtra4().doubleValue() + s1.getExtra4().doubleValue() + s2.getExtra4().doubleValue() - s3.getExtra4().doubleValue()));
    s.setExtra5(Double.valueOf(s.getExtra5().doubleValue() + s1.getExtra5().doubleValue() + s2.getExtra5().doubleValue() - s3.getExtra5().doubleValue()));
    s.setExtra6(Double.valueOf(s.getExtra6().doubleValue() + s1.getExtra6().doubleValue() + s2.getExtra6().doubleValue() - s3.getExtra6().doubleValue()));
    return s;
  }
}
