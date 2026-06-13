<%-- 
    Document   : delete-section-order
    Created on : Feb 6, 2013, 11:33:12 AM
    Author     : admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%
    String st = "{success: false}";
    TalukaOrderDS  dS = new TalukaOrderDS();
    int i = dS.resetSectionOrderDetails(Integer.parseInt(request.getParameter("talukaOrderID")));
    if(i != 0)
    {
        st = "{success: true}";
    }
    out.write(st);
%>
