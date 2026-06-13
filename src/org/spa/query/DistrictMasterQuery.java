package org.spa.query;

public class DistrictMasterQuery
{
  public String s1 = "SELECT district_id, district_english, district_marathi, std_type from district_master";
  
  public String s2 = "SELECT tm.taluka_id, tm.district_id_fk, tm.taluka_english, tm.taluka_marathi, dm.district_marathi FROM taluka_master tm, district_master dm WHERE tm.district_id_fk=? AND dm.district_id = tm.district_id_fk ";
  
  public String s3 = "SELECT sm.section_id,sm.taluka_id_fk, sm.section_english, sm.section_marathi, tm.taluka_marathi, dm.district_marathi, dm.district_id, sm.beat_flag  FROM section_master sm, taluka_master tm, district_master dm WHERE sm.taluka_id_fk=? AND tm.taluka_id = sm.taluka_id_fk AND dm.district_id = tm.district_id_fk ";
  
  public String s4 = "SELECT bm.beat_id,sm.section_id, bm.beat_english, bm.beat_marathi,sm.section_marathi, tm.taluka_marathi, dm.district_marathi , dm.district_id, tm.taluka_id FROM beat_master bm, section_master sm, taluka_master tm, district_master dm WHERE bm.section_id=? AND sm.section_id = bm.section_id AND tm.taluka_id = sm.taluka_id_fk AND dm.district_id = tm.district_id_fk ";
  
  public String s5 = " SELECT scm.school_id,scm.beat_id_fk, scm.school_english, scm.school_marathi,bm.beat_marathi,sm.section_marathi, tm.taluka_marathi, dm.district_marathi , dm.district_id, tm.taluka_id ,sm.section_id FROM school_master scm,beat_master bm, section_master sm, taluka_master tm, district_master dm  WHERE scm.beat_id_fk = ? AND bm.beat_id = scm.beat_id_fk AND sm.section_id = bm.section_id AND tm.taluka_id = sm.taluka_id_fk AND dm.district_id = tm.district_id_fk ";
  
  public String s6 = " select count(*) from district_master  where (district_english=? or district_marathi=?) and std_type = ? ";
  
  public String s7 = " SELECT COUNT(*) FROM district_master  WHERE (district_english=? OR district_marathi=?) AND std_type = ? AND district_id<>? ";
  
  public String s8 = " select count(*) from taluka_master where (taluka_english=? or taluka_marathi=?) and district_id_fk = ? ";
  
  public String s9 = " SELECT COUNT(*) FROM taluka_master WHERE (taluka_english = ? OR taluka_marathi = ? ) AND taluka_id = ? AND district_id_fk = ?";
  
  public String s10 = " select count(*) from section_master where (section_english=? or section_marathi=?) and taluka_id_fk = ?";
  
  public String s11 = " select count(*) from section_master where (section_english=? or section_marathi=?)  and section_id<>? ";
  
  public String s12 = " SELECT COUNT(*) FROM beat_master WHERE (beat_english=? OR beat_marathi=?) AND section_id = ? ";
  
  public String s13 = " SELECT COUNT(*) FROM beat_master WHERE (beat_english=? OR beat_marathi=?)  AND beat_id<>? ";
  
  public String s14 = " SELECT COUNT(*) FROM school_master scm, section_master sm, taluka_master tm, district_master dm , beat_master bm WHERE (scm.school_english=? OR scm.school_marathi=?) AND scm.beat_id_fk = bm.beat_id AND bm.section_id = sm.section_id AND sm.taluka_id_fk = tm.taluka_id AND tm.district_id_fk = dm.district_id AND scm.beat_id_fk = ? ";
  
  public String s15 = " SELECT COUNT(*) FROM school_master scm, section_master sm, taluka_master tm, district_master dm , beat_master bm WHERE (scm.school_english=? OR scm.school_marathi=?) AND scm.beat_id_fk = bm.beat_id AND bm.section_id = sm.section_id AND sm.taluka_id_fk = tm.taluka_id AND tm.district_id_fk = dm.district_id  and school_id<>?";
  
  public String s16 = " SELECT scm.school_english, scm.school_marathi FROM school_master scm WHERE scm.school_id = ? ";
  
  public String s17 = " SELECT scm.school_english, scm.school_marathi FROM school_master scm WHERE scm.beat_id_fk = ? ";
  
  public String s18 = " SELECT section_id, taluka_id_fk, section_english, section_marathi FROM section_master WHERE section_id =? ";
  
  public String s19 = " SELECT beat_id, section_id, beat_english, beat_marathi FROM beat_master WHERE beat_id = ? ";
  
  public String i1 = "INSERT INTO district_master VALUES (null,?,?,?)";
  
  public String i2 = "INSERT INTO taluka_master VALUES (null,?,?,?)";
  
  public String i3 = "INSERT INTO section_master VALUES (null,?,?,?,?)";
  
  public String i4 = "INSERT INTO beat_master VALUES (null,?,?,?)";
  
  public String i5 = "INSERT INTO school_master VALUES (null,?,?,?)";
  
  public String u1 = " update district_master set district_english = ?, district_marathi = ? where district_id=? ";
  
  public String u2 = " update taluka_master set taluka_english = ?, taluka_marathi = ? where taluka_id=? ";
  
  public String u3 = " update section_master set section_english = ?, section_marathi = ?, beat_flag = ? where section_id=? ";
  
  public String u4 = " UPDATE beat_master SET beat_english = ?, beat_marathi = ? WHERE beat_id=? ";
  
  public String u5 = "update school_master set school_english = ?, school_marathi = ? where school_id=?";
  
  public String d1 = " delete from district_master where district_id=? ";
  
  public String d2 = " delete from taluka_master where taluka_id=? ";
  
  public String d3 = " delete from section_master where section_id=? ";
  
  public String d4 = " DELETE FROM beat_master WHERE beat_id=? ";
  
  public String d5 = "delete from school_master where school_id=?";
  
  public String d6 = " DELETE FROM school_master WHERE beat_id_fk = ? ";
  
  public String m1 = "update taluka_master set district_id_fk = ? where taluka_id= ?  ";
  
  public String m2 = "update section_master set taluka_id_fk = ? where section_id=?";
  
  public String m3 = " UPDATE beat_master SET section_id = ? WHERE beat_id=? ";
  
  public String m4 = " UPDATE school_master SET beat_id_fk = ? WHERE school_id = ? ";
  
  public DistrictMasterQuery() {}
}
