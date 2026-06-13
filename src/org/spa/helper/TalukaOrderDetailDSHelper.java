package org.spa.helper;

import flexjson.JSONDeserializer;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import org.spa.connect.dbConnection;
import org.spa.convert.monthYearToMarathi;
import org.spa.entity.DispatchTalukaOrder;
import org.spa.entity.SectionWiseItemSum;
import org.spa.entity.TalukaInvoice;
import org.spa.entity.TalukaOrder;




public class TalukaOrderDetailDSHelper
{
  PreparedStatement ps = null; PreparedStatement ps1 = null;
  ResultSet resultSet = null; ResultSet resultSet1 = null;
  
  public TalukaOrderDetailDSHelper() {}
  
  public List<SectionWiseItemSum> convert(String jsonString, int talukaOrderId, int sectionID) { Map map = null;
    try
    {
      map = (Map)new JSONDeserializer().use("data", SectionWiseItemSum.class).deserialize(jsonString);
    }
    catch (IndexOutOfBoundsException e)
    {
      return null;
    }
    List l = (List)map.get("data");
    SectionWiseItemSum detail = null;
    List d = new ArrayList();
    for (Object ob : l)
    {
      Map map2 = (Map)ob;
      detail = new SectionWiseItemSum();
      Set set = map2.entrySet();
      for (Object o2 : set)
      {
        Map.Entry en = (Map.Entry)o2;
        String key = (String)en.getKey();
        Object valObj = en.getValue();
        String value = "";
        
        if ((valObj instanceof Integer))
        {
          Integer valueInt = (Integer)valObj;
          value = valueInt.toString();
        }
        else if ((valObj instanceof Double))
        {
          Double valueDouble = (Double)valObj;
          value = valueDouble.toString();
        }
        else
        {
          value = (String)valObj;
        }
        
        if ((value != null) && (value.length() != 0) && ("talukaOrderDetailsId".equals(key)))
        {
          detail.setTalukaOrderDetailsId(Integer.parseInt(value));
        }
        
        detail.setTalukaOrderId(talukaOrderId);
        detail.setSectionID(sectionID);
        
        if ((value != null) && (value.length() != 0) && ("beatID".equals(key)))
        {
          detail.setBeatID(Integer.parseInt(value));
        }
        if ((value != null) && (value.length() != 0) && ("schoolID".equals(key)))
        {
          detail.setSchoolID(Integer.parseInt(value));
        }
        if ((value != null) && (value.length() != 0) && ("challanNumber".equals(key)))
        {
          detail.setChallanNumber(Integer.parseInt(value));
        }
        if ("challanDate".equals(key))
        {
          detail.setChallanDate(value);
        }
        
        if ((value != null) && (value.length() != 0) && ("mungdaal".equals(key)))
        {
          detail.setMungdaal(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("matki".equals(key)))
        {
          detail.setMatki(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("mung".equals(key)))
        {
          detail.setMung(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("masuldaal".equals(key)))
        {
          detail.setMasuldaal(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("chvli".equals(key)))
        {
          detail.setChvli(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("tel".equals(key)))
        {
          detail.setTel(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("mith".equals(key)))
        {
          detail.setMith(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("mirchi".equals(key)))
        {
          detail.setMirchi(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("halad".equals(key)))
        {
          detail.setHalad(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("jire".equals(key)))
        {
          detail.setJire(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("mohari".equals(key)))
        {
          detail.setMohari(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("tandul".equals(key)))
        {
          detail.setTandul(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("harbara".equals(key)))
        {
          detail.setHarbara(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("vatana".equals(key)))
        {
          detail.setVatana(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("extra1".equals(key)))
        {
          detail.setExtra1(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("extra2".equals(key)))
        {
          detail.setExtra2(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("extra3".equals(key)))
        {
          detail.setExtra3(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("extra4".equals(key)))
        {
          detail.setExtra4(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("extra5".equals(key)))
        {
          detail.setExtra5(Double.parseDouble(value));
        }
        if ((value != null) && (value.length() != 0) && ("extra6".equals(key)))
        {
          detail.setExtra6(Double.parseDouble(value));
        }
      }
      d.add(detail);
    }
    System.out.println("d.size()   :: " + d.size());
    return d;
  }
  
  dbConnection dbCon;
  Connection con;
  public int getCorrectMonth(int monthDiff, int yearDiff) { int yd = yearDiff;
    int md = monthDiff;
    
    int correctedMonths = md;
    
    if (yd < 0)
    {
      throw new RuntimeException("Wrong years");
    }
    if (yd > 0)
    {
      if (md < 0)
      {
        correctedMonths = (md + 12) * yd;
      }
      if (md > 0)
      {
        correctedMonths = md + 12 * yd;
      }
      if (md == 0)
      {
        correctedMonths = 12 * yd;
      }
    }
    if (yd == 0)
    {
      if (md < 0)
      {
        throw new RuntimeException("Wrong months");
      }
      if (md > 0)
      {
        correctedMonths = md + 12 * yd;
      }
    }
    return correctedMonths;
  }
  
  public TalukaOrder talukaOrderDetails(int talukaOrderId)
    throws SQLException
  {
    TalukaOrder d = new TalukaOrder();
    monthYearToMarathi m = new monthYearToMarathi();
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    
    String sql = " SELECT tor.taluka_id, tm.taluka_marathi, dm.district_id , dm.district_marathi , tor.order_type, tor.from_month, tor.from_year,tor.to_month, tor.to_year, dm.std_type  ,tor.taluka_order_date FROM taluka_order tor , taluka_master tm, district_master dm  WHERE taluka_order_id = ?  AND tm.taluka_id = tor.taluka_id  AND tm.district_id_fk = dm.district_id ";
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, talukaOrderId);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        d.setTalukaId(resultSet.getInt(1));
        d.setTalukaName(resultSet.getString(2));
        d.setDistrictId(resultSet.getInt(3));
        d.setDistrictName(resultSet.getString(4));
        d.setOrderType(resultSet.getInt(5));
        if (d.getOrderType() == 1) {
          d.setStdTypeDetails("Rice");
        } else
          d.setStdTypeDetails("Ration");
        d.setFromMonth(m.monthString(resultSet.getInt(6)));
        d.setFromYear(m.yearString(resultSet.getInt(7)));
        d.setToMonth(m.monthString(resultSet.getInt(8)));
        d.setToYear(m.yearString(resultSet.getInt(9)));
        d.setStdType(resultSet.getInt(10));
        if (d.getStdType() == 1) {
          d.setOrderTypeDetails("१ ते ५");
        } else
          d.setOrderTypeDetails("६ ते ८");
        d.settOrderDate(resultSet.getString(11));
      }
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    } finally {
      ps.close();resultSet.close(); }
    return d;
  }
  
  public List<TalukaOrder> districtOrderDetails(int talukaOrderId)
    throws SQLException
  {
    TalukaOrder d = null;
    List list = new ArrayList();
    monthYearToMarathi m = new monthYearToMarathi();
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    
    String sql = " SELECT tor.taluka_id, tm.taluka_marathi, dm.district_id , dm.district_marathi , tor.order_type, tor.from_month, tor.from_year,tor.to_month, tor.to_year, dm.std_type, IFNULL(ti.invoice_id,0), ti.weight, ti.bill_matrix_version_id_fk,ti.invoice_date  ,tor.taluka_order_date FROM taluka_master tm, district_master dm, taluka_order tor  LEFT JOIN taluka_invoice ti ON ti.taluka_order_id = tor.taluka_order_id  WHERE tor.district_order_id = ?  AND tm.taluka_id = tor.taluka_id  AND tm.district_id_fk = dm.district_id AND  ti.weight != '' ";
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, talukaOrderId);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        d = new TalukaOrder();
        d.setTalukaId(resultSet.getInt(1));
        d.setTalukaName(resultSet.getString(2));
        d.setDistrictId(resultSet.getInt(3));
        d.setDistrictName(resultSet.getString(4));
        d.setOrderType(resultSet.getInt(5));
        if (d.getOrderType() == 1) {
          d.setStdTypeDetails("Rice");
        } else
          d.setStdTypeDetails("Ration");
        d.setFromMonth(m.monthString(resultSet.getInt(6)));
        d.setFromYear(m.yearString(resultSet.getInt(7)));
        d.setToMonth(m.monthString(resultSet.getInt(8)));
        d.setToYear(m.yearString(resultSet.getInt(9)));
        d.setStdType(resultSet.getInt(10));
        if (d.getStdType() == 1) {
          d.setOrderTypeDetails("१ ते ५");
        } else
          d.setOrderTypeDetails("६ ते ८");
        d.setInvoiceID(resultSet.getInt(11));
        d.setWeight(Double.valueOf(resultSet.getDouble(12)));
        d.setVersion(resultSet.getInt(13));
        d.setInvoiceDate(resultSet.getString(14));
        d.settOrderDate(resultSet.getString(15));
        list.add(d);
      }
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    } finally {
      ps.close();resultSet.close(); }
    return list;
  }
  
  public List<TalukaOrder> districtOrderReturnDetails(int talukaOrderId) throws SQLException
  {
    TalukaOrder d = null;
    List list = new ArrayList();
    monthYearToMarathi m = new monthYearToMarathi();
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    
    String sql = " SELECT tor.taluka_id, tm.taluka_marathi, dm.district_id , dm.district_marathi , tor.order_type, tor.from_month, tor.from_year,tor.to_month, tor.to_year, dm.std_type, IFNULL(ti.invoice_id,0), ti.weight, ti.bill_matrix_version_id_fk,ti.invoice_date  FROM taluka_master tm, district_master dm, taluka_order tor  LEFT JOIN taluka_invoice ti ON ti.taluka_order_id = tor.taluka_order_id  WHERE tor.district_order_id = ?  AND tm.taluka_id = tor.taluka_id  AND tm.district_id_fk = dm.district_id ";
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, talukaOrderId);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        d = new TalukaOrder();
        d.setTalukaId(resultSet.getInt(1));
        d.setTalukaName(resultSet.getString(2));
        d.setDistrictId(resultSet.getInt(3));
        d.setDistrictName(resultSet.getString(4));
        d.setOrderType(resultSet.getInt(5));
        if (d.getOrderType() == 1) {
          d.setStdTypeDetails("Rice");
        } else
          d.setStdTypeDetails("Ration");
        d.setFromMonth(m.monthString(resultSet.getInt(6)));
        d.setFromYear(m.yearString(resultSet.getInt(7)));
        d.setToMonth(m.monthString(resultSet.getInt(8)));
        d.setToYear(m.yearString(resultSet.getInt(9)));
        d.setStdType(resultSet.getInt(10));
        if (d.getStdType() == 1) {
          d.setOrderTypeDetails("१ ते ५");
        } else
          d.setOrderTypeDetails("६ ते ८");
        d.setInvoiceID(resultSet.getInt(11));
        d.setWeight(Double.valueOf(resultSet.getDouble(12)));
        d.setVersion(resultSet.getInt(13));
        d.setInvoiceDate(resultSet.getString(14));
        list.add(d);
      }
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    } finally {
      ps.close();resultSet.close(); }
    return list;
  }
  
  public DispatchTalukaOrder districtOrderDetailsByID(int distOrderId)
    throws SQLException
  {
    DispatchTalukaOrder d = null;
    List list = new ArrayList();
    monthYearToMarathi m = new monthYearToMarathi();
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    String sql = " SELECT too.district_order_id,dm.district_marathi,too.from_month,too.from_year,too.to_month,too.to_year, SUM(IFNULL(tod.mungdaal,0)),SUM(IFNULL(tod.matki,0)),SUM(IFNULL(tod.mung,0)),SUM(IFNULL(tod.masuldaal,0)), SUM(IFNULL(tod.chvli,0)),SUM(IFNULL(tod.tel,0)),SUM(IFNULL(tod.mith,0)),SUM(IFNULL(tod.mirchi,0)), SUM(IFNULL(tod.halad,0)),SUM(IFNULL(tod.jire,0)),SUM(IFNULL(tod.mohari,0)),SUM(IFNULL(tod.tandul,0)),SUM(IFNULL(tod.harbara,0)),SUM(IFNULL(tod.vatana,0)),SUM(IFNULL(tod.extra1,0)),SUM(IFNULL(tod.extra2,0)),SUM(IFNULL(tod.extra3,0)),SUM(IFNULL(tod.extra4,0)),SUM(IFNULL(tod.extra5,0)),SUM(IFNULL(tod.extra6,0))   FROM district_order dod  INNER JOIN taluka_order too ON too.district_order_id = dod.district_order_id  INNER JOIN taluka_order_details tod ON  tod.taluka_order_id = too.taluka_order_id  INNER JOIN district_master dm ON dm.district_id = dod.district_id  WHERE dod.district_order_id = ? ";
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, distOrderId);
      resultSet = ps.executeQuery();
      d = new DispatchTalukaOrder();
      if (resultSet.next())
      {
        d.setDistrictOrderId(Integer.valueOf(resultSet.getInt(1)));
        d.setDistrictName(resultSet.getString(2));
        d.setFromMonth(m.monthString(resultSet.getInt(3)));
        d.setFromMonthYear(m.yearString(resultSet.getInt(4)));
        d.setToMonth(m.monthString(resultSet.getInt(5)));
        d.setToMonthYear(m.yearString(resultSet.getInt(6)));
        d.setMungdaal(Double.valueOf(resultSet.getDouble(7)));
        d.setMatki(Double.valueOf(resultSet.getDouble(8)));
        d.setMung(Double.valueOf(resultSet.getDouble(9)));
        d.setMasuldaal(Double.valueOf(resultSet.getDouble(10)));
        d.setChvli(Double.valueOf(resultSet.getDouble(11)));
        d.setTel(Double.valueOf(resultSet.getDouble(12)));
        d.setMith(Double.valueOf(resultSet.getDouble(13)));
        d.setMirchi(Double.valueOf(resultSet.getDouble(14)));
        d.setHalad(Double.valueOf(resultSet.getDouble(15)));
        d.setJire(Double.valueOf(resultSet.getDouble(16)));
        d.setMohari(Double.valueOf(resultSet.getDouble(17)));
        d.setTandul(Double.valueOf(resultSet.getDouble(18)));
        
        d.setHarbara(Double.valueOf(resultSet.getDouble(19)));
        d.setVatana(Double.valueOf(resultSet.getDouble(20)));
        d.setExtra1(Double.valueOf(resultSet.getDouble(21)));
        d.setExtra2(Double.valueOf(resultSet.getDouble(22)));
        d.setExtra3(Double.valueOf(resultSet.getDouble(23)));
        d.setExtra4(Double.valueOf(resultSet.getDouble(24)));
        d.setExtra5(Double.valueOf(resultSet.getDouble(25)));
        d.setExtra6(Double.valueOf(resultSet.getDouble(26)));
      }
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    } finally {
      ps.close();resultSet.close(); }
    return d;
  }
  
  public DispatchTalukaOrder districtReturnDetailsByID(int distOrderId) throws SQLException
  {
    DispatchTalukaOrder d = null;
    List list = new ArrayList();
    monthYearToMarathi m = new monthYearToMarathi();
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    String sql1 = " SELECT too.district_order_id,dm.district_marathi,too.from_month,too.from_year,too.to_month,too.to_year, SUM(IFNULL(tod.mungdaal,0)),SUM(IFNULL(tod.matki,0)),SUM(IFNULL(tod.mung,0)),SUM(IFNULL(tod.masuldaal,0)), SUM(IFNULL(tod.chvli,0)),SUM(IFNULL(tod.tel,0)),SUM(IFNULL(tod.mith,0)),SUM(IFNULL(tod.mirchi,0)), SUM(IFNULL(tod.halad,0)),SUM(IFNULL(tod.jire,0)),SUM(IFNULL(tod.mohari,0)),SUM(IFNULL(tod.tandul,0)),SUM(IFNULL(tod.harbara,0)),SUM(IFNULL(tod.vatana,0)),SUM(IFNULL(tod.extra1,0)),SUM(IFNULL(tod.extra2,0)),SUM(IFNULL(tod.extra3,0)),SUM(IFNULL(tod.extra4,0)),SUM(IFNULL(tod.extra5,0)),SUM(IFNULL(tod.extra6,0))   FROM district_order dod  INNER JOIN taluka_order too ON too.district_order_id = dod.district_order_id  INNER JOIN taluka_return_details tod ON  tod.taluka_order_id = too.taluka_order_id  INNER JOIN district_master dm ON dm.district_id = dod.district_id  WHERE dod.district_order_id = ? ";
    try
    {
      ps = con.prepareStatement(sql1);
      ps.setInt(1, distOrderId);
      resultSet = ps.executeQuery();
      d = new DispatchTalukaOrder();
      if (resultSet.next())
      {
        d.setDistrictOrderId(Integer.valueOf(resultSet.getInt(1)));
        d.setDistrictName(resultSet.getString(2));
        d.setFromMonth(m.monthString(resultSet.getInt(3)));
        d.setFromMonthYear(m.yearString(resultSet.getInt(4)));
        d.setToMonth(m.monthString(resultSet.getInt(5)));
        d.setToMonthYear(m.yearString(resultSet.getInt(6)));
        d.setMungdaal(Double.valueOf(resultSet.getDouble(7)));
        d.setMatki(Double.valueOf(resultSet.getDouble(8)));
        d.setMung(Double.valueOf(resultSet.getDouble(9)));
        d.setMasuldaal(Double.valueOf(resultSet.getDouble(10)));
        d.setChvli(Double.valueOf(resultSet.getDouble(11)));
        d.setTel(Double.valueOf(resultSet.getDouble(12)));
        d.setMith(Double.valueOf(resultSet.getDouble(13)));
        d.setMirchi(Double.valueOf(resultSet.getDouble(14)));
        d.setHalad(Double.valueOf(resultSet.getDouble(15)));
        d.setJire(Double.valueOf(resultSet.getDouble(16)));
        d.setMohari(Double.valueOf(resultSet.getDouble(17)));
        d.setTandul(Double.valueOf(resultSet.getDouble(18)));
        
        d.setHarbara(Double.valueOf(resultSet.getDouble(19)));
        d.setVatana(Double.valueOf(resultSet.getDouble(20)));
        d.setExtra1(Double.valueOf(resultSet.getDouble(21)));
        d.setExtra2(Double.valueOf(resultSet.getDouble(22)));
        d.setExtra3(Double.valueOf(resultSet.getDouble(23)));
        d.setExtra4(Double.valueOf(resultSet.getDouble(24)));
        d.setExtra5(Double.valueOf(resultSet.getDouble(25)));
        d.setExtra6(Double.valueOf(resultSet.getDouble(26)));
      }
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    } finally {
      ps.close();resultSet.close(); }
    return d;
  }
  
  public List<TalukaInvoice> talukaCoverLetterDetails(String talukaName, int orderID1, int orderID2)
    throws SQLException
  {
    List list = new ArrayList();
    TalukaInvoice d = null;
    monthYearToMarathi m = new monthYearToMarathi();
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    
    String sql = " SELECT tm.taluka_id,tm.taluka_marathi,dm.district_marathi,ti.invoice_id,dor.district_order_date,tor.from_month, tor.from_year,tor.to_month, tor.to_year,ti.invoice_id_ration,ti.invoice_id_tandul_k,ti.invoice_id_tandul_r,ti.total_amount_ration,ti.total_amount_tandul_k,ti.total_amount_tandul_r  FROM taluka_invoice ti  INNER JOIN taluka_order tor ON tor.taluka_order_id = ti.taluka_order_id AND tor.deleted <> 1  INNER JOIN taluka_master tm ON tm.taluka_id = tor.taluka_id AND tm.taluka_marathi = ?  INNER JOIN district_master dm ON dm.district_id = tm.district_id_fk  INNER JOIN district_order dor ON dor.district_order_id = tor.district_order_id AND (dor.district_order_id = ? OR dor.district_order_id = ?) ";
    try
    {
      ps = con.prepareStatement(sql);
      ps.setString(1, talukaName);
      ps.setInt(2, orderID1);
      ps.setInt(3, orderID2);
      System.out.println(ps);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        d = new TalukaInvoice();
        d.setTalukaID(resultSet.getInt(1));
        d.setTalukaMarathi(resultSet.getString(2));
        d.setDistrictMarathi(resultSet.getString(3));
        d.setInvoiceID(resultSet.getInt(4));
        d.setDistrictOrderDate(resultSet.getString(5));
        d.setFromMonth(m.monthString(resultSet.getInt(6)));
        d.setFromYear(m.yearString(resultSet.getInt(7)));
        d.setToMonth(m.monthString(resultSet.getInt(8)));
        d.setToYear(m.yearString(resultSet.getInt(9)));
        d.setInvoiceIDMan(resultSet.getInt(10));
        d.setInvoiceIDMan1(resultSet.getInt(11));
        d.setInvoiceIDMan2(resultSet.getInt(12));
        d.setTotalAmount(resultSet.getDouble(13));
        d.setTotalAmount1(resultSet.getDouble(14));
        d.setTotalAmount2(resultSet.getDouble(15));
        list.add(d);
      }
      System.out.println(list.size());
    }
    catch (Exception ex)
    {
      throw new RuntimeException(ex);
    } finally {
      ps.close();resultSet.close(); }
    return list;
  }
}
