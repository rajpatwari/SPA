<%-- 
    Document   : delete-taluka-order
    Created on : Jan 31, 2013, 11:49:55 AM
    Author     : anita
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.TalukaOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%
    String st = "{success: false}";
    String taluka_order_id = request.getParameter("taluka_order_id").trim();
    TalukaOrder tOrder = new TalukaOrder();
    tOrder.setTalukaOrderId(Integer.parseInt(taluka_order_id));
    TalukaOrderDS ds = new TalukaOrderDS();
    ds.deleteTalukaOrder(tOrder);
    st = "{success: true}";
    out.write(st);
%>
