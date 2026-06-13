<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="org.spa.entity.District"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
     String districtID = request.getParameter("districtID");
     String districtEnglish = request.getParameter("districtEnglish");
     String districtMarathi = request.getParameter("districtMarathi");
     String s = "{success: false}";
     District d = new District();

     d.setDistrict(districtEnglish);
     d.setDistrictMarathi(districtMarathi);
     d.setDistrictID(Integer.parseInt(districtID));
     d.setStdType(Integer.parseInt(request.getParameter("stdType")));

     DistrictMaster masterDS = new DistrictMaster();
     int dups  = masterDS.getDistrictDups(d); //checking for dupliaction

     if( dups == 0) 
     {
         masterDS.updateDistrict(d);
         s = "{success: true}";
     }
     else
     {

     }
     out.write(s);
%>
