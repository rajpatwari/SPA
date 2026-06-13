package org.spa.ds;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.spa.connect.dbConnection;
import org.spa.entity.Supplier;
import org.spa.query.SupplierMasterQuery;

public class SupplierMaster
{
  dbConnection dbCon;
  Connection con;
  PreparedStatement ps = null;
  ResultSet resultSet = null;
  int key = 0;
  SupplierMasterQuery SMQ = new SupplierMasterQuery();
  
  public SupplierMaster() {}
  
  public ArrayList<Supplier> getAllSupplier() throws SQLException {
    ArrayList arr_supplier = new ArrayList();
    Supplier supplier = null;
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(SMQ.s1);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        supplier = new Supplier();
        supplier.setSupplierID(resultSet.getInt(1));
        supplier.setSupplierName(resultSet.getString(2));
        supplier.setSupplierAddress(resultSet.getString(3));
        supplier.setContactNum(resultSet.getString(4));
        supplier.setTin(resultSet.getString(5));
        supplier.setCst(resultSet.getString(6));
        arr_supplier.add(supplier);
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
    return arr_supplier;
  }
  
  public int getSupplierDups(Supplier supplier)
    throws SQLException
  {
    int supplierID = supplier.getSupplierID();
    int count = 0;
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    if (con == null)
    {
      System.out.println("connection fails");
    }
    try
    {
      if (supplierID == 0)
      {
        ps = con.prepareStatement(SMQ.s2);
      }
      else
      {
        ps = con.prepareStatement(SMQ.s3);
      }
      ps.setString(1, supplier.getSupplierName());
      if (supplierID != 0)
      {
        ps.setInt(2, supplierID);
      }
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        count = resultSet.getInt(1);
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
    return count;
  }
  
  public int addSupplierMaster(Supplier supplier)
    throws SQLException
  {
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(SMQ.i1);
      ps.setString(1, supplier.getSupplierName());
      ps.setString(2, supplier.getSupplierAddress());
      ps.setString(3, supplier.getContactNum());
      ps.setString(4, supplier.getTin());
      ps.setString(5, supplier.getCst());
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
  
  public int updateSupplierMaster(Supplier supplier)
    throws SQLException
  {
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(SMQ.u1);
      ps.setString(1, supplier.getSupplierName());
      ps.setString(2, supplier.getSupplierAddress());
      ps.setString(3, supplier.getContactNum());
      ps.setString(4, supplier.getTin());
      ps.setString(5, supplier.getCst());
      ps.setInt(6, supplier.getSupplierID());
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
  
  public int deleteSupplierMaster(Supplier supplier)
    throws SQLException
  {
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(SMQ.d1);
      ps.setInt(1, supplier.getSupplierID());
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
