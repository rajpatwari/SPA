package org.spa.query;

public class StockDSQuery
{
  public String select1 = " SELECT stock_diff_id,stock_diff_date,stock_diff_type,mungdaal,matki,mung,masuldaal,chvli,tel,mith,mirchi,halad,jire,mohari,tandul,harbara,vatana,extra1,extra2,extra3,extra4,extra5,extra6 FROM stock_diff_details ";

  public String select2 = " SELECT IFNULL(SUM(mungdaal),0) , IFNULL(SUM(matki),0) , IFNULL(SUM(mung),0) , IFNULL(SUM(masuldaal),0) , IFNULL(SUM(chvli),0) , IFNULL(SUM(tel),0) , IFNULL(SUM(mith),0) , IFNULL(SUM(mirchi),0) , IFNULL(SUM(halad),0) , IFNULL(SUM(jire),0) , IFNULL(SUM(mohari),0) , IFNULL(SUM(tandul),0) , IFNULL(SUM(harbara),0) , IFNULL(SUM(vatana),0) , IFNULL(SUM(extra1),0) , IFNULL(SUM(extra2),0) , IFNULL(SUM(extra3),0) , IFNULL(SUM(extra4),0) , IFNULL(SUM(extra5),0) , IFNULL(SUM(extra6),0)  FROM stock_diff_details tod WHERE stock_diff_type = ? ";

  public String select3 = " SELECT im.item_id,im.item_name_marathi, IFNULL(SUM(inm.qty_in_kg),0)  FROM item_master im  LEFT JOIN inward_master inm ON inm.item_id_fk = im.item_id  GROUP BY im.item_id ";
  
  public String select4 = " SELECT IFNULL(SUM(mungdaal),0) , IFNULL(SUM(matki),0) , IFNULL(SUM(mung),0) , IFNULL(SUM(masuldaal),0) , IFNULL(SUM(chvli),0) , IFNULL(SUM(tel),0) , IFNULL(SUM(mith),0) , IFNULL(SUM(mirchi),0) , IFNULL(SUM(halad),0) , IFNULL(SUM(jire),0) , IFNULL(SUM(mohari),0) , IFNULL(SUM(tandul),0) , IFNULL(SUM(harbara),0) , IFNULL(SUM(vatana),0) , IFNULL(SUM(extra1),0) , IFNULL(SUM(extra2),0) , IFNULL(SUM(extra3),0) , IFNULL(SUM(extra4),0) , IFNULL(SUM(extra5),0) , IFNULL(SUM(extra6),0) FROM taluka_return_details ";

  public String select5 = " SELECT stock_diff_id,stock_diff_date,stock_diff_type,mungdaal,matki,mung,masuldaal,chvli,tel,mith,mirchi,halad,jire,mohari,tandul,harbara,vatana,extra1,extra2,extra3,extra4,extra5,extra6  FROM stock_diff_details  WHERE STR_TO_DATE(`stock_diff_date`,'%d/%m/%Y') BETWEEN STR_TO_DATE(?,'%d/%m/%Y') AND STR_TO_DATE(?,'%d/%m/%Y')  AND stock_diff_type = ? ";

  public String select6 = " SELECT IFNULL(SUM(mungdaal),0) , IFNULL(SUM(matki),0) , IFNULL(SUM(mung),0) , IFNULL(SUM(masuldaal),0) , IFNULL(SUM(chvli),0) , IFNULL(SUM(tel),0) , IFNULL(SUM(mith),0) , IFNULL(SUM(mirchi),0) , IFNULL(SUM(halad),0) , IFNULL(SUM(jire),0) , IFNULL(SUM(mohari),0) , IFNULL(SUM(tandul),0) , IFNULL(SUM(harbara),0) , IFNULL(SUM(vatana),0) , IFNULL(SUM(extra1),0) , IFNULL(SUM(extra2),0) , IFNULL(SUM(extra3),0) , IFNULL(SUM(extra4),0) , IFNULL(SUM(extra5),0) , IFNULL(SUM(extra6),0)  FROM stock_diff_details tod WHERE stock_diff_type = ? AND STR_TO_DATE(stock_diff_date,'%d/%m/%Y') <= STR_TO_DATE(?,'%d/%m/%Y') ";

  public String select7 = " SELECT IFNULL(SUM(mungdaal),0) , IFNULL(SUM(matki),0) , IFNULL(SUM(mung),0) , IFNULL(SUM(masuldaal),0) , IFNULL(SUM(chvli),0) , IFNULL(SUM(tel),0) , IFNULL(SUM(mith),0) , IFNULL(SUM(mirchi),0) , IFNULL(SUM(halad),0) , IFNULL(SUM(jire),0) , IFNULL(SUM(mohari),0) , IFNULL(SUM(tandul),0) , IFNULL(SUM(harbara),0) , IFNULL(SUM(vatana),0) , IFNULL(SUM(extra1),0) , IFNULL(SUM(extra2),0) , IFNULL(SUM(extra3),0) , IFNULL(SUM(extra4),0) , IFNULL(SUM(extra5),0) , IFNULL(SUM(extra6),0)  FROM taluka_return_details WHERE STR_TO_DATE(created_on,'%d/%m/%Y') <= STR_TO_DATE(?,'%d/%m/%Y') ";

  public String select8 = " SELECT im.item_id,im.item_name_marathi, IFNULL(SUM(inm.qty_in_kg),0)  FROM item_master im  LEFT JOIN inward_master inm ON inm.item_id_fk = im.item_id AND STR_TO_DATE(inm.inward_date,'%d/%m/%Y') <= STR_TO_DATE(?,'%d/%m/%Y')  GROUP BY im.item_id ";
  
  public String insert1 = " INSERT INTO stock_diff_details(stock_diff_id,stock_diff_date,stock_diff_type,mungdaal,matki,mung,masuldaal,chvli,tel,mith,mirchi,halad,jire,mohari,tandul,harbara,vatana,extra1,extra2,extra3,extra4,extra5,extra6)  VALUE (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";

  public String update1 = " UPDATE stock_diff_details SET stock_diff_date=?,stock_diff_type=?,mungdaal=?,matki=?,mung=?,masuldaal=?,chvli=?,tel=?,mith=?,mirchi=?,halad=?,jire=?,mohari=?,tandul=?,harbara=?,vatana=?,extra1=?,extra2=?,extra3=?,extra4=?,extra5=?,extra6=? WHERE stock_diff_id = ? ";

  public String delete1 = " DELETE FROM stock_diff_details WHERE stock_diff_id = ? ";
  
  public StockDSQuery() {}
}
