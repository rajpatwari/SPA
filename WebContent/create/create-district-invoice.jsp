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
	int districtID = 0;
	String previewDate = "";
	InvoiceDS invoiceDS = new InvoiceDS();
	
	invoiceNumber1 = Integer.parseInt(request.getParameter("invoiceNumber1"));
	invoiceNumber2 = Integer.parseInt(request.getParameter("invoiceNumber2"));
	orderID = Integer.parseInt(request.getParameter("orderID"));
	total = Double.parseDouble(request.getParameter("total"));
	total1 = Double.parseDouble(request.getParameter("total1"));
	weight = Double.parseDouble(request.getParameter("weightTotal"));
	districtID = Integer.parseInt(request.getParameter("districtID"));
	previewDate = request.getParameter("invoiceDate");
	version = Integer.parseInt(request.getParameter("version"));
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
   		t.setDistrictID(districtID);
   		t.setInvoiceDate(previewDate);
   		t.setVersion(version);
   		t.setWeight(weight);
        /* flag = invoiceDS.isDuplicateDistrict(invoiceNumber1);
        flag1 = invoiceDS.isDuplicateDistrict(invoiceNumber2);
        if(flag != 0 && flag1 != 0)
			msg = "Bill No. :" + invoiceNumber1 + " And "+ invoiceNumber2 +" already exists, please enter new one";
        else if(flag == 0 && flag1 != 0)
			msg = "Bill No. :" + invoiceNumber2 +" already exists, please enter new one";
        else if(flag != 0 && flag1 == 0)
			msg = "Bill No. :" + invoiceNumber1 +" already exists, please enter new one";
        else  */
        	result = invoiceDS.createDistrictInvoice(t);
   	}
	
	if(result == 0)
	{
%>  
<jsp:forward page="../reports/preview-district-invoice.jsp" >
    <jsp:param name="msg"  value="<%=msg%>"></jsp:param>
    <jsp:param name="previewDate"  value="<%=previewDate%>"></jsp:param>
    <jsp:param name="orderID"  value="<%=orderID%>"></jsp:param>
    <jsp:param name="districtID"  value="<%=districtID%>"></jsp:param>
</jsp:forward>
<%
	}
	else
	{
%>
<jsp:forward page="../reports/print-district-invoice.jsp" >
    <jsp:param name="invoiceID" value="<%=result%>"></jsp:param>
</jsp:forward>
<%
	}
%>