package org.spa.ds;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import org.spa.connect.dbConnection;
import org.spa.entity.Beat;
import org.spa.entity.District;
import org.spa.entity.School;
import org.spa.entity.Section;
import org.spa.entity.Taluka;
import org.spa.query.DistrictMasterQuery;

public class DistrictMaster
{
  dbConnection dbConnection = null;
  Connection con = null;
  int key = 0;
  PreparedStatement ps = null; PreparedStatement ps1 = null;
  ResultSet resultSet = null; ResultSet resultSet1 = null;
  DistrictMasterQuery DMQ = new DistrictMasterQuery();
  
  public DistrictMaster() {}
  
  public Vector<District> getAllDistricts() throws SQLException {
    District district = null;
    dbConnection dbConnection = new dbConnection();
    Connection c = dbConnection.getConnection();
    
    Vector<District> districts = new Vector();
    try
    {
      ps = c.prepareStatement(DMQ.s1);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          district = new District();
          district.setDistrictID(resultSet.getInt(1));
          district.setDistrict(resultSet.getString(2));
          district.setDistrictMarathi(resultSet.getString(3));
          district.setStdType(resultSet.getInt(4));
          if (resultSet.getInt(4) == 1)
          {
            district.setStdTypeDetails("STD 1 TO STD 5");
          }
          if (resultSet.getInt(4) == 2)
          {
            district.setStdTypeDetails("STD 6 TO STD 8");
          }
          district.setDistrictList(district.getDistrictMarathi() + "(" + district.getStdTypeDetails() + ")");
          districts.add(district);
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return districts;
  }
  
  public int getDistrictDups(District district)
    throws SQLException
  {
    int districtID = district.getDistrictID();
    int count = 0;
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      if (districtID == 0)
      {
        ps = con.prepareStatement(DMQ.s6);
      }
      else
      {
        ps = con.prepareStatement(DMQ.s7);
      }
      ps.setString(1, district.getDistrict());
      ps.setString(2, district.getDistrictMarathi());
      ps.setInt(3, district.getStdType());
      if (districtID != 0)
      {
        ps.setInt(4, districtID);
      }
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        count = resultSet.getInt(1);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return count;
  }
  
  public int createDistrict(District district)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.i1);
      ps.setString(1, district.getDistrict());
      ps.setString(2, district.getDistrictMarathi());
      ps.setInt(3, district.getStdType());
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int updateDistrict(District district)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.u1);
      ps.setString(1, district.getDistrict());
      ps.setString(2, district.getDistrictMarathi());
      ps.setInt(3, district.getDistrictID());
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int deleteDistricts(int[] districtIDs)
    throws SQLException
  {
    for (int districtID : districtIDs)
    {
      deleteDistrict(districtID);
    }
    return 1;
  }
  
  public int deleteDistrict(int districtID) throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      Vector<Taluka> l = getAllTalukas(districtID);
      for (Taluka t : l)
      {
        deleteTaluka(t.getTalukaID());
      }
      ps = con.prepareStatement(DMQ.d1);
      ps.setInt(1, districtID);
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public Vector<Taluka> getAllTalukas(int districtID) throws SQLException
  {
    Taluka taluka = null;
    Vector<Taluka> talukas = new Vector();
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.s2);
      ps.setInt(1, districtID);
      resultSet = ps.executeQuery();
      if (resultSet != null) {
        while (resultSet.next()) {
          taluka = new Taluka();
          taluka.setTalukaID(resultSet.getInt(1));
          taluka.setDistrictID(resultSet.getInt(2));
          taluka.setTaluka(resultSet.getString(3));
          taluka.setTalukaMarathi(resultSet.getString(4));
          taluka.setDistrictMarathi(resultSet.getString(5));
          talukas.add(taluka);
        }
      }
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    } finally {
      resultSet.close();
      ps.close();
    }
    return talukas;
  }
  
  public int getTalukaDups(Taluka taluka)
    throws SQLException
  {
    int talukaID = taluka.getTalukaID();
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      if (talukaID == 0)
      {
        ps = con.prepareStatement(DMQ.s8);
      }
      else
      {
        ps = con.prepareStatement(DMQ.s9);
      }
      ps.setString(1, taluka.getTaluka());
      ps.setString(2, taluka.getTalukaMarathi());
      if (talukaID != 0)
      {
        ps.setInt(3, talukaID);
        ps.setInt(4, taluka.getDistrictID());
      }
      else
      {
        ps.setInt(3, taluka.getDistrictID());
      }
      
      resultSet = ps.executeQuery();
      if (resultSet.next()) {
        key = resultSet.getInt(1);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return key;
  }
  
  public int createTaluka(Taluka taluka)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.i2);
      ps.setInt(1, taluka.getDistrictID());
      ps.setString(2, taluka.getTaluka());
      ps.setString(3, taluka.getTalukaMarathi());
      
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int updateTaluka(Taluka taluka)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.u2);
      ps.setString(1, taluka.getTaluka());
      ps.setString(2, taluka.getTalukaMarathi());
      ps.setInt(3, taluka.getTalukaID());
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int deleteTalukas(int[] talukaIDs)
    throws SQLException
  {
    for (int talukaID : talukaIDs)
    {
      deleteTaluka(talukaID);
    }
    return 1;
  }
  
  public int deleteTaluka(int talukaID) throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      Vector<Section> l = getAllSections(talukaID);
      for (Section s : l)
      {
        deleteSection(s.getSectionID().intValue());
      }
      ps = con.prepareStatement(DMQ.d2);
      ps.setInt(1, talukaID);
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int moveTaluka(int talukaID, int districtID) throws SQLException {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    key = 0;
    //int dub;
    try {
      int dub = getMoveTalukaDups(talukaID, districtID);
      System.out.println("Dub " + dub);
      if (dub == 0)
      {
        ps = con.prepareStatement(DMQ.m1);
        ps.setInt(1, districtID);
        ps.setInt(2, talukaID);
        key = ps.executeUpdate();
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int getMoveTalukaDups(int talukaID, int districtID)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    int dub = 0;
    try
    {
      ps = con.prepareStatement(" SELECT tm.`taluka_english`, tm.`taluka_marathi` FROM `taluka_master` tm WHERE tm.`taluka_id` = ? ");
      ps1 = con.prepareStatement(" SELECT tm.`taluka_english`, tm.`taluka_marathi` FROM `taluka_master` tm WHERE tm.`district_id_fk` = ? ");
      ps.setInt(1, talukaID);
      ps1.setInt(1, districtID);
      resultSet = ps.executeQuery();
      resultSet1 = ps1.executeQuery();
      if (resultSet.next())
      {
        while (resultSet1.next())
        {
          System.out.println(resultSet.getString(1) + " : : " + resultSet1.getString(1) + " : : " + resultSet.getString(2) + " : : " + resultSet1.getString(2) + " : : ");
          if ((resultSet.getString(1).equalsIgnoreCase(resultSet1.getString(1))) && (resultSet.getString(2).equalsIgnoreCase(resultSet1.getString(2))))
          {
            dub++;
          }
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      resultSet1.close();
      ps.close();
      ps1.close();
    }
    return dub;
  }
  
  public Vector<Section> getAllSections(int talukaID)
    throws SQLException
  {
    Section section = null;
    Vector<Section> sections = new Vector();
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.s3);
      ps.setInt(1, talukaID);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          section = new Section();
          section.setSectionID(Integer.valueOf(resultSet.getInt(1)));
          section.setTalukaID(Integer.valueOf(resultSet.getInt(2)));
          section.setSection(resultSet.getString(3));
          section.setSectionMarathi(resultSet.getString(4));
          section.setTalukaMarathi(resultSet.getString(5));
          section.setDistrictMarathi(resultSet.getString(6));
          section.setDistrictID(Integer.valueOf(resultSet.getInt(7)));
          section.setBeatFlag(Integer.valueOf(resultSet.getInt(8)));
          sections.add(section);
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return sections;
  }
  
  public int getSectionDups(Section section)
    throws SQLException
  {
    int sectionID = section.getSectionID().intValue();
    int count = 0;
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      if (sectionID == 0)
      {
        ps = con.prepareStatement(DMQ.s10);
      }
      else
      {
        ps = con.prepareStatement(DMQ.s11);
      }
      ps.setString(1, section.getSection());
      ps.setString(2, section.getSectionMarathi());
      if (sectionID != 0)
      {
        ps.setInt(3, sectionID);
      }
      else
      {
        ps.setInt(3, section.getTalukaID().intValue());
      }
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        count = resultSet.getInt(1);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return count;
  }
  
  public int createSection(Section section)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.i3);
      ps.setInt(1, section.getTalukaID().intValue());
      ps.setString(2, section.getSection());
      ps.setString(3, section.getSectionMarathi());
      ps.setInt(4, section.getBeatFlag().intValue());
      key = ps.executeUpdate();
      if (section.getBeatFlag().intValue() == 1)
      {
        resultSet = ps.getGeneratedKeys();
        if (resultSet.next())
        {
          key = resultSet.getInt(1);
        }
        Beat b = new Beat();
        b.setSectionID(key);
        b.setBeatMarathi(section.getSectionMarathi());
        b.setBeat(section.getSection());
        createBeat(b);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
      resultSet.close();
    }
    return key;
  }
  
  public int updateSection(Section section) throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.u3);
      ps.setString(1, section.getSection());
      ps.setString(2, section.getSectionMarathi());
      ps.setInt(3, section.getBeatFlag().intValue());
      ps.setInt(4, section.getSectionID().intValue());
      key = ps.executeUpdate();
      if (section.getBeatFlag().intValue() == 1)
      {
        Beat b = new Beat();
        b.setSectionID(section.getSectionID().intValue());
        b.setBeatMarathi(section.getSectionMarathi());
        b.setBeat(section.getSection());
        createBeat(b);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int deleteSections(int[] sectionIDs)
    throws SQLException
  {
    for (int sectionID : sectionIDs)
    {
      deleteSection(sectionID);
    }
    return 1;
  }
  
  public int deleteSection(int sectionID) throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      Vector<Beat> l = getAllBeats(sectionID);
      for (Beat b : l)
      {
        deleteBeat(b.getBeatID());
      }
      ps = con.prepareStatement(DMQ.d3);
      ps.setInt(1, sectionID);
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int moveSection(int sectionID, int talukaID) throws SQLException {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    key = 0;
    //int dub;
    try {
      int dub = getMoveSectionDups(sectionID, talukaID);
      if (dub == 0)
      {
        ps = con.prepareStatement(DMQ.m2);
        ps.setInt(1, talukaID);
        ps.setInt(2, sectionID);
        key = ps.executeUpdate();
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int getMoveSectionDups(int sectionID, int talukaID)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    int dub = 0;
    try
    {
      ps = con.prepareStatement(" SELECT sm.`section_english`, sm.`section_marathi` FROM `section_master` sm WHERE sm.`section_id` = ? ");
      ps1 = con.prepareStatement(" SELECT sm.`section_english`, sm.`section_marathi` FROM `section_master` sm WHERE sm.`taluka_id_fk` = ? ");
      ps.setInt(1, sectionID);
      ps1.setInt(1, talukaID);
      resultSet = ps.executeQuery();
      resultSet1 = ps1.executeQuery();
      if (resultSet.next())
      {
        while (resultSet1.next())
        {
          if ((resultSet.getString(1).equalsIgnoreCase(resultSet1.getString(1))) && (resultSet.getString(2).equalsIgnoreCase(resultSet1.getString(2))))
          {
            dub++;
          }
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      resultSet1.close();
      ps.close();
      ps1.close();
    }
    return dub;
  }
  
  public Vector<Beat> getAllBeats(int section)
    throws SQLException
  {
    Beat beat = null;
    Vector<Beat> beats = new Vector();
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.s4);
      ps.setInt(1, section);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          beat = new Beat();
          beat.setBeatID(resultSet.getInt(1));
          beat.setSectionID(resultSet.getInt(2));
          beat.setBeat(resultSet.getString(3));
          beat.setBeatMarathi(resultSet.getString(4));
          beat.setSectionMarathi(resultSet.getString(5));
          beat.setTalukaMarathi(resultSet.getString(6));
          beat.setDistrictMarathi(resultSet.getString(7));
          beat.setDistrictID(resultSet.getInt(8));
          beat.setTalukaID(resultSet.getInt(9));
          beats.add(beat);
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return beats;
  }
  
  public int getBeatDups(Beat beat)
    throws SQLException
  {
    int beatID = beat.getBeatID();
    System.out.println(beatID);
    int count = 0;
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      if (beatID == 0)
      {
        ps = con.prepareStatement(DMQ.s12);
      }
      else
      {
        ps = con.prepareStatement(DMQ.s13);
      }
      ps.setString(1, beat.getBeat());
      ps.setString(2, beat.getBeatMarathi());
      if (beatID != 0)
      {
        ps.setInt(3, beatID);
      }
      else
      {
        ps.setInt(3, beat.getSectionID());
      }
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        count = resultSet.getInt(1);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return count;
  }
  
  public int createBeat(Beat beat)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.i4);
      ps.setInt(1, beat.getSectionID());
      ps.setString(2, beat.getBeat());
      ps.setString(3, beat.getBeatMarathi());
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int updateBeat(Beat beat)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.u4);
      ps.setString(1, beat.getBeat());
      ps.setString(2, beat.getBeatMarathi());
      ps.setInt(3, beat.getBeatID());
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int deleteBeat(int[] beatIds)
    throws SQLException
  {
    for (int beatID : beatIds)
    {
      deleteBeat(beatID);
    }
    return 1;
  }
  
  public int deleteBeat(int beatID) throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      deleteSchoolOnBeat(beatID);
      ps = con.prepareStatement(DMQ.d4);
      ps.setInt(1, beatID);
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int moveBeat(int beatID, int sectionID) throws SQLException {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    key = 0;
    //int dub;
    try {
      int dub = getMoveBeatDups(beatID, sectionID);
      if (dub == 0)
      {
        ps = con.prepareStatement(DMQ.m3);
        ps.setInt(1, sectionID);
        ps.setInt(2, beatID);
        key = ps.executeUpdate();
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int getMoveBeatDups(int beatID, int sectionID)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    int dub = 0;
    try
    {
      ps = con.prepareStatement(" SELECT bm.`beat_english`, bm.`beat_marathi` FROM `beat_master` bm WHERE bm.`beat_id` = ? ");
      ps1 = con.prepareStatement(" SELECT bm.`beat_english`, bm.`beat_marathi` FROM `beat_master` bm WHERE bm.`section_id` = ? ");
      ps.setInt(1, beatID);
      ps1.setInt(1, sectionID);
      resultSet = ps.executeQuery();
      resultSet1 = ps1.executeQuery();
      if (resultSet.next())
      {
        while (resultSet1.next())
        {
          if ((resultSet.getString(1).equalsIgnoreCase(resultSet1.getString(1))) && (resultSet.getString(2).equalsIgnoreCase(resultSet1.getString(2))))
          {
            dub++;
          }
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      resultSet1.close();
      ps.close();
      ps1.close();
    }
    return dub;
  }
  
  public Vector<School> getAllSchools(int sectionID)
    throws SQLException
  {
    School school = null;
    Vector<School> schools = new Vector();
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.s5);
      ps.setInt(1, sectionID);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          school = new School();
          school.setSchoolID(resultSet.getInt(1));
          school.setBeatID(resultSet.getInt(2));
          school.setSchool(resultSet.getString(3));
          school.setSchoolMarathi(resultSet.getString(4));
          school.setBeatMarathi(resultSet.getString(5));
          school.setSectionMarathi(resultSet.getString(6));
          school.setTalikaMarathi(resultSet.getString(7));
          school.setDistrictMarathi(resultSet.getString(8));
          school.setDistrictID(resultSet.getInt(9));
          school.setTalukaID(resultSet.getInt(10));
          school.setSectionID(resultSet.getInt(11));
          schools.add(school);
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return schools;
  }
  
  public int getSchoolDups(School school)
    throws SQLException
  {
    int schoolID = school.getSchoolID();
    int count = 0;
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      if (schoolID == 0)
      {
        ps = con.prepareStatement(DMQ.s14);
      }
      else
      {
        ps = con.prepareStatement(DMQ.s15);
      }
      ps.setString(1, school.getSchool());
      ps.setString(2, school.getSchoolMarathi());
      if (schoolID != 0)
      {
        ps.setInt(3, schoolID);
      }
      else
      {
        ps.setInt(3, school.getBeatID());
      }
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        count = resultSet.getInt(1);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return count;
  }
  
  public int createSchool(School school, org.spa.entity.User user)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.i5);
      ps.setInt(1, school.getSectionID());
      ps.setString(2, school.getSchool());
      ps.setString(3, school.getSchoolMarathi());
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int updateSchool(School school)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.u5);
      ps.setString(1, school.getSchool());
      ps.setString(2, school.getSchoolMarathi());
      ps.setInt(3, school.getSchoolID());
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int deleteSchools(int[] schoolIDs)
    throws SQLException
  {
    for (int schoolID : schoolIDs)
    {
      deleteSchool(schoolID);
    }
    return 1;
  }
  
  public int deleteSchool(int schoolID) throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.d5);
      ps.setInt(1, schoolID);
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int moveSchool(int schoolID, int beatID) throws SQLException {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    key = 0;
    //int dub;
    try {
      int dub = getMoveSchoolDups(schoolID, beatID);
      if (dub == 0)
      {
        ps = con.prepareStatement(DMQ.m4);
        ps.setInt(1, beatID);
        ps.setInt(2, schoolID);
        key = ps.executeUpdate();
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public int getMoveSchoolDups(int schoolID, int beatID)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    int dub = 0;
    try
    {
      ps = con.prepareStatement(DMQ.s16);
      ps1 = con.prepareStatement(DMQ.s17);
      ps.setInt(1, schoolID);
      ps1.setInt(1, beatID);
      resultSet = ps.executeQuery();
      resultSet1 = ps1.executeQuery();
      if (resultSet.next())
      {
        while (resultSet1.next())
        {
          if ((resultSet.getString(1).equalsIgnoreCase(resultSet1.getString(1))) && (resultSet.getString(2).equalsIgnoreCase(resultSet1.getString(2))))
          {
            dub++;
          }
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      resultSet1.close();
      ps.close();
      ps1.close();
    }
    return dub;
  }
  
  public int deleteSchoolOnBeat(int beatID) throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(DMQ.d6);
      ps.setInt(1, beatID);
      key = ps.executeUpdate();
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      ps.close();
    }
    return key;
  }
  
  public Section getSectionDetails(int section)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    Section s = new Section();
    try
    {
      ps = con.prepareStatement(DMQ.s18);
      ps.setInt(1, section);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        s.setSectionID(Integer.valueOf(resultSet.getInt(1)));
        s.setTalukaID(Integer.valueOf(resultSet.getInt(2)));
        s.setSection(resultSet.getString(3));
        s.setSectionMarathi(resultSet.getString(4));
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return s;
  }
  
  public Beat getBeatDetails(int beatID)
    throws SQLException
  {
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    Beat b = new Beat();
    try
    {
      ps = con.prepareStatement(DMQ.s19);
      ps.setInt(1, beatID);
      resultSet = ps.executeQuery();
      if (resultSet.next())
      {
        b.setBeatID(resultSet.getInt(1));
        b.setSectionID(resultSet.getInt(2));
        b.setBeat(resultSet.getString(3));
        b.setBeatMarathi(resultSet.getString(4));
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return b;
  }
  
  public Vector<Taluka> getAllTalukaListByDistOrders(int orderId, int orderId1)
    throws SQLException
  {
    Taluka taluka = null;
    Vector<Taluka> talukas = new Vector();
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    String sql = " SELECT tm.taluka_id, tm.taluka_marathi FROM taluka_master tm  INNER JOIN taluka_order tor ON tor.taluka_id = tm.taluka_id  INNER JOIN district_order dor ON dor.district_order_id = tor.district_order_id INNER JOIN district_sales_invoice dsi ON dsi.district_order_id_1to5 = ? OR dsi.district_order_id_6to8 = ? GROUP BY tm.taluka_marathi ORDER BY tm.taluka_id ";
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, orderId);
      ps.setInt(2, orderId1);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        while (resultSet.next())
        {
          taluka = new Taluka();
          taluka.setTalukaID(resultSet.getInt(1));
          taluka.setTalukaMarathi(resultSet.getString(2));
          talukas.add(taluka);
        }
      }
    }
    catch (Exception e) {
      throw new RuntimeException(e);
    } finally {
      resultSet.close();
      ps.close();
    }
    return talukas;
  }
  
  public Taluka talukaDetailsByTalukaId(int talukaID) throws SQLException
  {
    String sql = " SELECT taluka_marathi FROM taluka_master WHERE taluka_id = ? ";
    Taluka taluka = null;
    dbConnection = new dbConnection();
    con = dbConnection.getConnection();
    try
    {
      ps = con.prepareStatement(sql);
      ps.setInt(1, talukaID);
      resultSet = ps.executeQuery();
      if (resultSet != null)
      {
        if (resultSet.next())
        {
          taluka = new Taluka();
          taluka.setTalukaMarathi(resultSet.getString(1));
        }
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
    finally
    {
      resultSet.close();
      ps.close();
    }
    return taluka;
  }
}
