package org.spa.ds;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.spa.connect.dbConnection;
import org.spa.entity.InwardMaterialDetails;
import org.spa.query.InwardMaterialDSQuery;

public class InwardMaterialDS
{
  dbConnection dbConnection = null;
  Connection con = null;
  int key = 0;
  PreparedStatement ps = null;
  ResultSet resultSet = null;
  InwardMaterialDSQuery IMDSQ = new InwardMaterialDSQuery();
  
  public InwardMaterialDS() {}
  
  public ArrayList<InwardMaterialDetails> getAllInwardMaterialReceive(String fromDate, String toDate, int start, int limit) throws SQLException { ArrayList arr_inwardMaterial = new ArrayList();
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(IMDSQ.s1);
      ps.setString(1, fromDate);
      ps.setString(2, toDate);
      ps.setInt(3, start);
      ps.setInt(4, limit);
      System.out.println(ps);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        InwardMaterialDetails inwardMaterialDetails = new InwardMaterialDetails();
        inwardMaterialDetails.setInwardId(Integer.valueOf(resultSet.getInt(1)));
        inwardMaterialDetails.setItemId(Integer.valueOf(resultSet.getInt(2)));
        inwardMaterialDetails.setItemMarathi(resultSet.getString(3));
        inwardMaterialDetails.setSupplierId(Integer.valueOf(resultSet.getInt(4)));
        inwardMaterialDetails.setSupplierName(resultSet.getString(5));
        inwardMaterialDetails.setQtyInKG(resultSet.getDouble(6));
        inwardMaterialDetails.setInwardDate(resultSet.getNString(7));
        inwardMaterialDetails.setTruckNo(resultSet.getString(8));
        inwardMaterialDetails.setBag(Integer.valueOf(resultSet.getInt(9)));
        arr_inwardMaterial.add(inwardMaterialDetails);
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
    return arr_inwardMaterial;
  }
  
  public int addInwardMaterial(InwardMaterialDetails inwardMaterialDetails)
    throws SQLException
  {
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(IMDSQ.i1);
      ps.setInt(1, inwardMaterialDetails.getItemId().intValue());
      ps.setInt(2, inwardMaterialDetails.getSupplierId().intValue());
      ps.setString(3, inwardMaterialDetails.getInwardDate());
      ps.setDouble(4, inwardMaterialDetails.getQtyInKG());
      ps.setString(5, inwardMaterialDetails.getTruckNo());
      ps.setInt(6, inwardMaterialDetails.getBag().intValue());
      
      key = ps.executeUpdate();
      System.out.println("key = " + key);
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
  
  public int updateInwardMaster(InwardMaterialDetails inwardMaterialDetails)
    throws SQLException
  {
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(IMDSQ.u1);
      ps.setDouble(1, inwardMaterialDetails.getQtyInKG());
      ps.setString(2, inwardMaterialDetails.getInwardDate());
      ps.setString(3, inwardMaterialDetails.getTruckNo());
      ps.setInt(4, inwardMaterialDetails.getBag().intValue());
      ps.setInt(5, inwardMaterialDetails.getInwardId().intValue());
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
  
  public int deleteInward(InwardMaterialDetails inwardMaterialDetails)
    throws SQLException
  {
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(IMDSQ.d1);
      ps.setInt(1, inwardMaterialDetails.getInwardId().intValue());
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
