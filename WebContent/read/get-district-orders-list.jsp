<%@page import="org.spa.ds.DistrictOrderDS"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String s = new JSONSerializer().exclude("*.class").deepSerialize("root",new DistrictOrderDS().getDistrictOrderList(Integer.parseInt(request.getParameter("districtID"))));
out.write(s);
%>