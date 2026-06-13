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
	int flag = 0;
	int invoiceNumber1 = 0,invoiceNumber2 = 0;
	int orde1to5 = 0, orde6to8 = 0;
	int result = 0,orderType;
	double total1 = 0.0,total2 = 0.0;
	double weight = 0.0, weight1 = 0.0;
	String previewDate = "";
	InvoiceDS invoiceDS = new InvoiceDS();
	
	orderType = Integer.parseInt(request.getParameter("orderType"));
	invoiceNumber1 = Integer.parseInt(request.getParameter("invoiceNumber1"));
	invoiceNumber2 = Integer.parseInt(request.getParameter("invoiceNumber2"));
	orde1to5 = Integer.parseInt(request.getParameter("orde1to5"));
	orde6to8 = Integer.parseInt(request.getParameter("orde6to8"));
	total1 = Double.parseDouble(request.getParameter("total1"));
	total2 = Double.parseDouble(request.getParameter("total2"));
	weight = Double.parseDouble(request.getParameter("weight"));
	previewDate = request.getParameter("invoiceDate");
	version = Integer.parseInt(request.getParameter("version"));
	
	t = new TalukaInvoice();
	t.setInvoiceIDMan1(invoiceNumber1);
	t.setInvoiceIDMan2(invoiceNumber2);
	t.setOrderID(orde1to5);
	t.setOrderID1(orde6to8);
	t.setTotalAmount(total1);
	t.setTotalAmount1(total2);
	t.setInvoiceDate(previewDate);
	t.setVersion(version);
	t.setWeight(weight);
    //flag = invoiceDS.isDuplicateDistrict(invoiceNumber);
    //if(flag != 0)
	//	msg = "Bill No. :" + invoiceNumber + " already exists, please enter new one";
    //else 
     	result = invoiceDS.createDistrictRationSalesInvoice(t);
   	
	
	if(result == 0)
	{
%>  
<jsp:forward page="../reports/preview-district-ration-for-both-stype-invoice.jsp" >
    <jsp:param name="msg"  value="<%=msg%>"></jsp:param>
    <jsp:param name="salesBillDate"  value="<%=previewDate%>"></jsp:param>
    <jsp:param name="orde1to5"  value="<%=orde1to5%>"></jsp:param>
    <jsp:param name="orde6to8"  value="<%=orde6to8%>"></jsp:param>
    <jsp:param name="orderType"  value="<%=orderType%>"></jsp:param>
</jsp:forward>
<%
	}
	else
	{
%>
<jsp:forward page="../reports/print-district-ration-for-both-stype-invoice_update_lasun.jsp" >
    <jsp:param name="invoiceID" value="<%=result%>"></jsp:param>
</jsp:forward>
<%
	}
%>