<%-- 
    Document   : add-district-order
    Created on : Jan 29, 2013, 3:44:35 PM
    Author     : anita
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.DistrictOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.DistrictOrderDS"%>

<%
    String s = "{success: false}";
    DistrictOrderDS districtOrderDS  = new DistrictOrderDS();
    DistrictOrder districtOrder = new DistrictOrder();
    districtOrder.setOrderNoDate(request.getParameter("orderDate").trim());
    districtOrder.setDistrictID(Integer.parseInt(request.getParameter("district_id").trim()));
    districtOrder.setDistrictGovOrderID(request.getParameter("govOrderNumber").trim());
    //System.out.println("Anita Madam  .....  "+request.getParameter("orderNumber").trim());
    districtOrder.setOrderNumber(request.getParameter("orderNumber").trim());
    int orderID = districtOrderDS.addDistrictOrder(districtOrder);
    if (orderID != 0) 
    {
        s = "{success: true}";
    }
    out.write(s);
%>
