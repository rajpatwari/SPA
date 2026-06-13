package org.spa.query;

public class DistrictOrderDSQuery
{
  public String s1 = " SELECT dor.district_order_id, m.district_marathi, dor.district_gov_order_num, dor.district_order_date, dor.order_number, dor.creation_date, m.district_id, m.`std_type`  FROM district_order dor  INNER JOIN `district_master` m ON m.district_id = dor.district_id AND dor.`deleted`=0  WHERE STR_TO_DATE(dor.district_order_date,'%d/%m/%Y') BETWEEN STR_TO_DATE(?,'%d/%m/%Y') AND STR_TO_DATE(?,'%d/%m/%Y')  GROUP BY dor.`district_order_id` ASC  LIMIT ?,? ";
  
  public String s2 = " SELECT dor.district_order_id, m.district_marathi, dor.district_gov_order_num, dor.district_order_date, dor.order_number, dor.creation_date, m.district_id, m.`std_type`  FROM district_order dor  INNER JOIN `district_master` m ON m.district_id = dor.district_id   WHERE dor.`district_order_id` = ? ";
  
  public String select4 = " SELECT tm.taluka_id, tm.taluka_marathi,t.taluka_order_id, SUM(IFNULL(tod.mungdaal,0)),SUM(IFNULL(tod.matki,0)),SUM(IFNULL(tod.mung,0)),SUM(IFNULL(tod.masuldaal,0)), SUM(IFNULL(tod.chvli,0)),SUM(IFNULL(tod.tel,0)),SUM(IFNULL(tod.mith,0)),SUM(IFNULL(tod.mirchi,0)), SUM(IFNULL(tod.halad,0)),SUM(IFNULL(tod.jire,0)),SUM(IFNULL(tod.mohari,0)),SUM(IFNULL(tod.tandul,0)),t.order_type,SUM(IFNULL(tod.harbara,0)),SUM(IFNULL(tod.vatana,0)),SUM(IFNULL(tod.extra1,0)),SUM(IFNULL(tod.extra2,0)),SUM(IFNULL(tod.extra3,0)),SUM(IFNULL(tod.extra4,0)),SUM(IFNULL(tod.extra5,0)),SUM(IFNULL(tod.extra6,0))  FROM taluka_order_details tod  INNER JOIN taluka_order t ON t.taluka_order_id = tod.taluka_order_id  INNER JOIN taluka_master tm ON tm.taluka_id = t.taluka_id  WHERE t.district_order_id = ?  GROUP BY tod.taluka_order_id ";

  public String select5 = " SELECT tm.taluka_marathi,sm.school_marathi,cm.challan_number,cm.challan_date,t.order_type ,IFNULL(tod.mungdaal,0),IFNULL(tod.matki,0),IFNULL(tod.mung,0),IFNULL(tod.masuldaal,0),IFNULL(tod.chvli,0),IFNULL(tod.tel,0),IFNULL(tod.mith,0),IFNULL(tod.mirchi,0),IFNULL(tod.halad,0),IFNULL(tod.jire,0),IFNULL(tod.mohari,0),IFNULL(tod.tandul,0),IFNULL(tod.harbara,0),IFNULL(tod.vatana,0),IFNULL(tod.extra1,0),IFNULL(tod.extra2,0),IFNULL(tod.extra3,0),IFNULL(tod.extra4,0),IFNULL(tod.extra5,0),IFNULL(tod.extra6,0)  FROM taluka_order_details tod  INNER JOIN taluka_order t ON t.taluka_order_id = tod.taluka_order_id   INNER JOIN taluka_master tm ON tm.taluka_id = t.taluka_id  INNER JOIN school_master sm ON sm.school_id = tod.school_id  INNER JOIN challan_master cm ON cm.challan_master_id = tod.challan_master_id  WHERE STR_TO_DATE(tod.challan_date,'%d/%m/%Y') BETWEEN STR_TO_DATE(?,'%d/%m/%Y') AND STR_TO_DATE(?,'%d/%m/%Y') ";

  public String i1 = "INSERT INTO district_order VALUES (null,?,?,?,?, curdate(),0)";
  
  public String u1 = "UPDATE district_order SET district_order_date=?,order_number=?,district_gov_order_num=? where district_order_id=?";
  
  public String u2 = "UPDATE district_order SET deleted = 1 where district_order_id = ?";
  
  public DistrictOrderDSQuery() {}
}
