package org.spa.ds;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.spa.connect.dbConnection;
import org.spa.entity.Item;
import org.spa.entity.TalukaInvoice;

public class InvoiceDS
{
  dbConnection dbConnection = null;
  Connection con = null;
  int key = 0;
  PreparedStatement ps = null;
  ResultSet resultSet = null;
  
  public InvoiceDS() {}
  
  public int getDupInvoice(int orderID) throws SQLException { String sql = " SELECT COUNT(*), invoice_id FROM taluka_invoice WHERE taluka_order_id = ? ";
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, orderID);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        key = resultSet.getInt(1);
        if (key != 0) {
          key = resultSet.getInt(2);
        }
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
  
  public int getDupDistrictInvoice(int orderID) throws SQLException
  {
    String sql = " SELECT COUNT(*), dist_invoice_id FROM district_invoice WHERE district_order_id = ? ";
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, orderID);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        key = resultSet.getInt(1);
        if (key != 0) {
          key = resultSet.getInt(2);
        }
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
  
  public ArrayList<Item> getAllItemByVersion(String billDate) throws SQLException
  {
    String sql = " SELECT item_id_fk,rates,vat_percent,transpotation_rate,k_rate,r_rate,VERSION  FROM bill_matrix  WHERE VERSION IN  (  \t\tSELECT VERSION \t\tFROM bill_matrix_version_master\t\tWHERE STR_TO_DATE(?,'%d/%m/%Y')  \t\tBETWEEN STR_TO_DATE(startdate,'%d/%m/%Y') \t\tAND STR_TO_DATE(enddate,'%d/%m/%Y') ) ";
    
    ArrayList arr_item = new ArrayList();
    Item item = null;
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setString(1, billDate);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        item = new Item();
        item.setItemId(resultSet.getInt(1));
        item.setRatePerKg(resultSet.getDouble(2));
        item.setVat(resultSet.getDouble(3));
        item.setTranRate(resultSet.getDouble(4));
        item.setkRate(resultSet.getDouble(5));
        item.setrRate(resultSet.getDouble(6));
        item.setVersion(resultSet.getInt(7));
        
        arr_item.add(item);
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
    
    return arr_item;
  }
  
  public int isDuplicate(int invoiceNo) throws SQLException
  {
    int flag = 0;
    String sql1 = " SELECT COUNT(*) FROM taluka_invoice WHERE invoice_id_ration = ? OR invoice_id_tandul_k = ? OR invoice_id_tandul_r = ? ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql1);
      ps.setInt(1, invoiceNo);
      ps.setInt(2, invoiceNo);
      ps.setInt(3, invoiceNo);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        flag = resultSet.getInt(1);
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
    System.out.println(invoiceNo + "\t" + flag);
    return flag;
  }
  
  public int isDuplicateDistrict(int invoiceNo) throws SQLException
  {
    int flag = 0;
    String sql1 = " SELECT COUNT(*) FROM district_invoice WHERE invoice_id_tandul_k = ? OR invoice_id_tandul_r = ? ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql1);
      ps.setInt(1, invoiceNo);
      ps.setInt(2, invoiceNo);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        flag = resultSet.getInt(1);
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
    return flag;
  }
  
  public int createInvoice(TalukaInvoice talukaInvoice) throws SQLException
  {
    int key = 0;
    String s = " INSERT INTO taluka_invoice(invoice_id,taluka_order_id,total_amount_ration,total_amount_tandul_k,total_amount_tandul_r,weight,invoice_date,creation_date,invoice_id_ration,invoice_id_tandul_k,invoice_id_tandul_r,bill_matrix_version_id_fk)  VALUES \t\t\t       (   NULL   ,      ?        ,         ?         ,          ?          ,          ?          ,   ?  ,      ?     ,  CURDATE()  ,         ?       ,         ?         ,         ?         ,            ?            ) ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(s);
      ps.setInt(1, talukaInvoice.getOrderID());
      ps.setDouble(2, talukaInvoice.getTotalAmount());
      ps.setDouble(3, talukaInvoice.getTotalAmount1());
      ps.setDouble(4, talukaInvoice.getTotalAmount2());
      ps.setDouble(5, talukaInvoice.getWeight());
      ps.setString(6, talukaInvoice.getInvoiceDate());
      ps.setDouble(7, talukaInvoice.getInvoiceIDMan());
      ps.setDouble(8, talukaInvoice.getInvoiceIDMan1());
      ps.setDouble(9, talukaInvoice.getInvoiceIDMan2());
      ps.setInt(10, talukaInvoice.getVersion());
      ps.executeUpdate();
      resultSet = ps.getGeneratedKeys();
      if (resultSet.next())
      {
        key = resultSet.getInt(1);
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
  
  public int createDistrictInvoice(TalukaInvoice talukaInvoice) throws SQLException
  {
    int key = 0;
    String s = " INSERT INTO district_invoice(dist_invoice_id,district_order_id,total_amount_tandul_k,total_amount_tandul_r,weight,invoice_date,creation_date,invoice_id_tandul_k,invoice_id_tandul_r,bill_matrix_version_id_fk)  VALUES \t\t\t         (       NULL    ,        ?        ,          ?          ,          ?          ,  ?   ,       ?    ,  CURDATE()  ,          ?        ,         ?         ,            ?            ) ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(s);
      ps.setInt(1, talukaInvoice.getOrderID());
      ps.setDouble(2, talukaInvoice.getTotalAmount1());
      ps.setDouble(3, talukaInvoice.getTotalAmount2());
      ps.setDouble(4, talukaInvoice.getWeight());
      ps.setString(5, talukaInvoice.getInvoiceDate());
      ps.setDouble(6, talukaInvoice.getInvoiceIDMan1());
      ps.setDouble(7, talukaInvoice.getInvoiceIDMan2());
      ps.setInt(8, talukaInvoice.getVersion());
      ps.executeUpdate();
      resultSet = ps.getGeneratedKeys();
      if (resultSet.next())
      {
        key = resultSet.getInt(1);
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
  
  public int createDistrictRiceSalesInvoice(TalukaInvoice talukaInvoice) throws SQLException
  {
    int key = 0;
    String s = " INSERT INTO district_sales_invoice(disrict_sales_invoice_id,disrict_sales_invoice_date,district_order_id_1to5,district_order_id_6to8,invoice_no_tandul,invoice_no_ration_taxable,invoice_no_ration_nontaxable,weight_1to5,weight_6to8,weight_total,invoice_amount_tandul,invoice_amount_ration_taxable,invoice_amount_ration_nontaxable,bill_matrix_version)  VALUES \t\t\t               (            NULL        ,              ?           ,           ?          ,           ?          ,        ?        ,             ?           ,               ?            ,     ?     ,     ?     ,      ?     ,          ?          ,              ?              ,                ?               ,           ?       ) ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(s);
      ps.setString(1, talukaInvoice.getInvoiceDate());
      ps.setInt(2, talukaInvoice.getOrderID());
      ps.setInt(3, talukaInvoice.getOrderID1());
      ps.setInt(4, talukaInvoice.getInvoiceIDMan1());
      ps.setInt(5, 0);
      ps.setInt(6, 0);
      ps.setDouble(7, talukaInvoice.getWeight());
      ps.setDouble(8, talukaInvoice.getWeight1());
      ps.setDouble(9, talukaInvoice.getWeight() + talukaInvoice.getWeight1());
      ps.setDouble(10, talukaInvoice.getTotalAmount());
      ps.setDouble(11, 0.0D);
      ps.setDouble(12, 0.0D);
      ps.setInt(13, talukaInvoice.getVersion());
      ps.executeUpdate();
      resultSet = ps.getGeneratedKeys();
      if (resultSet.next())
      {
        key = resultSet.getInt(1);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
      resultSet.close();
    }
    return key;
  }
  
  public int createDistrictRationSalesInvoice(TalukaInvoice talukaInvoice) throws SQLException
  {
    int key = 0;
    String s = " INSERT INTO district_sales_invoice(disrict_sales_invoice_id,disrict_sales_invoice_date,district_order_id_1to5,district_order_id_6to8,invoice_no_tandul,invoice_no_ration_taxable,invoice_no_ration_nontaxable,weight_1to5,weight_6to8,weight_total,invoice_amount_tandul,invoice_amount_ration_taxable,invoice_amount_ration_nontaxable,bill_matrix_version)  VALUES \t\t\t               (            NULL        ,              ?           ,           ?          ,           ?          ,        ?        ,             ?           ,               ?            ,     ?     ,     ?     ,      ?     ,          ?          ,              ?              ,                ?               ,           ?       ) ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(s);
      ps.setString(1, talukaInvoice.getInvoiceDate());
      ps.setInt(2, talukaInvoice.getOrderID());
      ps.setInt(3, talukaInvoice.getOrderID1());
      ps.setInt(4, 0);
      ps.setInt(5, talukaInvoice.getInvoiceIDMan2());
      ps.setInt(6, talukaInvoice.getInvoiceIDMan1());
      ps.setDouble(7, 0.0D);
      ps.setDouble(8, 0.0D);
      ps.setDouble(9, talukaInvoice.getWeight());
      ps.setDouble(10, 0.0D);
      ps.setDouble(11, talukaInvoice.getTotalAmount1());
      ps.setDouble(12, talukaInvoice.getTotalAmount());
      ps.setInt(13, talukaInvoice.getVersion());
      ps.executeUpdate();
      resultSet = ps.getGeneratedKeys();
      if (resultSet.next())
      {
        key = resultSet.getInt(1);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
      resultSet.close();
    }
    return key;
  }
  
  public TalukaInvoice readInvoice(int invoiceId) throws SQLException
  {
    TalukaInvoice talukaInvoice = new TalukaInvoice();
    String sql = " SELECT ti.invoice_id, ti.invoice_id_ration,ti.invoice_id_tandul_k,ti.invoice_id_tandul_r, ti.invoice_date, ti.taluka_order_id, tod.taluka_id,ti.total_amount_ration,ti.total_amount_tandul_k,ti.total_amount_tandul_r,ti.bill_matrix_version_id_fk  FROM taluka_invoice ti  INNER JOIN taluka_order tod ON tod.taluka_order_id = ti.taluka_order_id  WHERE ti.invoice_id = ? ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, invoiceId);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        if (resultSet.next())
        {
          talukaInvoice.setInvoiceID(resultSet.getInt(1));
          talukaInvoice.setInvoiceIDMan(resultSet.getInt(2));
          talukaInvoice.setInvoiceIDMan1(resultSet.getInt(3));
          talukaInvoice.setInvoiceIDMan2(resultSet.getInt(4));
          talukaInvoice.setInvoiceDate(resultSet.getString(5));
          talukaInvoice.setOrderID(resultSet.getInt(6));
          talukaInvoice.setTalukaID(resultSet.getInt(7));
          talukaInvoice.setTotalAmount(resultSet.getDouble(8));
          talukaInvoice.setTotalAmount1(resultSet.getDouble(9));
          talukaInvoice.setTotalAmount2(resultSet.getDouble(10));
          talukaInvoice.setVersion(resultSet.getInt(11));
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
    return talukaInvoice;
  }
  
  public TalukaInvoice readDistrictInvoice(int invoiceId) throws SQLException
  {
    TalukaInvoice talukaInvoice = new TalukaInvoice();
    String sql = " SELECT di.dist_invoice_id, di.invoice_id_tandul_k, di.invoice_id_tandul_r, di.invoice_date, di.district_order_id, dod.district_id, di.total_amount_tandul_k, di.total_amount_tandul_r, di.bill_matrix_version_id_fk, dm.district_marathi, dm.std_type  FROM district_invoice di  INNER JOIN district_order dod ON dod.district_order_id = di.district_order_id  INNER JOIN district_master dm ON dm.district_id = dod.district_id  WHERE di.dist_invoice_id = ? ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, invoiceId);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        if (resultSet.next())
        {
          talukaInvoice.setInvoiceID(resultSet.getInt(1));
          talukaInvoice.setInvoiceIDMan1(resultSet.getInt(2));
          talukaInvoice.setInvoiceIDMan2(resultSet.getInt(3));
          talukaInvoice.setInvoiceDate(resultSet.getString(4));
          talukaInvoice.setOrderID(resultSet.getInt(5));
          talukaInvoice.setDistrictID(resultSet.getInt(6));
          talukaInvoice.setTotalAmount1(resultSet.getDouble(7));
          talukaInvoice.setTotalAmount2(resultSet.getDouble(8));
          talukaInvoice.setVersion(resultSet.getInt(9));
          talukaInvoice.setDistrictMarathi(resultSet.getString(10));
          talukaInvoice.setStdType(resultSet.getInt(11));
          if (resultSet.getInt(11) == 1) {
            talukaInvoice.setStdTypeDetails("१ ली ते ५ वी");
          } else {
            talukaInvoice.setStdTypeDetails("६ वी ते ८ वी");
          }
        }
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
    return talukaInvoice;
  }
  
  public List<TalukaInvoice> readInvoiceByOrderType(int orderType, String fromDate, String toDate) throws SQLException
  {
    TalukaInvoice talukaInvoice = null;
    String sql = " SELECT ti.invoice_id, ti.invoice_id_ration,ti.invoice_id_tandul_k,ti.invoice_id_tandul_r, ti.invoice_date, ti.taluka_order_id, tod.taluka_id,ti.total_amount_ration,ti.total_amount_tandul_k,ti.total_amount_tandul_r,ti.bill_matrix_version_id_fk, tm.taluka_marathi, dm.district_marathi,dm.std_type,tod.taluka_gov_order_num  FROM taluka_invoice ti  INNER JOIN taluka_order tod ON tod.taluka_order_id = ti.taluka_order_id AND tod.`order_type` = ? AND STR_TO_DATE(tod.taluka_order_date,'%d/%m/%Y') BETWEEN STR_TO_DATE(?,'%d/%m/%Y') AND STR_TO_DATE(?,'%d/%m/%Y')  LEFT JOIN taluka_master tm ON tm.taluka_id = tod.taluka_id  LEFT JOIN district_master dm ON dm.district_id = tm.district_id_fk ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    List list1 = new ArrayList();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, orderType);
      ps.setString(2, fromDate);
      ps.setString(3, toDate);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          talukaInvoice = new TalukaInvoice();
          talukaInvoice.setInvoiceID(resultSet.getInt(1));
          talukaInvoice.setInvoiceIDMan(resultSet.getInt(2));
          talukaInvoice.setInvoiceIDMan1(resultSet.getInt(3));
          talukaInvoice.setInvoiceIDMan2(resultSet.getInt(4));
          talukaInvoice.setInvoiceDate(resultSet.getString(5));
          talukaInvoice.setOrderID(resultSet.getInt(6));
          talukaInvoice.setTalukaID(resultSet.getInt(7));
          talukaInvoice.setTotalAmount(resultSet.getDouble(8));
          talukaInvoice.setTotalAmount1(resultSet.getDouble(9));
          talukaInvoice.setTotalAmount2(resultSet.getDouble(10));
          talukaInvoice.setVersion(resultSet.getInt(11));
          talukaInvoice.setTalukaMarathi(resultSet.getString(12));
          talukaInvoice.setDistrictMarathi(resultSet.getString(13));
          talukaInvoice.setStdType(resultSet.getInt(14));
          if (resultSet.getInt(14) == 1) {
            talukaInvoice.setStdTypeDetails("१ ली ते ५ वी");
          } else
            talukaInvoice.setStdTypeDetails("६ वी ते ८ वी");
          talukaInvoice.setTalukaOrderNo(resultSet.getString(15));
          list1.add(talukaInvoice);
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
    return list1;
  }
  
  public List<TalukaInvoice> readDistrictInvoiceByOrderType(String fromDate, String toDate) throws SQLException
  {
    TalukaInvoice talukaInvoice = null;
    String sql = " SELECT di.dist_invoice_id, di.invoice_id_tandul_k, di.invoice_id_tandul_r, di.invoice_date, di.district_order_id, dm.district_id, di.total_amount_tandul_k, di.total_amount_tandul_r, di.bill_matrix_version_id_fk, dm.district_marathi, dm.std_type, dod.district_gov_order_num  FROM district_invoice di   INNER JOIN district_order dod ON dod.district_order_id = di.district_order_id AND STR_TO_DATE(dod.district_order_date,'%d/%m/%Y') BETWEEN STR_TO_DATE(?,'%d/%m/%Y') AND STR_TO_DATE(?,'%d/%m/%Y')  LEFT JOIN district_master dm ON dm.district_id = dod.district_id ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    List list1 = new ArrayList();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setString(1, fromDate);
      ps.setString(2, toDate);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          talukaInvoice = new TalukaInvoice();
          talukaInvoice.setInvoiceID(resultSet.getInt(1));
          talukaInvoice.setInvoiceIDMan1(resultSet.getInt(2));
          talukaInvoice.setInvoiceIDMan2(resultSet.getInt(3));
          talukaInvoice.setInvoiceDate(resultSet.getString(4));
          talukaInvoice.setOrderID(resultSet.getInt(5));
          talukaInvoice.setDistrictID(resultSet.getInt(6));
          talukaInvoice.setTotalAmount1(resultSet.getDouble(7));
          talukaInvoice.setTotalAmount2(resultSet.getDouble(8));
          talukaInvoice.setVersion(resultSet.getInt(9));
          talukaInvoice.setDistrictMarathi(resultSet.getString(10));
          talukaInvoice.setStdType(resultSet.getInt(11));
          if (resultSet.getInt(11) == 1) {
            talukaInvoice.setStdTypeDetails("१ ली ते ५ वी");
          } else
            talukaInvoice.setStdTypeDetails("६ वी ते ८ वी");
          talukaInvoice.setDistrictOrderNo(resultSet.getString(12));
          list1.add(talukaInvoice);
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
    return list1;
  }
  
  public int deleteTalukaInvoice(int invoiceID) throws SQLException
  {
    int key = 0;
    String s = " delete from taluka_invoice where invoice_id = ? ";
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(s);
      ps.setInt(1, invoiceID);
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
  
  public int deleteDistrictInvoice(int invoiceID) throws SQLException
  {
    int key = 0;
    String s = " delete from district_invoice where dist_invoice_id = ? ";
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(s);
      ps.setInt(1, invoiceID);
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
  
  public TalukaInvoice readDistrictRiceSalesInvoice(int invoiceId) throws SQLException
  {
    TalukaInvoice talukaInvoice = new TalukaInvoice();
    String sql = " SELECT dsi.disrict_sales_invoice_id, dsi.disrict_sales_invoice_date, dsi.district_order_id_1to5, dsi.district_order_id_6to8, dsi.invoice_no_tandul, dsi.weight_1to5, dsi.weight_6to8, dsi.invoice_amount_tandul, dsi.bill_matrix_version, dm.district_marathi,dsi.invoice_no_ration_nontaxable,dsi.invoice_no_ration_taxable  FROM district_sales_invoice dsi  INNER JOIN district_order dos ON dos.district_order_id = dsi.district_order_id_1to5 OR dos.district_order_id = dsi.district_order_id_6to8  INNER JOIN district_master dm ON dm.district_id = dos.district_id  WHERE dsi.disrict_sales_invoice_id = ?  GROUP BY dsi.disrict_sales_invoice_id ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, invoiceId);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        if (resultSet.next())
        {
          talukaInvoice.setInvoiceID(resultSet.getInt(1));
          talukaInvoice.setInvoiceDate(resultSet.getString(2));
          talukaInvoice.setOrderID(resultSet.getInt(3));
          talukaInvoice.setOrderID1(resultSet.getInt(4));
          talukaInvoice.setInvoiceIDMan(resultSet.getInt(5));
          talukaInvoice.setWeight(resultSet.getDouble(6));
          talukaInvoice.setWeight1(resultSet.getDouble(7));
          talukaInvoice.setTotalAmount1(resultSet.getDouble(8));
          talukaInvoice.setVersion(resultSet.getInt(9));
          talukaInvoice.setDistrictMarathi(resultSet.getString(10));
          talukaInvoice.setInvoiceIDMan1(resultSet.getInt(11));
          talukaInvoice.setInvoiceIDMan2(resultSet.getInt(12));
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
    return talukaInvoice;
  }
  
  public List<TalukaInvoice> readAllDistrictRiceSalesInvoice(String fromDate, String toDate) throws SQLException
  {
    List l1 = new ArrayList();
    TalukaInvoice talukaInvoice = null;
    String sql = " SELECT dsi.disrict_sales_invoice_id, dsi.disrict_sales_invoice_date, dsi.district_order_id_1to5, dsi.district_order_id_6to8, dsi.invoice_no_tandul, dsi.weight_1to5, dsi.weight_6to8, dsi.invoice_amount_tandul, dsi.bill_matrix_version, dm.district_marathi,dsi.invoice_no_ration_nontaxable,dsi.invoice_no_ration_taxable,dsi.invoice_amount_ration_nontaxable,dsi.invoice_amount_ration_taxable,get_district_order_details(dsi.district_order_id_1to5),get_district_order_details(dsi.district_order_id_6to8)  FROM district_sales_invoice dsi  INNER JOIN district_order dos ON dos.district_order_id = dsi.district_order_id_1to5 OR dos.district_order_id = dsi.district_order_id_6to8  INNER JOIN district_master dm ON dm.district_id = dos.district_id  WHERE dsi.invoice_no_tandul <> 0  AND STR_TO_DATE(dsi.disrict_sales_invoice_date,'%d/%m/%Y') BETWEEN STR_TO_DATE(?,'%d/%m/%Y') AND STR_TO_DATE(?,'%d/%m/%Y')  GROUP BY dsi.disrict_sales_invoice_id ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setString(1, fromDate);
      ps.setString(2, toDate);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          talukaInvoice = new TalukaInvoice();
          talukaInvoice.setInvoiceID(resultSet.getInt(1));
          talukaInvoice.setInvoiceDate(resultSet.getString(2));
          talukaInvoice.setOrderID(resultSet.getInt(3));
          talukaInvoice.setOrderID1(resultSet.getInt(4));
          talukaInvoice.setInvoiceIDMan(resultSet.getInt(5));
          talukaInvoice.setWeight(resultSet.getDouble(6) + resultSet.getDouble(7));
          talukaInvoice.setTotalAmount(resultSet.getDouble(8));
          talukaInvoice.setVersion(resultSet.getInt(9));
          talukaInvoice.setDistrictMarathi(resultSet.getString(10));
          talukaInvoice.setInvoiceIDMan1(resultSet.getInt(11));
          talukaInvoice.setInvoiceIDMan2(resultSet.getInt(12));
          talukaInvoice.setTotalAmount1(resultSet.getDouble(13));
          talukaInvoice.setTotalAmount2(resultSet.getDouble(14));
          talukaInvoice.setDistOrder1to5Details(resultSet.getString(15));
          talukaInvoice.setDistOrder6to8Details(resultSet.getString(16));
          l1.add(talukaInvoice);
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
    return l1;
  }
  
  public List<TalukaInvoice> readAllDistrictRationSalesInvoice(String fromDate, String toDate) throws SQLException
  {
    List l1 = new ArrayList();
    TalukaInvoice talukaInvoice = null;
    String sql = " SELECT dsi.disrict_sales_invoice_id, dsi.disrict_sales_invoice_date, dsi.district_order_id_1to5, dsi.district_order_id_6to8, dsi.invoice_no_tandul, dsi.weight_1to5, dsi.weight_6to8, dsi.invoice_amount_tandul, dsi.bill_matrix_version, dm.district_marathi,dsi.invoice_no_ration_nontaxable,dsi.invoice_no_ration_taxable,dsi.invoice_amount_ration_nontaxable,dsi.invoice_amount_ration_taxable,get_district_order_details(dsi.district_order_id_1to5),get_district_order_details(dsi.district_order_id_6to8)  FROM district_sales_invoice dsi  INNER JOIN district_order dos ON dos.district_order_id = dsi.district_order_id_1to5 OR dos.district_order_id = dsi.district_order_id_6to8  INNER JOIN district_master dm ON dm.district_id = dos.district_id  WHERE dsi.invoice_no_tandul = 0  AND STR_TO_DATE(dsi.disrict_sales_invoice_date,'%d/%m/%Y') BETWEEN STR_TO_DATE(?,'%d/%m/%Y') AND STR_TO_DATE(?,'%d/%m/%Y')  GROUP BY dsi.disrict_sales_invoice_id ";
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setString(1, fromDate);
      ps.setString(2, toDate);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          talukaInvoice = new TalukaInvoice();
          talukaInvoice.setInvoiceID(resultSet.getInt(1));
          talukaInvoice.setInvoiceDate(resultSet.getString(2));
          talukaInvoice.setOrderID(resultSet.getInt(3));
          talukaInvoice.setOrderID1(resultSet.getInt(4));
          talukaInvoice.setInvoiceIDMan(resultSet.getInt(5));
          talukaInvoice.setWeight(resultSet.getDouble(6) + resultSet.getDouble(7));
          talukaInvoice.setTotalAmount(resultSet.getDouble(13) + resultSet.getDouble(14));
          talukaInvoice.setVersion(resultSet.getInt(9));
          talukaInvoice.setDistrictMarathi(resultSet.getString(10));
          talukaInvoice.setInvoiceIDMan1(resultSet.getInt(11));
          talukaInvoice.setInvoiceIDMan2(resultSet.getInt(12));
          talukaInvoice.setTotalAmount1(resultSet.getDouble(13));
          talukaInvoice.setTotalAmount2(resultSet.getDouble(14));
          talukaInvoice.setDistOrder1to5Details(resultSet.getString(15));
          talukaInvoice.setDistOrder6to8Details(resultSet.getString(16));
          l1.add(talukaInvoice);
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
    return l1;
  }
  
  public int deleteDistrictTandulSalesInvoice(int invoiceID) throws SQLException
  {
    int key = 0;
    String s = " delete from district_sales_invoice where disrict_sales_invoice_id = ? ";
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(s);
      ps.setInt(1, invoiceID);
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
}
