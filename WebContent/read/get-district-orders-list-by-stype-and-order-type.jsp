<%@page import="org.spa.ds.DistrictOrderDS"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String fromDate  = (String)session.getAttribute("fromYear");
	String toDate  = (String)session.getAttribute("toYear");
	int orderType = Integer.parseInt(request.getParameter("orderType").trim());
	int sType = Integer.parseInt(request.getParameter("sType").trim());
	String s = new JSONSerializer().exclude("*.class").deepSerialize("root",new DistrictOrderDS().getDistrictOrderListBysTypeAndOrderType(sType,orderType,fromDate,toDate));
	out.write(s);
%>