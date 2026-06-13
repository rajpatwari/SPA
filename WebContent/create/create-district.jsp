<%@page import="org.spa.entity.District"%>
<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
    DistrictMaster dS = new DistrictMaster();
    District d = new District();
    String s = "{success: false}";
    d.setDistrict(request.getParameter("districtEnglish"));
    d.setDistrictMarathi(request.getParameter("districtMarathi"));
    d.setStdType(Integer.parseInt(request.getParameter("schoolType")));
    if(dS.getDistrictDups(d) ==0 )
    { //  checking for duplication
         dS.createDistrict(d);
         s = "{success: true}";
    }

    out.write(s);
%>
