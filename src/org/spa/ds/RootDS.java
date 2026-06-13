package org.spa.ds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.spa.connect.dbConnection;
import org.spa.entity.Root;
import org.spa.entity.School;
import org.spa.query.RootDSQuery;

public class RootDS
{
  dbConnection dbConnection = null;
  Connection con = null;
  int key = 0;
  PreparedStatement ps = null;
  ResultSet resultSet = null;
  RootDSQuery rdsq = new RootDSQuery();
  
  public RootDS() {}
  
  public ArrayList<Root> getAllRoot() throws SQLException {
    ArrayList arr_Root = new ArrayList();
    Root root = null;
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(rdsq.select1);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        root = new Root();
        root.setRootMasterID(Integer.valueOf(resultSet.getInt(1)));
        root.setRoot(resultSet.getString(2));
        root.setRootMarathi(resultSet.getString(3));
        arr_Root.add(root);
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
    return arr_Root;
  }
  
  public int getRootDups(Root root)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      if (root.getRootMasterID().intValue() == 0)
      {
        ps = con.prepareStatement(rdsq.dub1);
      }
      else
      {
        ps = con.prepareStatement(rdsq.dub2);
        ps.setInt(3, root.getRootMasterID().intValue());
      }
      ps.setString(1, root.getRoot());
      ps.setString(2, root.getRootMarathi());
      resultSet = ps.executeQuery();
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
      resultSet.close();
      ps.close();
    }
    return key;
  }
  
  public int createRoot(Root root)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(rdsq.insert1);
      ps.setString(1, root.getRoot());
      ps.setString(2, root.getRootMarathi());
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
  
  public int updateRoot(Root root)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(rdsq.update1);
      ps.setString(1, root.getRoot());
      ps.setString(2, root.getRootMarathi());
      ps.setInt(3, root.getRootMasterID().intValue());
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
  
  public int deleteRoot(int rootMasterID)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(rdsq.delete1);
      ps.setInt(1, rootMasterID);
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
  
  public ArrayList<School> getAllSchoolNotAddedOnRoot(int beatID)
    throws SQLException
  {
    ArrayList arr_Root = new ArrayList();
    School school = null;
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(rdsq.select2);
      ps.setInt(1, beatID);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        school = new School();
        school.setSchoolID(resultSet.getInt(1));
        school.setSchool(resultSet.getString(2));
        school.setSchoolMarathi(resultSet.getString(3));
        arr_Root.add(school);
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
    return arr_Root;
  }
  
  public ArrayList<Root> getAllSchoolByRoot(int rootMasterID)
    throws SQLException
  {
    ArrayList arr_Root = new ArrayList();
    Root root = null;
    
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(rdsq.select3);
      ps.setInt(1, rootMasterID);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        root = new Root();
        root.setRootDetailsID(Integer.valueOf(resultSet.getInt(1)));
        root.setSchoolID(Integer.valueOf(resultSet.getInt(2)));
        root.setSchoolMarathi(resultSet.getString(3));
        arr_Root.add(root);
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
    return arr_Root;
  }
  
  public int createSchoolToRoot(Root root)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(rdsq.insert2);
      ps.setInt(1, root.getRootMasterID().intValue());
      ps.setInt(2, root.getSchoolID().intValue());
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
  
  public int deleteSchoolFromRoot(int rootDetailsID)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(rdsq.delete2);
      ps.setInt(1, rootDetailsID);
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
