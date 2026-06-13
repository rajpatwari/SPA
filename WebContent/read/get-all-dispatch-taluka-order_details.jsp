<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String s = new JSONSerializer().exclude("*.class").deepSerialize("root",
	           new DispatchDS().getDispatchesDetails(
	           Integer.parseInt(request.getParameter("beatID")),
	           Integer.parseInt(request.getParameter("biltyFlag")),
	           Integer.parseInt(request.getParameter("dispatchDetailsID")), 
	           Integer.parseInt(request.getParameter("talukaOrderID")),
	           Integer.parseInt(request.getParameter("dispatchID"))));
	
	out.write(s);
%>