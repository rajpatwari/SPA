package org.spa.query;

public class RootDSQuery
{
  public String select1 = " SELECT ROOT_MASTER_ID,ROOT,ROOT_MARATHI FROM root_master ";
  
  public String select2 = " SELECT sm.school_id,sm.school_english,sm.school_marathi FROM  school_master sm WHERE sm.beat_id_fk = ? AND sm.school_id NOT IN (SELECT rd.FK_SCHOOL_ID FROM root_details rd) ";
  
  public String select3 = " SELECT rd.ROOT_DETAILS_ID,sm.school_id,sm.school_marathi   FROM root_details rd   INNER JOIN school_master sm ON sm.school_id = rd.FK_SCHOOL_ID  WHERE rd.FK_ROOT_MASTER_ID = ? ";
  
  public String dub1 = " SELECT COUNT(*) FROM root_master WHERE ROOT = ? AND ROOT_MARATHI = ? ";
  
  public String dub2 = " SELECT COUNT(*) FROM root_master WHERE ROOT = ? AND ROOT_MARATHI = ? AND ROOT_MASTER_ID <> ? ";
  
  public String insert1 = " INSERT INTO root_master(ROOT_MASTER_ID,ROOT,ROOT_MARATHI) VALUE(NULL,?,?) ";
  
  public String insert2 = " INSERT INTO root_details(ROOT_DETAILS_ID,FK_ROOT_MASTER_ID,FK_SCHOOL_ID) VALUE(NULL,?,?) ";
  
  public String update1 = " UPDATE root_master SET ROOT = ?, ROOT_MARATHI = ? WHERE ROOT_MASTER_ID = ? ";
  
  public String delete1 = " DELETE FROM root_master WHERE ROOT_MASTER_ID = ? ";
  
  public String delete2 = " DELETE FROM root_details WHERE ROOT_DETAILS_ID = ? ";
  
  public RootDSQuery() {}
}
