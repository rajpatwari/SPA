package org.spa.connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbConnection
{
  static Connection conn = null;
  
  static
  {
    try
    {
      String userName = "root";
      String password = "";
      String url = "jdbc:mysql://localhost:3306/spa_20_items?useEncoding=true&characterEncoding=UTF-8";
      Class.forName("com.mysql.jdbc.Driver").newInstance();
      
      conn = DriverManager.getConnection(url, userName, password);
    }
    catch (Exception ex)
    {
      System.err.print(ex);
    }
  }
  
  public dbConnection() {}
  
  public Connection getConnection() throws SQLException {
    return conn;
  }
}
