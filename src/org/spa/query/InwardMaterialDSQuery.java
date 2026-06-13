package org.spa.query;

public class InwardMaterialDSQuery
{
  public String s1 = " SELECT im.inward_id, im.item_id_fk, itm.item_name_marathi, im.supplier_id, sm.supplier_name, im.qty_in_kg, im.inward_date, im.truck_no, im.bag FROM inward_master im, supplier_master sm, item_master itm WHERE im.item_id_fk = itm.item_id AND im.supplier_id = sm.supplier_id AND STR_TO_DATE(im.inward_date, '%m/%d/%Y')  BETWEEN STR_TO_DATE(?, '%d/%m/%Y') AND STR_TO_DATE(?, '%d/%m/%Y') LIMIT ?,? ";
  
  public String i1 = " INSERT INTO inward_master VALUES (NULL,?,?,?,?,?,?) ";
  
  public String u1 = " UPDATE inward_master SET qty_in_kg= ?, inward_date= ?, truck_no = ?, bag = ? WHERE inward_id = ? ";
  
  public String d1 = " DELETE FROM inward_master WHERE inward_id = ? ";
  
  public InwardMaterialDSQuery() {}
}
