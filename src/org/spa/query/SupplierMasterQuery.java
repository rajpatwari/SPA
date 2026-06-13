package org.spa.query;

public class SupplierMasterQuery
{
  public String s1 = " SELECT s.supplier_id,s.supplier_name,s.supplier_address,s.supplier_number,s.tin,s.cst FROM supplier_master s";
  
  public String s2 = "select count(*) from supplier_master where (supplier_name=?) ";
  
  public String s3 = "select count(*) from supplier_master where (supplier_name=?) and supplier_id<>? ";
  
  public String i1 = "INSERT INTO supplier_master VALUES (null,?,?,?,?,?,DATE_FORMAT(curdate(),'%d/%m/%Y'))";
  
  public String u1 = "UPDATE supplier_master set supplier_name=?,supplier_address=?,supplier_number=?,tin=?,cst=? where supplier_id = ?";
  
  public String d1 = "DELETE FROM supplier_master where supplier_id = ?";
  
  public SupplierMasterQuery() {}
}
