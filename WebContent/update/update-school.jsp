<%@page import="org.spa.entity.School"%>
<%@page import="org.spa.entity.Taluka"%>
<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="org.spa.entity.District"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
     String schoolID = request.getParameter("schoolID");
     String schoolEnglish = request.getParameter("schoolEnglish");
     String schoolMarathi = request.getParameter("schoolMarathi");
     String s = "{success: false}";
     School sc = new School();
     sc.setSchool(schoolEnglish);
     sc.setSchoolMarathi(schoolMarathi);
     sc.setSchoolID(Integer.parseInt(schoolID));
     DistrictMaster masterDS = new DistrictMaster();
     int dups  = masterDS.getSchoolDups(sc); 
     // checking for duplication
     if( dups == 0) 
     {
         masterDS.updateSchool(sc);
         s = "{success: true}";
     }
     else
     {
     }     
     out.write(s);
%>
