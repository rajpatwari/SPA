<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String s = new JSONSerializer().exclude("*.class").deepSerialize("root",new DistrictMaster().getAllTalukas(Integer.parseInt(request.getParameter("districtID"))));out.write(s);
%>