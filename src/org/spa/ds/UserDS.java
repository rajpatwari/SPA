package org.spa.ds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.spa.connect.dbConnection;
import org.spa.entity.User;

public class UserDS
{
  dbConnection dbCon;
  Connection con;
  PreparedStatement ps = null;
  ResultSet resultSet = null;
  
  public UserDS() {}
  
  public User getUser(String userId, String password) throws SQLException { User user = null;
    String sql = " SELECT user_id,login_id,password, first_name,last_name  FROM user  WHERE login_id=? and password=? ";
    
    dbCon = new dbConnection();
    con = dbCon.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setString(1, userId);
      ps.setString(2, password);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        user = new User();
        user.setUserID(resultSet.getInt(1));
        user.setLoginID(resultSet.getString(2));
        user.setPassword(resultSet.getString(3));
        user.setFirstName(resultSet.getString(4));
        user.setLastName(resultSet.getString(5));
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
    return user;
  }
}
