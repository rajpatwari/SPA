<%-- 
    Document   : delete-district-order
    Created on : Jan 30, 2013, 12:19:52 PM
    Author     : anita
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.DistrictOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.DistrictOrderDS"%>
<%
    String st = "{success: false}";
    String district_order_id = request.getParameter("district_order_id").trim();
    DistrictOrder dOrder = new DistrictOrder();
    dOrder.setOrderID(Integer.parseInt(district_order_id));

    DistrictOrderDS ds = new DistrictOrderDS();
    ds.deleteDistrictOrder(dOrder);
    st = "{success: true}";

out.write(st);%>
