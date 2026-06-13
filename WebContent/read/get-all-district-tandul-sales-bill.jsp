<%@page import="org.spa.ds.DistrictOrderDS"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%@page import="org.spa.ds.InvoiceDS"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	String fromDate  = (String)session.getAttribute("fromYear");
	String toDate  = (String)session.getAttribute("toYear");
	String s = new JSONSerializer().exclude("*.class").deepSerialize("root",new InvoiceDS().readAllDistrictRiceSalesInvoice(fromDate,toDate));
	out.write(s);
%>