<%-- 
    Document   : create-challans
    Created on : Feb 4, 2013, 4:00:48 PM
    Author     : admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%
    String st = "{success: false}";
    String beatID = request.getParameter("beatID").trim();
    String taluka_order_id = request.getParameter("taluka_order_id").trim();
    String challan_date = request.getParameter("challanDate").trim();

    TalukaOrderDS ds = new TalukaOrderDS();
    int i = ds.createChallans(Integer.parseInt(beatID),Integer.parseInt(taluka_order_id),challan_date);
    if(i != 0)
    {
        st = "{success: true}";
    }
out.write(st);%>
