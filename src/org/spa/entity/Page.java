package org.spa.entity;

import java.util.List;

public class Page
{
  private List<?> root;
  private int totalElements;
  
  public List<?> getRoot()
  {
    return root;
  }
  
  public void setRoot(List<?> root) {
    this.root = root;
  }
  
  public int getTotalElements() {
    return totalElements;
  }
  
  public void setTotalElements(int totalElements) {
    this.totalElements = totalElements;
  }
  
  public Page(List<?> root, int totalElements) {
    this.root = root;
    this.totalElements = totalElements;
  }
}
