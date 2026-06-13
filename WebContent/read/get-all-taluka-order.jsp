<%-- 
    Document   : get-all-taluka-order
    Created on : Jan 30, 2013, 12:57:25 PM
    Author     : anita
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.spa.entity.TalukaOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="flexjson.JSONSerializer"%>
<%@page import="org.spa.ds.TalukaOrderDS"%>
<%@page import="org.spa.helper.Paging"%>
<%@page import="org.spa.entity.User"%>
<%@page import="org.spa.entity.Page"%>
<%
    String s = null;
    String fromDate = session.getAttribute("fromYear").toString().trim();
    String toDate =  session.getAttribute("toYear").toString().trim();
    int start = Integer.parseInt(request.getParameter("start"));
    int limit = Integer.parseInt(request.getParameter("limit"));
    int dist_id = Integer.parseInt(request.getParameter("district_id"));
    String dist_order_id = request.getParameter("district_order_id");
    int district_order_id = Integer.parseInt(dist_order_id);
    String sql  = " SELECT *, "
           		+ " ( "
           		+ "      SELECT tod1.taluka_order_details_id FROM taluka_order_details tod1 "
            	+ "      WHERE tod1.taluka_order_id = taluka_order "
            	+ "      GROUP BY taluka_order_id "
            	+ " ) AS order_detail_id "
            	+ " FROM "
            	+ " ( "
            	+ "      SELECT   tao.taluka_order_id AS taluka_order,  tao.taluka_gov_order_num, tm.taluka_id, tm.taluka_marathi, tao.from_month,  tao.from_year,  tao.to_month,  tao.to_year,  tao.taluka_order_date, tao.order_type "
            	+ "      FROM  taluka_master tm  "
            	+ "      LEFT JOIN  taluka_order tao  ON  tao.taluka_id = tm.taluka_id AND tao.district_order_id = "+district_order_id+" AND deleted = 0  "
            	+ "      AND STR_TO_DATE(tao.taluka_order_date,'%d/%m/%Y') BETWEEN STR_TO_DATE('"+fromDate+"','%d/%m/%Y') AND STR_TO_DATE('"+toDate+"','%d/%m/%Y') "
            	+ "      WHERE tm.district_id_fk = "+dist_id
            	+ " ) AS a " ;
    Page paginatedPage = new Page(new TalukaOrderDS().getAllTalukaOrder(district_order_id,fromDate,toDate,dist_id,start,limit),new Paging().getTotalRowCount(sql));
    s = new JSONSerializer().exclude("*.class").deepSerialize(paginatedPage);
    
    
    //s = new JSONSerializer().exclude("*.class").deepSerialize("root",new TalukaOrderDS().getAllTalukaOrder(district_order_id,fromDate,toDate,dist_id));
    out.write(s);
%>
