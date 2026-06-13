<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String s = new JSONSerializer().exclude("*.class").deepSerialize("root",new DistrictMaster().getAllTalukaListByDistOrders(Integer.parseInt(request.getParameter("distOrder1to5")),Integer.parseInt(request.getParameter("distOrder6to8"))));
	out.write(s);
%>