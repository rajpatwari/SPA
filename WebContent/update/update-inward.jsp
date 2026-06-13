<%--
    Document   : update-district
    Created on : Jan 2, 2013, 7:01:05 PM
    Author     : user1
--%>
<%@page import="org.spa.entity.InwardMaterialDetails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.InwardMaterialDS"%>
<%
    String st = "{success: false}";

    InwardMaterialDetails inward = new InwardMaterialDetails();
    inward.setInwardId(Integer.parseInt(request.getParameter("ermId").trim()));
    inward.setQtyInKG(Double.parseDouble(request.getParameter("ermWeight").trim()));
    inward.setInwardDate(request.getParameter("ermDate").trim());     
    inward.setBag(Integer.parseInt(request.getParameter("etbag")));
    inward.setTruckNo(request.getParameter("etno"));         

    InwardMaterialDS ds = new InwardMaterialDS();
    int key = ds.updateInwardMaster(inward);
    if(key != 0)
        st = "{success: true}";
    out.write(st);
%>
