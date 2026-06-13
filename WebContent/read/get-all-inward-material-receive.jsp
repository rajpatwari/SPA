<%--
    Document   : get-all-vendor
    Created on : Jan 28, 2013, 4:31:03 PM
    Author     : rohit
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.InwardMaterialDS"%>
<%@page import="org.spa.helper.Paging"%>
<%@page import="org.spa.entity.User"%>
<%@page import="org.spa.entity.Page"%>
<%
    String s = null;
    String fromDate  = (String)session.getAttribute("fromYear");
    String toDate  = (String)session.getAttribute("toYear");
    int start = Integer.parseInt(request.getParameter("start"));
    int limit = Integer.parseInt(request.getParameter("limit"));
    
    String sql  = " SELECT im.inward_id, im.item_id_fk, itm.item_name_marathi, im.supplier_id, sm.supplier_name, im.qty_in_kg, im.inward_date, im.truck_no, im.bag FROM inward_master im, supplier_master sm, item_master itm WHERE im.item_id_fk = itm.item_id AND im.supplier_id = sm.supplier_id AND STR_TO_DATE(im.inward_date, '%m/%d/%Y')  BETWEEN STR_TO_DATE('"+ fromDate +"', '%d/%m/%Y') AND STR_TO_DATE('" + toDate + "', '%d/%m/%Y') " ;
	int i = new Paging().getTotalRowCount(sql);
	//System.out.println(i);
    Page paginatedPage = new Page(new InwardMaterialDS().getAllInwardMaterialReceive(fromDate,toDate,start,limit),i);
	s = new JSONSerializer().exclude("*.class").deepSerialize(paginatedPage);
    
    
    //s = new JSONSerializer().exclude("*.class").deepSerialize("root",new InwardMaterialDS().getAllInwardMaterialReceive(fromDate,toDate));
    out.write(s);
%>

