<%-- 
    Document   : delete-inward
    Created on : Feb 18, 2013, 7:03:00 PM
    Author     : admin
--%>

<%@page import="org.spa.entity.InwardMaterialDetails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.InwardMaterialDS"%>
<%
    String st = "{success: false}";
    String inwardId = request.getParameter("inwardId").trim();
    InwardMaterialDetails inward = new InwardMaterialDetails();
    inward.setInwardId(Integer.parseInt(inwardId));

    InwardMaterialDS ds = new InwardMaterialDS();
    ds.deleteInward(inward);
    st = "{success: true}";

out.write(st);%>
