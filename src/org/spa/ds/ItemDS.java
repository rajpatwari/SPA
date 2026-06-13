package org.spa.ds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.spa.connect.dbConnection;
import org.spa.entity.Item;

public class ItemDS
{
  dbConnection dbConnection = null;
  Connection con = null;
  int key = 0;
  PreparedStatement ps = null;
  ResultSet resultSet = null;
  
  public ItemDS() {}
  
  public ArrayList<Item> getAllItem() throws SQLException {
    ArrayList arr_item = new ArrayList();
    Item item = null;
    String sql = "SELECT i.item_id,i.item_name_english,i.item_name_marathi,i.rate_per_kg FROM item_master i";
    dbConnection dbConnection = new dbConnection();
    Connection con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      resultSet = ps.executeQuery();
      while (resultSet.next())
      {
        item = new Item();
        item.setItemId(resultSet.getInt(1));
        item.setItemEnglish(resultSet.getString(2));
        item.setItemMarathi(resultSet.getString(3));
        item.setRatePerKg(resultSet.getDouble(4));
        arr_item.add(item);
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
    return arr_item;
  }
}
