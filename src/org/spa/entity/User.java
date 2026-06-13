package org.spa.entity;

public class User {
  int userID;
  String loginID;
  String password;
  String firstName;
  String lastName;
  
  public User() {}
  
  public String getFirstName() {
    return firstName;
  }
  
  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }
  
  public String getLastName() {
    return lastName;
  }
  
  public void setLastName(String lastName) {
    this.lastName = lastName;
  }
  
  public String getLoginID() {
    return loginID;
  }
  
  public void setLoginID(String loginID) {
    this.loginID = loginID;
  }
  
  public String getPassword() {
    return password;
  }
  
  public void setPassword(String password) {
    this.password = password;
  }
  
  public int getUserID() {
    return userID;
  }
  
  public void setUserID(int userID) {
    this.userID = userID;
  }
}
