<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String talukaID = request.getParameter("talukaID");
    //System.out.println("talukaID" + talukaID);
    String s = new JSONSerializer().exclude("*.class").deepSerialize("root",new DistrictMaster().getAllSections(Integer.parseInt(talukaID)));
    out.write(s);
%>