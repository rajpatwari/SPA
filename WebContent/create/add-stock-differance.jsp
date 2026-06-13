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

    stock.setStockDiffDate(request.getParameter("selectDate").trim());
    stock.setDiffType(Integer.parseInt(request.getParameter("diffType").trim())); 
    
    if(request.getParameter("chvli").trim() ==  "")
		stock.setChvli(0.0);
	else
		stock.setChvli(Double.parseDouble(request.getParameter("chvli").trim())); 
    if(request.getParameter("halad").trim() ==  "")
		stock.setHalad(0.0);
	else
		stock.setHalad(Double.parseDouble(request.getParameter("halad").trim())); 
    if(request.getParameter("jire").trim() ==  "")
		stock.setJire(0.0);
	else
		stock.setJire(Double.parseDouble(request.getParameter("jire").trim())); 
    if(request.getParameter("masuldaal").trim() ==  "")
		stock.setMasuldaal(0.0);
	else
		stock.setMasuldaal(Double.parseDouble(request.getParameter("masuldaal").trim())); 
    if(request.getParameter("matki").trim() ==  "")
		stock.setMatki(0.0);
	else
		stock.setMatki(Double.parseDouble(request.getParameter("matki").trim())); 
    if(request.getParameter("mirchi").trim() ==  "")
		stock.setMirchi(0.0);
	else
		stock.setMirchi(Double.parseDouble(request.getParameter("mirchi").trim())); 
    if(request.getParameter("mith").trim() ==  "")
		stock.setMith(0.0);
	else
		stock.setMith(Double.parseDouble(request.getParameter("mith").trim())); 
    if(request.getParameter("mohari").trim() ==  "")
		stock.setMohari(0.0);
	else
		stock.setMohari(Double.parseDouble(request.getParameter("mohari").trim())); 
    if(request.getParameter("mung").trim() ==  "")
		stock.setMung(0.0);
	else
		stock.setMung(Double.parseDouble(request.getParameter("mung").trim())); 
    if(request.getParameter("mungdaal").trim() ==  "")
		stock.setMungdaal(0.0);
	else
		stock.setMungdaal(Double.parseDouble(request.getParameter("mungdaal").trim())); 
    if(request.getParameter("tandul").trim() ==  "")
		stock.setTandul(0.0);
	else
		stock.setTandul(Double.parseDouble(request.getParameter("tandul").trim()));
    if(request.getParameter("tel").trim() ==  "")
		stock.setTel(0.0);
	else
		stock.setTel(Double.parseDouble(request.getParameter("tel").trim()));
    
    if(request.getParameter("harbara").trim() ==  "")
		stock.setHarbara(0.0);
	else
		stock.setHarbara(Double.parseDouble(request.getParameter("harbara").trim())); 
    if(request.getParameter("vatana").trim() ==  "")
 		stock.setVatana(0.0);
 	else
 		stock.setVatana(Double.parseDouble(request.getParameter("vatana").trim()));
    if(request.getParameter("extra1").trim() ==  "")
 		stock.setExtra1(0.0);
 	else
 		stock.setExtra1(Double.parseDouble(request.getParameter("extra1").trim()));
    if(request.getParameter("extra2").trim() ==  "")
 		stock.setExtra2(0.0);
 	else
 		stock.setExtra2(Double.parseDouble(request.getParameter("extra2").trim()));
    if(request.getParameter("extra3").trim() ==  "")
 		stock.setExtra3(0.0);
 	else
 		stock.setExtra3(Double.parseDouble(request.getParameter("extra3").trim()));
    if(request.getParameter("extra4").trim() ==  "")
 		stock.setExtra4(0.0);
 	else
 		stock.setExtra4(Double.parseDouble(request.getParameter("extra4").trim()));
    if(request.getParameter("extra5").trim() ==  "")
 		stock.setExtra5(0.0);
 	else
 		stock.setExtra5(Double.parseDouble(request.getParameter("extra5").trim()));
    if(request.getParameter("extra6").trim() ==  "")
 		stock.setExtra6(0.0);
 	else
 		stock.setExtra6(Double.parseDouble(request.getParameter("extra6").trim()));

    int key = sds.createStockDifferance(stock);
    if(key != 0)
    {
        st = "{success: true}";
    }  
    out.write(st);
%>
