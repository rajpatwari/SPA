<%-- 
    Document   : add-inward-master
    Created on : Mar 1, 2013, 3:55:10 PM
    Author     : Rohit
--%>

<%@page import="org.spa.ds.InwardMaterialDS"%>
<%@page import="org.spa.entity.User"%>
<%@page import="org.spa.entity.InwardMaterialDetails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%
    String st = "{success: false}";
    InwardMaterialDetails imd = new InwardMaterialDetails();
    InwardMaterialDS Ids = new InwardMaterialDS();     
    imd.setItemId(Integer.parseInt(request.getParameter("inward-item-combo")));
    imd.setSupplierId(Integer.parseInt(request.getParameter("supplier-combo")));
    imd.setQtyInKG(Double.parseDouble(request.getParameter("quantity")));
    imd.setInwardDate(request.getParameter("rdate"));       
    imd.setBag(Integer.parseInt(request.getParameter("tbag")));
    imd.setTruckNo(request.getParameter("tno"));         
    int key = Ids.addInwardMaterial(imd);
    if(key != 0)
    {
        st = "{success: true}";
    }  
    out.write(st);
%>
