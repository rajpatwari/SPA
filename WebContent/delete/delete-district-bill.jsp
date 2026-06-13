<%@page import="org.spa.ds.InvoiceDS"%>
<%@page import="org.spa.ds.DispatchDS"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="flexjson.JSONDeserializer"%>
<%
    String s = "{success: false}";
    int key = new InvoiceDS().deleteDistrictInvoice(Integer.parseInt(request.getParameter("invoiceID")));
    if(key != 0)
    	s = "{success: true}";
    out.write(s);
%>
