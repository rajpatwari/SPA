<%-- 
    Document   : get-all-school-order
    Created on : Jan 31, 2013, 5:37:42 PM
    Author     : anita
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%
    String s = null;
    String fromDate = session.getAttribute("fromYear").toString().trim();
    String toDate =  session.getAttribute("toYear").toString().trim();

    int beatID = Integer.parseInt(request.getParameter("beatID"));
    String tal_order_id = request.getParameter("taluka_order_id");
    int taluka_order_id = Integer.parseInt(tal_order_id);
    //int districtOrderID = Integer.parseInt(request.getParameter("district_order_id"));

    //s = new JSONSerializer().exclude("*.class").deepSerialize("root",new TalukaOrderDS().getAllTalukaOrderDetails(section_id,taluka_order_id,districtOrderID));
    s = new JSONSerializer().exclude("*.class").deepSerialize("root",new TalukaOrderDS().getAllTalukaOrderDetails(beatID,taluka_order_id));

    out.write(s);
%>