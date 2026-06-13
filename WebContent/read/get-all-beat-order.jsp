<%-- 
    Document   : get-all-section-order
    Created on : Jan 31, 2013, 2:46:29 PM
    Author     : anita
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.Section"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%
    String s = null;
    int taluka_order_id = Integer.parseInt(request.getParameter("talukaOrderID"));
    int section_id = Integer.parseInt(request.getParameter("sectionID"));
    s = new JSONSerializer().exclude("*.class").deepSerialize("root",new TalukaOrderDS().getAllBeatForOrder(section_id,taluka_order_id));
    //System.out.println("s : "+s);
    out.write(s);
%>
