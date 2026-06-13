<!-- Fetching all school based on section selected to display it on grid -->
<%@page import="org.spa.ds.InvoiceDS"%>
<%@page import="org.spa.ds.DistrictMaster"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	String fromYear  = (String)session.getAttribute("fromYear");
	String toYear = (String)session.getAttribute("toYear");
    String s = new JSONSerializer().exclude("*.class").deepSerialize("root",new InvoiceDS().readInvoiceByOrderType(2,fromYear,toYear));
    out.write(s);
%>