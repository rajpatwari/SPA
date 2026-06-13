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
    int key = sds.deleteStockDifferance(stock);
    if(key != 0)
    {
        st = "{success: true}";
    }  
    out.write(st);
%>
