<%-- 
    Document   : add-inward-master
    Created on : Mar 1, 2013, 3:55:10 PM
    Author     : Rohit
--%>

<%@page import="org.spa.ds.StockDS"%>
<%@page import="org.spa.entity.User"%>
<%@page import="org.spa.entity.Stock"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%
    String st = "{success: false}";
    Stock stock = new Stock();
    StockDS sds = new StockDS(); 

    stock.setStockDiffID(Integer.parseInt(request.getParameter("stockDiffID").trim()));
    stock.setStockDiffDate(request.getParameter("eselectDate").trim());
    stock.setDiffType(Integer.parseInt(request.getParameter("ediffType").trim())); 
    
    if(request.getParameter("echvli").trim() ==  "")
		stock.setChvli(0.0);
	else
		stock.setChvli(Double.parseDouble(request.getParameter("echvli").trim())); 
    if(request.getParameter("ehalad").trim() ==  "")
		stock.setHalad(0.0);
	else
		stock.setHalad(Double.parseDouble(request.getParameter("ehalad").trim())); 
    if(request.getParameter("ejire").trim() ==  "")
		stock.setJire(0.0);
	else
		stock.setJire(Double.parseDouble(request.getParameter("ejire").trim())); 
    if(request.getParameter("emasuldaal").trim() ==  "")
		stock.setMasuldaal(0.0);
	else
		stock.setMasuldaal(Double.parseDouble(request.getParameter("emasuldaal").trim())); 
    if(request.getParameter("ematki").trim() ==  "")
		stock.setMatki(0.0);
	else
		stock.setMatki(Double.parseDouble(request.getParameter("ematki").trim())); 
    if(request.getParameter("emirchi").trim() ==  "")
		stock.setMirchi(0.0);
	else
		stock.setMirchi(Double.parseDouble(request.getParameter("emirchi").trim())); 
    if(request.getParameter("emith").trim() ==  "")
		stock.setMith(0.0);
	else
		stock.setMith(Double.parseDouble(request.getParameter("emith").trim())); 
    if(request.getParameter("emohari").trim() ==  "")
		stock.setMohari(0.0);
	else
		stock.setMohari(Double.parseDouble(request.getParameter("emohari").trim())); 
    if(request.getParameter("emung").trim() ==  "")
		stock.setMung(0.0);
	else
		stock.setMung(Double.parseDouble(request.getParameter("emung").trim())); 
    if(request.getParameter("emungdaal").trim() ==  "")
		stock.setMungdaal(0.0);
	else
		stock.setMungdaal(Double.parseDouble(request.getParameter("emungdaal").trim())); 
    if(request.getParameter("etandul").trim() ==  "")
		stock.setTandul(0.0);
	else
		stock.setTandul(Double.parseDouble(request.getParameter("etandul").trim()));
    if(request.getParameter("etel").trim() ==  "")
		stock.setTel(0.0);
	else
		stock.setTel(Double.parseDouble(request.getParameter("etel").trim()));
    
    int key = sds.updateStockDifferance(stock);
    if(key != 0)
    {
        st = "{success: true}";
    }  
    out.write(st);
%>
