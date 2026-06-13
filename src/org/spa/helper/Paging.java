package org.spa.helper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.spa.connect.dbConnection;
import org.spa.query.DispatchDSQuery;

public class Paging
{
  dbConnection dbConnection = null;
  Connection con = null;
  int key = 0;
  PreparedStatement ps = null; PreparedStatement ps1 = null; PreparedStatement ps2 = null;
  ResultSet resultSet = null; ResultSet resultSet1 = null; ResultSet resultSet2 = null;
  DispatchDSQuery ddsq = new DispatchDSQuery();
  
  public Paging() {}
  
  public int getTotalRowCount(String query) throws SQLException { int count = 0;
    dbConnection dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(query);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          count++;
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
    return count;
  }
}
