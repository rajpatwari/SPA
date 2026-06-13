<%-- 
    Document   : get-all-items
    Created on : Jan 24, 2013, 1:30:08 PM
    Author     : Rohit
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.Stock"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.StockDS"%>
<%
    String s = null;
    s = new JSONSerializer().exclude("*.class").deepSerialize("root",new StockDS().getAllStockDifferance());
    out.write(s);
%>
