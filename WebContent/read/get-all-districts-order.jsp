<%-- 
    Document   : get-all-districts-order
    Created on : Jan 29, 2013, 5:33:57 PM
    Author     : Rohit
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.DistrictOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.DistrictOrderDS"%>
<%@page import="org.spa.helper.Paging"%>
<%@page import="org.spa.entity.User"%>
<%@page import="org.spa.entity.Page"%>
<%
    String fromDate = session.getAttribute("fromYear").toString().trim();
    String toDate =  session.getAttribute("toYear").toString().trim();
    int start = Integer.parseInt(request.getParameter("start"));
    int limit = Integer.parseInt(request.getParameter("limit"));
    String s = null;
    String sql  = " SELECT dor.district_order_id, m.district_marathi, dor.district_gov_order_num, dor.district_order_date, dor.order_number, dor.creation_date, m.district_id, m.`std_type` "
            	+ " FROM district_order dor "
                + " INNER JOIN `district_master` m ON m.district_id = dor.district_id AND dor.`deleted`=0 "
            	+ " WHERE STR_TO_DATE(dor.district_order_date,'%d/%m/%Y') BETWEEN STR_TO_DATE('"+fromDate+"','%d/%m/%Y') AND STR_TO_DATE('"+toDate+"','%d/%m/%Y') "
            	+ " GROUP BY dor.`district_order_id` ASC ";
    Page paginatedPage = new Page(new DistrictOrderDS().getAllDistrictOrder(fromDate,toDate,start,limit),new Paging().getTotalRowCount(sql));
    s = new JSONSerializer().exclude("*.class").deepSerialize(paginatedPage);
    
    
    //s = new JSONSerializer().exclude("*.class").deepSerialize("root",new DistrictOrderDS().getAllDistrictOrder(fromDate,toDate));
    out.write(s);
%>