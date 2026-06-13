
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.*"%>
<%@page import="org.spa.ds.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
﻿<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
	int key = new InvoiceDS().getDupDistrictInvoice(Integer.parseInt(request.getParameter("orderID")));
    if (key != 0) 
    {
         //request.setAttribute("dups", list);
%>
         
<jsp:forward page="../reports/print-district-invoice.jsp" >
    <jsp:param name="invoiceID" value="<%=key%>"></jsp:param>
</jsp:forward>


         <%-- <jsp:forward page="dups-invoices.jsp" ></jsp:forward> --%>
<%
	}
    else
    {
%>
         <jsp:forward page="preview-district-invoice.jsp" ></jsp:forward>
<%
    }
%>