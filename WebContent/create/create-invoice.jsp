<%@page import="com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException"%>
<%@page import="org.spa.entity.TalukaInvoice"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.spa.ds.InvoiceDS"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
</html>
<%
	TalukaInvoice t = null;
	String msg = "";
	int version =0;
	int flag = 0, flag1 = 0;
	int invoiceNumber1 = 0;
	int invoiceNumber2 = 0;
	int orderID = 0;
	int result = 0;
	double total = 0.0;
	double total1 = 0.0;
	double weight = 0.0;
	int talukaID = 0;
	String previewDate = "";
	int orderType = 0;
	int invoiceNumber = 0;
	InvoiceDS invoiceDS = new InvoiceDS();
	if(request.getParameter("invoiceNumber") == null)
	{
		invoiceNumber1 = Integer.parseInt(request.getParameter("invoiceNumber1"));
		invoiceNumber2 = Integer.parseInt(request.getParameter("invoiceNumber2"));
		orderID = Integer.parseInt(request.getParameter("orderID1"));
		total = Double.parseDouble(request.getParameter("total1"));
		total1 = Double.parseDouble(request.getParameter("total2"));
		weight = Double.parseDouble(request.getParameter("weightTotal1"));
		talukaID = Integer.parseInt(request.getParameter("talukaID1"));
		previewDate = request.getParameter("invoiceDate1");
		orderType = Integer.parseInt(request.getParameter("orderType1"));
		version = Integer.parseInt(request.getParameter("version1"));
		/* if(invoiceNumber1 == invoiceNumber2)
    	{
    		msg = "Both Bill No. are same, please enter new one";
    	}
    	else */
    	{
    		t = new TalukaInvoice();
    		t.setInvoiceIDMan(0);
    		t.setInvoiceIDMan1(invoiceNumber1);
    		t.setInvoiceIDMan2(invoiceNumber2);
    		t.setOrderID(orderID);
    		t.setTotalAmount(0.0);
    		t.setTotalAmount1(total);
    		t.setTotalAmount2(total1);
    		t.setTalukaID(talukaID);
    		t.setInvoiceDate(previewDate);
    		t.setOrderType(orderType);
    		t.setVersion(version);
    		t.setWeight(weight);
            /* flag = invoiceDS.isDuplicate(invoiceNumber1);
            flag1 = invoiceDS.isDuplicate(invoiceNumber2);
            if(flag != 0 && flag1 != 0)
    			msg = "Bill No. :" + invoiceNumber1 + " And "+ invoiceNumber2 +" already exists, please enter new one";
            else if(flag == 0 && flag1 != 0)
    			msg = "Bill No. :" + invoiceNumber2 +" already exists, please enter new one";
            else if(flag != 0 && flag1 == 0)
    			msg = "Bill No. :" + invoiceNumber1 +" already exists, please enter new one";
            else */
            	result = invoiceDS.createInvoice(t); 
    	}
	}
	else
	{
		invoiceNumber = Integer.parseInt(request.getParameter("invoiceNumber"));
		orderID = Integer.parseInt(request.getParameter("orderID"));
		total = Double.parseDouble(request.getParameter("total"));
		talukaID = Integer.parseInt(request.getParameter("talukaID"));
		previewDate = request.getParameter("invoiceDate");
		orderType = Integer.parseInt(request.getParameter("orderType"));
		version = Integer.parseInt(request.getParameter("version"));
		weight = Double.parseDouble(request.getParameter("weightTotal"));
		t = new TalukaInvoice();
		t.setInvoiceIDMan(invoiceNumber);
		t.setInvoiceIDMan1(0);
		t.setInvoiceIDMan2(0);
		t.setOrderID(orderID);
		t.setTotalAmount(total);
		t.setTotalAmount1(0.0);
		t.setTotalAmount2(0.0);
		t.setTalukaID(talukaID);
		t.setInvoiceDate(previewDate);
		t.setOrderType(orderType);
		t.setVersion(version);
		t.setWeight(weight);
		flag = invoiceDS.isDuplicate(invoiceNumber);
        /* if(flag != 0)
    		msg = "Bill No. :" + invoiceNumber + " already exists, please enter new one";
        else  */
        	result = invoiceDS.createInvoice(t);
	}
	if(result == 0)
	{
%>  
<jsp:forward page="../reports/preview-invoice.jsp" >
    <jsp:param name="msg"  value="<%=msg%>"></jsp:param>
    <jsp:param name="previewDate"  value="<%=previewDate%>"></jsp:param>
    <jsp:param name="orderID"  value="<%=orderID%>"></jsp:param>
    <jsp:param name="talukaID"  value="<%=talukaID%>"></jsp:param>
</jsp:forward>
<%
	}
	else
	{
%>
<jsp:forward page="../reports/print-invoice.jsp" >
    <jsp:param name="invoiceID" value="<%=result%>"></jsp:param>
</jsp:forward>
<%
	}
%>