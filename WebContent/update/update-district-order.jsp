<%-- 
    Document   : update-taluka-order
    Created on : Jan 30, 2013, 4:24:01 PM
    Author     : Rohit
--%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="org.spa.connect.dbConnection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.DistrictOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.DistrictOrderDS"%>
<%
    String st = "{success: false}";
    String dOrderId = request.getParameter("edistrict-order-id").trim();
    String dOrderDate = request.getParameter("eorderDate").trim();
    String dOrderNo = request.getParameter("eorderNumber").trim();
    String dGovOrderNo = request.getParameter("egovOrderNumber").trim();
    //System.out.println("Anita Madam  .....  "+dGovOrderNo);
    DistrictOrder dOrder = new DistrictOrder();
    dOrder.setOrderID(Integer.parseInt(dOrderId));
    dOrder.setOrderNoDate(dOrderDate);
    dOrder.setOrderNumber(dOrderNo);
    dOrder.setDistrictGovOrderID(dGovOrderNo);
    DistrictOrderDS ds = new DistrictOrderDS();
    int orderID = ds.updateDistrictOrder(dOrder);
    if (orderID != 0) 
    {
        st = "{success: true}";
    }
out.write(st);%>
